#[starknet::contract]
mod Pond {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        ducks_number: u128,
        owners_and_ducks: LegacyMap::<ContractAddress, felt252>
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        DuckCameEvent: DuckCameEvent,
    }

    #[derive(Drop, starknet::Event)]
    struct DuckCameEvent {
        #[key]
        user: ContractAddress,
        name: felt252,
    }

    #[generate_trait]
    impl SimpleStorage of IPond {
        fn get_ducks_number(self: @ContractState) -> u128 {
            self.ducks_number.read()
        }
        fn add_duck(ref self: ContractState, duck: felt252) {
            let caller_address = get_caller_address();
            assert(self.owners_and_ducks.read(caller_address) == 0, 'User can represent only 1 duck');
            self.ducks_number.write(self.ducks_number.read() + 1);

            self.emit(DuckCameEvent {user: caller_address, name: duck});
            self.owners_and_ducks.write(caller_address, duck);
        }
        fn remove_duck(ref self: ContractState, name: felt252) {
            assert(self.owners_and_ducks.read(get_caller_address()) == name, 'Only owner can remove duck');
            self.ducks_number.write(self.ducks_number.read() - 1);
            self.owners_and_ducks.write(get_caller_address(), 0);
        }
    }
}