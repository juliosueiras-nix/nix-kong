let
  kong = (import ./. {}).defaultNix.packages.x86_64-linux.kong;
in {
  services.kongServer = { pkgs, ... }: {
    nixos.useSystemd = true;

    nixos.configuration = {
      boot.tmpOnTmpfs = true;

      services.postgresql = {
        enable = true;
        ensureDatabases = [
          "kong"
        ];

        ensureUsers = [{
          name = "root";
          ensurePermissions = {
            "DATABASE kong" = "ALL PRIVILEGES";
          };
        }];
      };

      environment.variables = {
        KONG_CASSANDRA_CONTACT_POINTS = "localhost";
        KONG_PROXY_LISTEN = "0.0.0.0:8000";
        KONG_ADMIN_LISTEN = "0.0.0.0:8001";
        KONG_DATABASE = "postgres";
        KONG_PG_DATABASE = "kong";
        KONG_PG_PASSWORD = "Test";
        KONG_PG_HOST = "localhost";
        KONG_PG_USER = "root";
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.zlib
        ];
      };

      environment.systemPackages = [
        kong
        pkgs.vim
        (pkgs.openresty.override {
          modules = [
            {
              src = pkgs.fetchFromGitHub {
                name = "lua-kong-nginx-module";
                owner = "Kong";
                repo = "lua-kong-nginx-module";
                rev = "0.0.8";
                sha256 = "J0UW5EPo6mU89GkJSKK7RiKTryw3sVVDCb7HTR7ohDA=";
              };
            }
          ];
        })
      ];
    };
    service.useHostStore = true;
    service.ports = [
      "8000:8000/tcp"
      "127.0.0.1:8001:8001/tcp"
      "8443:8443/tcp"
      "127.0.0.1:8444:8444/tcp"
    ];
  };
}
