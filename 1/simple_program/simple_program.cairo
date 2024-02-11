mod simple_program_test {
    use debug::PrintTrait;

    fn gcd(number1_ptr: @u8, number2_ptr: @u8) -> u8 {
        let number1 = *number1_ptr;
        let number2 = *number2_ptr;
        let common_divisor = if number1 == number2 {
            number1
        } else if number1 > number2 {
            let diff = number1 - number2;
            gcd(@diff, number2_ptr)
        } else {
            let diff = number2 - number1;
            gcd(number1_ptr, @diff)
        };
        common_divisor
    }

    fn main() {
        let a = 56;
        let b = 21;
        let common_divisor: u8 = gcd(@a, @b);
        common_divisor.print();
    }
}