import { getPasswordStrength } from './solution.ts';

// HackerRank-style stdin runner:
//   n, then n passwords, then m, then m common words (one per line)
let data = '';
process.stdin.setEncoding('utf-8');
process.stdin.on('data', (chunk) => (data += chunk));
process.stdin.on('end', () => {
    const lines = data.split('\n').map((l) => l.replace(/\r$/, ''));
    let i = 0;
    const n = parseInt(lines[i++], 10);
    const passwords = lines.slice(i, i + n);
    i += n;
    const m = parseInt(lines[i++], 10);
    const commonWords = lines.slice(i, i + m);
    console.log(getPasswordStrength(passwords, commonWords).join('\n'));
});
