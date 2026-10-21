use std::io::{self, Read};

use password_validation::get_password_strength;

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).expect("read stdin");
    let mut lines = input.split('\n').map(|l| l.trim_end_matches('\r').to_string());
    let mut read_list = || -> Vec<String> {
        let n: usize = lines.next().unwrap_or_default().trim().parse().expect("count");
        (0..n).map(|_| lines.next().unwrap_or_default()).collect()
    };

    let passwords = read_list();
    let common_words = read_list();
    for r in get_password_strength(&passwords, &common_words) {
        println!("{r}");
    }
}
