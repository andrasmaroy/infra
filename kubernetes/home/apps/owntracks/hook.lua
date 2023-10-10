JSON = assert(loadfile "/config/JSON.lua")() -- http://regex.info/blog/lua/json

function otr_init()
end

function otr_exit()
end

function otr_hook(topic, _type, data)
    local payload = JSON:encode(data)

    otr.publish("homeassistant/" .. topic, payload, 1, 0)
end
