enum Option<T> {
    Some(T),
    None,
}

fn main() {
    let x: Option<i32> = Option::Some(5);
    let y: Option<i32> = Option::None;

    match x {
        Option::Some(value) => println!("Value is: {}", value),
        Option::None => println!("No value"),
    }

    match y {
        Option::Some(value) => println!("Value is: {}", value),
        Option::None => println!("No value"),
    }
}
