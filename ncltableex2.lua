local NCLMODEL = require  ("nclmodel")

css = { 
	["*"] = {
		["zIndex"] = 1
	},
	
}

print ("ncl url: "..arg[1]) 
local file = io.open(arg[1]);
local nclfile = file:read("*all")
file:close()

tabela = NCLMODEL:process(css, nclfile)
