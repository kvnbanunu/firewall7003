local user = os.getenv('SUDO_USER') or os.getenv('USER') or 'root'
local RULE_BASE = '/home/' .. user
local RULE_PATH = RULE_BASE

local HTTP_PORTS = '80'

ips = {
    variables = {
        nets = { HOME_NET = '192.168.0.0/24', EXTERNAL_NET = 'any'},
        -- nets = { HOME_NET = '192.168.0.10/32', EXTERNAL_NET = 'any'},
        -- nets = { HOME_NET = '{ 192.168.0.10/32, 10.0.0.5/32 }', EXTERNAL_NET = 'any'},
        -- nets = { HOME_NET = '{ 192.168.0.0/24, 10.0.0.0/24 }', EXTERNAL_NET = 'any'},
        -- nets = { HOME_NET = 'any', EXTERNAL_NET = 'any'},
        ports = { HTTP_PORTS = HTTP_PORTS }
    },
    include = RULE_PATH .. '/local.rules'
}

stream = { }
stream_tcp = { }
http_inspect = { }

binder = {
    {
        when = {
            proto = 'tcp',
            ports = HTTP_PORTS
        },
        use = {
            type = 'http_inspect'
        }
    }
}
