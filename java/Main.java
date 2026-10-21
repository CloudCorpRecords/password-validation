import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class Main {
    private static List<String> readList(BufferedReader in) throws IOException {
        int n = Integer.parseInt(in.readLine().trim());
        List<String> items = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            String line = in.readLine();
            items.add(line == null ? "" : line);
        }
        return items;
    }

    public static void main(String[] args) throws IOException {
        // BufferedReader.readLine already strips "\r\n" and "\n".
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        List<String> passwords = readList(in);
        List<String> commonWords = readList(in);
        StringBuilder out = new StringBuilder();
        for (String r : Solution.getPasswordStrength(passwords, commonWords)) out.append(r).append('\n');
        System.out.print(out);
    }
}
