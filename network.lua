--Raylib Ver1.04--
p_table={last=0,farther=0,farther2=0}
function p_data_reset()
	for i=0,_PLAYERS() do
		p_table[i]={x=0,y=0,z=0,vx=0,vy=0,vz=0,lenx=0,leny=0,lenz=0,len=0,old_x={},old_y={},old_z={}}
	end
end
raylib=raylib or {}

function p_date(core,data)--コアチップ番号、過去座標の保存数
	core=core or 0
	data=data or 30
	data=data-1
	local own_n=hikeolib.netown()
	if p_table.last~=_TICKS() then
		p_table.farther=0
		p_table.farther2=0
		for i=0,_PLAYERS()-1 do
			p_table[i]=p_table[i] or {x=0,y=0,z=0,vx=0,vy=0,vz=0,vel=0,lenx=0,leny=0,lenz=0,len=0,old_x={},old_y={},old_z={}}
			if i~=own_n and _PLAYERS()>0 then
				table.insert(p_table[i].old_x,1,p_table[i].x)
				table.insert(p_table[i].old_y,1,p_table[i].y)
				table.insert(p_table[i].old_z,1,p_table[i].z)
				if data<table.getn(p_table[i].old_x) then
						table.remove(p_table[i].old_x,data+1)
						table.remove(p_table[i].old_y,data+1)
						table.remove(p_table[i].old_z,data+1)
				end
				for k=2,data do
					if p_table[i].old_x[k]==nil then
						p_table[i].old_x[k]=p_table[i].old_x[k-1]
						p_table[i].old_y[k]=p_table[i].old_y[k-1]
						p_table[i].old_z[k]=p_table[i].old_z[k-1]
					end
				end
				p_table[i].x,p_table[i].y,p_table[i].z=getpos(i)
				p_table[i].vx=p_table[i].old_x[29]-p_table[i].x
				p_table[i].vy=p_table[i].old_y[29]-p_table[i].y
				p_table[i].vz=p_table[i].old_z[29]-p_table[i].z
				p_table[i].vel=LEN(p_table[i].vx,p_table[i].vy,p_table[i].vz)
				p_table[i].lenx=p_table[i].x-_X(core)
				p_table[i].leny=p_table[i].y-_Y(core)
				p_table[i].lenz=p_table[i].z-_Z(core)
				p_table[i].len=LEN(p_table[i].lenx,p_table[i].leny,p_table[i].lenz)
				p_table.farther=math.max(p_table.farther,p_table[i].len)
				p_table.farther2=math.max(p_table.farther2,LEN(p_table[i].lenx,p_table[i].lenz))
			else
				table.insert(p_table[i].old_x,1,p_table[i].x)
				table.insert(p_table[i].old_y,1,p_table[i].y)
				table.insert(p_table[i].old_z,1,p_table[i].z)
				if data<table.getn(p_table[i].old_x) then
						table.remove(p_table[i].old_x,data+1)
						table.remove(p_table[i].old_y,data+1)
						table.remove(p_table[i].old_z,data+1)
				end
				for k=2,data do
					if p_table[i].old_x[k]==nil then
						p_table[i].old_x[k]=p_table[i].old_x[k-1]
						p_table[i].old_y[k]=p_table[i].old_y[k-1]
						p_table[i].old_z[k]=p_table[i].old_z[k-1]
					end
				end
				p_table[i].x=_X(core)
				p_table[i].y=_Y(core)
				p_table[i].z=_Z(core)
				p_table[i].vx=p_table[i].old_x[data]-p_table[i].x
				p_table[i].vy=p_table[i].old_y[data]-p_table[i].y
				p_table[i].vz=p_table[i].old_z[data]-p_table[i].z
				p_table[i].vel=LEN(p_table[i].vx,p_table[i].vy,p_table[i].vz)
				p_table[i].lenx=0
				p_table[i].leny=0
				p_table[i].lenz=0
				p_table[i].len=0
			end
		end
		p_table.last=_TICKS()
	end
	return p_table
end

function getNoise()
	local own_n=hikeolib.netown()
	local mx=0
	local my=0
	local mz=0
	raylib.noise=raylib.noise or {nx,ny,nz,TICKS}
	local myname=_PLAYERNAME(own_n)
	if _TICKS()==raylib.noise.TICKS then
		return raylib.noise.nx,raylib.noise.ny,raylib.noise.nz
	end
	for i=0,_PLAYERS() do
		if _PLAYERNAME(i)==myname.."_M" then
			mx,my,mz=getpos2(i)
			mx=(mx-100)/(_PLAYERCHIPS(i)^(1/3))
			my=(my-100)/(_PLAYERCHIPS(i)^(1/3))
			mz=(mz-100)/(_PLAYERCHIPS(i)^(1/3))
			if LEN(mx,my,mz)>4 then
				mx,my,mz=0,0,0
			end
			raylib.noise.nx=mx
			raylib.noise.ny=my
			raylib.noise.nz=mz
			raylib.noise.TICKS=_TICKS()
			break
		end
	end
	return mx,my,mz
end
function getpos(p)
	local nx,ny,nz=0,0,0
	nx,ny,nz=getNoise()
	nx=nx*(_PLAYERCHIPS(p)^(1/3))
	ny=ny*(_PLAYERCHIPS(p)^(1/3))
	nz=nz*(_PLAYERCHIPS(p)^(1/3))
	local px,py,pz=getpos2(p)
	px=px-nx
	py=py-ny
	pz=pz-nz
	return px,py,pz
end

function getpos2(p)
	math.randomseed(1519)
	local px=_PLAYERX(p)
	math.randomseed(1519)
	local py=_PLAYERY(p)
	math.randomseed(1519)
	local pz=_PLAYERZ(p)
	
	return px,py,pz
end

function NetWork(line,chip,kn)
	p_table=p_date(chip,30)
	kn=kn or 15
	n=n or 0
	if _KEYDOWN(kn)>0 then
		if n~=_PLAYERS() then
			n=n+1
		end
	end
	if n>=_PLAYERS() then
		n=0
	end
	out(line,string.format("No.%d/%d %s Distance=%2.1f m Chip:%d Arm:%d ID:%d",n,_PLAYERS()-1,_PLAYERNAME(n),p_table[n].len,_PLAYERCHIPS(n),_PLAYERARMS(n),_PLAYERID(n)))
	_SETCOLOR(_PLAYERCOLOR(n))
	--[[_MOVE3D(p_table[n].x,p_table[n].y,p_table[n].z)
	for i=1,table.getn(p_table[n].old_x),6 do
		_LINE3D(p_table[n].old_x[i],p_table[n].old_y[i],p_table[n].old_z[i])
	end]]
	--return px,py,pz
end
function NetWork_t(line,chip,kn)
	p_table=p_date()
	kn=kn or 15
	n=n or 0
	if _KEYDOWN(kn)>0 then
		if n~=_PLAYERS() then
			n=n+1
		end
	end
	if n>=_PLAYERS() then
		n=0
	end
	out(line,string.format("No.%d/%d %s Distance=%2.1f m Chip:%d Arm:%d ID:%d",n,_PLAYERS()-1,_PLAYERNAME(n),p_table[n].len,_PLAYERCHIPS(n),_PLAYERARMS(n),_PLAYERID(n)))
	k=_SETCOLOR(_PLAYERCOLOR(n))
	k=_MOVE3D(p_table[n].x,p_table[n].y,p_table[n].z)
	k=_LINE3D(_X(chip),_Y(chip),_Z(chip))
	--return px,py,pz
end
function cross_pos(Pos,vel,myPos)
	local vx=vel[1]
	local vy=vel[2]
	local vz=vel[3]
	local mx=myPos[1] or _X()
	local my=myPos[2] or _Y()
	local mz=myPos[3] or _Z()
	local px=Pos[1]
	local py=Pos[2]
	local pz=Pos[3]
	local d=LEN(px,py,pz)
	local d3=d
	if d<=2000 then
		local d2
		local bs
		if my>0 then
			bs=300
		else
			bs=60
		end
		local ds
		local loop=10
		for i=1,10 do
			ds=d/bs
			px=px-vx*ds
			py=py-vy*ds
			pz=pz-vz*ds
			d2=LEN(px,py,pz)
			d=d2-d3
			if math.abs(d)<0.6 then
				loop=i
				break
			end
			d3=d2
		end
	end
	return px,py,pz,d3
end
function future_pos(Pos,vel,tick)
	local vx=vel[1]
	local vy=vel[2]
	local vz=vel[3]
	local px=Pos[1]
	local py=Pos[2]
	local pz=Pos[3]
	local d=LEN(px,py,pz)
	px=px-vx*tick
	py=py-vy*tick
	pz=pz-vz*tick
	return px,py,pz
end