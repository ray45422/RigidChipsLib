--Raylib Ver1.04--

raylib={}
function beengun()	--耐久値が減ると強制的に_BYEします
	for i=0,_CHIPS()-1 do
		if _T(i)~=10000 then
			_BYE(i)
		end
	end
end

function damageLevel(cn,cn2)	--ダメージを適当に三段階で返す
	if _T(cn)==-1 or _PARENT(cn)==-1 then
		return 1
	else
		return math.min(math.floor(_T(cn)/5000)+2,3)
	end
	return 1
end

function numTable(n)	--HUD表示に使おうとした数字を入れると桁ごとに配列に入れて返す関数
	max=math.floor(math.log(n,10)+1)
	local a={}
	n=math.floor(n*10000)
	for i=-3,max do
		a[i]=math.mod(n,10)
		n=math.floor(n/10)
	end
	return a
end

function selecter(v,n)
	if v>n then
		v=v-n-1
	end
	if v<0 then
		v=v+n+1
	end
	return v
end

function LEN(a,b,c)		--3点間の距離 LEN2なんてなかった
	c=c or 0
	return math.sqrt(a^2+b^2+c^2)
end

--[[function LEN2(a,b)		--2点間の距離
	return math.sqrt(a^2+b^2)
end]]

function _VEL(chip)		--Scriptにあった_VEL()もどき
	return LEN(_VX(chip), _VY(chip), _VZ(chip))
end
function sign(n)		--値が正か負か0かを返す
	if n<0 then return -1 end
	if n>0 then return 1 end
	return 0
end
PorM=sign

function PosToRad(x,y)	--極座標変換
	local r=LEN(x,y)
	local a=math.asin(y/r)/math.abs(math.asin(y/r))
	local rad=math.acos(x/r)*a
	return rad,r
end

function Rot2D(x,y,r) --作成者不明 orz8019より
	
	return x*math.cos(r)-y*math.sin(r),x*math.sin(r)+y*math.cos(r)
end

function chip3D(chip,lxp,lyp,lzp) --siruhu/stdlib.lua chip3D13
	size=0.18
	xm,ym,zm=_X(chip),_Y(chip),_Z(chip)
	for chip=math.mod(_TICKS(),2),_CHIPS(),2 do	--for chip=0,_CHIPS()-1 do
		if _TYPE(chip)<7 then
			local xx,xy,xz,yx,yy,yz,zx,zy,zz,x,y,z,lx,ly,lz
			xx,xy,xz=_XX(chip)*0.3*size,_XY(chip)*0.3*size,_XZ(chip)*0.3*size
			yx,yy,yz=_YX(chip)*0.3*size,_YY(chip)*0.3*size,_YZ(chip)*0.3*size
			zx,zy,zz=_ZX(chip)*0.3*size,_ZY(chip)*0.3*size,_ZZ(chip)*0.3*size
			x,y,z=(_X(chip)-xm)*size+xm+lxp,(_Y(chip)-ym)*size+ym+lyp,(_Z(chip)-zm)*size+zm+lzp

			--_SETCOLOR(RGB(math.ceil((10000-_T(chip))/39),math.ceil(_T(chip)/40),0))
			if _T(chip)>8000 then
				_SETCOLOR(RGB(0,255,0))
			elseif _T(chip)>5000 then
				_SETCOLOR(RGB(255,255,0))
			elseif _T(chip)>2000 then
				_SETCOLOR(RGB(255,128,0))
			elseif _T(chip)>0 then
				_SETCOLOR(RGB(255,0,0))
			else
				_SETCOLOR(0)
			end

			_MOVE3D(x+xx+zx,y+xy+zy,z+xz+zz)
			_LINE3D(x+xx-zx,y+xy-zy,z+xz-zz)
			_LINE3D(x-xx-zx,y-xy-zy,z-xz-zz)
			_LINE3D(x-xx+zx,y-xy+zy,z-xz+zz)
			_LINE3D(x+xx+zx,y+xy+zy,z+xz+zz)
			--_LINE3D(x-xx-zx,y-xy-zy,z-xz-zz)
		end
	end
end

function trace_n(a1,a2,n,core,mode,step)
	--プレイヤー方向を向く関数 modeで偏差射撃もできる
	--a1:左右角度 a2：上下角度　n:プレイヤー番号 core:コアチップ番号 step:1フレームあたりの最大回転角 mode:偏差射撃設定(0:off,それ以外:on)
	p_date()
	local px=p_table[n].x
	local py=p_table[n].y
	local pz=p_table[n].z
	local vx=p_table[n].vx
	local vy=p_table[n].vy
	local vz=p_table[n].vz
	local len=p_table[n].len
	local d3
	mode=mode or 0
	if mode~=0 then
		px,py,pz,d3=cross_pos({px,py,pz},{vx,vy,vz},{_X(core),_Y(core),_Z(core)})
	end
	px=px-_X(core)
	py=py-_Y(core)
	pz=pz-_Z(core)
	a1,a2=trace(a1,a2,px,py,pz,step)
	d3=d3 or len
	return a1,a2,d3,d3
end

function trace(a1,a2,px,py,pz,step)
	--指定座標を向く関数
	--a1:左右角度 a2：上下角度　px,py,pz:目標座標
	dz=math.deg(PosToRad(-pz,px))
	local r=math.floor(math.abs(a1)/360)*sign(a1)
	local b
	step=step or 30
	for i=r-1,r+1 do
		b=dz+360*i
		if math.abs(a1-b)<=180 then
			break
		end
	end
	b=b or 0
	a1=hikeolib.ang(a1,b,step)
	dx=90-math.deg(math.atan(py/LEN(px,pz)))
	a2=hikeolib.ang(a2,dx,step)
	return a1,a2
end
	
function jibaku(a,b)	--aからb番目のチップを_BYEする
	if a==0 and b==0 then
		for i=1,_CHIPS()-1 do
			if _TYPE(i)~=9 then
				_BYE(i)
			end
		end
	else
		for i=a,b do
			if _TYPE(i)~=9 then
				_BYE(i)
			end
		end
	end
end

function to24(a)	--CCD関数からチップで使える色へ変換
	b=(math.mod(math.floor(a/1024),32)*65536+math.mod(math.floor(a/32),32)*256+math.mod(a,32))*8
	return b
end
