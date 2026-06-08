{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [ pkgs.git ];

  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_24;
    pnpm = {
      enable = true;
      package = pkgs.pnpm;
    };
  };

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_18;
    initialDatabases = [ { name = "noikos"; } ];
    initialScript = ''
      CREATE USER noikos;
      GRANT ALL PRIVILEGES ON DATABASE noikos TO noikos;
    '';
  };

  env = {
    DATABASE_URL = "postgresql://noikos@localhost/noikos";
    NODE_NO_WARNINGS = "1";
    NODE_ENV = "development";
  };

  scripts = {
    db-migrate.exec = "pnpm --filter './apps/api' mikro-orm migration:up";
    db-rollback.exec = "pnpm --filter './apps/api' mikro-orm migration:down";
    db-fresh.exec = "pnpm --filter './apps/api' mikro-orm schema:fresh --run";
    db-studio.exec = "pnpm --filter './apps/api' mikro-orm debug";
    setup.exec = "pnpm install";
  };

  enterShell = ''
    echo "🏠 Noikos dev environment"
    echo "Node: $(node --version)"
    echo "pnpm: $(pnpm --version)"
    echo ""
    echo "Scripts DB : db-migrate | db-rollback | db-fresh"
    echo "Services   : devenv up → PostgreSQL"
  '';
}
