#[cfg(test)]
mod tests;

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