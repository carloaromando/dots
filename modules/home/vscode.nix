{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      workbench.colorTheme = "Minimal Light";
      debug.console.fontSize = 11;
      editor.fontFamily = "JetBrains Mono";
      ditor.fontLigatures = true;
      editor.fontSize = 14;
      debug.console.fontFamily = "JetBrains Mono";
      terminal.integrated.fontSize = 15;
      terminal.integrated.fontWeightBold = "900";
      editor.fontWeight = 400;
      telemetry.telemetryLevel = "off";
      terminal.integrated.fontWeight = "700";
      workbench.statusBar.visible = true;
      editor.bracketPairColorization.enabled = false;
      workbench.iconTheme = "vs-minimal";
      editor.minimap.enabled = false;
      explorer.confirmDelete = false;
      workbench.editor.showTabs = "single";
      window.titleBarStyle = "custom";
      extensions.ignoreRecommendations = true;
      editor.mouseWheelScrollSensitivity = 5;
      editor.stablePeek = false;
      workbench.colorCustomizations = {
        titleBar.activeBackground = "#eee";
        titleBar.activeForeground = "#000";
        titleBar.inactiveBackground = "#eee";
        titleBar.inactiveForeground = "#eee";
        sideBar.background = "#FFFFFF";
        sideBarSectionHeader.background = "#eeeeee";
        sideBarSectionHeader.border = "#555";
        list.activeSelectionBackground = "#FFFFFF";
        list.inactiveSelectionBackground = "#FFFFFF";
        list.activeSelectionForeground = "#000";
        statusBar.background = "#eeeeee";
        statusBar.border = "#555";
        statusBar.foreground = "#000";
        editor.background = "#FFFFFF";
        editorLineNumber.foreground = "#000000";
        editor.lineHighlightBackground = "#f3f3f3";
        sideBar.border = "#555";
      };
      editor.tokenColorCustomizations."[Minimal Light]".textMateRules = [
        {
          scope = "comment";
          settings = {
            foreground = "#7c0000";
          };
        }
        {
          scope = "string";
          settings = {
            foreground = "#555";
          };
        }
        {
          scope = "constant";
          settings = {
            foreground = "#000000";
          };
        }
        {
          scope = "keyword";
          settings = {
            foreground = "#000000";
            fontStyle = "";
          };
        }
      ];
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      editor.formatOnSave = true;
      editor.inlayHints.enabled = "off";
      security.workspace.trust.untrustedFiles = "open";
      diffEditor.ignoreTrimWhitespace = false;
      window.zoomLevel = -1;
      clang-format.executable = "clang-format";
      nix.enableLanguageServer = true;
      nix.serverPath = "nil";
      nix.serverSettings.nil.formatting.command = [
        "nixpkgs-fmt"
      ];
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      mkhl.direnv
      xaver.clang-format
      golang.go
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-bazel";
        publisher = "BazelBuild";
        version = "0.7.0";
        sha256 = "sha256-/a34MMsHy7zmGrVAtjMWKmulwS+lip3J1YugkACMmxc=";
      }
      {
        name = "minimal";
        publisher = "calebdoxsey";
        version = "0.1.0";
        sha256 = "sha256-DQANTJuzFfAzuizDas89BdgXXMrJflLWVodPp3ZDq4I=";
      }
    ];
  };
}
