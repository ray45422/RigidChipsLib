--Raylib Ver1.04--

--[[
	chip1:描画したいchip
	chip2:描画したいchipの親chip
	x,y:ずらし
	isize:コンテナのサイズ
	col:コンテナの色
]]
hudData={rock=0,x=0,y=0,tn=0}
function hud_all(core,hud,size,no,option)
	--core:親チップ名 hud:hudチップ名 size:大きさ指定 no:選択中のターゲット x,y:位置調整(省略可）
	--使用例(core,hud,size,no,{x=x,y=y,col=col,range=1500})
	option=option or {}
	local col=option.col or "FF00"
	_SETCOLOR(tonumber(col,16))
	local x=option.x or 0
	local y=option.y or 0
	local range=option.range or 500
	p_table=p_date()
	local dx={} local dy={} local dz={}
	local dx2={} local dy2={} local dz2={}
	local dst1={} local dst2={}
	local dx3={} local dy3={} local dz3={}
	for i=0,_PLAYERS()-1 do
		if i~=hikeolib.netown() then
			dx[i],dy[i],dz[i]=local3DPos2(p_table[i].x,p_table[i].y,p_table[i].z,core)
			dx2[i],dy2[i],dz2[i]=local3DPos2(_X(hud),_Y(hud),_Z(hud),core)
			dx3[i]=dx2[i] dy3[i]=dy2[i] dz3[i]=dz2[i]
			dst2[i]=LEN(dx2[i],dy2[i],dz2[i]-0.75)
			dst1[i]=LEN(dx[i],dy[i],dz[i]-0.75)
			dx[i]=(dst2[i]/dst1[i])*dx[i]-dx3[i]
			dy[i]=(dst2[i]/dst1[i])*dy[i]-dy3[i]
			if dz[i]<=0 then
				local len=p_table[i].len
				if math.abs(dx[i])<=0.3 and math.abs(dy[i])<=0.3 then
					local rock=0
					if i==no and p_table[i].len<=range then
						rock=1
					end
					container(core,hud,size,col,dx[i],dy[i],rock,{x,y})
					--距離描画 名前描画
					_SETCOLOR(tonumber("FF00",16))
					if len<10000 then
						local i1=math.floor(math.abs(len)/1000)
						local i2=math.floor(math.abs(len)/100)-i1*10
						local i3=math.floor(math.abs(len)/10)-i1*100-i2*10
						local i4=math.floor(math.abs(len))-i1*1000-i2*100-i3*10
						if i1~=0 then
							seg7_3D[i1](dx3[i]+dx[i]+size*2,dy3[i]+dy[i]-size*1.2,dz3[i],core,size*0.6)
						end
						if i1~=0 or i2~=0 then
							seg7_3D[i2](dx3[i]+dx[i]+size*1.5,dy3[i]+dy[i]-size*1.2,dz3[i],core,size*0.6)
						end
						if i1~=0 or i2~=0 or i3~=0 then
							seg7_3D[i3](dx3[i]+dx[i]+size,dy3[i]+dy[i]-size*1.2,dz3[i],core,size*0.6)
						end
						seg7_3D[i4](dx3[i]+dx[i]+size*0.5,dy3[i]+dy[i]-size*1.2,dz3[i],core,size*0.6)
						if i==no then
							string3D(_PLAYERNAME(i),dx3[i]+dx[i]-size*0.5,dy3[i]+dy[i]-size*1.2,dz3[i],core,size*0.8,col)
						end
					end
				elseif i==no then
					hudData.rock=0
					hudData.x=0
					hudData.y=0
				end
			end
			if (dz[i]>=0 or math.abs(dx[i])>=0.3 or math.abs(dy[i])>=0.3) and no==i then
				local x1,y1,z1=local3DPos2(_X(hud),_Y(hud),_Z(hud),core)
				local rad=PosToRad(dx[i],dy[i])
				localmove3D(x1+x+0.13*math.cos(rad-math.pi/90),y1+y+0.13*math.sin(rad-math.pi/90),z1,core)
				localline3D(x1+x+0.15*math.cos(rad),y1+y+0.15*math.sin(rad),z1,core)
				localline3D(x1+x+0.13*math.cos(rad+math.pi/90),y1+y+0.13*math.sin(rad+math.pi/90),z1,core)
			end
		end
	end
end

function basicmoniter2D(core,size,col)
	core=core or 0
	size=size/20 or 0.05
	_SETCOLOR(tonumber(col,16))
	--上昇計
	local ex=math.deg(_AX(core))/-5
	for i=-18,18,1 do
		local k=(ex-i)*size*1.5
		if ex-i<=5 and ex-i>=-5 then
			if i==0 then
				local x,y=Rot2D(-8*size,k+size/2,_EZ())
				seg7[0](x,y,size)
				_MOVE2D(Rot2D(-7*size,k,_EZ()))
				_LINE2D(Rot2D(-2*size,k,_EZ()))
				_MOVE2D(Rot2D(7*size,k,_EZ()))
				_LINE2D(Rot2D(2*size,k,_EZ()))
			elseif math.mod(i,2)==0 then
				if i<=18 and i>=-18 then
					angx=math.floor(math.abs(i)/2)
					local x,y=Rot2D(-8*size,k+size/2,_EZ())
					seg7[angx](x-size,y,size)
					seg7[0](x,y,size)
				end
				_MOVE2D(Rot2D(-6*size,k,_EZ()))
				_LINE2D(Rot2D(-2*size,k,_EZ()))
				_MOVE2D(Rot2D(6*size,k,_EZ()))
				_LINE2D(Rot2D(2*size,k,_EZ()))
			else
				_MOVE2D(Rot2D(-4*size,k,_EZ()))
				_LINE2D(Rot2D(-2*size,k,_EZ()))
				_MOVE2D(Rot2D(4*size,k,_EZ()))
				_LINE2D(Rot2D(2*size,k,_EZ()))
			end
		end
	end
	local vx=-_VX(core)/math.abs(_VZ()) local vy=_VY(core)/math.abs(_VZ())
	r=0.3
	_MOVE2D(0+vx*size,r*size+vy*size)
	for i=0,360,45 do
		ang=math.rad(i)
		_LINE2D(math.sin(ang)*r*size+vx*size,math.cos(ang)*r*size+vy*size)
	end	
	_MOVE2D(-r*size+vx*size,vy*size)
	_LINE2D(-r*2*size+vx*size,vy*size)
	_MOVE2D(vx*size,r*size+vy*size)
	_LINE2D(vx*size,r*2*size+vy*size)
	_MOVE2D(r*size+vx*size,vy*size)
	_LINE2D(r*2*size+vx*size,vy*size)
	
	_MOVE2D(0.6*size,0)
	_LINE2D(0.4*size,0)
	_LINE2D(0.2*size,-0.4*size)
	_LINE2D(0,0)
	_LINE2D(-0.2*size,-0.4*size)
	_LINE2D(-0.4*size,0)
	_LINE2D(-0.6*size,0)
	
	--方位計
	ey1=math.deg(_EY(core))
	_MOVE2D(8*size,10*size)
	_LINE2D(-8*size,10*size)
	for i=-180,180,10 do
		if i+ey1>=-16 and i+ey1<=16 then
			if ey1<=0 then
				ey=ey1-360
			end
			k=(i+ey1)*-size/2
			if math.mod(i,90)==0 then tmp=0.4*size
			else tmp=0 end
			if i==0 then _SETCOLOR(tonumber("FF0000",16)) end
			_MOVE2D(k,10*size)
			_LINE2D(k,11*size+tmp)
		end
		_SETCOLOR(tonumber(col,16))
	end
	local tmp=ey1
	if tmp<=0 then tmp=360+tmp
	else tmp=tmp end
	for i=1,-1,-1 do	
		local tmp2=math.mod(math.floor(tmp),10)
		seg7[tmp2](size*i-size/4,13*size,size)
		tmp=tmp/10
	end
	tmp=nil
	_MOVE2D(size*1.8,13.2*size)
	_LINE2D(-size*1.8,13.2*size)
	_LINE2D(-size*1.8,11.8*size)
	_LINE2D(size*1.8,11.8*size)
	_LINE2D(size*1.8,13.2*size)
	
	--速度計 spirytus入れてない限り不要だが999以上は表示できない
	vz=_VZ(core)*-3.6
	i1=math.floor(math.abs(vz)/100)
	i2=math.floor(math.abs(vz)/10)-i1*10
	i3=math.floor(math.abs(vz))-i1*100-i2*10
	if i1~=0 then
		seg7[i1](-11*size-size,11.4*size,size)
	end
	if i1~=0 or i2~=0 then
		seg7[i2](-11*size,11.4*size,size)
	end
	seg7[i3](-11*size+size,11.4*size,size)
	_MOVE2D(-11*size-size,10*size)
	_LINE2D(-11*size+size+size/2,10*size)
	
	--高度計 1万m以上では表示しない
	y=_Y(core)
	if math.abs(y)<10000 then
		i1=math.floor(math.abs(y)/1000)
		i2=math.floor(math.abs(y)/100)-i1*10
		i3=math.floor(math.abs(y)/10)-i1*100-i2*10
		i4=math.floor(math.abs(y))-i1*1000-i2*100-i3*10
		if i1~=0 then
			seg7[i1](10*size-size,11.4*size,size)
		end
		if i1~=0 or i2~=0 then
			seg7[i2](10*size,11.4*size,size)
		end
		if i1~=0 or i2~=0 or i3~=0 then
			seg7[i3](10*size+size,11.4*size,size)
		end
		seg7[i4](10*size+2*size,11.4*size,size)
	else
		_SETCOLOR(tonumber("FF0000",16))
		_MOVE2D(10*size+2*size+size/2,11.4*size)
		_LINE2D(10*size+size+size/2,11.4*size)
		_SETCOLOR(tonumber(col,16))
	end
	_MOVE2D(10*size-size,10*size)
	_LINE2D(10*size+2*size+size/2,10*size)
	
end

function basicmoniter3D(core,hud,size,col,x2,y2,option)
	size=size/20 or 0.05
	local x2=x2 or 0
	local y2=y2 or 0
	local size=size*0.6
	local x1,y1,z1=local3DPos2(_X(hud),_Y(hud),_Z(hud),core)
	option =option or {0}	--いろいろ増えた時のために配列にしておく
	_SETCOLOR(tonumber(col,16))
	local dx=x1+x2
	local dy=y1+y2
	if option[1]==0 then
		--上昇計
		local ex=math.deg(_AX(core))/-5
		for i=-18,18,1 do
			local k=(ex-i)*size*1.4
			if ex-i<=4 and ex-i>=-4 then
				if i==0 then
					local x,y=Rot2D(5.8*size,k+size/2,-_EZ())
					seg7_3D[0](x+dx,y+dy,z1,core,size)
					x,y=Rot2D(4.6*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-4.6*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
				elseif math.mod(i,2)==0 then
					if i<=18 and i>=-18 then
						angx=math.floor(math.abs(i)/2)
						local x,y=Rot2D(4.2*size,k+size/2,-_EZ())
						seg7_3D[0](x+dx,y+dy,z1,core,size)
						seg7_3D[angx](x+dx+size,y+dy,z1,core,size)
					end
					x,y=Rot2D(3*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-3*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
				else
					x,y=Rot2D(2*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-2*size,k,-_EZ())
					localmove3D(x+dx,y+dy,z1,core)
					x,y=Rot2D(-1*size,k,-_EZ())
					localline3D(x+dx,y+dy,z1,core)
				end
			end
		end
		--未来予測
		local vx=_VX(core)/math.abs(_VZ())*20 local vy=_VY(core)/math.abs(_VZ())*20
		if math.abs(vx)<10 and math.abs(vy)<5 then
			r=0.3
			localmove3D(vx*size,dy+r*size+vy*size,z1,core)
			for i=0,360,45 do
				ang=math.rad(i)
				localline3D(math.sin(ang)*r*size+vx*size,dy+math.cos(ang)*r*size+vy*size,z1,core)
			end	
			localmove3D(-r*size+vx*size,dy+vy*size,z1,core)
			localline3D(-r*2*size+vx*size,dy+vy*size,z1,core)
			localmove3D(vx*size,dy+r*size+vy*size,z1,core)
			localline3D(vx*size,dy+r*2*size+vy*size,z1,core)
			localmove3D(r*size+vx*size,dy+vy*size,z1,core)
			localline3D(r*2*size+vx*size,dy+vy*size,z1,core)
			--[[localmove3D(dx+vx*size+size/2,dy+vy*size+size,z1,core)
			localline3D(dx+vx*size,dy+vy*size,z1,core)
			localline3D(dx+vx*size-size/2,dy+vy*size+size,z1,core)
			--雪風みたいにしたが見づらかったので没]]
		end
		--中心
		localmove3D(0.6*size,dy,z1,core)
		localline3D(0.4*size,dy,z1,core)
		localline3D(0.2*size,dy-0.4*size,z1,core)
		localline3D(0,dy,z1,core)
		localline3D(-0.2*size,dy-0.4*size,z1,core)
		localline3D(-0.4*size,dy,z1,core)
		localline3D(-0.6*size,dy,z1,core)
		
		--方位計
		ey1=math.deg(-_EY(core))
		--方位数値
		localmove3D(dx+1.4*size,dy+9*size,z1,core)
		localline3D(dx-1.4*size,dy+9*size,z1,core)
		localline3D(dx-1.4*size,dy+8*size,z1,core)
		localline3D(dx+1.4*size,dy+8*size,z1,core)
		localline3D(dx+1.4*size,dy+9*size,z1,core)
		local tmp=ey1
		if tmp<=0 then tmp=tmp*-1
		else tmp=360-tmp end
		for i=1,-1,-1 do	
			local tmp2=math.mod(math.floor(tmp),10)
			seg7_3D[tmp2](dx-size*0.7*i+size/4,dy+8.8*size,z1,core,size*0.6)
			tmp=tmp/10
		end
		tmp=nil
		--バー
		localmove3D(dx+5.2*size,dy+6.5*size,z1,core)
		localline3D(dx-5.2*size,dy+6.5*size,z1,core)
		for i=-180,180,10 do
			if i+ey1>=-10 and i+ey1<=10 then
				k=(i+ey1)*-size/2
				if math.mod(i,90)==0 then tmp=0.4*size
				else tmp=0 end
				if i==0 then _SETCOLOR(tonumber("FF0000",16)) end
				localmove3D(dx+k,dy+6.5*size,z1,core)
				localline3D(dx+k,dy+7.5*size+tmp,z1,core)
			end
			_SETCOLOR(tonumber(col,16))
		end
		
		--速度計
		local vz=math.floor(math.abs(_VZ(core)*3.6))
		if _VZ()>2 then
			_SETCOLOR(tonumber("FF0000",16))
		end
		local v=0 local t={}
		for i=1,4 do
			t[i]=math.mod(vz,10)
			vz=math.floor(vz/10)
		end
		for i=4,1,-1 do
			if t[i]~=0 then v=1 end
			if v==1 or i==1 then
				seg7_3D[t[i]](dx+7.5*size+size*(i-2),dy+7.8*size,z1,core,size)
			end
		end
		_SETCOLOR(tonumber(col,16))
		localmove3D(dx+7.5*size+size*2,dy+6.5*size,z1,core)
		localline3D(dx+7.5*size-size-size/1.5,dy+6.5*size,z1,core)
		
		--高度計
		y=_Y(core)
		if math.abs(y)<10000 then
			i1=math.floor(math.abs(y)/1000)
			i2=math.floor(math.abs(y)/100)-i1*10
			i3=math.floor(math.abs(y)/10)-i1*100-i2*10
			i4=math.floor(math.abs(y))-i1*1000-i2*100-i3*10
			if i1~=0 then
				seg7_3D[i1](dx-7.5*size+size,dy+7.8*size,z1,core,size)
			end
			if i1~=0 or i2~=0 then
				seg7_3D[i2](dx-7.2*size,dy+7.8*size,z1,core,size)
			end
			if i1~=0 or i2~=0 or i3~=0 then
				seg7_3D[i3](dx-7.2*size-size,dy+7.8*size,z1,core,size)
			end
			seg7_3D[i4](dx-7.2*size-2*size,dy+7.8*size,z1,core,size)
		else
			_SETCOLOR(tonumber("FF0000",16))
			localmove3D(dx-7.8*size-2*size+size/2,dy+7.8*size,z1,core)
			localline3D(dx-7.8*size-size+size/2,dy+7.8*size,z1,core)
			_SETCOLOR(tonumber(col,16))
		end
		localmove3D(dx-7.2*size+size,dy+6.5*size,z1,core)
		localline3D(dx-7.2*size-2*size-size/2,dy+6.5*size,z1,core)
		if option.gear~=1 then
			string3D("GEAR",dx-8*size,dy-size,z1,core,size,col)
		end
	elseif option[1]==1 then
		--[[localmove3D(dx+0.5*size,dy,z1,core)
		localline3D(dx-0.5*size,dy,z1,core)
		localmove3D(dx,dy+0.5*size,z1,core)
		localline3D(dx,dy-0.5*size,z1,core)]]
		
		localmove3D(dx+7.5*size,dy+8*size,z1,core)
		localline3D(dx+8*size,dy+8*size,z1,core)
		localline3D(dx+8*size,dy-8*size,z1,core)
		localline3D(dx+7.5*size,dy-8*size,z1,core)
		
		localmove3D(dx-7.5*size,dy+8*size,z1,core)
		localline3D(dx-8*size,dy+8*size,z1,core)
		localline3D(dx-8*size,dy-8*size,z1,core)
		localline3D(dx-7.5*size,dy-8*size,z1,core)
		
		--速度計 spirytus入れてない限り不要だが9999以上は表示できない
		local vz=math.floor(math.abs(_VZ(core)*3.6))
		if _VZ()>2 then
			_SETCOLOR(tonumber("FF0000",16))
		end
		local v=0 local t={} local size2=size*0.8
		for i=1,4 do
			t[i]=math.mod(vz,10)
			vz=math.floor(vz/10)
		end
		for i=4,1,-1 do
			if t[i]~=0 then v=1 end
			if v==1 or i==1 then
				seg7_3D[t[i]](dx+10*size+size2*(i-2),dy+size2/2,z1,core,size2)
			end
		end
		_SETCOLOR(tonumber(col,16))
		localmove3D(dx+10*size-size2*2,dy+size2*0.8,z1,core)
		localline3D(dx+10*size+size2*2.4,dy+size2*0.8,z1,core)
		localline3D(dx+10*size+size2*2.4,dy-size2*0.8,z1,core)
		localline3D(dx+10*size-size2*2,dy-size2*0.8,z1,core)
		localline3D(dx+10*size-size2*2,dy+size2*0.8,z1,core)
		--G表示
		if option.g~=nil then
			local G=option.g
			if G>100 then G=99 end
			local i1=math.floor(math.abs(G)/10)
			local i2=math.floor(math.abs(G))-i1*10
			local size2=size*0.8
			if i1~=0 then
				seg7_3D[i1](dx+10*size+size,dy-size,z1,core,size2)
			end
			seg7_3D[i2](dx+10*size,dy-size,z1,core,size2)
			string3D("G",dx+10*size-size,dy-size,z1,core,size,col)
		end
		if option.ammo~=nil then
			local ammo=option.ammo
			local i1=math.floor(math.abs(ammo)/1000)
			local i2=math.floor(math.abs(ammo)/100)-i1*10
			local i3=math.floor(math.abs(ammo)/10)-i1*100-i2*10
			local i4=math.floor(math.abs(ammo))-i1*1000-i2*100-i3*10
			if i1~=0 then
				seg7_3D[i1](dx-10*size+size2,dy-size*2,z1,core,size2)
			end
			if i1~=0 or i2~=0 then
				seg7_3D[i2](dx-10*size,dy-size*2,z1,core,size2)
			end
			if i1~=0 or i2~=0 or i3~=0 then
				seg7_3D[i3](dx-10*size-size2,dy-size*2,z1,core,size2)
			end
			seg7_3D[i4](dx-10*size-2*size2,dy-size*2,z1,core,size2)
			string3D("GUN",dx-10*size,dy-size2,z1,core,size,col)
		end
		--高度計
		local y=_Y(core)
		if math.abs(y)<10000 then
			local i1=math.floor(math.abs(y)/1000)
			local i2=math.floor(math.abs(y)/100)-i1*10
			local i3=math.floor(math.abs(y)/10)-i1*100-i2*10
			local i4=math.floor(math.abs(y))-i1*1000-i2*100-i3*10
			if i1~=0 then
				seg7_3D[i1](dx-10*size+size2,dy+size2/2,z1,core,size2)
			end
			if i1~=0 or i2~=0 then
				seg7_3D[i2](dx-10*size,dy+size2/2,z1,core,size2)
			end
			if i1~=0 or i2~=0 or i3~=0 then
				seg7_3D[i3](dx-10*size-size2,dy+size2/2,z1,core,size2)
			end
			seg7_3D[i4](dx-10*size-2*size2,dy+size2/2,z1,core,size2)
		else
			_SETCOLOR(tonumber("FF0000",16))
			localmove3D(dx-10*size-size2*2,dy,z1,core)
			localline3D(dx-10*size+size2*0.5,dy,z1,core)
			_SETCOLOR(tonumber(col,16))
		end
		localmove3D(dx-10*size-size2*3,dy+size2*0.8,z1,core)
		localline3D(dx-10*size+size2*1.2,dy+size2*0.8,z1,core)
		localline3D(dx-10*size+size2*1.2,dy-size2*0.8,z1,core)
		localline3D(dx-10*size-size2*3,dy-size2*0.8,z1,core)
		localline3D(dx-10*size-size2*3,dy+size2*0.8,z1,core)
		localline3D(dx-10*size-size2*2,dy+size2*0.8,z1,core)
	end
end

function cont_def2(core,hud,target,size,rock)
	--core:親チップ名 hud:hudチップ名 size:大きさ指定
	--使用例(core,hud,(x,y,z),size)
	dstx,dsty,dstz=local3DPos2(x,y,z,core)
	dstx2,dsty2,dstz2=local3DPos2(_X(hud),_Y(hud),_Z(hud),core)
	dst2=LEN(dstx2,dsty2,dstz2)
	dst1=LEN(dstx,dsty,dstz)
	dx=(dst2/dst1)*dstx-dstx2
	dy=(dst2/dst1)*dsty-dsty2
	container(core,hud,size,0,dx,dy,rock)
end

function container(chip2,chip1,isize,col,x,y,rock,def)
	local x1,y1,z1=local3DPos2(_X(chip1),_Y(chip1),_Z(chip1),chip2)
	_SETCOLOR(tonumber("FF00",16))
	if rock==1 then
		local x2=hudData.x
		local y2=hudData.y
		if hudData.rock~=2 then
			hudData.rock=rock
		end
		if hudData.rock==2 then
			_SETCOLOR(tonumber("FF0000",16))
			x2=x
			y2=y
		elseif hudData.rock==1 then
			x2=hikeolib.ang(x2,x,0.01)
			y2=hikeolib.ang(y2,y,0.01)
			hudData.x=x2
			hudData.y=y2
			if x2==x and y2==y then
				hudData.rock=2
			end
		end
		localmove3D(x1+x2+isize,y1+y2,z1,chip2)
		for i=0,360,30 do
			k=math.rad(i)
			localline3D(x1+x2+isize*math.cos(k),y1+y2+isize*math.sin(k),z1,chip2)
		end
	end
	if hudData.rock==2 then
		--_SETCOLOR(tonumber("FF0000",16))
	end
	localmove3D(x1+x+isize,y1+y+isize,z1,chip2)
	localline3D(x1+x-isize,y1+y+isize,z1,chip2)
	localline3D(x1+x-isize,y1+y-isize,z1,chip2)
	localline3D(x1+x+isize,y1+y-isize,z1,chip2)
	localline3D(x1+x+isize,y1+y+isize,z1,chip2)
	--_SETCOLOR(tonumber("FF00",16))
end

function reticle(chip2,chip1,isize,col,x,y,range,def)
	local x1,y1,z1=local3DPos2(_X(chip1),_Y(chip1),_Z(chip1),chip2)
	_SETCOLOR(tonumber("FF00",16))
	rock2=rock2 or {3,0}
	x2=x2 or 0 y2=y2 or 0
	def=def or {0,0}
	--[[localmove3D(x1+x+isize,y1+y+isize,z1,chip2)
	localline3D(x1+x-isize,y1+y+isize,z1,chip2)
	localline3D(x1+x-isize,y1+y-isize,z1,chip2)
	localline3D(x1+x+isize,y1+y-isize,z1,chip2)
	localline3D(x1+x+isize,y1+y+isize,z1,chip2)
	localmove3D(x1-x2+x+isize,y1-y2+y,z1,chip2)]]
	localmove3D(x1+x,y1+y+isize*0.5,z1,chip2)
	localline3D(x1+x,y1+y-isize*0.5,z1,chip2)
	localmove3D(x1+x+isize*0.5,y1+y,z1,chip2)
	localline3D(x1+x-isize*0.5,y1+y,z1,chip2)
	localmove3D(x1+x+2*isize+def[1],y1+y+def[2],z1,chip2)
	for i=0,360,30 do
		local k=math.rad(i)
		localline3D(x1+x+2*isize*math.cos(k)+def[1],y1+y+2*isize*math.sin(k)+def[2],z1,chip2)
	end
	for i=0,360,30 do
		local k=math.rad(i)
		localmove3D(x1+x+2*isize*math.cos(k)+def[1],y1+y+2*isize*math.sin(k)+def[2],z1,chip2)
		localline3D(x1+x+2.4*isize*math.cos(k)+def[1],y1+y+2.4*isize*math.sin(k)+def[2],z1,chip2)
	end
	localmove3D(x1+x+def[1],y1+y+1.6*isize+def[2],z1,chip2)
	for i=0,360*range,30 do
		local k=math.rad(i)
		localline3D(x1+x-1.6*isize*math.sin(k)+def[1],y1+y+1.6*isize*math.cos(k)+def[2],z1,chip2)
	end
end


function circle(x,y,r)
	step=18
	for i=0,360,step do
		_MOVE2D(x+r*math.cos(math.rad(i)),y+r*math.sin(math.rad(i)))
		_LINE2D(x+r*math.cos(math.rad(i+step)),y+r*math.sin(math.rad(i+step)))
	end
end
