# Declare de langage of cairo
%lang starknet

## IMPORTS

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

## EVENTS ##

@event
func newWave(user : felt, timestamp : felt, message: felt):
end

## STORAGE VARIABLES ##

@storage_var
func totalWaves() -> (res : felt):
end

@storage_var
func waves(user: felt) -> (res: felt):
end

## CONSTRUCTOR ##

## FUNCTIONS ##

@external
func waves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    let (caller_address) = get_caller_address()

    newWave.emit(user=caller_address,timestamp=null,message=null)
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