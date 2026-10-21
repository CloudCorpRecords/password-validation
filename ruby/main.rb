require_relative 'solution'

lines = $stdin.read.split("\n", -1).map { |l| l.chomp("\r") }
i = 0
n = lines[i].to_i
i += 1
passwords = lines[i, n]
i += n
m = lines[i].to_i
i += 1
common_words = lines[i, m] || []

puts PasswordValidation.password_strength(passwords, common_words)
