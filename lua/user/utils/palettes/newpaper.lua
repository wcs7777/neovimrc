local coolors = require('user.utils.palettes.coolors')

local M = {}

local bg = coolors.backgrounds.dmg_lighter
local white = bg.white
local silver = bg.silver
local lightsilver = bg.lightsilver
local black = coolors.foregrounds.ink_black

M.custom = {

	white       = white,
	bg          = white,
	silver      = silver,
	match       = silver,
	text_cursor = silver,
	lightsilver = lightsilver,

	black = black,
	fg = black,
	task_fg = black,

	-- green dark
	bluegreen            = coolors.dark.blue.crayola_blue2, -- object.property
	darkcyan             = coolors.dark.blue.bright_marine,
	darkengreen          = coolors.dark.blue.digital_blue2, -- import React
	darkgreen            = coolors.dark.violet.royal_violet, -- const
	git_added            = coolors.dark.blue.twitter_blue,
	github_added         = coolors.dark.brown.rosewood,
	green                = coolors.dark.blue.yale_blue,
	hint_fg              = coolors.dark.turquoise.blue_green,
	neovim_green         = coolors.dark.blue.cobalt_blue,
	nephritis            = coolors.dark.blue.oxford_navy2,
	ocean                = coolors.dark.turquoise.dark_cyan,
	ok_fg                = coolors.dark.violet.indigo_bloom,
	olive                = coolors.dark.blue.dodger_blue, -- : int py
	regexp_green         = coolors.dark.violet.royal_violet,
	teal                 = coolors.dark.blue.navy_electric, -- lua line normal text
	tex_SI_green         = coolors.dark.blue.grape_soda,
	tex_ch_green         = coolors.dark.pink.berry_blush,
	tex_lightgreen       = coolors.dark.pink.dusty_lavender,
	tex_math             = coolors.dark.blue.glaucous2,
	tex_math_cmd         = coolors.dark.pink.berry_cream,
	tex_math_delim       = coolors.dark.pink.mauve_shadow,
	tex_part_title       = coolors.dark.pink.raspberry_plum,
	tex_tikz_green       = coolors.dark.violet.violet_ray,
	tex_tikz_verb        = coolors.dark.brown.clay_soil,
	tex_verb             = coolors.dark.brown.raw_umber,
	todo_hint            = coolors.dark.blue.majorelle_blue,

	-- green light
	diffadd              = coolors.light.blue.baby_blue2,
	diffadd_accent       = coolors.light.blue.baby_blue,
	hint_bg              = coolors.light.blue.pale_cyan2,
	ok_bg                = coolors.light.blue.sky_surge2,
	rainbowgreen         = coolors.light.blue.sky_reflection,
	regexp_green_bg      = coolors.light.blue.light_blue,
	rust_green           = coolors.light.blue.steel_blue,
	spelllocal           = coolors.light.blue.cool_sky2,
	tex_math_error       = coolors.light.yellow.apricot_cream,
	tex_olive            = coolors.light.yellow.golden_orange,
	tex_only_math_error  = coolors.light.yellow.ivory_mist,

	redorange            = coolors.dark.orange.brick_ember, -- import
	orange               = coolors.dark.orange.autumn_leaf2, -- parameters
	persimona            = coolors.dark.orange.burnt_orange, -- ,
	yellow               = coolors.light.yellow.banana_cream, -- search_bg
	purple               = coolors.dark.violet.indigo_bloom, -- const
	lightmagenta         = coolors.light.pink.cotton_bloom, -- ${
	darkyellow           = coolors.dark.orange.spicy_paprika, -- import foo py
	tex_teal             = '#2e1dae',
}

M.custom_advanced = {
	strings = coolors.dark.pink.neon_fuchsia2,
}

M.custom_highlights = {
	['@none'] = { link = 'Normal' },
	['@property.json'] = { fg = coolors.dark.blue.navy_electric },
	['@string.json'] = { fg = coolors.dark.blue.azure_blue },
	['@string.csv'] = { fg = coolors.dark.blue.navy_electric },
	['@number.csv'] = { fg = coolors.dark.red.burgundy },
	['@property.yaml'] = { link = '@variable.member' },
}

M.default = {
	black                = '#2F2A3D', -- color00
	maroon               = '#AF0000', -- color01
	darkgreen            = '#008700', -- color02
	darkorange           = '#AF5F00', -- color03
	navy                 = '#27408B', -- color04
	purple               = '#8700AF', -- color05
	teal                 = '#005F87', -- color06
	darkgrey             = '#444444', -- color08
	red                  = '#E14133', -- color09
	green                = '#50A14F', -- color10
	orange               = '#D75F00', -- color11
	lightblue            = '#0072C1', -- color12 strings
	lightmagenta         = '#E563BA', -- color13
	blue                 = '#0087AF', -- color14
	white                = '#F1F3F2',

	-- Default fg and bg
	fg                   = '#2F2A3D', -- color15
	bg                   = '#F1F3F2', -- color07

	-- Other colors
	dark_maroon          = '#8C1919',
	redorange            = '#E12D23',
	pink                 = '#FFEEFF',
	lightorange          = '#E4C07A',
	persimona            = '#EF7932',
	yellow               = '#FFFF66',
	darkyellow           = '#C18301',
	olive                = '#5F8700',
	darkengreen          = '#007200',
	ocean                = '#2E8B57',
	nephritis            = '#00AB66',
	bluegreen            = '#1B7F82',
	darkcyan             = '#008B8B',
	aqua                 = '#BFD5EC',
	aquadark             = '#AFD7FF',
	aqualight            = '#DFE4EB',
	lightviolet          = '#E5D9F2',
	blueviolet           = '#AF87D7',
	violet               = '#957CC6',
	darkpurple           = '#5823C7',
	magenta              = '#D7005F',
	magenta_bg           = '#FFBBFF',
	grey                 = '#585858',
	lightgrey            = '#878787',
	lightlightgrey       = '#D4D4D4',
	silver               = '#E4E4E4',
	lightsilver          = '#EEEEEE',
	match                = '#E4E4E4',

	codeblock            = '#DEDEDE',
	disabled             = '#C3C3C3',

	regexp_blue          = '#5588FF',
	regexp_brown         = '#884400',
	regexp_green         = '#00AA00',
	regexp_magenta       = '#CC00CC',
	regexp_orange        = '#DD7700',
	regexp_green_bg      = '#E1F0E1',
	regexp_orange_bg     = '#F0F0C8',

	-- Git and diff
	git_fg               = '#413932',
	git_bg               = '#EBEAE2',
	git_added            = '#28A745',
	git_modified         = '#DBAB09',
	git_removed          = '#D73A49',
	git_merged           = '#00909A',
	git_untracked        = '#8F8F8B',
	github_added         = '#1A4D1A',
	github_removed       = '#6B1F1F',
	diffadd              = '#DAFBE1',
	diffadd_accent       = '#ACEEBB',
	diffdelete           = '#FFEBE9',
	diffdelete_accent    = '#FFCECB',
	diffchange           = '#FFE7B7',
	difftext             = '#FFFFD7',

	-- Spell
	spellbad             = '#FFF4FF',
	spellcap             = '#E7E7FF',
	spellrare            = '#FFFFDF',
	spelllocal           = '#E3FFD5',

	-- LSP message
	error_fg             = '#D75F66',
	warn_fg              = '#D37300',
	info_fg              = '#005FAF',
	hint_fg              = '#0EA674',
	ok_fg                = '#0EA628',
	lsp_error_bg         = '#FDF0F0',
	warn_bg              = '#FDF5EC',
	info_bg              = '#EBF0FD',
	hint_bg              = '#E7F8F2',
	ok_bg                = '#E6F6E9',

	-- Todo
	todo_error           = '#DF0000',
	todo_warn            = '#D75F00',
	todo_info            = '#3A72ED',
	todo_hint            = '#199319',
	todo_default         = '#894DEE',
	todo_test            = '#B748B7',

	-- TeX
	tex_maroon           = '#A2251A',
	tex_olive            = '#89802B',
	tex_navy             = '#1E40C2',
	tex_red              = '#D84342',
	tex_blue             = '#0089B3',
	tex_teal             = '#005579',
	tex_magenta          = '#E00050',
	tex_aqua             = '#14B9C4',
	tex_orange           = '#D37300',
	tex_redorange        = '#F3752D',
	tex_darkorange       = '#BA6400',

	tex_lightpurple      = '#684D99',
	tex_lightviolet      = '#B777B7',
	tex_pink             = '#D75F66',
	tex_lightgreen       = '#20A93E',

	tex_math             = '#008000',
	tex_math_cmd         = '#636D1D',
	tex_math_delim       = '#349279',
	tex_operator         = '#09529B',
	tex_part_title       = '#5F8A00',
	tex_ch_brown         = '#8C1919',
	tex_ch_orange        = '#E5740B',
	tex_ch_green         = '#19A665',
	tex_ch_red           = '#E04A4A',
	tex_ch_blue          = '#394892',
	tex_keyword          = '#7F2DC2',
	tex_verb             = '#4E5B5F',
	tex_string           = '#007FD7',
	tex_tikz_purple      = '#635F8C',
	tex_tikz_green       = '#568355',
	tex_tikz_orange      = '#AB915E',
	tex_tikz_navy        = '#4654C0',
	tex_tikz_verb        = '#535362',
	tex_quotes           = '#003399',
	tex_SI_purple        = '#523891',
	tex_SI_orange        = '#D55C1F',
	tex_SI_red           = '#D83851',
	tex_SI_navy          = '#0B5394',
	tex_SI_green         = '#589927',
	tex_SI_magenta       = '#BC5AA2',
	tex_SI_yellow        = '#C88900',

	tex_group_error      = '#EBF2FF',
	tex_math_error       = '#CCE5CC',
	tex_math_delim_error = '#FBE5CC',
	tex_parbox_opt_error = '#F0D4D1',
	tex_only_math_error  = '#EAE8D5',

	-- Ruby
	ruby_maroon          = '#880000',
	ruby_navy            = '#09529B',
	ruby_purple          = '#6838CC',
	ruby_magenta         = '#A626A4',
	ruby_orange          = '#BF5019',

	-- Lua
	lua_navy             = '#030380',
	lua_blue             = '#128897',

	-- Jinja
	jinja_red            = '#B80000',

	-- Python
	python_blue          = '#336D9E',

	--Rust
	rust_green           = '#0B7261',

	-- HTML
	tag_navy             = '#0044AA',

	rainbowred           = '#FF0000',
	rainbowyellow        = '#FDA135',
	rainbowblue          = '#0041FF',
	rainboworange        = '#FF6A00',
	rainbowgreen         = '#28CE00',
	rainbowviolet        = '#7D00E5',
	rainbowcyan          = '#E500E5',

	-- Neovim
	neovim_green         = '#54A23D',

	-- Presets
	text_fg              = '#404040',
	text_bg              = '#F4F4F2',
	text_cursor          = '#E4E4E4',
	text_visual          = '#C2E8FF',
	task_fg              = '#2F2A3D',
	task_bg              = '#F3EEC3',
	task_cursor          = '#F2E3A2',
	task_visual          = '#D9CC91',
}

local advanced = {


    -- Optional colors
    booleans            = M.default.nephritis,
    comments            = M.default.lightgrey,
    doc_comments        = M.default.tex_verb,
    keywords            = M.default.purple,
    links               = M.default.tag_navy,
    numbers             = M.default.tex_ch_red,
    strings             = M.default.lightblue,
    tags                = M.default.tag_navy,
    texts               = M.default.darkgrey,
    variables           = M.default.fg,
    none                = "NONE",

    -- Editor
    accent              = M.default.blue,
    active              = M.default.silver,
    borders             = M.default.purple,
    colorcol            = M.default.silver,
    contrast            = M.default.lightlightgrey,
    cursor              = M.default.fg,
    cursor_nr_bg        = M.default.lightsilver,
    cursor_nr_fg        = M.default.darkorange,
    eob                 = M.default.disabled,
    folded_bg           = M.default.aqua,
    folded_fg           = M.default.blue,
    linenumber_bg       = M.default.lightsilver,
    linenumber_fg       = M.default.comments,
    msgarea_bg          = M.default.bg,
    msgarea_fg          = M.default.fg,
    normal_bg           = M.default.bg,
    normal_fg           = M.default.fg,
    pmenu_bg            = M.default.lightlightgrey,
    pmenu_fg            = M.default.darkgrey,
    pmenu_sel           = M.default.aquadark,
    selection           = M.default.blue,
    titles              = M.default.fg,
    wildmenu_bg         = M.default.yellow,
    wildmenu_fg         = M.default.darkgrey,
    win_act_border      = M.default.violet,
    win_border          = M.default.grey,
    winbar_bg           = M.default.bg,
    winbar_fg           = M.default.grey,

    -- Search
    search_bg           = M.default.yellow,
    search_fg           = M.default.black,

    -- Error message
    errormsg_fg         = M.default.red,
    errormsg_bg         = M.default.pink,

    -- Tabline
    tabline_bg          = M.default.lightlightgrey,
    tabline_active_fg   = M.default.fg,
    tabline_active_bg   = M.default.bg,
    tabline_inactive_fg = M.default.lightgrey,
    tabline_inactive_bg = M.default.silver,

    -- Sidebar and float windows
    sb_fg               = M.default.fg,
    sb_bg               = M.default.bg,
    sb_contrast_fg      = M.default.fg,
    sb_contrast_bg      = M.default.silver,
    float_fg            = M.default.fg,
    float_bg            = M.default.bg,
    float_contrast      = M.default.silver,
    ----------------------------------------------------------------------------

    -- Terminal
    term_fg             = M.default.fg,
    term_bg             = M.default.bg,
    term_fl_fg          = M.default.fg,
    term_fl_bg          = M.default.bg,
    term_contrast_fg    = M.default.fg,
    term_contrast_bg    = M.default.silver,
    term_contrast_fl_bg = M.default.silver,

    ----------------------------------------------------------------------------

    -- PLugins -----------------------------------------------------------------
    -- Git Signs
    git_sign_bg = M.default.linenumber_bg,

    -- IndentBlankline
    contextchar = M.default.violet,

    -- NvimTree
    nvimtree_fg = M.default.sb_fg,
    nvimtree_bg = M.default.sb_bg,

    -- Trouble
    trouble_fg = M.default.sb_fg,
    trouble_bg = M.default.sb_bg,

    -- Telescope
    telescope_fg       = M.default.fg,
    telescope_bg       = M.default.bg,
    telescope_contrast = M.default.silver,
    ----------------------------------------------------------------------------

    -- Diff highlight
    diffadd_fg           = M.default.github_added,
    diffdelete_fg        = M.default.github_removed,
    diffchange_fg        = M.default.git_fg,
    difftext_fg          = M.default.git_fg,
    diffadd_bg           = M.default.diffadd,
    diffadd_accent_bg    = M.default.diffadd_accent,
    diffdelete_bg        = M.default.diffdelete,
    diffdelete_accent_bg = M.default.diffdelete_accent,
    diffchange_bg        = M.default.diffchange,
    difftext_bg          = M.default.difftext,
    ----------------------------------------------------------------------------

    -- Presets colors
    text_linenumber_fg  = M.default.disabled,
    text_cursor_nr_fg   = M.default.linenumber_fg,
    text_cursor_nr_bg   = M.default.none,
    text_cursor_fold_bg = M.default.none,
    text_cursor_sign_bg = M.default.none,

    task_linenumber_fg  = M.default.disabled,
    task_cursor_nr_fg   = M.default.linenumber_fg,
    task_cursor_nr_bg   = M.default.none,
    task_cursor_fold_bg = M.default.none,
    task_cursor_sign_bg = M.default.none,
    ----------------------------------------------------------------------------
}

return M
