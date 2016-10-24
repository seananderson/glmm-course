
Manipulating data with tidyr
============================

Goals
=====

-   Be able to identify wide- and long-format data and why we might need one or the other
-   Be able to convert between the two formats with the tidyr package

Introduction
============

Wide data has a column for each variable.

``` r
library(tidyverse)
air <- airquality # built into R
names(air) <- tolower(names(air))
air <- as_data_frame(air) %>% 
  select(-ozone, -solar.r, -wind)
```

For example, this is long-format data:

``` r
air
```

    ## # A tibble: 153 × 3
    ##     temp month   day
    ##    <int> <int> <int>
    ## 1     67     5     1
    ## 2     72     5     2
    ## 3     74     5     3
    ## 4     62     5     4
    ## 5     56     5     5
    ## 6     66     5     6
    ## 7     65     5     7
    ## 8     59     5     8
    ## 9     61     5     9
    ## 10    69     5    10
    ## # ... with 143 more rows

And this is wide-format data:

``` r
spread(air, month, temp)
```

    ## # A tibble: 31 × 6
    ##      day   `5`   `6`   `7`   `8`   `9`
    ## *  <int> <int> <int> <int> <int> <int>
    ## 1      1    67    78    84    81    91
    ## 2      2    72    74    85    81    92
    ## 3      3    74    67    81    82    93
    ## 4      4    62    84    84    86    93
    ## 5      5    56    85    83    85    87
    ## 6      6    66    79    83    87    84
    ## 7      7    65    82    88    89    80
    ## 8      8    59    87    92    90    78
    ## 9      9    61    90    92    90    75
    ## 10    10    69    87    89    92    73
    ## # ... with 21 more rows

Long-format data has a column or columns identifying the rows of data and a column for the values of those variables. In wide data, the values of those identifiers form columns themselves.

It turns out that you need wide-format data for some types of data analysis and long-format data for others. In reality, you need long-format data much more commonly than wide-format data. For example, ggplot2 requires long-format data,`dplyr::group_by()` requires long-format data, and most modelling functions (such as `lm()`, `lmer()`, `glm()`, and `gam()`) require long-format data (except for the predictors themselves). But people often find it easier to record their data in wide format.

tidyr
=====

tidyr is a successor to the reshape2 package. It doesn't do everything that the reshape2 package does (and if you need that, see my [blog post](http://seananderson.ca/2013/10/19/reshape.html)). But it covers the majority of data reshaping and it does it more elegantly than reshape2 (read: it works nicely with the data pipe, `%>%`).

tidyr is based around two key functions: `gather()` and `spread()`.

`gather` goes from wide-format data and *gathers* it into fewer columns.

`spread` takes long-format data and *spreads* it out wide.

We'll sometimes end up having to use these to get data formatted for fitting mixed effects models and for manipulating the output.

tidyr::spread
=============

`spread` takes in order a data frame, the name of the 'key' column (the column that gets 'swung' up to made the new identifying columns), and the name of the 'value' column (the column that fills the wide dataset with values).

The tidyr package functions take bare (unquoted) column names. This saves typing and makes the functions work well with pipes. E.g. `spread(data, x, y)` *not* `spread(data, "x", "y"))`.

Let's take our `air` data and make it wide:

``` r
air_wide <- spread(air, month, temp)
air_wide
```

    ## # A tibble: 31 × 6
    ##      day   `5`   `6`   `7`   `8`   `9`
    ## *  <int> <int> <int> <int> <int> <int>
    ## 1      1    67    78    84    81    91
    ## 2      2    72    74    85    81    92
    ## 3      3    74    67    81    82    93
    ## 4      4    62    84    84    86    93
    ## 5      5    56    85    83    85    87
    ## 6      6    66    79    83    87    84
    ## 7      7    65    82    88    89    80
    ## 8      8    59    87    92    90    78
    ## 9      9    61    90    92    90    75
    ## 10    10    69    87    89    92    73
    ## # ... with 21 more rows

tidyr::gather
=============

`gather` takes wide data and makes it long.

The first argument is the data, the second argument represents whatever we want to call the ID columns in the long dataset, and the rest of the (unnamed) arguments use the syntax from the `dplyr::select` function to specify which colums to gather (i.e. all non ID columns.)

As an example: let's turn `air_wide` back into `air`.

``` r
gather(air_wide, month, temp, -day)
```

    ## # A tibble: 155 × 3
    ##      day month  temp
    ##    <int> <chr> <int>
    ## 1      1     5    67
    ## 2      2     5    72
    ## 3      3     5    74
    ## 4      4     5    62
    ## 5      5     5    56
    ## 6      6     5    66
    ## 7      7     5    65
    ## 8      8     5    59
    ## 9      9     5    61
    ## 10    10     5    69
    ## # ... with 145 more rows

Challenge 1
-----------

Try and answer the following questions before running the code:

What will the following do?

``` r
gather(air_wide, zebra, aligator, -day) # exercise
```

    ## # A tibble: 155 × 3
    ##      day zebra aligator
    ##    <int> <chr>    <int>
    ## 1      1     5       67
    ## 2      2     5       72
    ## 3      3     5       74
    ## 4      4     5       62
    ## 5      5     5       56
    ## 6      6     5       66
    ## 7      7     5       65
    ## 8      8     5       59
    ## 9      9     5       61
    ## 10    10     5       69
    ## # ... with 145 more rows

Is this the same as above?

``` r
gather(air_wide, month, temp, 2:6)
```

    ## # A tibble: 155 × 3
    ##      day month  temp
    ##    <int> <chr> <int>
    ## 1      1     5    67
    ## 2      2     5    72
    ## 3      3     5    74
    ## 4      4     5    62
    ## 5      5     5    56
    ## 6      6     5    66
    ## 7      7     5    65
    ## 8      8     5    59
    ## 9      9     5    61
    ## 10    10     5    69
    ## # ... with 145 more rows

Why doesn't the following do what we want?

``` r
gather(air_wide, month, temp)
```

Challenge 2
-----------

Start by running the following code to create a data set:

``` r
# from ?tidyr::spread
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
```

Now make the dataset (stock prices for stocks X, Y, and Z) long with columns for time, stock ID, and price. Save the output into `stocks_long`.

Answer:

``` r
stocks_long <- stocks %>% 
  gather(
    key = stock, value = price, -time) # exercise
```

Make `stocks_long` wide again with `spread()`:

``` r
stocks_long %>% spread(
  key = stock, value = price) # exercise
```

    ##          time          X           Y          Z
    ## 1  2009-01-01 -0.6357365 -1.01191492  0.2406418
    ## 2  2009-01-02 -0.4616447  2.68607765 -2.3555779
    ## 3  2009-01-03  1.4322822 -0.42915882  2.1259848
    ## 4  2009-01-04 -0.6506964 -0.35911306 -6.0735763
    ## 5  2009-01-05 -0.2073807 -0.20038148  1.2262314
    ## 6  2009-01-06 -0.3928079  1.42533261 -6.1457993
    ## 7  2009-01-07 -0.3199929 -0.14712881 -1.2039045
    ## 8  2009-01-08 -0.2791133 -0.07526834 -2.1131196
    ## 9  2009-01-09  0.4941883 -1.36332096 -2.6083791
    ## 10 2009-01-10 -0.1773305 -0.64854054 -0.2275871

Bonus: There's another possible wide format for this dataset. Can you figure it out and make it with `spread()`? Hint: there's a row for each stock.

``` r
stocks_long %>% spread(
  key = time, value = price) # exercise
```

    ##   stock 2009-01-01 2009-01-02 2009-01-03 2009-01-04 2009-01-05 2009-01-06
    ## 1     X -0.6357365 -0.4616447  1.4322822 -0.6506964 -0.2073807 -0.3928079
    ## 2     Y -1.0119149  2.6860777 -0.4291588 -0.3591131 -0.2003815  1.4253326
    ## 3     Z  0.2406418 -2.3555779  2.1259848 -6.0735763  1.2262314 -6.1457993
    ##   2009-01-07  2009-01-08 2009-01-09 2009-01-10
    ## 1 -0.3199929 -0.27911330  0.4941883 -0.1773305
    ## 2 -0.1471288 -0.07526834 -1.3633210 -0.6485405
    ## 3 -1.2039045 -2.11311962 -2.6083791 -0.2275871

Further information
===================

Parts of this exercise were modified from <http://seananderson.ca/2013/10/19/reshape.html>, which uses the older, more powerful, but less pipe friendly reshape2 package.

<http://r4ds.had.co.nz/tidy-data.html>

<https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>
