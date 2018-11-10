context("Cubing non-numerics")

test_that("At least numeric values work.", {
  num_vec <- c(0, -4.6, 3.4)
  expect_identical(cube(numeric(0)), numeric(0))
  expect_identical(cube(1:3),c(1,8,27))
  expect_identical(cube(num_vec),num_vec^3)
})

test_that("Logicals automatically convert to numeric.", {
  logic_vec <- c(TRUE, TRUE, FALSE)
  expect_identical(cube(logic_vec),c(1,1,0))
})


