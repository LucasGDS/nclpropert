local SLAXML = require ("slaxdom_ext")
local inspect = require ("inspect")

local nclmodel = {}

function domsearch(proc, knot, v)
	local i
  if knot.el ~= nil then
	for i,n in ipairs(knot.el) do
	      domsearch(proc, knot.el[i], v) --pieces[#pieces+1] = domsearch(proc,n)
	      --elseif n.type=='text' then pieces[#pieces+1] = n.value
	end	    
  end
  
	if knot.el ~= nil then
		if knot.attr["id"] == proc then
			print("ACHOU" .. knot.attr["id"])
			for m,n in pairs(v) do
				local element = {attr = {}, name = "property",type = "element"}
				SLAXML:set_attr(element, "name", m)	--atributo m e seu valor n
				SLAXML:set_attr(element, "value", n)
				table.insert(knot.kids,element)
			end
		end
	    --[[for j,k in ipairs(knot.attr) do 
		if k.name=="id" then    -- forcando atributo id
		    if k.value==proc then
		      print("ACHOU" .. k.value)
		    end
		end
	    end]]
	end
	  --return table.concat(pieces)

end

function nclmodel:process(css, nclfile)
	local doc = SLAXML:dom(nclfile)
	local adicionando

	--print (inspect(doc.root))

	--print (doc.root.el[1].el[1].attr[1].value , doc.root.attr[1].name, doc.root.el[1].el[2].attr[1].value, doc.root.el[1].el[2].attr["id"])

	
	for k,v in pairs(css) do -- lendo tabela css,le um nome da midia k que aponta para o endereco v com os atributos
		adicionando = domsearch(k, doc.root, v)	--procura k em doc
		
		--print(k) 	-- lista de midias ; print(k,v) v mostra endereco tabela
		--if k ==
		--for m,n in pairs(v) do print(m,n) end --atributo m e seu valor n
	end
	
	local serial = SLAXML:serialize(doc)
	
	--serialize test
	file = io.open("out.ncl", "w")
	file:write(serial)
	file:flush()
	file:close()
	--
	
	return doc
end


return nclmodel
