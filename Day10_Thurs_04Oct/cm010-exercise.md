cm010 Exercises
================

Install `nycflights13` package
------------------------------

``` r
install.packages("nycflights13")
```

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: replacing previous import by 'tibble::as_tibble' when loading
    ## 'broom'

    ## Warning: replacing previous import by 'tibble::tibble' when loading 'broom'

``` r
suppressPackageStartupMessages(library(nycflights13))
```

Types of mutating join
----------------------

### Let's join tibbles using four mutating functions: `left_join`, `right_join`, `inner_join` and `full_join`.

### create two tibbles named `a` and `b`

``` r
(a <- tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
(b <- tibble(x1 = LETTERS[c(1,2,4)], x3 = c("T", "F", "T")))
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

### left\_join: Join matching rows from `b` to `a` by matching "x1" variable

``` r
left_join(a,b,by='x1')
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA>

### right\_join: Join matching rows from `a` to `b` by matching "x1" variable.

``` r
right_join(a,b,by='x1')
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 D        NA T

``` r
right_join(b,a,by='x1')
```

    ## # A tibble: 3 x 3
    ##   x1    x3       x2
    ##   <chr> <chr> <int>
    ## 1 A     T         1
    ## 2 B     F         2
    ## 3 C     <NA>      3

``` r
right_join(a,b) # R takes the column that has row common to the two tables
```

    ## Joining, by = "x1"

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 D        NA T

### inner\_join: Join data. Retain only rows in both sets `a` to `b` by matching "x1" variable.

``` r
inner_join(a,b, by="x1")
```

    ## # A tibble: 2 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F

``` r
inner_join(a,b)
```

    ## Joining, by = "x1"

    ## # A tibble: 2 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F

### full\_join: Join data. Retain all values, all rows of `a` to `b` by matching "x1"

``` r
full_join(a,b,by="x1")
```

    ## # A tibble: 4 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA> 
    ## 4 D        NA T

### what happen if we do not specify `by` option?

``` r
left_join(a,b) # finds the column that is common to both table and use it
```

    ## Joining, by = "x1"

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA>

### what happen if we join two different variables (e.g., "x1" to "x3") from two tibbles `a` to `b`?

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
b
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

``` r
left_join(a,b, by=c("x1"="x3"))
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x1.y 
    ##   <chr> <int> <chr>
    ## 1 A         1 <NA> 
    ## 2 B         2 <NA> 
    ## 3 C         3 <NA>

### what happen if two columns of `a` and `c` datasets have the identical colnames?

``` r
# make data frame c and use inner_join()
(c <- tibble(x1 = c(LETTERS[1:2],"x"), x2 = c(1,4,5)))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         4
    ## 3 x         5

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
left_join(a,c)
```

    ## Joining, by = c("x1", "x2")

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
c
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         4
    ## 3 x         5

``` r
left_join(c,a)
```

    ## Joining, by = c("x1", "x2")

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         4
    ## 3 x         5

In class practice
-----------------

`nycflights13` dataset has several tibbles e.g., `flights`, `airports`, `planes`, `weather`.

### 1. Explore `nycflights13` dataset

``` r
#check the tibbles included in `nycflights13` package
class(flights)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
colnames(flights)
```

    ##  [1] "year"           "month"          "day"            "dep_time"      
    ##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
    ##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
    ## [13] "origin"         "dest"           "air_time"       "distance"      
    ## [17] "hour"           "minute"         "time_hour"

``` r
colnames(airlines)
```

    ## [1] "carrier" "name"

``` r
colnames(weather)
```

    ##  [1] "origin"     "year"       "month"      "day"        "hour"      
    ##  [6] "temp"       "dewp"       "humid"      "wind_dir"   "wind_speed"
    ## [11] "wind_gust"  "precip"     "pressure"   "visib"      "time_hour"

``` r
dim(airlines)
```

    ## [1] 16  2

``` r
dim(flights)
```

    ## [1] 336776     19

``` r
head(flights)
```

    ## # A tibble: 6 x 19
    ##    year month   day dep_time sched_dep_time dep_delay arr_time
    ##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ## 1  2013     1     1      517            515         2      830
    ## 2  2013     1     1      533            529         4      850
    ## 3  2013     1     1      542            540         2      923
    ## 4  2013     1     1      544            545        -1     1004
    ## 5  2013     1     1      554            600        -6      812
    ## 6  2013     1     1      554            558        -4      740
    ## # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
    ## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
    ## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
    ## #   time_hour <dttm>

### 2. Drop unimportant variables so it's easier to understand the join results. Also take first 1000 rows to run it faster.

``` r
flights2 <- flights[1:1000,]%>% 
  select(year, tailnum, carrier, time_hour)


flights2
```

    ## # A tibble: 1,000 x 4
    ##     year tailnum carrier time_hour          
    ##    <int> <chr>   <chr>   <dttm>             
    ##  1  2013 N14228  UA      2013-01-01 05:00:00
    ##  2  2013 N24211  UA      2013-01-01 05:00:00
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00
    ##  6  2013 N39463  UA      2013-01-01 05:00:00
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00
    ## # ... with 990 more rows

``` r
head(airlines)
```

    ## # A tibble: 6 x 2
    ##   carrier name                    
    ##   <chr>   <chr>                   
    ## 1 9E      Endeavor Air Inc.       
    ## 2 AA      American Airlines Inc.  
    ## 3 AS      Alaska Airlines Inc.    
    ## 4 B6      JetBlue Airways         
    ## 5 DL      Delta Air Lines Inc.    
    ## 6 EV      ExpressJet Airlines Inc.

### 3. Add airline names to `flights2` from `airlines` dataset.

``` r
# Which join function to use?
colnames(airlines)
```

    ## [1] "carrier" "name"

``` r
colnames(flights2)
```

    ## [1] "year"      "tailnum"   "carrier"   "time_hour"

``` r
left_join(flights2,airlines)
```

    ## Joining, by = "carrier"

    ## # A tibble: 1,000 x 5
    ##     year tailnum carrier time_hour           name                    
    ##    <int> <chr>   <chr>   <dttm>              <chr>                   
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  2  2013 N24211  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00 American Airlines Inc.  
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00 JetBlue Airways         
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00 Delta Air Lines Inc.    
    ##  6  2013 N39463  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00 JetBlue Airways         
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00 ExpressJet Airlines Inc.
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00 JetBlue Airways         
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 American Airlines Inc.  
    ## # ... with 990 more rows

### 3.5 Add tailmun to `airlines` from `flights` dataset.

``` r
head(airlines)
```

    ## # A tibble: 6 x 2
    ##   carrier name                    
    ##   <chr>   <chr>                   
    ## 1 9E      Endeavor Air Inc.       
    ## 2 AA      American Airlines Inc.  
    ## 3 AS      Alaska Airlines Inc.    
    ## 4 B6      JetBlue Airways         
    ## 5 DL      Delta Air Lines Inc.    
    ## 6 EV      ExpressJet Airlines Inc.

``` r
left_join(airlines,flights, by = 'carrier')
```

    ## # A tibble: 336,776 x 20
    ##    carrier name   year month   day dep_time sched_dep_time dep_delay
    ##    <chr>   <chr> <int> <int> <int>    <int>          <int>     <dbl>
    ##  1 9E      Ende…  2013     1     1      810            810         0
    ##  2 9E      Ende…  2013     1     1     1451           1500        -9
    ##  3 9E      Ende…  2013     1     1     1452           1455        -3
    ##  4 9E      Ende…  2013     1     1     1454           1500        -6
    ##  5 9E      Ende…  2013     1     1     1507           1515        -8
    ##  6 9E      Ende…  2013     1     1     1530           1530         0
    ##  7 9E      Ende…  2013     1     1     1546           1540         6
    ##  8 9E      Ende…  2013     1     1     1550           1550         0
    ##  9 9E      Ende…  2013     1     1     1552           1600        -8
    ## 10 9E      Ende…  2013     1     1     1554           1600        -6
    ## # ... with 336,766 more rows, and 12 more variables: arr_time <int>,
    ## #   sched_arr_time <int>, arr_delay <dbl>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>

``` r
colnames(airlines)
```

    ## [1] "carrier" "name"

``` r
right_join(flights2,airlines)
```

    ## Joining, by = "carrier"

    ## # A tibble: 1,002 x 5
    ##     year tailnum carrier time_hour           name             
    ##    <int> <chr>   <chr>   <dttm>              <chr>            
    ##  1  2013 N915XJ  9E      2013-01-01 08:00:00 Endeavor Air Inc.
    ##  2  2013 N8444F  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  3  2013 N920XJ  9E      2013-01-01 14:00:00 Endeavor Air Inc.
    ##  4  2013 N8409N  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  5  2013 N8631E  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  6  2013 N913XJ  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  7  2013 N904XJ  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  8  2013 N934XJ  9E      2013-01-01 15:00:00 Endeavor Air Inc.
    ##  9  2013 N910XJ  9E      2013-01-01 16:00:00 Endeavor Air Inc.
    ## 10  2013 N931XJ  9E      2013-01-01 16:00:00 Endeavor Air Inc.
    ## # ... with 992 more rows

``` r
colnames(flights2)
```

    ## [1] "year"      "tailnum"   "carrier"   "time_hour"

``` r
colnames(airlines)
```

    ## [1] "carrier" "name"

### 4. Add `weather` information to the `flights2` dataset by matching "year" and "time\_hour" variables.

``` r
left_join(flights2,weather, by = c("year" ,"time_hour"))
```

    ## # A tibble: 2,888 x 17
    ##     year tailnum carrier time_hour           origin month   day  hour  temp
    ##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int> <dbl>
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 EWR        1     1     5  39.0
    ##  2  2013 N14228  UA      2013-01-01 05:00:00 JFK        1     1     5  39.0
    ##  3  2013 N14228  UA      2013-01-01 05:00:00 LGA        1     1     5  39.9
    ##  4  2013 N24211  UA      2013-01-01 05:00:00 EWR        1     1     5  39.0
    ##  5  2013 N24211  UA      2013-01-01 05:00:00 JFK        1     1     5  39.0
    ##  6  2013 N24211  UA      2013-01-01 05:00:00 LGA        1     1     5  39.9
    ##  7  2013 N619AA  AA      2013-01-01 05:00:00 EWR        1     1     5  39.0
    ##  8  2013 N619AA  AA      2013-01-01 05:00:00 JFK        1     1     5  39.0
    ##  9  2013 N619AA  AA      2013-01-01 05:00:00 LGA        1     1     5  39.9
    ## 10  2013 N804JB  B6      2013-01-01 05:00:00 EWR        1     1     5  39.0
    ## # ... with 2,878 more rows, and 8 more variables: dewp <dbl>, humid <dbl>,
    ## #   wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>, precip <dbl>,
    ## #   pressure <dbl>, visib <dbl>

``` r
head(weather)
```

    ## # A tibble: 6 x 15
    ##   origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
    ##   <chr>  <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
    ## 1 EWR     2013     1     1     1  39.0  26.1  59.4      270      10.4 
    ## 2 EWR     2013     1     1     2  39.0  27.0  61.6      250       8.06
    ## 3 EWR     2013     1     1     3  39.0  28.0  64.4      240      11.5 
    ## 4 EWR     2013     1     1     4  39.9  28.0  62.2      250      12.7 
    ## 5 EWR     2013     1     1     5  39.0  28.0  64.4      260      12.7 
    ## 6 EWR     2013     1     1     6  37.9  28.0  67.2      240      11.5 
    ## # ... with 5 more variables: wind_gust <dbl>, precip <dbl>,
    ## #   pressure <dbl>, visib <dbl>, time_hour <dttm>

### 5. Add `weather` information to the `flights2` dataset by matching only "time\_hour" variable

``` r
left_join(flights2,weather, by = c("time_hour"))
```

    ## # A tibble: 2,888 x 18
    ##    year.x tailnum carrier time_hour           origin year.y month   day
    ##     <int> <chr>   <chr>   <dttm>              <chr>   <dbl> <dbl> <int>
    ##  1   2013 N14228  UA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  2   2013 N14228  UA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  3   2013 N14228  UA      2013-01-01 05:00:00 LGA      2013     1     1
    ##  4   2013 N24211  UA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  5   2013 N24211  UA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  6   2013 N24211  UA      2013-01-01 05:00:00 LGA      2013     1     1
    ##  7   2013 N619AA  AA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  8   2013 N619AA  AA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  9   2013 N619AA  AA      2013-01-01 05:00:00 LGA      2013     1     1
    ## 10   2013 N804JB  B6      2013-01-01 05:00:00 EWR      2013     1     1
    ## # ... with 2,878 more rows, and 10 more variables: hour <int>, temp <dbl>,
    ## #   dewp <dbl>, humid <dbl>, wind_dir <dbl>, wind_speed <dbl>,
    ## #   wind_gust <dbl>, precip <dbl>, pressure <dbl>, visib <dbl>

Types of filtering join
-----------------------

### Let's filter tibbles using two filtering functions: `semi_join`, `anti_join`

### example for `semi_join`: All rows in `a` that have a match in `b`

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
b
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

``` r
semi_join(a,b)
```

    ## Joining, by = "x1"

    ## # A tibble: 2 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2

``` r
semi_join(b,a)
```

    ## Joining, by = "x1"

    ## # A tibble: 2 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F

### example for `anti_join`: All rows in `a` that do not have a match in `b`

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
b
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

``` r
anti_join(a,b)
```

    ## Joining, by = "x1"

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 C         3

``` r
anti_join(b,a)
```

    ## Joining, by = "x1"

    ## # A tibble: 1 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 D     T

### example of joinin by matching two variables (e.g., "x1", "x2") from both datasets `a` and `c`

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
c
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         4
    ## 3 x         5

``` r
semi_join(a,c)
```

    ## Joining, by = c("x1", "x2")

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1

Types of Set Operations for two datasets
----------------------------------------

### Let's use three `set` functions: `intersect`, `union` and `setdiff`

### create two tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet

``` r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

### example for `intersect`: Rows that appear in both `y` and `z`

``` r
y
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
intersect(y,z)
```

    ## # A tibble: 2 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3

### example for `union`: Rows that appear in either or both `y` and `z`

``` r
union(y,z)
```

    ## # A tibble: 4 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 D         4
    ## 2 C         3
    ## 3 B         2
    ## 4 A         1

### example for `setdiff`: Rows that appear in `y` but not `z`. **Caution:** `setdiff` for `y` to `z` and `z` to `y` are different.

``` r
setdiff(y,z)
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1

``` r
setdiff(z,y)
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 D         4

### what happen if colnames are differentin `y` and `x`? Is there any error message and why?

``` r
(x <- tibble(x1 = c("B", "C", "D"), x3 = 2:4))
```

    ## # A tibble: 3 x 2
    ##   x1       x3
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

``` r
y
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

Types of binding datasets
-------------------------

### Let's bind datasets by rows or column using two binding functions:

### example for `bind_rows`: Append `z` to `y` as new rows

``` r
bind_rows(y,z)
```

    ## # A tibble: 6 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3
    ## 4 B         2
    ## 5 C         3
    ## 6 D         4

### example for `bind_cols`: Append `z` to `y` as new columns. **Caution**: matches rows by position. Check colnames after binding.

``` r
z
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

``` r
M <-bind_cols(y,z)
class(M)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
knitr::kable(M)
```

| x1  |   x2| x11 |  x21|
|:----|----:|:----|----:|
| A   |    1| B   |    2|
| B   |    2| C   |    3|
| C   |    3| D   |    4|

``` r
bind_cols(y,x)
```

    ## # A tibble: 3 x 4
    ##   x1       x2 x11      x3
    ##   <chr> <int> <chr> <int>
    ## 1 A         1 B         2
    ## 2 B         2 C         3
    ## 3 C         3 D         4

### what happen if colnames are different between `y` and `x` datasets?

``` r
bind_rows(y,x)
```

    ## # A tibble: 6 x 3
    ##   x1       x2    x3
    ##   <chr> <int> <int>
    ## 1 A         1    NA
    ## 2 B         2    NA
    ## 3 C         3    NA
    ## 4 B        NA     2
    ## 5 C        NA     3
    ## 6 D        NA     4

Practice Exercises
------------------

Practice these concepts in the following exercises. It might help you to first identify the type of function you are applying.

### 1. Filter the rows of `flights2` by matching "year" and "time\_hour" variables to `weather` dataset. Use both `semi_join()` and `anti_join()`

``` r
semi_join(flights2,weather,by=c("year","time_hour"))
```

    ## # A tibble: 1,000 x 4
    ##     year tailnum carrier time_hour          
    ##    <int> <chr>   <chr>   <dttm>             
    ##  1  2013 N14228  UA      2013-01-01 05:00:00
    ##  2  2013 N24211  UA      2013-01-01 05:00:00
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00
    ##  6  2013 N39463  UA      2013-01-01 05:00:00
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00
    ## # ... with 990 more rows

### 2. Can we apply `set` and `binding` funcions between `flights2` and `weather` datasets. Why and why not?

``` r
head(flights2)
```

    ## # A tibble: 6 x 4
    ##    year tailnum carrier time_hour          
    ##   <int> <chr>   <chr>   <dttm>             
    ## 1  2013 N14228  UA      2013-01-01 05:00:00
    ## 2  2013 N24211  UA      2013-01-01 05:00:00
    ## 3  2013 N619AA  AA      2013-01-01 05:00:00
    ## 4  2013 N804JB  B6      2013-01-01 05:00:00
    ## 5  2013 N668DN  DL      2013-01-01 06:00:00
    ## 6  2013 N39463  UA      2013-01-01 05:00:00

``` r
head(weather)
```

    ## # A tibble: 6 x 15
    ##   origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
    ##   <chr>  <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
    ## 1 EWR     2013     1     1     1  39.0  26.1  59.4      270      10.4 
    ## 2 EWR     2013     1     1     2  39.0  27.0  61.6      250       8.06
    ## 3 EWR     2013     1     1     3  39.0  28.0  64.4      240      11.5 
    ## 4 EWR     2013     1     1     4  39.9  28.0  62.2      250      12.7 
    ## 5 EWR     2013     1     1     5  39.0  28.0  64.4      260      12.7 
    ## 6 EWR     2013     1     1     6  37.9  28.0  67.2      240      11.5 
    ## # ... with 5 more variables: wind_gust <dbl>, precip <dbl>,
    ## #   pressure <dbl>, visib <dbl>, time_hour <dttm>

``` r
bind_rows(flights2,weather)
```

    ## # A tibble: 27,115 x 17
    ##     year tailnum carrier time_hour           origin month   day  hour  temp
    ##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int> <dbl>
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
    ##  2  2013 N24211  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
    ##  6  2013 N39463  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
    ## # ... with 27,105 more rows, and 8 more variables: dewp <dbl>,
    ## #   humid <dbl>, wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>,
    ## #   precip <dbl>, pressure <dbl>, visib <dbl>

``` r
colnames(flights2)
```

    ## [1] "year"      "tailnum"   "carrier"   "time_hour"

``` r
colnames(airlines)
```

    ## [1] "carrier" "name"

### 3. Let's create a tibble `p` with "x1" and "x2" coulmns and have duplicated element in "x1" column. Create another tibble `q` with "x1" and "x3" columns. Then apply `left_join` function `p` to `q` and `q` to `p`.

``` r
(p <- tibble(x1=c("a","b","b","c"),x2=1:4))
```

    ## # A tibble: 4 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 a         1
    ## 2 b         2
    ## 3 b         3
    ## 4 c         4

``` r
(q <- tibble(x1=c("a","b","c","c"),x3=5:8))
```

    ## # A tibble: 4 x 2
    ##   x1       x3
    ##   <chr> <int>
    ## 1 a         5
    ## 2 b         6
    ## 3 c         7
    ## 4 c         8

``` r
left_join(p,q)
```

    ## Joining, by = "x1"

    ## # A tibble: 5 x 3
    ##   x1       x2    x3
    ##   <chr> <int> <int>
    ## 1 a         1     5
    ## 2 b         2     6
    ## 3 b         3     6
    ## 4 c         4     7
    ## 5 c         4     8

``` r
left_join(q,p)
```

    ## Joining, by = "x1"

    ## # A tibble: 5 x 3
    ##   x1       x3    x2
    ##   <chr> <int> <int>
    ## 1 a         5     1
    ## 2 b         6     2
    ## 3 b         6     3
    ## 4 c         7     4
    ## 5 c         8     4
