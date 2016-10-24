
Manipulating data with dplyr and pipes
======================================

Goals
=====

-   Become familiar with the 5 dplyr verbs of data manipulation
-   Be comfortable chaining R commands with the `%>%` (pipe) symbol

dplyr
=====

dplyr is built around 5 verbs. These verbs make up the majority of the data manipulation you tend to do. You might need to:

*Select* certain columns of data.

*Filter* your data to select specific rows.

*Arrange* the rows of your data into an order.

*Mutate* your data frame to contain new columns.

*Summarise* chunks of you data in some way.

Let's look at how those work.

The data
========

We're going to work with a dataset of mammal life-history, geography, and ecology traits from the PanTHERIA database:

Jones, K.E., *et al*. PanTHERIA: a species-level database of life history, ecology, and geography of extant and recently extinct mammals. Ecology 90:2648. <http://esapubs.org/archive/ecol/E090/184/>

You can download the data from here:

``` r
pantheria <-
  "http://esapubs.org/archive/ecol/E090/184/PanTHERIA_1-0_WR05_Aug2008.txt"
download.file(pantheria, destfile = "data/raw/mammals.txt")
```

I've cached the file in `data/raw/` as well.

We'll load the dplyr package:

``` r
library(dplyr)
```

Next we'll read it in and simplify it. This gets a bit ugly, but you can safely just run this code chunk and ignore the details. Later you might want to come back and work through the code if any looks new to you. This type of data cleaning is commonly required:

``` r
mammals <- readr::read_tsv("data/raw/mammals.txt")
names(mammals) <- sub("[0-9._-]+", "", names(mammals))
names(mammals) <- sub("MSW", "", names(mammals))
mammals <- select(mammals, Order, Binomial, AdultBodyMass_g, 
  AdultHeadBodyLen_mm, HomeRange_km2, LitterSize)
names(mammals) <- gsub("([A-Z])", "_\\L\\1", names(mammals), perl = TRUE)
names(mammals) <- gsub("^_", "", names(mammals), perl = TRUE)
mammals[mammals == -999] <- NA
names(mammals)[names(mammals) == "binomial"] <- "species"
mammals <- as_data_frame(mammals) # for prettier printing etc.
```

Looking at the data
===================

Data frames look a bit different in dplyr. Above, I called the `as_data_frame()` function on our data. This provides more useful printing of data frames in the console. Ever accidentally printed a massive data frame in the console before? Yeah... this avoids that. You don't need to change your data to a data frame tbl first — the dplyr functions will automatically convert your data when you call them. This is what the data look like on the console:

``` r
mammals
```

    ## # A tibble: 5,416 × 6
    ##           order             species adult_body_mass_g
    ##           <chr>               <chr>             <dbl>
    ## 1  Artiodactyla Camelus dromedarius         492714.47
    ## 2     Carnivora       Canis adustus          10392.49
    ## 3     Carnivora        Canis aureus           9658.70
    ## 4     Carnivora       Canis latrans          11989.10
    ## 5     Carnivora         Canis lupus          31756.51
    ## 6  Artiodactyla       Bos frontalis         800143.05
    ## 7  Artiodactyla       Bos grunniens         500000.00
    ## 8  Artiodactyla       Bos javanicus         635974.34
    ## 9      Primates  Callicebus cupreus           1117.02
    ## 10     Primates Callicebus discolor                NA
    ## # ... with 5,406 more rows, and 3 more variables:
    ## #   adult_head_body_len_mm <dbl>, home_range_km2 <dbl>, litter_size <dbl>

dplyr also provides a function `glimpse()` that makes it easy to look at our data in a transposed view. It's similar to the `str()` (structure) function, but has a few advantages (see `?glimpse`).

``` r
glimpse(mammals)
```

    ## Observations: 5,416
    ## Variables: 6
    ## $ order                  <chr> "Artiodactyla", "Carnivora", "Carnivora...
    ## $ species                <chr> "Camelus dromedarius", "Canis adustus",...
    ## $ adult_body_mass_g      <dbl> 492714.47, 10392.49, 9658.70, 11989.10,...
    ## $ adult_head_body_len_mm <dbl> NA, 745.32, 827.53, 872.39, 1055.00, 27...
    ## $ home_range_km2         <dbl> 1.963200e+02, 1.010000e+00, 2.950000e+0...
    ## $ litter_size            <dbl> 0.98, 4.50, 3.74, 5.72, 4.98, 1.22, 1.0...

Selecting columns
=================

`select()` lets you subset by columns. This is similar to `subset()` in base R, but it also allows for some fancy use of helper functions such as `contains()`, `starts_with()` and, `ends_with()`. I think these examples are self explanatory, so I'll just include them here:

``` r
select(mammals, adult_head_body_len_mm)
```

    ## # A tibble: 5,416 × 1
    ##    adult_head_body_len_mm
    ##                     <dbl>
    ## 1                      NA
    ## 2                  745.32
    ## 3                  827.53
    ## 4                  872.39
    ## 5                 1055.00
    ## 6                 2700.00
    ## 7                      NA
    ## 8                 2075.00
    ## 9                  354.99
    ## 10                     NA
    ## # ... with 5,406 more rows

``` r
select(mammals, adult_head_body_len_mm, litter_size)
```

    ## # A tibble: 5,416 × 2
    ##    adult_head_body_len_mm litter_size
    ##                     <dbl>       <dbl>
    ## 1                      NA        0.98
    ## 2                  745.32        4.50
    ## 3                  827.53        3.74
    ## 4                  872.39        5.72
    ## 5                 1055.00        4.98
    ## 6                 2700.00        1.22
    ## 7                      NA        1.00
    ## 8                 2075.00        1.22
    ## 9                  354.99        1.01
    ## 10                     NA          NA
    ## # ... with 5,406 more rows

``` r
select(mammals, adult_head_body_len_mm:litter_size)
```

    ## # A tibble: 5,416 × 3
    ##    adult_head_body_len_mm home_range_km2 litter_size
    ##                     <dbl>          <dbl>       <dbl>
    ## 1                      NA         196.32        0.98
    ## 2                  745.32           1.01        4.50
    ## 3                  827.53           2.95        3.74
    ## 4                  872.39          18.88        5.72
    ## 5                 1055.00         159.86        4.98
    ## 6                 2700.00             NA        1.22
    ## 7                      NA             NA        1.00
    ## 8                 2075.00             NA        1.22
    ## 9                  354.99             NA        1.01
    ## 10                     NA             NA          NA
    ## # ... with 5,406 more rows

``` r
select(mammals, -adult_head_body_len_mm)
```

    ## # A tibble: 5,416 × 5
    ##           order             species adult_body_mass_g home_range_km2
    ##           <chr>               <chr>             <dbl>          <dbl>
    ## 1  Artiodactyla Camelus dromedarius         492714.47         196.32
    ## 2     Carnivora       Canis adustus          10392.49           1.01
    ## 3     Carnivora        Canis aureus           9658.70           2.95
    ## 4     Carnivora       Canis latrans          11989.10          18.88
    ## 5     Carnivora         Canis lupus          31756.51         159.86
    ## 6  Artiodactyla       Bos frontalis         800143.05             NA
    ## 7  Artiodactyla       Bos grunniens         500000.00             NA
    ## 8  Artiodactyla       Bos javanicus         635974.34             NA
    ## 9      Primates  Callicebus cupreus           1117.02             NA
    ## 10     Primates Callicebus discolor                NA             NA
    ## # ... with 5,406 more rows, and 1 more variables: litter_size <dbl>

``` r
select(mammals, starts_with("adult"))
```

    ## # A tibble: 5,416 × 2
    ##    adult_body_mass_g adult_head_body_len_mm
    ##                <dbl>                  <dbl>
    ## 1          492714.47                     NA
    ## 2           10392.49                 745.32
    ## 3            9658.70                 827.53
    ## 4           11989.10                 872.39
    ## 5           31756.51                1055.00
    ## 6          800143.05                2700.00
    ## 7          500000.00                     NA
    ## 8          635974.34                2075.00
    ## 9            1117.02                 354.99
    ## 10                NA                     NA
    ## # ... with 5,406 more rows

``` r
select(mammals, ends_with("g"))
```

    ## # A tibble: 5,416 × 1
    ##    adult_body_mass_g
    ##                <dbl>
    ## 1          492714.47
    ## 2           10392.49
    ## 3            9658.70
    ## 4           11989.10
    ## 5           31756.51
    ## 6          800143.05
    ## 7          500000.00
    ## 8          635974.34
    ## 9            1117.02
    ## 10                NA
    ## # ... with 5,406 more rows

``` r
select(mammals, 1:3)
```

    ## # A tibble: 5,416 × 3
    ##           order             species adult_body_mass_g
    ##           <chr>               <chr>             <dbl>
    ## 1  Artiodactyla Camelus dromedarius         492714.47
    ## 2     Carnivora       Canis adustus          10392.49
    ## 3     Carnivora        Canis aureus           9658.70
    ## 4     Carnivora       Canis latrans          11989.10
    ## 5     Carnivora         Canis lupus          31756.51
    ## 6  Artiodactyla       Bos frontalis         800143.05
    ## 7  Artiodactyla       Bos grunniens         500000.00
    ## 8  Artiodactyla       Bos javanicus         635974.34
    ## 9      Primates  Callicebus cupreus           1117.02
    ## 10     Primates Callicebus discolor                NA
    ## # ... with 5,406 more rows

Filtering rows
==============

`filter()` lets you subset by rows. You can use any valid logical statements:

``` r
filter(mammals, adult_body_mass_g > 1e7)[ , 1:3]
```

    ## # A tibble: 12 × 3
    ##      order                species adult_body_mass_g
    ##      <chr>                  <chr>             <dbl>
    ## 1  Cetacea      Caperea marginata          32000000
    ## 2  Cetacea  Balaenoptera musculus         154321304
    ## 3  Cetacea  Balaenoptera physalus          47506008
    ## 4  Cetacea     Balaena mysticetus          79691179
    ## 5  Cetacea  Balaenoptera borealis          22106252
    ## 6  Cetacea     Balaenoptera edeni          20000000
    ## 7  Cetacea      Berardius bairdii          11380000
    ## 8  Cetacea  Eschrichtius robustus          27324024
    ## 9  Cetacea    Eubalaena australis          23000000
    ## 10 Cetacea    Eubalaena glacialis          23000000
    ## 11 Cetacea Megaptera novaeangliae          30000000
    ## 12 Cetacea       Physeter catodon          14540960

``` r
filter(mammals, species == "Balaena mysticetus")
```

    ## # A tibble: 1 × 6
    ##     order            species adult_body_mass_g adult_head_body_len_mm
    ##     <chr>              <chr>             <dbl>                  <dbl>
    ## 1 Cetacea Balaena mysticetus          79691179               12187.12
    ## # ... with 2 more variables: home_range_km2 <dbl>, litter_size <dbl>

``` r
filter(mammals, order == "Carnivora", adult_body_mass_g < 200)
```

    ## # A tibble: 3 × 6
    ##       order         species adult_body_mass_g adult_head_body_len_mm
    ##       <chr>           <chr>             <dbl>                  <dbl>
    ## 1 Carnivora Mustela altaica            180.24                 243.52
    ## 2 Carnivora Mustela frenata            190.03                 229.31
    ## 3 Carnivora Mustela nivalis             78.45                 188.18
    ## # ... with 2 more variables: home_range_km2 <dbl>, litter_size <dbl>

Challenge: filter `mammals` for all rows where `adult_body_mass_g` is `NA` and `adult_head_body_len_mm` is greater than 2000. Hint (use `is.na()`):

``` r
filter(mammals, is.na(home_range_km2), adult_head_body_len_mm > 2000) # exercise
```

    ## # A tibble: 76 × 6
    ##             order               species adult_body_mass_g
    ##             <chr>                 <chr>             <dbl>
    ## 1    Artiodactyla         Bos frontalis         800143.05
    ## 2    Artiodactyla         Bos javanicus         635974.34
    ## 3    Artiodactyla           Bos sauveli         791321.76
    ## 4         Cetacea Balaenoptera musculus      154321304.50
    ## 5         Cetacea Balaenoptera physalus       47506008.23
    ## 6       Carnivora   Erignathus barbatus         279999.99
    ## 7  Perissodactyla          Equus grevyi         408000.35
    ## 8  Perissodactyla        Equus hemionus         235248.07
    ## 9         Cetacea Delphinapterus leucas        1381640.73
    ## 10        Cetacea     Delphinus delphis          79271.69
    ## # ... with 66 more rows, and 3 more variables:
    ## #   adult_head_body_len_mm <dbl>, home_range_km2 <dbl>, litter_size <dbl>

Arranging rows
==============

`arrange()` lets you order the rows by one or more columns in ascending or descending order. I'm selecting the first three columns only to make the output easier to read:

``` r
arrange(mammals, adult_body_mass_g)[ , 1:3]
```

    ## # A tibble: 5,416 × 3
    ##           order                     species adult_body_mass_g
    ##           <chr>                       <chr>             <dbl>
    ## 1    Chiroptera Craseonycteris thonglongyai              1.96
    ## 2    Chiroptera            Kerivoula minuta              2.03
    ## 3  Soricomorpha             Suncus etruscus              2.26
    ## 4  Soricomorpha          Sorex minutissimus              2.46
    ## 5  Soricomorpha     Suncus madagascariensis              2.47
    ## 6  Soricomorpha         Crocidura lusitania              2.48
    ## 7  Soricomorpha         Crocidura planiceps              2.50
    ## 8    Chiroptera        Pipistrellus nanulus              2.51
    ## 9  Soricomorpha                 Sorex nanus              2.57
    ## 10 Soricomorpha              Sorex arizonae              2.70
    ## # ... with 5,406 more rows

``` r
arrange(mammals, desc(adult_body_mass_g))[ , 1:3]
```

    ## # A tibble: 5,416 × 3
    ##      order                species adult_body_mass_g
    ##      <chr>                  <chr>             <dbl>
    ## 1  Cetacea  Balaenoptera musculus         154321304
    ## 2  Cetacea     Balaena mysticetus          79691179
    ## 3  Cetacea  Balaenoptera physalus          47506008
    ## 4  Cetacea      Caperea marginata          32000000
    ## 5  Cetacea Megaptera novaeangliae          30000000
    ## 6  Cetacea  Eschrichtius robustus          27324024
    ## 7  Cetacea    Eubalaena australis          23000000
    ## 8  Cetacea    Eubalaena glacialis          23000000
    ## 9  Cetacea  Balaenoptera borealis          22106252
    ## 10 Cetacea     Balaenoptera edeni          20000000
    ## # ... with 5,406 more rows

``` r
arrange(mammals, order, adult_body_mass_g)[ , 1:3]
```

    ## # A tibble: 5,416 × 3
    ##           order                species adult_body_mass_g
    ##           <chr>                  <chr>             <dbl>
    ## 1  Afrosoricida      Microgale pusilla              3.40
    ## 2  Afrosoricida      Microgale parvula              3.53
    ## 3  Afrosoricida         Geogale aurita              6.69
    ## 4  Afrosoricida   Microgale fotsifotsy              7.70
    ## 5  Afrosoricida Microgale longicaudata              8.08
    ## 6  Afrosoricida Microgale brevicaudata              8.99
    ## 7  Afrosoricida   Microgale principula             10.20
    ## 8  Afrosoricida    Microgale drouhardi             10.50
    ## 9  Afrosoricida       Microgale cowani             12.27
    ## 10 Afrosoricida        Microgale taiva             12.40
    ## # ... with 5,406 more rows

Mutating columns
================

`mutate()` lets you add new columns. Notice that the new columns you create can build on each other. I will wrap these in `glimpse()` to make the new columns easy to see:

``` r
glimpse(mutate(mammals, adult_body_mass_kg = adult_body_mass_g / 1000))
```

    ## Observations: 5,416
    ## Variables: 7
    ## $ order                  <chr> "Artiodactyla", "Carnivora", "Carnivora...
    ## $ species                <chr> "Camelus dromedarius", "Canis adustus",...
    ## $ adult_body_mass_g      <dbl> 492714.47, 10392.49, 9658.70, 11989.10,...
    ## $ adult_head_body_len_mm <dbl> NA, 745.32, 827.53, 872.39, 1055.00, 27...
    ## $ home_range_km2         <dbl> 1.963200e+02, 1.010000e+00, 2.950000e+0...
    ## $ litter_size            <dbl> 0.98, 4.50, 3.74, 5.72, 4.98, 1.22, 1.0...
    ## $ adult_body_mass_kg     <dbl> 492.71447, 10.39249, 9.65870, 11.98910,...

``` r
glimpse(mutate(mammals, 
    g_per_mm = adult_body_mass_g / adult_head_body_len_mm))
```

    ## Observations: 5,416
    ## Variables: 7
    ## $ order                  <chr> "Artiodactyla", "Carnivora", "Carnivora...
    ## $ species                <chr> "Camelus dromedarius", "Canis adustus",...
    ## $ adult_body_mass_g      <dbl> 492714.47, 10392.49, 9658.70, 11989.10,...
    ## $ adult_head_body_len_mm <dbl> NA, 745.32, 827.53, 872.39, 1055.00, 27...
    ## $ home_range_km2         <dbl> 1.963200e+02, 1.010000e+00, 2.950000e+0...
    ## $ litter_size            <dbl> 0.98, 4.50, 3.74, 5.72, 4.98, 1.22, 1.0...
    ## $ g_per_mm               <dbl> NA, 13.9436618, 11.6717219, 13.7428214,...

``` r
glimpse(mutate(mammals, 
    g_per_mm = adult_body_mass_g / adult_head_body_len_mm,
    kg_per_mm = g_per_mm / 1000))
```

    ## Observations: 5,416
    ## Variables: 8
    ## $ order                  <chr> "Artiodactyla", "Carnivora", "Carnivora...
    ## $ species                <chr> "Camelus dromedarius", "Canis adustus",...
    ## $ adult_body_mass_g      <dbl> 492714.47, 10392.49, 9658.70, 11989.10,...
    ## $ adult_head_body_len_mm <dbl> NA, 745.32, 827.53, 872.39, 1055.00, 27...
    ## $ home_range_km2         <dbl> 1.963200e+02, 1.010000e+00, 2.950000e+0...
    ## $ litter_size            <dbl> 0.98, 4.50, 3.74, 5.72, 4.98, 1.22, 1.0...
    ## $ g_per_mm               <dbl> NA, 13.9436618, 11.6717219, 13.7428214,...
    ## $ kg_per_mm              <dbl> NA, 0.0139436618, 0.0116717219, 0.01374...

Summarising columns
===================

Finally, `summarise()` lets you calculate summary statistics. On its own `summarise()` isn't that useful, but when combined with `group_by()` you can summarise by chunks of data. This is similar to what you might be familiar with through `ddply()` and `summarise()` from the plyr package:

``` r
summarise(mammals, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))
```

    ## # A tibble: 1 × 1
    ##   mean_mass
    ##       <dbl>
    ## 1  177810.2

``` r
# summarise with group_by:
head(summarise(group_by(mammals, order),
  mean_mass = mean(adult_body_mass_g, na.rm = TRUE)))
```

    ## # A tibble: 6 × 2
    ##          order    mean_mass
    ##          <chr>        <dbl>
    ## 1 Afrosoricida 9.475564e+01
    ## 2 Artiodactyla 1.213294e+05
    ## 3    Carnivora 4.738645e+04
    ## 4      Cetacea 7.373065e+06
    ## 5   Chiroptera 5.772033e+01
    ## 6    Cingulata 4.699230e+03

Piping data
===========

Pipes take the output from one function and feed it to the first argument of the next function. You may have encountered the Unix pipe `|` before.

The magrittr R package contains the pipe function `%>%`. Yes it might look bizarre at first but it makes more sense when you think about it. The R language allows symbols wrapped in `%` to be defined as functions, the `>` helps imply a chain, and you can hit these 2 characters one after the other very quickly on a keyboard by holding down the Shift key. Try it!

Try pronouncing `%>%` "then" whenever you see it. If you want to see the help page, you'll need to wrap it in back ticks like so:

``` r
?magrittr::`%>%`
```

A trivial pipe example
======================

Pipes can work with nearly any functions. Let's start with a non-dplyr example:

``` r
x <- rnorm(10)
x %>% max
```

    ## [1] 1.767287

``` r
# is the same thing as:
max(x)
```

    ## [1] 1.767287

So, we took the value of `x` (what would have been printed on the console), captured it, and fed it to the first argument of `max()`. It's probably not clear why this is cool yet, but hang on.

A silly dplyr example with pipes
================================

Let's try a single-pipe dplyr example. We'll pipe the `mammals` data frame to the arrange function's first argument, and choose to arrange by the `adult_body_mass_g` column:

``` r
mammals %>% arrange(adult_body_mass_g)
```

    ## # A tibble: 5,416 × 6
    ##           order                     species adult_body_mass_g
    ##           <chr>                       <chr>             <dbl>
    ## 1    Chiroptera Craseonycteris thonglongyai              1.96
    ## 2    Chiroptera            Kerivoula minuta              2.03
    ## 3  Soricomorpha             Suncus etruscus              2.26
    ## 4  Soricomorpha          Sorex minutissimus              2.46
    ## 5  Soricomorpha     Suncus madagascariensis              2.47
    ## 6  Soricomorpha         Crocidura lusitania              2.48
    ## 7  Soricomorpha         Crocidura planiceps              2.50
    ## 8    Chiroptera        Pipistrellus nanulus              2.51
    ## 9  Soricomorpha                 Sorex nanus              2.57
    ## 10 Soricomorpha              Sorex arizonae              2.70
    ## # ... with 5,406 more rows, and 3 more variables:
    ## #   adult_head_body_len_mm <dbl>, home_range_km2 <dbl>, litter_size <dbl>

A better example
================

Here's where it gets interesting We can chain dplyr functions in succession. This lets us write data manipulation steps in the order we think of them and avoid creating temporary variables in the middle to capture the output. This works because the output from every dplyr function is a data frame and the first argument of every dplyr function is a data frame.

Say we wanted to find the species with the highest body-mass-to-length ratio:

``` r
mammals %>%
  mutate(mass_to_length = adult_body_mass_g / adult_head_body_len_mm) %>%
  arrange(desc(mass_to_length)) %>%
  select(species, mass_to_length)
```

    ## # A tibble: 5,416 × 2
    ##                   species mass_to_length
    ##                     <chr>          <dbl>
    ## 1      Balaena mysticetus       6538.967
    ## 2   Balaenoptera musculus       5063.035
    ## 3  Megaptera novaeangliae       2333.503
    ## 4   Eschrichtius robustus       2309.354
    ## 5   Balaenoptera physalus       2301.529
    ## 6         Elephas maximus       1703.728
    ## 7     Eubalaena glacialis       1653.834
    ## 8     Eubalaena australis       1625.442
    ## 9      Balaenoptera edeni       1444.443
    ## 10  Balaenoptera borealis       1202.593
    ## # ... with 5,406 more rows

So, we took `mammals`, fed it to `mutate()` to create a mass-length ratio column, arranged the resulting data frame in descending order by that ratio, and selected the columns we wanted to see. This is just the beginning. If you can imagine it, you can string it together. If you want to debug your code, just pull a pipe off the end and run the code down to that step. Or build your analysis up and add successive pipes.

The above is equivalent to:

``` r
select(
  arrange(
    mutate(mammals,
      mass_to_length = adult_body_mass_g / adult_head_body_len_mm),
    desc(mass_to_length)),
  species, mass_to_length)
```

    ## # A tibble: 5,416 × 2
    ##                   species mass_to_length
    ##                     <chr>          <dbl>
    ## 1      Balaena mysticetus       6538.967
    ## 2   Balaenoptera musculus       5063.035
    ## 3  Megaptera novaeangliae       2333.503
    ## 4   Eschrichtius robustus       2309.354
    ## 5   Balaenoptera physalus       2301.529
    ## 6         Elephas maximus       1703.728
    ## 7     Eubalaena glacialis       1653.834
    ## 8     Eubalaena australis       1625.442
    ## 9      Balaenoptera edeni       1444.443
    ## 10  Balaenoptera borealis       1202.593
    ## # ... with 5,406 more rows

But the problem here is that you have to read it inside out, it's easy to miss a bracket, and the arguments get separated from the function (e.g. see `mutate()` and `desc(mass_to_length))`). Plus, this is a rather trivial example. Chain together even more steps and it quickly gets out of hand.

Here's one more example. Let's ask what taxonomic orders have a median litter size greater than 3. I'll start by grouping by `order` and calculating the median litter sizes:

``` r
mammals %>% group_by(order) %>%
  summarise(median_litter = median(litter_size, na.rm = TRUE))
```

    ## # A tibble: 29 × 2
    ##              order median_litter
    ##              <chr>         <dbl>
    ## 1     Afrosoricida         2.500
    ## 2     Artiodactyla         1.000
    ## 3        Carnivora         2.350
    ## 4          Cetacea         1.000
    ## 5       Chiroptera         0.990
    ## 6        Cingulata         1.730
    ## 7   Dasyuromorphia         6.190
    ## 8       Dermoptera         1.000
    ## 9  Didelphimorphia         6.595
    ## 10   Diprotodontia         1.010
    ## # ... with 19 more rows

Challenge 1
-----------

Take what I started and add a line that keeps only the rows where `median_litter` is less than 3:

``` r
mammals %>% group_by(order) %>%
  summarise(median_litter = median(litter_size, na.rm = TRUE)) %>%
  filter(median_litter < 3) # exercise
```

    ## # A tibble: 22 × 2
    ##            order median_litter
    ##            <chr>         <dbl>
    ## 1   Afrosoricida         2.500
    ## 2   Artiodactyla         1.000
    ## 3      Carnivora         2.350
    ## 4        Cetacea         1.000
    ## 5     Chiroptera         0.990
    ## 6      Cingulata         1.730
    ## 7     Dermoptera         1.000
    ## 8  Diprotodontia         1.010
    ## 9     Hyracoidea         1.700
    ## 10 Macroscelidea         1.675
    ## # ... with 12 more rows

Bonus: also arrange the data frame by `median_litter` from largest to smallest and select only the columns `order` and `median_litter`:

``` r
mammals %>% group_by(order) %>%
  summarise(median_litter = median(litter_size, na.rm = TRUE)) %>%
  filter(median_litter < 3) %>% # exercise
  select(order, median_litter) %>% # exercise
  arrange(-median_litter) # exercise
```

    ## # A tibble: 22 × 2
    ##               order median_litter
    ##               <chr>         <dbl>
    ## 1  Paucituberculata         2.810
    ## 2      Afrosoricida         2.500
    ## 3         Carnivora         2.350
    ## 4        Scandentia         2.010
    ## 5   Peramelemorphia         2.000
    ## 6         Cingulata         1.730
    ## 7        Hyracoidea         1.700
    ## 8     Macroscelidea         1.675
    ## 9       Proboscidea         1.125
    ## 10    Tubulidentata         1.100
    ## # ... with 12 more rows

Challenge 2
-----------

Again, your turn: make the following piece of code easier to read by converting it to use pipes (hint: work from the inside out):

``` r
summarise(
  group_by(
    select(mammals, order, adult_body_mass_g), 
    order), 
  mean_body_mass = mean(adult_body_mass_g, na.rm = TRUE))
```

    ## # A tibble: 29 × 2
    ##              order mean_body_mass
    ##              <chr>          <dbl>
    ## 1     Afrosoricida   9.475564e+01
    ## 2     Artiodactyla   1.213294e+05
    ## 3        Carnivora   4.738645e+04
    ## 4          Cetacea   7.373065e+06
    ## 5       Chiroptera   5.772033e+01
    ## 6        Cingulata   4.699230e+03
    ## 7   Dasyuromorphia   7.960107e+02
    ## 8       Dermoptera   1.181100e+03
    ## 9  Didelphimorphia   2.012880e+02
    ## 10   Diprotodontia   5.436913e+03
    ## # ... with 19 more rows

Answer:

``` r
mammals %>% select(order, adult_body_mass_g) %>% # exercise
  group_by(order) %>% # exercise
  summarise(mean_body_mass = mean(adult_body_mass_g, na.rm = TRUE)) # exercise
```

    ## # A tibble: 29 × 2
    ##              order mean_body_mass
    ##              <chr>          <dbl>
    ## 1     Afrosoricida   9.475564e+01
    ## 2     Artiodactyla   1.213294e+05
    ## 3        Carnivora   4.738645e+04
    ## 4          Cetacea   7.373065e+06
    ## 5       Chiroptera   5.772033e+01
    ## 6        Cingulata   4.699230e+03
    ## 7   Dasyuromorphia   7.960107e+02
    ## 8       Dermoptera   1.181100e+03
    ## 9  Didelphimorphia   2.012880e+02
    ## 10   Diprotodontia   5.436913e+03
    ## # ... with 19 more rows

Resources
=========

Parts of this exercise were modified from: <http://seananderson.ca/2014/09/13/dplyr-intro.html>

<https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html>

<https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

<http://r4ds.had.co.nz/transform.html>

<http://r4ds.had.co.nz/pipes.html>
