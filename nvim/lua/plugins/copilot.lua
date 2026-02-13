return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<tab>" } },
            panel = { enabled = false },
            copilot_node_command = "node",
        })
    end,
}
