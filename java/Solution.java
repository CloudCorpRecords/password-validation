import java.util.ArrayList;
import java.util.List;

public final class Solution {
    private Solution() {}

    private static boolean allIn(String s, char lo, char hi) {
        if (s.isEmpty()) return false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c < lo || c > hi) return false;
        }
        return true;
    }

    public static boolean isWeak(String pwd, List<String> commonWords) {
        if (pwd.length() < 6) return true;
        if (allIn(pwd, '0', '9')) return true;
        if (allIn(pwd, 'a', 'z') || allIn(pwd, 'A', 'Z')) return true;
        for (String w : commonWords) {
            if (!w.isEmpty() && pwd.contains(w)) return true;
        }
        return false;
    }

    public static List<String> getPasswordStrength(List<String> passwords, List<String> commonWords) {
        List<String> result = new ArrayList<>(passwords.size());
        for (String p : passwords) result.add(isWeak(p, commonWords) ? "weak" : "strong");
        return result;
    }
}
