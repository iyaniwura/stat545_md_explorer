---
title: 'cm005: `dplyr` Exercise'
output: 
  html_document:
    keep_md: true
---

**Optional, but recommended startup**:

Change the file output to both html and md _documents_ (not notebook).

# Intro to `dplyr` syntax
1. select 
2. arrange
3. filter


* plyr take and R object either a vector or dataframe and output a data frame

* tibbles are special of data frame.

* tidyverse

1. Load the `gapminder` and `tidyverse` packages. Hint: `suppressPackageStartupMessages()`!
    - This loads `dplyr`, too.
2. `knit` the document. 



```r
library(gapminder)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```


## `select()`
Let us view the gapminder data frame first


```r
head(gapminder)
```

```
## # A tibble: 6 x 6
##   country     continent  year lifeExp      pop gdpPercap
##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
## 1 Afghanistan Asia       1952    28.8  8425333      779.
## 2 Afghanistan Asia       1957    30.3  9240934      821.
## 3 Afghanistan Asia       1962    32.0 10267083      853.
## 4 Afghanistan Asia       1967    34.0 11537966      836.
## 5 Afghanistan Asia       1972    36.1 13079460      740.
## 6 Afghanistan Asia       1977    38.4 14880372      786.
```

1. Make a data frame containing the columns `year`, `lifeExp`, `country` from the gapminder data, in that order.


```r
select(gapminder,year,lifeExp,country)
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country    
##    <int>   <dbl> <fct>      
##  1  1952    28.8 Afghanistan
##  2  1957    30.3 Afghanistan
##  3  1962    32.0 Afghanistan
##  4  1967    34.0 Afghanistan
##  5  1972    36.1 Afghanistan
##  6  1977    38.4 Afghanistan
##  7  1982    39.9 Afghanistan
##  8  1987    40.8 Afghanistan
##  9  1992    41.7 Afghanistan
## 10  1997    41.8 Afghanistan
## # ... with 1,694 more rows
```


2. Select all variables, from `country` to `lifeExp`. 


```r
select(gapminder,country:lifeExp)
```

```
## # A tibble: 1,704 x 4
##    country     continent  year lifeExp
##    <fct>       <fct>     <int>   <dbl>
##  1 Afghanistan Asia       1952    28.8
##  2 Afghanistan Asia       1957    30.3
##  3 Afghanistan Asia       1962    32.0
##  4 Afghanistan Asia       1967    34.0
##  5 Afghanistan Asia       1972    36.1
##  6 Afghanistan Asia       1977    38.4
##  7 Afghanistan Asia       1982    39.9
##  8 Afghanistan Asia       1987    40.8
##  9 Afghanistan Asia       1992    41.7
## 10 Afghanistan Asia       1997    41.8
## # ... with 1,694 more rows
```


3. Select all variables, except `lifeExp`.


```r
select(gapminder, -lifeExp)
```

```
## # A tibble: 1,704 x 5
##    country     continent  year      pop gdpPercap
##    <fct>       <fct>     <int>    <int>     <dbl>
##  1 Afghanistan Asia       1952  8425333      779.
##  2 Afghanistan Asia       1957  9240934      821.
##  3 Afghanistan Asia       1962 10267083      853.
##  4 Afghanistan Asia       1967 11537966      836.
##  5 Afghanistan Asia       1972 13079460      740.
##  6 Afghanistan Asia       1977 14880372      786.
##  7 Afghanistan Asia       1982 12881816      978.
##  8 Afghanistan Asia       1987 13867957      852.
##  9 Afghanistan Asia       1992 16317921      649.
## 10 Afghanistan Asia       1997 22227415      635.
## # ... with 1,694 more rows
```

Remove more than one field from the data:


```r
select(gapminder, -lifeExp, -continent)
```

```
## # A tibble: 1,704 x 4
##    country      year      pop gdpPercap
##    <fct>       <int>    <int>     <dbl>
##  1 Afghanistan  1952  8425333      779.
##  2 Afghanistan  1957  9240934      821.
##  3 Afghanistan  1962 10267083      853.
##  4 Afghanistan  1967 11537966      836.
##  5 Afghanistan  1972 13079460      740.
##  6 Afghanistan  1977 14880372      786.
##  7 Afghanistan  1982 12881816      978.
##  8 Afghanistan  1987 13867957      852.
##  9 Afghanistan  1992 16317921      649.
## 10 Afghanistan  1997 22227415      635.
## # ... with 1,694 more rows
```

Suppos we want to store the output of this selection into another variable, we use the assignment statement


```r
extract <- select(gapminder, -lifeExp)
extract
```

```
## # A tibble: 1,704 x 5
##    country     continent  year      pop gdpPercap
##    <fct>       <fct>     <int>    <int>     <dbl>
##  1 Afghanistan Asia       1952  8425333      779.
##  2 Afghanistan Asia       1957  9240934      821.
##  3 Afghanistan Asia       1962 10267083      853.
##  4 Afghanistan Asia       1967 11537966      836.
##  5 Afghanistan Asia       1972 13079460      740.
##  6 Afghanistan Asia       1977 14880372      786.
##  7 Afghanistan Asia       1982 12881816      978.
##  8 Afghanistan Asia       1987 13867957      852.
##  9 Afghanistan Asia       1992 16317921      649.
## 10 Afghanistan Asia       1997 22227415      635.
## # ... with 1,694 more rows
```


4. Put `continent` first. Hint: use the `everything()` function.


```r
select(gapminder, continent, everything())
```

```
## # A tibble: 1,704 x 6
##    continent country      year lifeExp      pop gdpPercap
##    <fct>     <fct>       <int>   <dbl>    <int>     <dbl>
##  1 Asia      Afghanistan  1952    28.8  8425333      779.
##  2 Asia      Afghanistan  1957    30.3  9240934      821.
##  3 Asia      Afghanistan  1962    32.0 10267083      853.
##  4 Asia      Afghanistan  1967    34.0 11537966      836.
##  5 Asia      Afghanistan  1972    36.1 13079460      740.
##  6 Asia      Afghanistan  1977    38.4 14880372      786.
##  7 Asia      Afghanistan  1982    39.9 12881816      978.
##  8 Asia      Afghanistan  1987    40.8 13867957      852.
##  9 Asia      Afghanistan  1992    41.7 16317921      649.
## 10 Asia      Afghanistan  1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


5. Rename `continent` to `cont`.


```r
rename(gapminder,cont=continent)
```

```
## # A tibble: 1,704 x 6
##    country     cont   year lifeExp      pop gdpPercap
##    <fct>       <fct> <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia   1952    28.8  8425333      779.
##  2 Afghanistan Asia   1957    30.3  9240934      821.
##  3 Afghanistan Asia   1962    32.0 10267083      853.
##  4 Afghanistan Asia   1967    34.0 11537966      836.
##  5 Afghanistan Asia   1972    36.1 13079460      740.
##  6 Afghanistan Asia   1977    38.4 14880372      786.
##  7 Afghanistan Asia   1982    39.9 12881816      978.
##  8 Afghanistan Asia   1987    40.8 13867957      852.
##  9 Afghanistan Asia   1992    41.7 16317921      649.
## 10 Afghanistan Asia   1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


## `arrange()`

1. Order by year.


```r
arrange(gapminder,lifeExp)
```

```
## # A tibble: 1,704 x 6
##    country      continent  year lifeExp     pop gdpPercap
##    <fct>        <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Rwanda       Africa     1992    23.6 7290203      737.
##  2 Afghanistan  Asia       1952    28.8 8425333      779.
##  3 Gambia       Africa     1952    30    284320      485.
##  4 Angola       Africa     1952    30.0 4232095     3521.
##  5 Sierra Leone Africa     1952    30.3 2143249      880.
##  6 Afghanistan  Asia       1957    30.3 9240934      821.
##  7 Cambodia     Asia       1977    31.2 6978607      525.
##  8 Mozambique   Africa     1952    31.3 6446316      469.
##  9 Sierra Leone Africa     1957    31.6 2295678     1004.
## 10 Burkina Faso Africa     1952    32.0 4469979      543.
## # ... with 1,694 more rows
```



```r
arrange(gapminder,desc(lifeExp))
```

```
## # A tibble: 1,704 x 6
##    country          continent  year lifeExp       pop gdpPercap
##    <fct>            <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Japan            Asia       2007    82.6 127467972    31656.
##  2 Hong Kong, China Asia       2007    82.2   6980412    39725.
##  3 Japan            Asia       2002    82   127065841    28605.
##  4 Iceland          Europe     2007    81.8    301931    36181.
##  5 Switzerland      Europe     2007    81.7   7554661    37506.
##  6 Hong Kong, China Asia       2002    81.5   6762476    30209.
##  7 Australia        Oceania    2007    81.2  20434176    34435.
##  8 Spain            Europe     2007    80.9  40448191    28821.
##  9 Sweden           Europe     2007    80.9   9031088    33860.
## 10 Israel           Asia       2007    80.7   6426679    25523.
## # ... with 1,694 more rows
```

2. Order by year, in descending order.


```r
arrange(gapminder, desc(year))
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp       pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Afghanistan Asia       2007    43.8  31889923      975.
##  2 Albania     Europe     2007    76.4   3600523     5937.
##  3 Algeria     Africa     2007    72.3  33333216     6223.
##  4 Angola      Africa     2007    42.7  12420476     4797.
##  5 Argentina   Americas   2007    75.3  40301927    12779.
##  6 Australia   Oceania    2007    81.2  20434176    34435.
##  7 Austria     Europe     2007    79.8   8199783    36126.
##  8 Bahrain     Asia       2007    75.6    708573    29796.
##  9 Bangladesh  Asia       2007    64.1 150448339     1391.
## 10 Belgium     Europe     2007    79.4  10392226    33693.
## # ... with 1,694 more rows
```


3. Order by year, then by life expectancy.


```r
arrange(gapminder, year, lifeExp)
```

```
## # A tibble: 1,704 x 6
##    country       continent  year lifeExp     pop gdpPercap
##    <fct>         <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Afghanistan   Asia       1952    28.8 8425333      779.
##  2 Gambia        Africa     1952    30    284320      485.
##  3 Angola        Africa     1952    30.0 4232095     3521.
##  4 Sierra Leone  Africa     1952    30.3 2143249      880.
##  5 Mozambique    Africa     1952    31.3 6446316      469.
##  6 Burkina Faso  Africa     1952    32.0 4469979      543.
##  7 Guinea-Bissau Africa     1952    32.5  580653      300.
##  8 Yemen, Rep.   Asia       1952    32.5 4963829      782.
##  9 Somalia       Africa     1952    33.0 2526994     1136.
## 10 Guinea        Africa     1952    33.6 2664249      510.
## # ... with 1,694 more rows
```

## Piping, `%>%`

Note: think of `%>%` as the word "then"!

1. Combine `select()` Task 1 with `arrange()` Task 3.



```r
gapminder %>%
  select(year, lifeExp, country) %>%
    arrange(year, lifeExp)
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```


Save final output to some variable



```r
Sel_data <- gapminder %>%
  select(year, lifeExp, country) %>%
    arrange(year, lifeExp)

Sel_data
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```
data_s %>%
*f(a=3, b=.)*


## `filter()`

1. Only take data with population greater than 100 million.


```r
gapminder %>%
  filter(pop > 1e9) # the argument of the filter function must be a logical operation
```

```
## # A tibble: 8 x 6
##   country continent  year lifeExp        pop gdpPercap
##   <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
## 1 China   Asia       1982    65.5 1000281000      962.
## 2 China   Asia       1987    67.3 1084035000     1379.
## 3 China   Asia       1992    68.7 1164970000     1656.
## 4 China   Asia       1997    70.4 1230075000     2289.
## 5 China   Asia       2002    72.0 1280400000     3119.
## 6 China   Asia       2007    73.0 1318683096     4959.
## 7 India   Asia       2002    62.9 1034172547     1747.
## 8 India   Asia       2007    64.7 1110396331     2452.
```

Brief dicussion about loical operation:


```r
A <- c(1, 2, 3, 4, 5)
A > 2
```

```
## [1] FALSE FALSE  TRUE  TRUE  TRUE
```


2. Of those, only take data from Asia.

## git stuff (Optional)

Knit, commit, push!

# Break/Challenge: metaprogramming

Here's an activity for you to do during the break, in case you're all caught up. It should help you understand metaprogramming a bit more.

Suppose you're the instructor of an R programming course. You write an assignment question to evaluate whether students can write an `if` statement, for which an answer to the question looks something like this:

```
my_commute <- 60
if (my_commute > 30) {
    print("That's a long commute!")
} else {
    print("That's a short commute.")
}
```

Your task is to use metaprogramming to check whether a response (like the one above) works and contains an `if` statement. You should roughly follow these steps, using [adv-r: expressions](https://adv-r.hadley.nz/expressions.html) as a resource (especially Section 18.1).

1. Wrap the above block of code in the `expr()` function from the `rlang` package.
2. Use the `eval()` function to execute the code, to see if the code runs.
3. Use the `as.character()` function to check whether this response contains an `if` statement.

# Relational/Comparison and Logical Operators in R

1. Find all entries of Canada and Algeria occuring in the '60s. 

2. Find all entries of Canada, and entries of Algeria occuring in the '60s. 
3. Find all entries _not_ including Canada and Algeria.

# Bonus Exercises

If there's time remaining, we'll practice with these three exercises. I'll give you 1 minute for each, then we'll go over the answer.

1. Take all countries in Europe that have a GDP per capita greater than 10000, and select all variables except `gdpPercap`. (Hint: use `-`).

2. Take the first three columns, and extract the names.

3. Of the `iris` data frame, take all columns that start with the word "Petal". 
    - Hint: take a look at the "Select helpers" documentation by running the following code: `?tidyselect::select_helpers`.
    - Exercise from [r-exercises](https://www.r-exercises.com/2017/10/19/dplyr-basic-functions-exercises/).
