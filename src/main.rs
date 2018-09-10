#![feature(panic_handler)]
#![feature(asm)]
#![no_std]
#![no_main]

extern crate stm32f401x;
use stm32f401x::nop;
use stm32f401x::peripherals::gpio;
use stm32f401x::peripherals::gpio::{Reg, Mode};

use core::panic::PanicInfo;

#[no_mangle]
pub fn main() -> ! {
    let led = gpio::A::enable(Reg::Moder5, Mode::Out);

    loop {
        led.on();
        for _i in 0..8000000 { nop() }
        led.off();
        for _i in 0..4000000 { nop() }
    }
}

#[panic_handler]
fn panic(_panic: &PanicInfo) -> ! {
    loop {}
}
