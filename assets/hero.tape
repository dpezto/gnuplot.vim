# Regenerate with: vhs assets/hero.tape (from the repo root)
Set FontFamily "FiraCode Nerd Font"
Set FontSize 18
Set Width 1200
Set Height 760
Set Theme "TokyoNight"
Set Padding 20

Hide
Type "nvim -i NONE -n assets/demo.gp"
Enter
Sleep 4s
Type ":lua vim.diagnostic.enable(false); vim.diagnostic.reset()"
Enter
Type "gg0"
Sleep 1s
Show
Sleep 1s
Screenshot assets/hero.png
Hide
Type ":qa!"
Enter
