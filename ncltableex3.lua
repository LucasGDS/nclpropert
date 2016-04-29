local NCLMODEL = require  ("nclmodel")

css = { 
	[".classe"] = {
		["zIndex"] = 0
	},
	["#mVideo"] = {
		["top"] = "0%",
		["left"] = "100%",
		["width"] = "100%",
		["height"] = "100%",
		
		["explicitDur"] = "10s"
	},
	["#mLua"] = {
		["top"] = "2%",
		["left"] = "2%",
		["width"] = "96%",
		["height"] = "96%",
		
	},
}


print ("ncl url: "..arg[1])
local file = io.open(arg[1]);
local nclfile = file:read("*all")
file:close()

tabela = NCLMODEL:process(css, nclfile)


