pub struct Foo<'a, T> {
    pub bar: String,
    pub baz: &'a str,
    kek: T,
}

impl<'a, T> Foo<'a, T> {
    pub fn new(bar: String, baz: &'a str, kek: T) -> Self {
        Self { bar, baz, kek }
    }
}
