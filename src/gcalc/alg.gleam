//// A set of algebraic operations for Gleam programs

import gleam/float

/// MathError represents an error that can occur when performing
/// a mathematical operation
pub type MathError {
  DivisionByZero
  ValueOutOfRange
  UnsupportedOperation
}

/// Returns the exponentiation of the two arguments
/// (i.e. the first argument raised to the power of the second argument)
pub fn pow(base: Float, power: Float) -> Float {
  pow_iter(base, power, 1.0)
}

/// Helper function for the pow function
fn pow_iter(base: Float, power: Float, accumulator: Float) -> Float {
  case power {
    0.0 -> accumulator
    _ -> pow_iter(base, power -. 1.0, base *. accumulator)
  }
}

/// Returns a result containing the factorial of the argument
/// or an error if the argument is negative
///
/// Note: This function only supports non-negative values
pub fn factorial(n: Float) -> Result(Float, MathError) {
  case n <. 0.0 {
    True -> Error(UnsupportedOperation)
    False -> Ok(factorial_iter(n, 1.0))
  }
}

/// Helper function for the factorial function
fn factorial_iter(n: Float, accumulator: Float) -> Float {
  case n {
    0.0 -> accumulator
    _ -> factorial_iter(n -. 1.0, n *. accumulator)
  }
}

/// Returns the absolute value of the argument
pub fn abs(n: Float) -> Float {
  case n <. 0.0 {
    True -> 0.0 -. n
    False -> n
  }
}

/// Returns a result containing the square root of the argument
/// or an error if the argument is negative
///
/// Note: This function only supports non-negative values
/// and returns the floor of the result
/// (i.e. the largest integer less than or equal to the result)
pub fn sqrt(n: Float) -> Result(Float, MathError) {
  case n <. 0.0 {
    True -> Error(ValueOutOfRange)
    False ->
      Ok(
        sqrt_iter(0.0, 1.0, n)
        |> float.floor(),
      )
  }
}

/// Helper function for the square root function
fn sqrt_iter(x0: Float, x1: Float, n: Float) -> Float {
  case abs(x1 -. x0) <. 0.0001 {
    True -> x1
    False -> {
      let x0 = x1
      let x1 = { x0 +. n /. x0 } /. 2.0
      sqrt_iter(x0, x1, n)
    }
  }
}

/// Returns a result containing 2^n where n is the argument
pub fn pow2(n: Float) -> Result(Float, MathError) {
  case n <. 0.0 {
    True -> Error(ValueOutOfRange)
    False -> Ok(pow2_iter(n, 1.0))
  }
}

/// Helper function for the pow2 function
fn pow2_iter(n: Float, accumulator: Float) -> Float {
  case n {
    0.0 -> accumulator
    _ -> pow2_iter(n -. 1.0, 2.0 *. accumulator)
  }
}

/// Returns a result containing 10^n where n is the argument
pub fn pow10(n: Float) -> Result(Float, MathError) {
  case n <. 0.0 {
    True -> Error(ValueOutOfRange)
    False -> Ok(pow10_iter(n, 1.0))
  }
}

/// Helper function for the pow10 function
fn pow10_iter(n: Float, accumulator: Float) -> Float {
  case n {
    0.0 -> accumulator
    _ -> pow10_iter(n -. 1.0, 10.0 *. accumulator)
  }
}
