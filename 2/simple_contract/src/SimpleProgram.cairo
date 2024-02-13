#[starknet::interface]
trait ISimpleProgram<TContractState> {
    fn set(ref self: TContractState, x: u128, y: u128);
    fn get_a(self: @TContractState) -> u128;
    fn get_b(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleProgram {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        a: u128, 
        b: u128
    }

    #[abi(embed_v0)]
    impl SimpleProgram of super::ISimpleProgram<ContractState> {
        fn set(ref self: ContractState, x: u128, y: u128) {
            self.a.write(x);
            self.b.write(y);
        }
        fn get_a(self: @ContractState) -> u128 {
            self.a.read()
        }
        fn get_b(self: @ContractState) -> u128 {
            self.b.read()
        }
    }
}
