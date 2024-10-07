-- default keybind g-c and g-c-c
return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
}
