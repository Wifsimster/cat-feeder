require('config')

-- Setup wifi
wifi.setmode(wifi.STATION)
wifi.sta.config(AP,PWD)

-- Declare GPIO
gpio_0 = 3
gpio_2 = 4

-- SET GPIO to OUTPUT
gpio.mode(gpio_0, gpio.OUTPUT)
gpio.mode(gpio_2, gpio.OUTPUT)

-- Init GPIO at boot
gpio.write(gpio_0, gpio.HIGH);
gpio.write(gpio_2, gpio.HIGH);
 
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
  
        local _on,_off = "",""
        if(_GET.rotate == "UP")then
              gpio.write(gpio_0, gpio.HIGH);
              gpio.write(gpio_2, gpio.LOW);
        elseif(_GET.rotate == "DOWN")then
              gpio.write(gpio_0, gpio.LOW);
              gpio.write(gpio_2, gpio.HIGH);
        elseif(_GET.rotate == "STOP")then
              gpio.write(gpio_0, gpio.HIGH);
              gpio.write(gpio_2, gpio.HIGH);
        elseif(_GET.rotate == "RST")then
              node.restart();
        end
 
        -- Cloture de la session
        local response = "HTTP/1.1 200 OK\r\n\r\nOK"
        conn:send(response, function()
            conn:close()
        end)
        collectgarbage();
    end)
end)
