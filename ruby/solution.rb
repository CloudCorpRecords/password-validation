# Password Validation: classify each password as "weak" or "strong".
module PasswordValidation
  module_function

  def weak?(pwd, common_words)
    return true if pwd.length < 6
    return true if pwd.match?(/\A[0-9]+\z/)
    return true if pwd.match?(/\A[a-z]+\z/) || pwd.match?(/\A[A-Z]+\z/)

    common_words.any? { |w| !w.empty? && pwd.include?(w) }
  end

  def password_strength(passwords, common_words)
    passwords.map { |p| weak?(p, common_words) ? 'weak' : 'strong' }
  end
end
