# Cat feeder

Double relay command with an ESP8266 through HTTP request (Jeedom)

This LUA script is for ESP8266 hardware.

1. Connect to a wifi AP
2. Start a web server and wait for HTTP request
3. If HTTP request received, parse request and get rotate param
4. If rotate = UP : GPIO_0 = HIGH and GPIO_2 = LOW
5. If rotate = DOWN :  GPIO_0 = LOW and GPIO_2 = HIGH
5. If rotate = STOP :  GPIO_0 = HIGH and GPIO_2 = HIGH
5. If rotate = RST :  ESP8266 is restart

![scheme](https://github.com/Wifsimster/distributeur-lua/blob/master/scheme.png)
