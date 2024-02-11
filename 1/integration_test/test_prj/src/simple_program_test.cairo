mod simple_program_test {
    fn gcd(number1: u8, number2: u8) -> u8 {
        let common_divisor = if number1 == number2 {
            number1
        } else if number1 > number2 {
            let diff = number1 - number2;
            gcd(diff, number2)
        } else {
            let diff = number2 - number1;
            gcd(number1, diff)
        };
        common_divisor
    }

    fn t() {
        let a = 48;
        let b = 56;
        let common_divisor = gcd(a, b);
        println!("height: {}", common_divisor);
    }
}