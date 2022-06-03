# Declare de langage of cairo
%lang starknet

## IMPORTS

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (
    get_block_number,
    get_block_timestamp,
    get_caller_address
)

## EVENTS ##

@event
func newWave(user : felt, timestamp : felt, message: felt):
end

## STORAGE VARIABLES ##

@storage_var
func seed() -> (res: felt):
end

@storage_var
func totalWaves() -> (res : felt):
end

@storage_var
func waves(user: felt) -> (res: Wave*):
end

## STRUCTS

struct Wave:
    member waver: felt
    member message: felt
    member timestamp: felt
end

## CONSTRUCTOR ##

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    tempvar (block_number) = get_block_number()
    tempvar (block_timestamp) = get_block_timestamp()

    seed.write((block_timestamp + block_number) % 100)
end

## FUNCTIONS ##

@external
func waves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(_message: felt):
    alloc_locals
    local (caller_address) = get_caller_address()
    totalWaves.write(totalWaves.read() + 1)

    # Is that good ?
    waves.write(user=caller_address, Wave(waver=caller_address, message=_message, timestamp=block.timestamp))

    local local_seed = ((block_timestamp + block_number + seed.read()) % 100)

    if (local_seed <= 50) {
        local prizeAmount = 1.0
        # TODO : Check contract balance and send prize
    }

    newWave.emit(user=caller_address,timestamp=block.timestamp,message=_message)
    return ()
end

@view
func getTotalWaves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (res : felt):
    let (res) = totalWaves.read()
    return (res)
end

@view
func getWaves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (res : felt):
    let (res) = waves.read()
    return (res)
end