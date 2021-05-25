{ lua51Packages, pkgs }:

with pkgs;
with lua51Packages;

let
  lyaml = buildLuarocksPackage {
    pname = "lyaml";
    version = "6.2.7-1";

    src = fetchurl {
      url = "https://luarocks.org/lyaml-6.2.7-1.src.rock";
      sha256 = "1sh1q84n109j4sammgbzyr69ni7fxnrjfwqb49fsbrhhd49vw7ca";
    };
    disabled = (luaOlder "5.1") || (luaAtLeast "5.5");
    propagatedBuildInputs = [ lua ];

    externalDeps = [{
      name = "YAML";
      dep = libyaml;
    }];

    meta = with stdenv.lib; {
      homepage = "http://github.com/gvvaughan/lyaml";
      description = "libYAML binding for Lua";
      license.fullName = "MIT/X11";
    };
  };

  lua-resty-worker-events = buildLuarocksPackage {
    pname = "lua-resty-worker-events";
    version = "1.0.0-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-worker-events-1.0.0-1.src.rock";
      sha256 = "0nzn6kr2pmizdyywfqq2jgz8qmr3bw7qfiiy5xi46dwih15frfvh";
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/lua-resty-worker-events";
      description = "Cross worker eventbus for OpenResty";
      license.fullName = "Apache 2.0";
    };
  };

  lua-resty-healthcheck = buildLuarocksPackage {
    pname = "lua-resty-healthcheck";
    version = "1.4.1-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-healthcheck-1.4.1-1.src.rock";
      sha256 = "1vryb29yj7819kp0qr4g07dacwsbvqww7kpfyk2i9cdf56c9zbiw";
    };
    propagatedBuildInputs =
      [ lua-resty-worker-events penlight lua-resty-timer ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/lua-resty-healthcheck";
      description =
        "Healthchecks for OpenResty to check upstream service status";
      license.fullName = "Apache 2.0";
    };
  };

  penlight = buildLuarocksPackage {
    pname = "penlight";
    version = "1.9.2-1";

    src = fetchurl {
      url = "https://luarocks.org/penlight-1.9.2-1.src.rock";
      sha256 = "1yymf60b3ax50pgqdk6p849f2pwpy1bh78y2gz38lnjam25pgrs9";
    };
    propagatedBuildInputs = [ luafilesystem ];

    meta = with stdenv.lib; {
      homepage = "https://lunarmodules.github.io/Penlight";
      description =
        "Lua utility libraries loosely based on the Python standard libraries";
      license.fullName = "MIT/X11";
    };
  };

  luasec = buildLuarocksPackage {
    pname = "luasec";
    version = "1.0.1-1";

    src = fetchurl {
      url = "https://luarocks.org/luasec-1.0.1-1.src.rock";
      sha256 = "0384afx1w124ljs3hpp31ldqlrrgsa2xl625sxrx79yddilgk48f";
    };

    externalDeps = [{
      name = "OPENSSL";
      dep = openssl;
    }];

    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua luasocket ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/brunoos/luasec/wiki";
      description =
        "A binding for OpenSSL library to provide TLS/SSL communication over LuaSocket.";
      license.fullName = "MIT";
    };
  };

  lualogging = buildLuarocksPackage {
    pname = "lualogging";
    version = "1.5.1-1";

    src = fetchurl {
      url = "https://luarocks.org/lualogging-1.5.1-1.src.rock";
      sha256 = "1c98dnpfa2292g9xhpgsrfdvm80r1fhndrpay1hcgnq0qnz1sibh";
    };
    propagatedBuildInputs = [ luasocket ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/lunarmodules/lualogging";
      description = "A simple API to use logging features";
      license.fullName = "MIT/X11";
    };
  };

  lua-resty-session = buildLuarocksPackage {
    pname = "lua-resty-session";
    version = "3.8-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-session-3.8-1.src.rock";
      sha256 = "1x4l6n0dnm4br4p376r8nkg53hwm6a48xkhrzhsh9fcd5xqgqvxz";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/bungle/lua-resty-session";
      description = "Session Library for OpenResty – Flexible and Secure";
      license.fullName = "BSD";
    };
  };

  lua-resty-lrucache = buildLuarocksPackage {
    pname = "lua-resty-lrucache";
    version = "0.09-2";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-lrucache-0.09-2.src.rock";
      sha256 = "00pa7v1ndcgdbsrng8w88sxf5f7yph0488yhkcpb9lmgh7fa1j4h";
    };

    meta = with stdenv.lib; {
      homepage = "https://openresty.org/";
      description =
        "lua-resty-lrucache - Lua-land LRU cache based on the LuaJIT FFI.";
      license.fullName = "2bsd";
    };
  };

  lua-resty-acme = buildLuarocksPackage {
    pname = "lua-resty-acme";
    version = "0.6.0-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-acme-0.6.0-1.src.rock";
      sha256 = "01za0zwl0c9y9njcyfl50ckb28lxdqq722nm0k3b7z11yvxbqag8";
    };
    propagatedBuildInputs =
      [ lua-resty-http lua-resty-lrucache lua-resty-openssl ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/fffonion/lua-resty-acme";
      description =
        "Automatic Let's Encrypt certificate serving and Lua implementation of ACME procotol";
      license.fullName = "BSD";
    };
  };

  lua-cjson = buildLuarocksPackage {
    pname = "lua-cjson";
    version = "2.1.0.6-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-cjson-2.1.0.6-1.src.rock";
      sha256 = "0dqqkn0aygc780kiq2lbydb255r8is7raf7md0gxdjcagp8afps5";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "http://www.kyne.com.au/~mark/software/lua-cjson.php";
      description = "A fast JSON encoding/parsing module";
      license.fullName = "MIT";
    };
  };

  lua-resty-timer = buildLuarocksPackage {
    pname = "lua-resty-timer";
    version = "1.1.0-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-timer-1.1.0-1.src.rock";
      sha256 = "0r5h0f0azir2c299g41xck6mr06d0m3cigpfva37r0rhnd4gjchn";
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/kong/lua-resty-timer";
      description = "Extended timer library for OpenResty";
      license.fullName = "Apache 2.0";
    };
  };

  luaxxhash = buildLuarocksPackage {
    pname = "luaxxhash";
    version = "1.0.0-1";

    knownRockspec = (fetchurl {
      url = "https://luarocks.org/luaxxhash-1.0.0-1.rockspec";
      sha256 = "1jnldjnydfmcbn238p6p1ndxjjjgb06k30iv9srmd06awvchxam2";
    }).outPath;

    src = fetchgit (removeAttrs (builtins.fromJSON ''
      {
        "url": "git://github.com/szensk/luaxxhash",
        "rev": "7bcca4f6da3385ca43eb2e3378ae7a66762bb4df",
        "date": "2020-09-09T12:34:55-05:00",
        "sha256": "1h6vrglvih7dw9lab6900b8qd0wky1c6ri35rwgzfa03clfr18z0",
        "fetchSubmodules": true,
        "deepClone": false,
        "leaveDotGit": false
      }
       '') [ "date" ]);

    meta = with stdenv.lib; {
      homepage = "https://github.com/szensk/luaxxhash";
      description = "A LuaJIT implementation of xxhash";
      license.fullName = "MIT";
    };
  };

  lrandom = buildLuarocksPackage {
    pname = "lrandom";
    version = "20180729-1";

    src = fetchurl {
      url = "https://luarocks.org/lrandom-20180729-1.src.rock";
      sha256 = "1f7ahv98sdxy07w41rpkkny9vsl0jva9radlkjq3isrg410syxwv";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "http://webserver2.tecgraf.puc-rio.br/~lhf/ftp/lua/";
      description =
        "A library for generating random numbers for Lua based on the Mersenne Twister.";
      license.fullName = "MIT";
    };
  };

  loadkit = buildLuarocksPackage {
    pname = "loadkit";
    version = "1.1.0-1";

    src = fetchurl {
      url = "https://luarocks.org/loadkit-1.1.0-1.src.rock";
      sha256 = "1jxwzsjdhiahv6qdkl076h8xf0lmypibh71bz6slqckqiaq1qqva";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/leafo/loadkit";
      description =
        "Loadkit allows you to load arbitrary files within the Lua package path";
      license.fullName = "MIT";
    };
  };

  etlua = buildLuarocksPackage {
    pname = "etlua";
    version = "1.3.0-1";

    src = fetchurl {
      url = "https://luarocks.org/etlua-1.3.0-1.src.rock";
      sha256 = "029710wg0viwf57f97sqwjqrllcbj8a4igj31rljkiisyf36y6ka";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/leafo/etlua";
      description = "Embedded templates for Lua";
      license.fullName = "MIT";
    };
  };

  date = buildLuarocksPackage {
    pname = "date";
    version = "2.1.3-1";

    src = fetchurl {
      url = "https://luarocks.org/date-2.1.3-1.src.rock";
      sha256 = "1lpd72ajla1ggvi10gvv4mj5fa6sin53kwcbn0d5lc3jw01glmal";
    };
    disabled = (luaOlder "5.0") || (luaAtLeast "5.5");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Tieske/date";
      description = "Date & Time module for Lua 5.x";
      license.fullName = "MIT";
    };
  };

  kong-plugin-azure-functions = buildLuarocksPackage {
    pname = "kong-plugin-azure-functions";
    version = "1.0.0-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-azure-functions-1.0.0-1.src.rock";
      sha256 = "1rwarr230rkby8hbxc54a2qm3cxnmx471grh2wlg1lmdqk27by2r";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "git://github.com/kong/kong-plugin-azure-functions";
      description = "This plugin allows Kong to invoke Azure functions.";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-zipkin = buildLuarocksPackage {
    pname = "kong-plugin-zipkin";
    version = "1.3.0-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-zipkin-1.3.0-1.src.rock";
      sha256 = "1q1f0l4lq4amlrj0x2yjf8k37kw4mvsqxad7r9ml66xdc76d4f3h";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lua-cjson lua-resty-http ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/kong/kong-plugin-zipkin";
      description =
        "This plugin allows Kong to propagate Zipkin headers and report to a Zipkin server";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-serverless-functions = buildLuarocksPackage {
    pname = "kong-plugin-serverless-functions";
    version = "2.1.0-0";

    src = fetchurl {
      url =
        "https://luarocks.org/kong-plugin-serverless-functions-2.1.0-0.src.rock";
      sha256 = "1q21i0wlcq87aigqxv0av5il1y8wjnsqkwq69ryncm8b73r4whiq";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "git://github.com/kong/kong-plugin-serverless-functions";
      description = "Dynamically run Lua code from Kong during plugin phases.";
      license.fullName = "Apache 2.0";
    };
  };

  kong-prometheus-plugin = buildLuarocksPackage {
    pname = "kong-prometheus-plugin";
    version = "1.2.1-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-prometheus-plugin-1.2.1-1.src.rock";
      sha256 = "0q9l39xy03351jlbsiw4j2s44lkzwmpxjc5r0g4fvwf88fgzhvk0";
    };
    propagatedBuildInputs = [ lua-resty-counter ];

    meta = with stdenv.lib; {
      homepage = "git://github.com/Kong/kong-plugin-prometheus";
      description =
        "Prometheus metrics for Kong and upstreams configured in Kong";
      license.fullName = "Apache 2.0";
    };
  };

  kong-proxy-cache-plugin = buildLuarocksPackage {
    pname = "kong-proxy-cache-plugin";
    version = "1.3.1-0";

    knownRockspec = (fetchurl {
      url = "https://luarocks.org/kong-proxy-cache-plugin-1.3.1-0.rockspec";
      sha256 = "1widk6w6yh4j4wnibv2hnlvdwz6pxbys7jfnnaqwfnil3i3ff1h1";
    }).outPath;

    src = fetchgit (removeAttrs (builtins.fromJSON ''
      {
        "url": "git://github.com/Kong/kong-plugin-proxy-cache",
        "rev": "76d5beb8ac3aa70f3442d65e0537f902f11d9f57",
        "date": "2020-10-14T23:10:50+08:00",
        "sha256": "0fhxfqq8mk8qrjlv7m764dn0vzwqrpvsngaqifp3zsslrqflkkpx",
        "fetchSubmodules": true,
        "deepClone": false,
        "leaveDotGit": false
      }
       '') [ "date" ]);

    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "git://github.com/Kong/kong-plugin-proxy-cache";
      description = "HTTP Proxy Caching for Kong";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-request-transformer = buildLuarocksPackage {
    pname = "kong-plugin-request-transformer";
    version = "1.3.2-0";

    src = fetchurl {
      url =
        "https://luarocks.org/kong-plugin-request-transformer-1.3.2-0.src.rock";
      sha256 = "0lfpj62jdl4ylnwgxd7ij3q0n2ln3pzpga3l093qkamlk57ah3qc";
    };

    meta = with stdenv.lib; {
      homepage = "git://github.com/Kong/kong-plugin-request-transformer";
      description = "Kong Request Transformer Plugin";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-session = buildLuarocksPackage {
    pname = "kong-plugin-session";
    version = "2.4.5-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-session-2.4.5-1.src.rock";
      sha256 = "0lf5x9qw9shv75jn3nrdjb6mbhv7yp4hh5l03vb6gkq8wxm3y6nj";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lua-resty-session ];

    meta = with stdenv.lib; {
      homepage = "http://konghq.com";
      description =
        "A Kong plugin to support implementing sessions for auth plugins.";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-aws-lambda = buildLuarocksPackage {
    pname = "kong-plugin-aws-lambda";
    version = "3.5.4-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-aws-lambda-3.5.4-1.src.rock";
      sha256 = "0nsca38spv3c5z6lzkzzr8m2bf4nvyzfzp94b7ljih03rikfhbza";
    };
    propagatedBuildInputs = [ lua-resty-openssl ];

    meta = with stdenv.lib; {
      homepage = "http://konghq.com";
      description = "Kong plugin to invoke AWS Lambda functions";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-acme = buildLuarocksPackage {
    pname = "kong-plugin-acme";
    version = "0.2.14-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-acme-0.2.14-1.src.rock";
      sha256 = "15f1c93icfchsw5r5zirmn1sggivqpmrb2dz2mci2y4vmsix1c8z";
    };
    propagatedBuildInputs = [ lua-resty-acme ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/kong-plugin-acme";
      description = "Let's Encrypt integration with Kong";
      license.fullName = "Apache 2.0";
    };
  };

  kong-plugin-grpc-web = buildLuarocksPackage {
    pname = "kong-plugin-grpc-web";
    version = "0.2.0-0";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-grpc-web-0.2.0-0.src.rock";
      sha256 = "08k2ly22fw1kcp1mnckny0wh21yakvyfap8b401gv64z7pa7954m";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lua-protobuf lua_pack ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/kong-plugin-grpc-web";
      description = "gRPC-Web gateway for Kong.";
      license.fullName = "MIT";
    };
  };

  kong-plugin-grpc-gateway = buildLuarocksPackage {
    pname = "kong-plugin-grpc-gateway";
    version = "0.1.2-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-plugin-grpc-gateway-0.1.2-1.src.rock";
      sha256 = "1hl8iqk2qs31vsrh1j45w2j65m42q8lgh5gqqd4s5adyb2zdw6ar";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lua-protobuf lua_pack ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/kong-plugin-grpc-gateway";
      description = "grpc-gateway gateway for Kong.";
      license.fullName = "MIT";
    };
  };

  lua-resty-ipmatcher = buildLuarocksPackage {
    pname = "lua-resty-ipmatcher";
    version = "0.6-0";

    knownRockspec = (fetchurl {
      url = "https://luarocks.org/lua-resty-ipmatcher-0.6-0.rockspec";
      sha256 = "13zxydizvb7f0md9ai0zfdxh9ancpamsg9fxshk9r1p6a36sr3ka";
    }).outPath;

    src = fetchgit (removeAttrs (builtins.fromJSON ''
      {
        "url": "git://github.com/iresty/lua-resty-ipmatcher",
        "rev": "211e0d2eb8bbb558b79368f89948a0bafdc23654",
        "date": "2021-05-06T15:02:38+08:00",
        "sha256": "1d5j8kdnnrniyflginxf5r3ry32xwkldlcg3l9wmsxzjf86w4f93",
        "fetchSubmodules": true,
        "deepClone": false,
        "leaveDotGit": false
      }
       '') [ "date" ]);

    meta = with stdenv.lib; {
      homepage = "https://github.com/iresty/lua-resty-ipmatcher";
      description = "High performance match IP address for Lua(OpenResty).";
      license.fullName = "Apache License 2.0";
    };
  };

  lua-resty-openssl = buildLuarocksPackage {
    pname = "lua-resty-openssl";
    version = "0.7.2-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-openssl-0.7.2-1.src.rock";
      sha256 = "00z6adib31ax4givq4zrhbfxa6l99l2hhlxnjpb6rfl4gf8h82kq";
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/fffonion/lua-resty-openssl";
      description = "No summary";
      license.fullName = "BSD";
    };
  };

  lua-resty-counter = buildLuarocksPackage {
    pname = "lua-resty-counter";
    version = "0.2.1-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-counter-0.2.1-1.src.rock";
      sha256 = "067f544wkx3rnbia6qiwwwch2xas651bcx14l22jjlgxq9rc94pq";
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/lua-resty-counter";
      description = "lua-resty-counter - Lock-free counter for OpenResty.";
      license.fullName = "Apache";
    };
  };

  lua-resty-cookie = buildLuarocksPackage {
    pname = "lua-resty-cookie";
    version = "0.1.0-1";

    knownRockspec = (fetchurl {
      url = "https://luarocks.org/lua-resty-cookie-0.1.0-1.rockspec";
      sha256 = "0k2fzfiiaf0qza7fhpm8kszmywbnkxvabvhjadvhnqpvil45w0yv";
    }).outPath;

    src = fetchgit (removeAttrs (builtins.fromJSON ''
      {
        "url": "git://github.com/cloudflare/lua-resty-cookie.git",
        "rev": "303e32e512defced053a6484bc0745cf9dc0d39e",
        "date": "2020-08-24T12:28:47+01:00",
        "sha256": "0y6006xscxvplzaqj9209h0lgvks15kr2wkif8h59kqn4a116cw5",
        "fetchSubmodules": true,
        "deepClone": false,
        "leaveDotGit": false
      }
       '') [ "date" ]);

    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/cloudflare/lua-resty-cookie";
      description =
        "Lua library for HTTP cookie manipulations for OpenResty/ngx_lua";
      license.fullName = "BSD";
    };
  };

  lua-resty-mlcache = buildLuarocksPackage {
    pname = "lua-resty-mlcache";
    version = "2.5.0-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-mlcache-2.5.0-1.src.rock";
      sha256 = "1krhbx7nska93aa2maqkm1wm65byi8s5lvsqrdy8jzy3h5qr9i1s";
    };

    meta = with stdenv.lib; {
      homepage = "https://github.com/thibaultcha/lua-resty-mlcache";
      description = "Layered caching library for OpenResty";
      license.fullName = "MIT";
    };
  };

  lua-protobuf = buildLuarocksPackage {
    pname = "lua-protobuf";
    version = "0.3.2-0";

    src = fetchurl {
      url = "https://luarocks.org/lua-protobuf-0.3.2-0.src.rock";
      sha256 = "0y7jpkmq6q4d11gma4j42z3k51ng994qckz1y2mqrgagcpnnniz2";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/starwing/lua-protobuf";
      description = "protobuf data support for Lua";
      license.fullName = "MIT";
    };
  };

  lua-resty-dns-client = buildLuarocksPackage {
    pname = "lua-resty-dns-client";
    version = "6.0.0-1";

    src = fetchurl {
      url = "https://luarocks.org/lua-resty-dns-client-6.0.0-1.src.rock";
      sha256 = "0lqnxbbxikklmwziw34d96mzsqywrbas2dy4ycm5rnsnq3gf2c3i";
    };
    disabled = (luaOlder "5.1") || (luaAtLeast "5.4");
    propagatedBuildInputs =
      [ lua penlight lrandom lua-resty-timer binaryheap luaxxhash ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/lua-resty-dns-client";
      description = "DNS library";
      license.fullName = "Apache 2.0";
    };
  };

  lua_pack = buildLuarocksPackage {
    pname = "lua_pack";
    version = "1.0.5-0";

    knownRockspec = (fetchurl {
      url = "https://luarocks.org/lua_pack-1.0.5-0.rockspec";
      sha256 = "1n2n0vc7md803dg0l443243y48pnin34dlf57vgc4j3vs45kp0kg";
    }).outPath;

    src = fetchgit (removeAttrs (builtins.fromJSON ''
      {
        "url": "git://github.com/mashape/lua-pack",
        "rev": "a6be40142a543b4cb745c19b40669961c89c50c2",
        "date": "2017-07-12T13:02:01-07:00",
        "sha256": "05i8a5zg0ssslaingsmbff2592npd583nw2ay5l2x58lkkqkfg15",
        "fetchSubmodules": true,
        "deepClone": false,
        "leaveDotGit": false
      }
       '') [ "date" ]);

    disabled = (luaOlder "5.1") || (luaAtLeast "5.3");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/mashape/lua-pack";
      description =
        "This is a simple Lua library for packing and unpacking binary data";
      license.fullName = "MIT";
    };
  };

  luasyslog = buildLuarocksPackage {
    pname = "luasyslog";
    version = "2.0.1-1";

    src = fetchurl {
      url = "https://luarocks.org/luasyslog-2.0.1-1.src.rock";
      sha256 = "1skhcqhd4pg6sx882w5v04gq7k679ay31irmyy7hz64yg3qwvlh2";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lualogging ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/lunarmodules/luasyslog";
      description = "Syslog logging for Lua";
      license.fullName = "MIT/X11";
    };
  };

  lua_system_constants = buildLuarocksPackage {
    pname = "lua_system_constants";
    version = "0.1.4-0";

    src = fetchurl {
      url = "https://luarocks.org/lua_system_constants-0.1.4-0.src.rock";
      sha256 = "0cd46bahgrrp0dmkb7ry9ihd4grwzak3g11ijhcwqvlf77j2w5vm";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/kong/lua-system-constants";
      description = "System Constants";
      license.fullName = "MIT";
    };
  };

  luatz = buildLuarocksPackage {
    pname = "luatz";
    version = "0.4-1";

    src = fetchurl {
      url = "https://luarocks.org/luatz-0.4-1.src.rock";
      sha256 = "16pkg4q1h0cwsvc19jgi0brwfxfkrr6gwzg8bym2z10qgl4rgybs";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/daurnimator/luatz/archive/v0.4.tar.gz";
      description = "library for time and date manipulation.";
      license.fullName = "MIT";
    };
  };

  pgmoon = buildLuarocksPackage {
    pname = "pgmoon";
    version = "1.12.0-1";

    src = fetchurl {
      url = "https://luarocks.org/pgmoon-1.12.0-1.src.rock";
      sha256 = "0sfhzmgkb2x7xh6gq3646dwhn73h9sp2brr419ps7qwm86v125fh";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua lpeg ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/leafo/pgmoon";
      description = "Postgres driver for OpenResty and Lua";
      license.fullName = "MIT";
    };
  };

  lua-cassandra = buildLuarocksPackage {
    pname = "lua-cassandra";
    version = "1.5.1-0";

    src = fetchurl {
      url = "https://luarocks.org/lua-cassandra-1.5.1-0.src.rock";
      sha256 = "0jcdsdssmg5aahy8vw6bhngw3waif3yrx3df6wv2pzxrf05nn28n";
    };
    propagatedBuildInputs = [ luabitop ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/thibaultcha/lua-cassandra";
      description = "A pure Lua client library for Apache Cassandra";
      license.fullName = "MIT";
    };
  };

  kong-lapis = buildLuarocksPackage {
    pname = "kong-lapis";
    version = "1.8.3.1-1";

    src = fetchurl {
      url = "https://luarocks.org/kong-lapis-1.8.3.1-1.src.rock";
      sha256 = "1v46fmw329dnhlh3zgg2wq6czsldw2pgj1p6jryvrfcrkw6j0lc4";
    };
    propagatedBuildInputs = [
      ansicolors
      date
      etlua
      loadkit
      lpeg
      luafilesystem
      luasocket
      pgmoon
      lua-resty-openssl
    ];

    meta = with stdenv.lib; {
      homepage = "git://github.com/Kong/lapis.git";
      description = "A fork of leafo/lapis for Kong";
      license.fullName = "MIT";
    };
  };

  version = buildLuarocksPackage {
    pname = "version";
    version = "1.0.1-2";

    src = fetchurl {
      url = "https://luarocks.org/version-1.0.1-2.src.rock";
      sha256 = "1hx0gywzv8l92y2vpyk99kz6l5kw5gv4ifj4il4xclahvp037lcw";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/version.lua";
      description = "Version comparison library";
      license.fullName = "Apache 2.0";
    };
  };

  lua-ffi-zlib = pkgs.lua51Packages.buildLuarocksPackage {
    pname = "lua-ffi-zlib";
    version = "0.5.0-0";

    src = pkgs.fetchurl {
      url = "https://luarocks.org/manifests/hamish/lua-ffi-zlib-0.5-0.src.rock";
      sha256 = "CgHcKxRG8slV2mF1+EdIhInd7Ur632xo0MVsRd/4mM0=";
    };
    disabled = (pkgs.lua51Packages.luaOlder "5.1");
    propagatedBuildInputs = [ pkgs.lua5_1 ];
  };

  lua-resty-jit-uuid = pkgs.lua51Packages.buildLuarocksPackage {
    pname = "lua-resty-jit-uuid";
    version = "0.0.7-2";

    src = pkgs.fetchurl {
      url =
        "https://luarocks.org/manifests/thibaultcha/lua-resty-jit-uuid-0.0.7-2.src.rock";
      sha256 = "nQPV1JNtkiFH034x6+coBtaEgZr8TBfqSf3rGgwykrY=";
    };
    disabled = (pkgs.lua51Packages.luaOlder "5.1");
    propagatedBuildInputs = [ pkgs.lua5_1 ];
  };

  multipart = buildLuarocksPackage {
    pname = "multipart";
    version = "0.5.9-1";

    src = fetchurl {
      url = "https://luarocks.org/multipart-0.5.9-1.src.rock";
      sha256 = "0biiz2hfximhg9as2l5yw34gi7gsmqyy9r9vrgh4f5jv50jl0h6j";
    };
    disabled = (luaOlder "5.1");
    propagatedBuildInputs = [ lua ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/Kong/lua-multipart";
      description = "A simple HTTP multipart encoder/decoder for Lua";
      license.fullName = "MIT";
    };
  };

in lua51Packages.buildLuarocksPackage {
  pname = "kong";
  version = "2.4.1-0";

  src = fetchurl {
    url = "https://luarocks.org/kong-2.4.1-0.src.rock";
    sha256 = "0bidg8xdjpwi937233lcya8q5l1zl3vd096bpk2mdr735mh04l48";
  };

  propagatedBuildInputs = with lua51Packages; [
    inspect
    luasec
    luasocket
    penlight
    lua-resty-http
    lua-resty-jit-uuid
    lua-ffi-zlib
    multipart
    version
    kong-lapis
    lua-cassandra
    pgmoon
    luatz
    lua_system_constants
    lyaml
    luasyslog
    lua_pack
    lua-resty-dns-client
    lua-protobuf
    lua-resty-worker-events
    lua-resty-healthcheck
    lua-resty-cookie
    lua-resty-mlcache
    lua-messagepack
    lua-resty-openssl
    lua-resty-counter
    lua-resty-ipmatcher
    kong-plugin-azure-functions
    kong-plugin-zipkin
    kong-plugin-serverless-functions
    kong-prometheus-plugin
    kong-proxy-cache-plugin
    kong-plugin-request-transformer
    kong-plugin-session
    kong-plugin-aws-lambda
    kong-plugin-acme
    kong-plugin-grpc-web
    kong-plugin-grpc-gateway
  ];

  postInstall = ''
    mkdir -p $out
    cp -r bin $out/

    sed -i 's/lua_package_path.*//g' $out/share/lua/5.1/kong/templates/nginx_kong.lua
    sed -i 's/lua_package_cpath.*//g' $out/share/lua/5.1/kong/templates/nginx_kong.lua

    cp -r ${
      pkgs.fetchFromGitHub {
        name = "lua-kong-nginx-module";
        owner = "Kong";
        repo = "lua-kong-nginx-module";
        rev = "0.0.8";
        sha256 = "J0UW5EPo6mU89GkJSKK7RiKTryw3sVVDCb7HTR7ohDA=";
      }
    }/lualib/* $out/share/lua/5.1/
  '';

  meta = with stdenv.lib; {
    homepage = "https://konghq.com";
    description =
      "Kong is a scalable and customizable API Management Layer built on top of Nginx.";
    license.fullName = "Apache 2.0";
  };
}

