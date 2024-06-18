use std::prelude::*;

mod prelude {}

struct Kek<'a> {
    pub foo: String,
    pub bar: &'a Box<Vec<i64>>,
}

fn main() {
    let x = "foo".to_owned();
}
