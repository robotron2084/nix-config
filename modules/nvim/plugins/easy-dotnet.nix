{pkgs, ...}: let
  netcoredbg = pkgs.netcoredbg;
in {
  programs.nixvim = {
    # easy-dotnet.nvim is a client for the `EasyDotnet` .NET server tool
    # (binary `dotnet-easydotnet`). That server is NOT packaged in nixpkgs, so
    # the plugin installs it imperatively on first launch via
    # `dotnet tool install -g EasyDotnet` (using whatever `dotnet` is on PATH).
    # The tool lands in ~/.dotnet/tools, which must be on your PATH.
    extraPlugins = with pkgs.vimPlugins; [
      easy-dotnet-nvim
      plenary-nvim # required
      nvim-nio # required by the RPC/async layer
    ];

    # netcoredbg is used server-side as the debug engine; make it available and
    # point easy-dotnet at this exact build.
    extraPackages = [netcoredbg];

    extraConfigLua = ''
      require("easy-dotnet").setup({
        -- easy-dotnet runs its own roslyn client (name: "easy_dotnet"). This is
        -- the sole C# LSP; the separate plugins.roslyn has been removed. The
        -- settings below are merged into roslyn (see roslyn/lsp.lua) and carry
        -- over the inlay-hint / code-lens config we previously set on roslyn.
        lsp = {
          enabled = true,
          config = {
            settings = {
              ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
              },
              ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
              },
            },
          },
        },
        debugger = {
          bin_path = "${netcoredbg}/bin/netcoredbg",
          auto_register_dap = true,
        },
        -- test_runner uses easy-dotnet's built-in runner (`:Dotnet testrunner`).
        -- To route tests through neotest instead, enable plugins.neotest, set
        -- `test_runner.neotest_integration = true`, and register
        -- `require("easy-dotnet.neotest")` as a neotest adapter.
      })
    '';

    keymaps = let
      mkDotnet = key: cmd: desc: {
        mode = "n";
        inherit key;
        action = "<cmd>Dotnet ${cmd}<CR>";
        options.desc = desc;
      };
    in [
      (mkDotnet "<leader>ct" "testrunner" "Dotnet: Test Runner")
      (mkDotnet "<leader>cr" "run" "Dotnet: Run")
      (mkDotnet "<leader>cb" "build" "Dotnet: Build")
      (mkDotnet "<leader>cw" "watch" "Dotnet: Watch")
      (mkDotnet "<leader>cs" "secrets" "Dotnet: User Secrets")
    ];
  };
}
