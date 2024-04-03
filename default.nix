{ options, config, lib, pkgs, inputs, ... }:
with lib;
with lib.custom;

let
  SilentFox = pkgs.fetchFromGitHub {
    owner = "linuxmobile";
    repo = "SilentFox";
    rev = "45ad3cb7c26c79831786a11387e21788edd84fe6";
    sha256 = "sha256-9Bj0M0CAch4CenM9TFXUkGa6nHwC6y24azCXcUFtU6M=";
  };
  cfg = config.firefox;
  theme = {

    base00 = "131415"; #131415
    base01 = "11111b"; #1a1c1d
    base02 = "242628"; #242628
    base03 = "393b3c"; #393b3c
    base04 = "f5e0dc"; #adb5bd 
    base05 = "ced4da"; #ced4da
    base06 = "dee2e6"; #dee2e6
    base07 = "f8f9fa"; #f8f9fa
    base08 = "F07178"; #F07178
    base09 = "FF8F40"; #FF8F40
    base0A = "FFB454"; #FFB454
    base0B = "B8CC52"; #B8CC52
    base0C = "95E6CB"; #95E6CB
    base0D = "59C2FF"; #59C2FF
    base0E = "D2A6FF"; #D2A6FF
    base0F = "E6B673"; #E6B673

    hp = "#FF00FF";
    # these colors are not used in the theme, but are used to find what
    # change is made when you change a color in the theme.
    # they are all unique colors, And distinct from each other.
    # they are also all bright colors, so they are easy to see.
    # follows roygbiv, and then some.
    idk00 = "FF0000"; #FF0000
    idk01 = "FF8000"; #FF8000
    idk02 = "FFFF00"; #FFFF00
    idk03 = "80FF00"; #80FF00
    idk04 = "00FF00"; #00FF00
    idk05 = "00FF80"; #00FF80
    idk06 = "00FFFF"; #00FFFF
    idk07 = "0080FF"; #0080FF
    idk08 = "0000FF"; #0000FF
    idk09 = "8000FF"; #8000FF
    idk0A = "FF00FF"; #FF00FF
    idk0B = "FF0080"; #FF0080

    # These should all go from light to dark

    gray00 = "a3a4a5"; #a3a4a5
    gray01 = "88898a"; #88898a
    gray02 = "6e6f70"; #6e6f70
    gray03 = "565758"; #565758
    gray04 = "3e3f40"; #3e3f40
    gray05 = "28292a"; #28292a
    gray06 = "131415"; #131415

    white00 = "f8f9fa"; #f8f9fa
    white01 = "e9ecef"; #e9ecef
    white02 = "dee2e6"; #dee2e6
    white03 = "ced4da"; #ced4da
    white04 = "adb5bd"; #adb5bd
    white05 = "6c757d"; #6c757d

    #white01 = "#e6e6e6";
    #white03 = "#b3b3b3";
    #white05 = "#808080";
    #white07 = "#4d4d4d";
    #white09 = "#1a1a1a";
    #white10 = "#000000";

    # Red
    red00 = "fe7272"; #fe7272
    red01 = "e95a58"; #e95a58
    red02 = "d44240"; #d44240
    red03 = "bb2f2d"; #bb2f2d
    red04 = "9e211f"; #9e211f
    red05 = "821111"; #821111

    # Orange
    orange00 = "FF8C00"; #FF8C00
    orange01 = "FF6B00"; #FF6B00
    orange02 = "E85400"; #E85400
    orange03 = "D9480F"; #D9480F

    # Brown
    brown00 = "A3685A"; #A3685A
    brown01 = "854442"; #854442

    # Yellow
    yellow00 = "FFD900"; #ffd900
    yellow01 = "E6C000"; #E6C000
    yellow02 = "CCB200"; #CCB200
    yellow03 = "B39800"; #B39800
    yellow04 = "997800"; #997800
    yellow05 = "7F5F00"; #7F5F00

    # Green
    green00 = "B5BD68"; #B5BD68
    green01 = "768948"; #768948
    green02 = "3C5340"; #3C5340
    green03 = "324635"; #324635
    green04 = "283C2C"; #283C2C
    green05 = "1E2F23"; #1E2F23

    # Cyan
    cyan00 = "C2E2DB"; #C2E2DB
    cyan01 = "A8D9D2"; #A8D9D2
    cyan02 = "8FCFC9"; #8FCFC9
    cyan03 = "75C6C1"; #75C6C1
    cyan04 = "3D9290"; #3D9290
    cyan05 = "29807D"; #29807D

    # Blue
    blue00 = "81A2BE"; #81A2BE
    blue01 = "5C81A6"; #5C81A6
    blue02 = "4F6D8C"; #4F6D8C
    blue03 = "3E5C7E"; #3E5C7E
    blue04 = "2E4A71"; #2E4A71
    blue05 = "1E3867"; #1E3867

    # Purple
    purple00 = "B294BB"; #B294BB
    purple01 = "8F6C97"; #8F6C97
  };

  cascadeCatppuccin = pkgs.stdenv.mkDerivation {
    name = "cascade";
    src = pkgs.fetchgit {
      url = "https://github.com/andreasgrafen/cascade.git";
      rev = "2f70e86";
      sha256 = "sha256-HOOBQ1cNjsDTFSymB3KjiZ1jw3GL16LF/RQxdn0sxr0=";
    };

    # Replace files as described in:
    # https://github.com/andreasgrafen/cascade#catppuccin
    installPhase = ''
      cp -r $src/* .
      chmod -R u+w .

      cp ./integrations/catppuccin/cascade-mocha.css ./chrome/includes/
      substituteInPlace ./chrome/userChrome.css  \
        --replace "colours" "mocha"

      cp -r ./chrome $out
    '';
  };

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

      #     home.file."cascade" = {
      #        target = ".mozilla/firefox/emil/chrome/cascade";
      #        source = fetchTarball {
      #          url =
      #            "https://github.com/andreasgrafen/cascade/archive/main/chrome.tar.gz";
      #          sha256 = "0qd6rswl538q7kxkq2aifn4fppp5gxqcwwd1fsmdj6ikn99ki866";
      #        };
      #      };
      home.file.".mozilla/firefox/emil/chrome" = {
        enable = false;
        source = "${cascadeCatppuccin}";
        recursive = true;
      };

      home.file.".mozilla/firefox/emil/chrome/includes" = {
        enable = true;
        source = ./moon;
        recursive = true;
      };
      #      home.file."firefox-theme" = {
      #        target = ".mozilla/firefox/dtsf/chrome/firefox-theme";
      #        source = fetchTarball {
      #          url =
      #            "https://github.com/andreasgrafen/cascade/archive/master.tar.gz";
      #          sha256 = "0p4fkpvr2wlxrphrs288jr4sjakd78n6rw4nzpy64152izwhi93w";
      #        };
      #      };
      #      home.file."firefox-config" = {
      #        target = ".mozilla/firefox/emil/chrome/firefox-config";
      #        source = fetchTarball {
      #          url =
      #            "https://github.com/Tnixc/firefox-config/archive/main/chrome.tar.gz";
      #          sha256 = "0p4fkpvr2wlxrphrs288jr4sjakd78n6rw4nzpy64152izwhi93w";
      #        };
      #      };
      #      # Add Firefox GNOME theme directory
      #      home.file."firefox-gnome-theme" = {
      #        target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      #        source = fetchTarball {
      #          url =
      #            "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
      #          sha256 =
      #            "sha256:0mack8i6splsywc5h0bdgh1njs4rm8fsi0lpvvwmbdqmjjlkz6a1";
      #        };
      #
      #      };

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
            surfingkeys
          ];
          #          extensions = with config.nur.repos.rycee.firefox-addons; [
          #            darkreader
          #            refined-github
          #            return-youtube-dislikes
          #            ublock-origin
          #            consent-o-matic
          #            bitwarden
          #            sidebery
          #            tabcenter-reborn
          #          ];
          #search.force = true;
          #userChrome = # javascript
          #  ''
          #    @import url("firefox-theme/chrome/userChrome.css");
          #    //@import "firefox-gnome-theme/userChrome.css";
          #    //@import "firefox-gnome-theme/theme/colors/dark.css"; 
          #    //@import "cascade/chrome/userChrome.css";
          #    //@import "firefox-config/chrome/userChrome.css";
          #    //@import "firefox-config/TabCenterReburn.css";
          #    //@import "cascade/integrations/catppuccin/cascade-mocha.css";
          #    //@import "cascade/integrations/tabcenter-reborn/tabcenter-reborn.css";
          #userChrome =  /* css */''
          # @import 'includes/userChrome.css';
          #'';
          userChrome = builtins.readFile ./shina/userChrome.css;

          userContent = /*css*/ ''
           @import 'includes/userContent.css';
          '';#builtins.readFile ./moon/userContent.css;
        #userContent = /*css*/'''';

        };
      };

    };
  };
}
