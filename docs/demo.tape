# Recorded by .github/workflows/verify.yml with https://github.com/charmbracelet/vhs
Output docs/verify-demo.gif
Output docs/verify-demo.mp4

Set Shell bash
Set FontSize 15
Set Width 1100
Set Height 860
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms

# --- recording starts ---

Type "# Same Password Validation solution in 7 languages, one shared test suite"
Enter
Sleep 1s
Type "ls"
Enter
Sleep 1500ms
Type "ls cases/"
Enter
Sleep 2s
Type "scripts/verify.sh"
Enter
Wait+Screen@180s /agree on all|Some checks failed/
Sleep 5s
