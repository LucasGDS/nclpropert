local SLAXML = require ("slaxdom_ext")
--local inspect = require ("inspect")

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
		if string.sub(proc, 1, 1) == "#"and knot.attr["id"] == string.sub(proc, 2) then
			print("ACHOU" .. knot.attr["id"])
			if knot.name == "media" then
				for m,n in pairs(v) do
					local element = {attr = {}, name = "property",type = "element"}
					SLAXML:set_attr(element, "name", m)	--atributo m e seu valor n
					SLAXML:set_attr(element, "value", n)
					table.insert(knot.kids,element)
				end
			else
				for m,n in pairs(v) do
					SLAXML:set_attr(knot, m, n)	--atributo m e seu valor n
				end
			end
		elseif  string.sub(proc, 1, 1) == "." and knot.attr["class"] == string.sub(proc, 2) then
			print("ACHOU")-- .. knot.attr["id"])
			if knot.name == "media" then
				for m,n in pairs(v) do
					local element = {attr = {}, name = "property",type = "element"}
					SLAXML:set_attr(element, "name", m)	--atributo m e seu valor n
					SLAXML:set_attr(element, "value", n)
					table.insert(knot.kids,element)
				end
			else
				for m,n in pairs(v) do
					SLAXML:set_attr(knot, m, n)	--atributo m e seu valor n
				end
			end
		elseif  knot.attr["id"] ~= nil and proc == "*" and knot.attr["src"] ~= nil then --knot.attr["src"] ~= nil makes sure its a media(keep it?)
			print("ACHOU")-- .. knot.attr["id"])
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

function nclmodel:process(css, nclfile, out)
	local name = out or "out.xml"
	local doc = SLAXML:dom(nclfile)
	local adicionando

	--print (inspect(doc.root))

	--print (doc.root.el[1].el[1].attr[1].value , doc.root.attr[1].name, doc.root.el[1].el[2].attr[1].value, doc.root.el[1].el[2].attr["id"])

	
	for k,v in pairs(css) do -- lendo tabela css,le um nome da midia k que aponta para o endereco v com os atributos
		adicionando = domsearch(k, doc.root, v)	--procura k em doc
	end
	
	local serial = SLAXML:serialize(doc)
	
	--serialize test 
	--TODO: save as anything other than ncl
	file = io.open(name, "w")
	file:write(serial)
	file:flush()
	file:close()
	--
	
	return doc
end


return nclmodel
