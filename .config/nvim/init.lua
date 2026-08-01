-- ========================================================================== --
-- 1. BASE CONFIGURATION & FONT SETTINGS                                      --
-- ========================================================================== --
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for easier navigation
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors

-- Highlight settings
vim.opt.cursorline = true     -- Highlight the text line under the cursor
vim.opt.cursorcolumn = true   -- Highlight the text column under the cursor

-- Graphical font settings
vim.opt.guifont = "lemon:h18" 

-- Set this to true to enable transparency
local transparent = true

-- ========================================================================== --
-- 2. CUSTOM THEME HIGHLIGHT GROUPS WITH TRANSPARENCY                         --
-- ========================================================================== --
-- Explicit hex definitions from your provided theme
local bg      = transparent and "NONE" or "#241b30"
local fg      = "#ff9f30"
local cursor  = "#e60a70"
local select  = "#6e29ad"
local select_fg = "#f2f2e3"
local green   = "#00986c"
local purple  = "#b300ad"
local cyan    = "#00b0b1"
local gray    = "#b9b1bc"

-- Subtle tint color for overlays (blends nicely with your dark purple base)
local tint_bg = "#2f233f" 

-- Function to safely apply custom theme colors
local function apply_theme()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "ghostty-transformed"

  local groups = {
    Normal       = { fg = fg, bg = bg },
    NormalNC     = { fg = fg, bg = bg }, 
    Cursor       = { fg = "#241b30", bg = cursor },
    Visual       = { fg = select_fg, bg = select },
    LineNr       = { fg = select, bg = "NONE" },
    CursorLineNr = { fg = cursor, bold = true, bg = "NONE" },
    SignColumn   = { bg = "NONE" },      
    Folded       = { bg = "NONE" },      
    
    -- Active Position Indicators
    -- Using the tint color lets you see the lines over your transparent grid
    CursorLine   = { bg = tint_bg }, 
    CursorColumn = { bg = tint_bg },
    ColorColumn  = { bg = tint_bg }, 
    
    -- Syntax groups mapping your theme elements
    Comment      = { fg = gray, italic = true },
    Constant     = { fg = cyan },
    String       = { fg = green },
    Identifier   = { fg = fg },
    Function     = { fg = purple, bold = true },
    Statement    = { fg = cursor, bold = true },
    PreProc      = { fg = purple },
    Type         = { fg = cyan, bold = true },
    Special      = { fg = cursor },
  }

  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

apply_theme()

require('cursor')
require('scroll')
