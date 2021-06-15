# autoconfig loading should be specified.
# config.py should call either
# `config.load_autoconfig()` (to load settings configured via the GUI)
# or
# config.load_autoconfig(False)` (to not do so)

config.load_autoconfig(False)

# {{{ Fonts

c.fonts.default_family = "Helvetica Neue"

c.fonts.tabs.selected = '22pt default_family'
c.fonts.tabs.unselected = '22pt default_family'

c.fonts.statusbar = "22pt default_family"

c.fonts.completion.category = "bold 22pt default_family"
c.fonts.completion.entry = "22pt default_family"

c.fonts.debug_console = "22pt default_family"

c.fonts.downloads = "22pt default_family"

c.fonts.hints = "bold 14pt default_family"
c.fonts.keyhint = "22pt default_family"

c.fonts.messages.error = "22pt default_family"
c.fonts.messages.info = "22pt default_family"
c.fonts.messages.warning = "22pt default_family"

c.fonts.prompts = "22pt default_family"

# }}}
