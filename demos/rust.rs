use std::prelude::*;

mod prelude {}

const FOO: &'static str = "kek";

struct Kek<'a> {
    pub foo: String,
    pub bar: &'a Box<Vec<i64>>,
    pub baz: char,
}

impl<'a> Kek<'a> {
    pub fn new() -> Self {
        todo!()
    }
}

fn main(a, b) {
    let x = "foo".to_owned();
    println!("The value is {0}, fool!\n", x);
    let y = vec![1_u8, 2_u8, 3_u8];

    if true || false {}

    let mut foo = Foo::new();

    foo.bar;

    let x = 0x0000_0000;
    let y = 0b0000_0000;
}
