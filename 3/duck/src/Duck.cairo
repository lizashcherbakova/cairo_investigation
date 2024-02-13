#[starknet::interface]
trait IDuck<TContractState> {
    fn set_duck_details(ref self: TContractState, gender: bool, name: felt252);
    fn quack(ref self: TContractState);
    fn get_duck_details(self: @TContractState) -> (bool, felt252);
}

#[starknet::contract]
mod Duck {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        gender: bool,
        name: felt252
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        DuckQuacked: DuckQuacked,
    }

    #[derive(Drop, starknet::Event)]
    struct DuckQuacked {
        #[key]
        quacker: ContractAddress,
        message: felt252,
        name: felt252
    }

    #[abi(embed_v0)]
    impl Duck of super::IDuck<ContractState> {
        fn set_duck_details(ref self: ContractState, gender: bool, name: felt252) {
            self.gender.write(gender);
            self.name.write(name);
        }

        fn quack(ref self: ContractState) {
            let quacker: ContractAddress = get_caller_address();
            let message: felt252 = 'Quack!';
            self.emit(DuckQuacked { quacker: quacker, message: message, name: self.name.read()});
        }

        fn get_duck_details(self: @ContractState) -> (bool, felt252) {
            (self.gender.read(), self.name.read())
        }
    }
}
