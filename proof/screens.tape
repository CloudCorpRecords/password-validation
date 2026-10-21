# Per-language screenshots, plus one showing a planted bug being caught.
# Recorded by .github/workflows/verify.yml with https://github.com/charmbracelet/vhs
Output proof/screens.gif

Set Shell bash
Set FontSize 15
Set Width 1000
Set Height 560
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 10ms

# --- recording starts ---
Type "clear && scripts/verify.sh typescript"
Enter
Wait@120s
Screenshot proof/screenshots/typescript.png
Type "clear && scripts/verify.sh python"
Enter
Wait@120s
Screenshot proof/screenshots/python.png
Type "clear && scripts/verify.sh cpp"
Enter
Wait@120s
Screenshot proof/screenshots/cpp.png
Type "clear && scripts/verify.sh go"
Enter
Wait@120s
Screenshot proof/screenshots/go.png
Type "clear && scripts/verify.sh java"
Enter
Wait@120s
Screenshot proof/screenshots/java.png
Type "clear && scripts/verify.sh rust"
Enter
Wait@120s
Screenshot proof/screenshots/rust.png
Type "clear && scripts/verify.sh ruby"
Enter
Wait@120s
Screenshot proof/screenshots/ruby.png

# Plant a bug (length check < 6 becomes < 5) and show the suite catching it.
Type "clear && sed -i 's/len(pwd) < 6/len(pwd) < 5/' python/solution.py"
Enter
Type "git --no-pager diff --color -U0 python/solution.py | tail -2"
Enter
Sleep 500ms
Type "FORCE_COLOR=1 scripts/verify.sh python 2>&1 | grep -E '== |unit tests|case|Summary|unit |checks failed|agree'; git checkout -- python/solution.py"
Enter
Wait@120s
Screenshot proof/screenshots/bug-caught.png
