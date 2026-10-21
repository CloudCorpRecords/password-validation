import java.util.List;

public class SolutionTest {
    private static int failures = 0;

    private static void check(boolean cond, String label) {
        if (!cond) {
            System.err.println("FAIL " + label);
            failures++;
        }
    }

    public static void main(String[] args) {
        List<String> none = List.of();

        check(Solution.getPasswordStrength(
                List.of("iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"),
                List.of("coffee", "code", "happy"))
            .equals(List.of("strong", "weak", "weak", "weak", "weak")), "problem example");
        check(Solution.isWeak("Abc12", none), "length 5 is weak");
        check(!Solution.isWeak("Abc123", none), "length 6 mixed is strong");
        check(Solution.isWeak("123456", none), "digits only");
        check(!Solution.isWeak("12345a", none), "digits plus letter");
        check(Solution.isWeak("abcdefg", none), "lowercase only");
        check(Solution.isWeak("ABCDEFG", none), "uppercase only");
        check(!Solution.isWeak("Abcdefg", none), "mixed case");
        check(Solution.isWeak("mycoffeecup1", List.of("coffee")), "contains common word");
        check(!Solution.isWeak("myCoffeeCup", List.of("coffee")), "common word is case-sensitive");
        check(!Solution.isWeak("Abc123", List.of("")), "empty common word ignored");

        if (failures > 0) {
            System.err.println(failures + " check(s) failed");
            System.exit(1);
        }
        System.out.println("java: all unit tests passed");
    }
}
