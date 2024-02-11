use test_prj::gcd;

#[test]
fn internal() {
    let a = 48;
    let b = 56;
    let common_divisor = gcd(a, b);
    println!("common_divisor for {} and {} = {}", a, b, common_divisor);
}