{...}: {
  # Generic DAP infrastructure only. The C#/.NET adapter and `cs` launch/attach
  # configurations are registered by easy-dotnet (see easy-dotnet.nix), which
  # owns that wiring via its `auto_register_dap` option. We deliberately do NOT
  # set `plugins.dap.adapters`/`.configurations` here: nixvim emits
  # `require("dap").adapters = {...}` as a full assignment, which would clobber
  # easy-dotnet's runtime registration depending on load order.
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;

        # NOTE: text must be non-empty. With text = "", Neovim's sign_place()
        # returns a fake-successful sign id but never actually registers the
        # sign anywhere sign_getplaced() can find it - and nvim-dap's entire
        # breakpoint tracking (toggle_breakpoint, dap-ui's breakpoints panel,
        # gutter icons) is built on sign_getplaced() as its source of truth.
        # An empty icon here doesn't just look wrong, it silently breaks
        # breakpoints completely, in every buffer/filetype.
        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DiagnosticSignError";
          };
          dapBreakpointCondition = {
            text = "◆";
            texthl = "DiagnosticSignWarn";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DiagnosticSignInfo";
          };
          dapStopped = {
            text = "▶";
            texthl = "DiagnosticSignWarn";
            linehl = "Visual";
          };
          dapBreakpointRejected = {
            text = "✗";
            texthl = "DiagnosticSignHint";
          };
        };
      };

      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };

    # Open/close the dap-ui panels automatically as debug sessions start/stop.
    extraConfigLua = ''
      do
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      end
    '';

    keymaps = let
      mkDap = key: action: desc: {
        mode = "n";
        inherit key;
        action.__raw = action;
        options.desc = desc;
      };
    in [
      # Core stepping controls (VS Code-style function keys).
      (mkDap "<F5>" ''function() require("dap").continue() end'' "Debug: Start/Continue")
      (mkDap "<F10>" ''function() require("dap").step_over() end'' "Debug: Step Over")
      (mkDap "<F11>" ''function() require("dap").step_into() end'' "Debug: Step Into")
      (mkDap "<F12>" ''function() require("dap").step_out() end'' "Debug: Step Out")

      # Debug commands, grouped under <leader>x alongside Trouble.
      (mkDap "<leader>xb" ''function() require("dap").toggle_breakpoint() end'' "Debug: Toggle Breakpoint")
      (mkDap "<leader>xB" ''function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end'' "Debug: Conditional Breakpoint")
      (mkDap "<leader>xc" ''function() require("dap").continue() end'' "Debug: Start/Continue")
      (mkDap "<leader>xr" ''function() require("dap").repl.toggle() end'' "Debug: Toggle REPL")
      (mkDap "<leader>xl" ''function() require("dap").run_last() end'' "Debug: Run Last")
      (mkDap "<leader>xk" ''function() require("dap").terminate() end'' "Debug: Terminate")
      (mkDap "<leader>xu" ''function() require("dapui").toggle() end'' "Debug: Toggle UI")
      (mkDap "<leader>xe" ''function() require("dapui").eval() end'' "Debug: Evaluate Expression")
    ];
  };
}
