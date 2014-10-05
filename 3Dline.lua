--Raylib Ver1.04--

function string3D(str,x,y,z,core,s,col)
	str=str or ""
	size=s*0.8
	x=x-s*0.05
	y=y-s*0.1
	core=core or 0
	--col=col or "FFFFFF"
	_SETCOLOR(tonumber(col or "FFFFFF",16))
	local str=string.upper(str)
	for i=1,string.len(str) do
		local d=-s*(i-1)/2
		local l=string.sub(str,i,i)
		if char3D[l]==nil then
			--error("char3D:"..string.format('%q',l).."not found")
			char3D["false"](x+d,y,z,core,size)
		else
			char3D[l](x+d,y,z,core,size)
		end
		--pcall(char3D[l],x+d,y,z,core,size)
	end
end
char3D={
	["0"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y,z-s/2,core)
		for i=0,360,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y,z+s/2*math.sin(r)-s/2,core)
		end
	end,
	["1"]=function(x,y,z,core,s)
		localmove3D(x-s/6,y-s/8,z,core)
		localline3D(x-s/4,y,z,core)
		localline3D(x-s/4,y-s,z,core)
		
		localmove3D(x-s*3/8,y-s,z,core)
		localline3D(x-s/8,y-s,z,core)
	end,
	["2"]=function(x,y,z,core,s)
		localmove3D(x,y-s/4,z,core)
		for i=180,-30,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		localline3D(x-s/4*math.cos(math.rad(-30))-s/4,y+s/4*math.sin(math.rad(-30))-s/4,z,core)
		localline3D(x,y-s,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["3"]=function(x,y,z,core,s)
		localmove3D(x-s/4*math.cos(math.rad(150))-s/4,y+s/4*math.sin(math.rad(150))-s/4,z,core)
		for i=135,-90,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		for i=90,-150,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s*3/4,z,core)
		end
	end,
	["4"]=function(x,y,z,core,s)
		localmove3D(x-s*3/8,y-s,z,core)
		localline3D(x-s*3/8,y,z,core)
		localline3D(x,y-s*3/4,z,core)
		localline3D(x-s/2,y-s*3/4,z,core)
	end,
	["5"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y,z,core)
		localline3D(x-s/8,y,z,core)
		for i=120,-150,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s*5/16*math.sin(r)-s*11/16,z,core)
		end
	end,
	["6"]=function(x,y,z,core,s)
		localmove3D(x-s/4*math.cos(math.rad(30))-s/4,y+s/4*math.sin(math.rad(30))-s/4,z,core)
		for i=45,90,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		for i=90,270,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/2*math.sin(r)-s/2,z,core)
		end
		for i=270,510,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/3*math.sin(r)-s*2/3,z,core)
		end
		localline3D(x-s/100,y-s*5/8,z,core)
	end,
	["7"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/2,y,z,core)
		localline3D(x-s/4,y-s,z,core)
	end,
	["8"]=function(x,y,z,core,s)
		localmove3D(x-s/4,y,z,core)
		for i=75,-270,-15 do
			local r=math.rad(i)
			localline3D(x-s/5*math.cos(r)-s/4,y+s/5*math.sin(r)-s/5,z,core)
		end
		localmove3D(x-s/4,y-s*2/5,z,core)
		for i=75,-270,-15 do
			local r=math.rad(i)
			localline3D(x-s*3/10*math.cos(r)-s/4,y+s*3/10*math.sin(r)-s*7/10,z,core)
		end
	end,
	["9"]=function(x,y,z,core,s)
		localmove3D(x-s/4,y,z,core)
		for i=75,-15,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		localline3D(x-s/4,y-s,z,core)
		for i=-15,-270,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
	end,
	["-"]=function(x,y,z,core,s)
		localmove3D(x,y-s/2,z,core)
		localline3D(x-s/2,y-s/2,z,core)
	end,
	["_"]=function(x,y,z,core,s)
		localmove3D(x,y-s,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["."]=function(x,y,z,core,s)
		localmove3D(x-s/4,y-s*99/100,z,core,s)
		localline3D(x-s/4,y-s,z,core,s)
		localline3D(x-s/4-s/100,y-s,z,core,s)
		localline3D(x-s/4-s/100,y-s*99/100,z,core,s)
		localline3D(x-s/4,y-s*99/100,z,core,s)
	end,
	["="]=function(x,y,z,core,s)
		localmove3D(x,y-s/3,z,core)
		localline3D(x-s/2,y-s/3,z,core)
		localmove3D(x,y-s*2/3,z,core)
		localline3D(x-s/2,y-s*2/3,z,core)
	end,
	[" "]=function(x,y,z,core,s)
	end,
	["A"]=function(x,y,z,core,s)
		localmove3D(x-s/4,y,z,core)
		localline3D(x-s/2,y-s,z,core)
		
		localmove3D(x-s/4,y,z,core)
		localline3D(x,y-s,z,core)
		
		localmove3D(x-s*5/12,y-s*2/3,z,core)
		localline3D(x-s/12,y-s*2/3,z,core)
	end,
	["B"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/6,y,z,core)
		for i=90,-90,-30 do
			local r=math.rad(i)
			localline3D(x-s/6-s/4*math.cos(r),y+s*7/32*math.sin(r)-s*7/32,z,core)
		end
		for i=90,-90,-30 do
			local r=math.rad(i)
			localline3D(x-s/4-s/4*math.cos(r),y+s*9/32*math.sin(r)-s*23/32,z,core)
		end
		localline3D(x,y-s,z,core)
		localline3D(x,y,z,core)
		
		localmove3D(x,y-s*7/16,z,core)
		localline3D(x-s/6,y-s*7/16,z,core)
	end,
	["C"]=function(x,y,z,core,s)
		localmove3D(x-s*9/32*math.cos(math.rad(45))-s*9/32,y+s/2*math.sin(math.rad(45))-s/2,z,core)
		for i=45,315,15 do
			local r=math.rad(i)
			localline3D(x-s*9/32*math.cos(r)-s*9/32,y+s/2*math.sin(r)-s/2,z,core)
		end
	end,
	["D"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		for i=90,-90,-15 do
			local r=math.rad(i)
			localline3D(x-s/3*math.cos(r)-s/6,y+s/2*math.sin(r)-s/2,z,core)
		end
		localline3D(x,y-s,z,core)
		localline3D(x,y,z,core)
	end,
	["E"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y,z,core)
		localline3D(x,y,z,core)
		localline3D(x,y-s,z,core)
		localline3D(x-s/2,y-s,z,core)
		
		localmove3D(x-s/2,y-s/2,z,core)
		localline3D(x,y-s/2,z,core)
	end,
	["F"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y,z,core)
		localline3D(x,y,z,core)
		localline3D(x,y-s,z,core)
		
		localmove3D(x-s/2,y-s/2,z,core)
		localline3D(x,y-s/2,z,core)
	end,
	["G"]=function(x,y,z,core,s)
		localmove3D(x-s*9/32*math.cos(math.rad(45))-s*9/32,y+s/2*math.sin(math.rad(45))-s/2,z,core)
		for i=45,315,15 do
			local r=math.rad(i)
			localline3D(x-s*9/32*math.cos(r)-s*9/32,y+s/2*math.sin(r)-s/2,z,core)
		end
		localline3D(x-s*9/32*math.cos(math.rad(315))-s*9/32,y-s/2,z,core)
		localline3D(x+s/20-s*9/32,y-s/2,z,core)
		
	end,
	["H"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x,y-s,z,core)
		
		localmove3D(x-s/2,y,z,core)
		localline3D(x-s/2,y-s,z,core)
		
		localmove3D(x,y-s/2,z,core)
		localline3D(x-s/2,y-s/2,z,core)
	end,
	["I"]=function(x,y,z,core,s)
		localmove3D(x-s/4,y,z,core)
		localline3D(x-s/4,y-s,z,core)
		
		localmove3D(x-s/8,y,z,core)
		localline3D(x-s*3/8,y,z,core)
		
		localmove3D(x-s/8,y-s,z,core)
		localline3D(x-s*3/8,y-s,z,core)
	end,
	["J"]=function(x,y,z,core,s)
		localmove3D(x-s*2/8,y,z,core)
		localline3D(x-s*4/8,y,z,core)
		
		localmove3D(x-s*2/5,y,z,core)
		localline3D(x-s*2/5,y-s/4,z,core)
		
		for i=0,-165,-15 do
			local r=math.rad(i)
			localline3D(x-s/5*math.cos(r)-s/5,y+s/4*math.sin(r)-s*3/4,z,core)
		end
	end,
	["K"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x,y-s,z,core)
		
		localmove3D(x-s/2,y,z,core)
		localline3D(x,y-s*5/8,z,core)
		
		localmove3D(x-s/8,y-s*3.7/8,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["L"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x,y-s,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["M"]=function(x,y,z,core,s)
		localmove3D(x,y-s,z,core)
		localline3D(x,y,z,core)
		localline3D(x-s/4,y-s/2,z,core)
		localline3D(x-s/2,y,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["N"]=function(x,y,z,core,s)
		localmove3D(x,y-s,z,core)
		localline3D(x,y,z,core)
		localline3D(x-s/2,y-s,z,core)
		localline3D(x-s/2,y,z,core)
	end,
	["O"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y-s/2,z,core)
		for i=15,360,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/2*math.sin(r)-s/2,z,core)
		end
	end,
	["P"]=function(x,y,z,core,s)
		localmove3D(x,y-s,z,core)
		localline3D(x,y,z,core)
		for i=90,-90,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		localline3D(x,y-s/2,z,core)
	end,
	["Q"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y-s/2,z,core)
		for i=15,360,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/2*math.sin(r)-s/2,z,core)
		end
		localmove3D(x-s/4,y-s*3/4,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["R"]=function(x,y,z,core,s)
		localmove3D(x,y-s,z,core)
		localline3D(x,y,z,core)
		for i=90,-90,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		localline3D(x,y-s/2,z,core)
		localmove3D(x-s/4,y-s/2,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["S"]=function(x,y,z,core,s)
		localmove3D(x-s/2,y-s/4,z,core)
		for i=0,270,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s/4,z,core)
		end
		for i=90,-180,-15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s*3/4,z,core)
		end
	end,
	["T"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/2,y,z,core)
		localmove3D(x-s/4,y-s,z,core)
		localline3D(x-s/4,y,z,core)
	end,
	["U"]=function(x,y,z,core,s)
		--localmove3D(x,y-s*3/4,z,core)
		localmove3D(x,y,z,core)
		
		for i=180,360,15 do
			local r=math.rad(i)
			localline3D(x-s/4*math.cos(r)-s/4,y+s/4*math.sin(r)-s*3/4,z,core)
		end
		localline3D(x-s/2,y,z,core)
	end,
	["V"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/4,y-s,z,core)
		localline3D(x-s/2,y,z,core)
	end,
	["W"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/8,y-s,z,core)
		localline3D(x-s/4,y-s/2,z,core)
		localline3D(x-s*3/8,y-s,z,core)
		localline3D(x-s/2,y,z,core)
	end,
	["X"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/2,y-s,z,core)
		localmove3D(x-s/2,y,z,core)
		localline3D(x,y-s,z,core)
	end,
	["Y"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/4,y-s/2,z,core)
		localline3D(x-s/2,y,z,core)
		localmove3D(x-s/4,y-s/2,z,core)
		localline3D(x-s/4,y-s,z,core)
	end,
	["Z"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/2,y,z,core)
		localline3D(x,y-s,z,core)
		localline3D(x-s/2,y-s,z,core)
	end,
	["false"]=function(x,y,z,core,s)
		localmove3D(x,y,z,core)
		localline3D(x-s/2,y-s,z,core)
		localmove3D(x-s/2,y,z,core)
		localline3D(x,y-s,z,core)
		localmove3D(x,y-s/2,z,core)
		localline3D(x-s/2,y-s/2,z,core)
	end,
}
seg7_3D={
[0]=function(x,y,z,core,s)	
	localmove3D(x,y,z,core)
	localline3D(x,y-s,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x,y,z,core)

end,
[1]=function(x,y,z,core,s)
	--âEÇÃècê¸
	localmove3D(x-s/2,y,z,core)
	localline3D(x-s/2,y-s,z,core)
end,
[2]=function(x,y,z,core,s)
	localmove3D(x,y,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x-s/2,y-s/2,z,core)
	localline3D(x,y-s/2,z,core)
	localline3D(x,y-s,z,core)
	localline3D(x-s/2,y-s,z,core)
end,
[3]=function(x,y,z,core,s)
	localmove3D(x,y,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x,y-s,z,core)
	--ê^ÇÒíÜÇÃâ°ê¸
	localmove3D(x,y-s/2,z,core)
	localline3D(x-s/2,y-s/2,z,core)
end,
[4]=function(x,y,z,core,s)
	localmove3D(x,y,z,core)
	localline3D(x,y-s/2,z,core)
	localline3D(x-s/2,y-s/2,z,core)

	localmove3D(x-s/2,y,z,core)
	localline3D(x-s/2,y-s,z,core)
end,
[5]=function(x,y,z,core,s)
	localmove3D(x-s/2,y,z,core)
	localline3D(x,y,z,core)
	localline3D(x,y-s/2,z,core)
	localline3D(x-s/2,y-s/2,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x,y-s,z,core)
end,
[6]=function(x,y,z,core,s)
	localmove3D(x-s/2,y,z,core)
	localline3D(x,y,z,core)
	localline3D(x,y-s,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x-s/2,y-s/2,z,core)
	localline3D(x,y-s/2,z,core)
end,
[7]=function(x,y,z,core,s)
	localmove3D(x,y,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x-s/2,y-s,z,core)
end,
[8]=function(x,y,z,core,s)

	localmove3D(x,y,z,core)
	localline3D(x,y-s,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x,y,z,core)
	localmove3D(x,y-s/2,z,core)
	localline3D(x-s/2,y-s/2,z,core)
end,
[9]=function(x,y,z,core,s)
	localmove3D(x,y-s,z,core)
	localline3D(x-s/2,y-s,z,core)
	localline3D(x-s/2,y,z,core)
	localline3D(x,y,z,core)
	localline3D(x,y-s/2,z,core)
	localline3D(x-s/2,y-s/2,z,core)
end,
}