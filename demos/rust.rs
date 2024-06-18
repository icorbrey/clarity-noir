use std::prelude::*;

mod prelude {}

const FOO: &'static str = "kek";

struct Kek<'a> {
    pub foo: String,
    pub bar: &'a Box<Vec<i64>>,
    pub baz: char,
}

fn main() {
    let x = "foo".to_owned();
    println!("The value is {0}, fool!", x);
    let y = vec![1_u8, 2_u8, 3_u8];
    if true {}
    let x = 0x0000_0000;
    let y = 0b0000_0000;
}
