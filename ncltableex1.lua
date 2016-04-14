local NCLMODEL = require  ("nclmodel")

css = { 
	["media1"] = {
		["top"] = "100",
		["left"] = "100"
	},
	
}

print ("ncl url: "..arg[1])
local file = io.open(arg[1]);
local nclfile = file:read("*all")
file:close()

tabela = NCLMODEL:process(css, nclfile)
