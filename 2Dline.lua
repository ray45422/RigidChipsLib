--Raylib Ver1.04--

function circlegraph(x,y,r,per,col,per2,col2)
	if per2==nil then per2=360 else per2=per2*3.6 end
	col2=col2 or 0
	_SETCOLOR(tonumber(col,16))
	if per>100 then per=100 end
	per=per*3.6
	for i=0,per,4 do
		ang=math.rad(i)
		if i>per2 then _SETCOLOR(tonumber(col2,16)) end
		_MOVE2D(x+r*math.sin(ang),y+r*math.cos(ang))
		_LINE2D(x+r*math.sin(ang)/2,y+r*math.cos(ang)/2)
	end	
end

function speedmeter(x,y,vel,col,size)
	size=size or 1
	vel=vel or 0
	size=size*0.2
	_SETCOLOR(tonumber("FF00",16))
	--vz=math.abs(-_VZ()*3.6)
	local vz=math.abs(vel)
	for i=1,-1,-1 do
		seg7[math.floor(math.mod(vz,10))](x+i*size*0.7-size*0.2,y,size)
		vz=vz/10
	end
	per=vz/0.005*0.35
	if per>100 then per=100 end
	per=per*3.6
	for i=-90,per-90,2 do
		ang=math.rad(i)
		_MOVE2D(x+0.05*size+size*4*math.sin(ang)/3,y-size*0.5+size*4*math.cos(ang)/3)
		_LINE2D(x+0.05*size+size*4*math.sin(ang)/2,y-size*0.5+size*4*math.cos(ang)/2)
	end
end
g_data={}

function g_draw(ID,data,dmax,col,m)
	g_data[ID]=g_data[ID] or {a={},m}
	col=col or "FF0000"
	dmax=dmax or 30
	table.insert(g_data[ID].a,data)
	if g_data[ID].m==nil then
		m=math.abs(0.8/data)
		g_data[ID].m=m
	end
	if m==nil then
		m=math.min(math.abs(0.8/data),g_data[ID].m)
	end
	g_data[ID].m=m
	if dmax<table.getn(g_data[ID].a) then
		table.remove(g_data[ID].a,1)
	end
	_SETCOLOR(tonumber("FFFFFF",16))
	_MOVE2D(-1,0.8)
	_LINE2D(-1,-0.8)
	_MOVE2D(1,0)
	_LINE2D(-1,0)
	_SETCOLOR(tonumber(col,16))
	_MOVE2D(-1,g_data[ID]["a"][1]*m)
	for i=2,dmax do
		if g_data[ID]["a"][i]~=nil then
			_LINE2D(-1+2/dmax*(i-1),g_data[ID]["a"][i]*m)
		end
	end
end
--0:全初期化,1:倍率のみ初期化,2:データのみ初期化
function g_reset(ID,mode)
	mode=mode or 0
	if mode==0 then
		g_data[ID]={a={},m}
	end
	if mode==1 then
		g_data[ID].m=nil
	end
	if mode==2 then
		g_data[ID].a={}
	end
end