--Raylib Ver1.04--

--前提としてp_dateを実行すること!
--[[フォーメーション名のテーブルの中にリーダからのx,y,z座標を入れる　左と後ろと上が正]]
formation={
	name={
		"satelite","delta","l_echelon","r_echelon","abreast","trail",
		"finger","pyramid","dyamond","compex","arrowhead",
		"hammerhead","wineglass","five_card","swan"
	},
	delta={{5,-2,5},{-5,2,5},{10,-4,10},{-10,4,10}},
	l_echelon={{-5,-2,5},{-10,-4,10},{-15,-6,10},{-20,-8,10}},
	r_echelon={{5,-2,5},{10,-4,10},{15,-6,15},{20,-8,20}},
	abreast={{5,0,0},{-5,0,0},{10,0,0},{10,0,0}},
	trail={{0,0,15},{0,0,30},{0,0,45},{0,0,60}},
	finger={{5,-2,5},{-5,-2,5},{-10,-4,10}},
	satelite={{0,2,0},{0,10,0},{0,100,0},{0,300,0}},
	pyramid={},
	dyamond={},
	compex={},
	arrowhead={},
	hammerhead={},
	wineglass={},
	five_card={},
	swan={},
}
formation.name[0]=""
function follow(core,n,mag,mode,form) --core:   n:プレイヤー番号 mag:倍率 form={name,n,x,y,z}
	n=n or 0
	mode=mode or 0
	form=form or {name=""}
	local speed=p_table[n].vel
	--[[if p_table[0]==nil then
		p_table=p_date()
	end]]
	local px=p_table[n].x
	local py=p_table[n].y
	local pz=p_table[n].z
	local vx=p_table[n].vx
	local vy=p_table[n].vy
	local vz=p_table[n].vz
	if (form.name~=nil or form.name~="") and formation[form.name]~=nil then
		local n=form.n or 2
		local x=form.x or 0
		local y=form.y or 0
		local z=form.z or 0
		local fx=formation[form.name][n-1][1]+x
		local fy=formation[form.name][n-1][2]+y
		local fz=formation[form.name][n-1][3]+z
		local vxz=LEN(vx,vz)
		local ex=vx/vxz
		local ez=vz/vxz
		local dx=ex*fz+ez*fx
		local dz=ez*fz-ex*fx
		px=px+dx
		py=py+fy
		pz=pz+dz
	end
	--_MOVE3D(_X(),_Y(),_Z())
	--_LINE3D(px,py,pz)
	pitch,roll,yaw,rtime,len,trigger=follow2(core,{px,py,pz},mag,mode)
	return pitch,roll,yaw,speed,rtime,len,trigger
end

function follow2(core,tar,mag,mode) --core:   tar:対象座標 mag:倍率 follow2(core,{x,y,z},mag)
	local trigger=false
	local mag=mag or {1,1,1} --ロール倍率,ピッチ倍率,ヨー倍率
	local pitch=pitch or 0 local roll=roll or 0 local yaw=yaw or 0 local a=a or 0
	local x=_X(core)-tar[1] local y=_Y(core)-tar[2] local z=_Z(core)-tar[3]
	local lx,ly,lz=local3DPos2(tar[1],tar[2],tar[3],core)
	local len=LEN(x,y,z)
	if lx==0 then lx=1 end
	if ly==0 then ly=1 end
	if lz==0 then lz=1 end
	local p1=math.deg(math.atan(lx/lz))
	local p2=math.deg(math.atan(ly/lz))
	pitch=p2*mag[2]
	yaw=p1*mag[3]
	if mode==0 then
		roll=-_AZ(core)*mag[1]
		if lz>0 then
			if lx>0 then
				yaw=-60*sign(mag[3])
			else
				yaw=60*sign(mag[3])
			end
			pitch=_AX(core)*mag[2]
		end
	elseif mode==1 then
		if (len<1000 or lz>0) and (math.abs(p1)>3 or math.abs(p2)>3) then
			local rad,r=PosToRad(ly,lx)
			r=math.max(r,1)
			roll=math.deg(rad)*mag[1]/100
		else
			roll=-_AZ(core)*mag[1]
		end
		if lz>0 then
			pitch=-100*mag[2]
			roll=0
		end
	end
	rtime=math.abs(len/_VZ(core))*_FPS()/_BASE()
	if math.abs(lx)<5 and math.abs(ly)<5 and lz<0 and len<500 then
		trigger=true
	end
	return pitch,roll,yaw,rtime,len,trigger
end