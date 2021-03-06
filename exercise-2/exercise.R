# Exercise 2: working with data APIs

# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie.name` that is the name of a movie of your choice.
movie.name <- "Toy Story"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
base_uri <- ("https://api.nytimes.com/svc/movies/v2/") 
resource <- ("reviews/search.json")

# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
query_params <- list("api-key" = nty_apikey, query = movie.name)


# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(paste0(base_uri, resource), query = query_params)
body <- fromJSON(content(response, "text"))
# What kind of data structure did this produce? A data frame? A list?
typeof(body)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(body)
names(body$results)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(body$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
headline <- reviews$headline[1]
short <- reviews$summary_short[1]
link <- reviews$link.url[1]

# Create a list of the three pieces of information from above. 
# Print out the list.
new_list <- c(headline, short, link)
print(new_list)
