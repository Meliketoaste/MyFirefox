{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.custom;

let

  cfg = config.firefox;


  catppuccin = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {

    pname = "catppuccin-mocha-rosewater";
    version = "old";
    addonId = "{5b78178f-135d-4df2-821f-1f289be7f348}";
    url =
      "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_mocha_rosewater.xpi";
    sha256 = "sha256-hh9l9icBlq3pCyiqdqfgUbYBclgshgmnEAR+drzYCu0=";

    meta = { };
  };

  chikamichi = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {

    pname = "chikamichi";
    version = "old";
    addonId = "{ebe3d640-8675-4237-a3f6-ac6c6a6aa07e}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3954983/chikamichi-2.17.0.xpi";

    sha256 = "sha256-n4D/kJf5CiqRHtx78kFd80rEycGPoBccdIqWc+sKJK4=";

    meta = { };
  };

  tab-ahead = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {

    pname = "tab-ahead";
    version = "old";

    addonId = "{4c7e1bb0-f2b8-4148-8727-78570bb2c656}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3655038/tab_ahead_firefox-1.5.0.xpi";

    sha256 = "sha256-H5aMkUuJ0idBKrCNFS4aoDzVwZl0RIlzBvoJ1XMblEQ=";

    meta = { };
  };

in {
  options.firefox = with types; { enable = mkBoolOpt false "Enable firefox"; };

  config = mkIf cfg.enable {
    home.extraOptions = {
      home.file.".mozilla/firefox/emil/chrome/includes" = {
        enable = true;
        source = ./moon;
        recursive = true;
      };

      programs.firefox = {
        enable = true;
        profiles.emil = {
          name = "emil";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "file:////home/emil/projects/index.html";
            "browser.search.region" = "US";
            "browser.search.isUS" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;  
            "layout.css.backdrop-filter.enabled" = true; # blur style
            "svg.context-properties.content.enabled" = true;
          };
          search.engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
              icon =
                "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
              search.force = true;

            };
          };
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            bitwarden # pw manager
            darkreader
            sidebery
            tridactyl # vi keybinds
            ublock-origin # ad-blocker
            catppuccin
            chikamichi
            tab-ahead
            vimium
];
          userChrome = builtins.readFile ./shina/userChrome.css;

          userContent = /*css*/ ''
           @import 'includes/userContent.css';
          '';
        };
      };

    };
  };
}
