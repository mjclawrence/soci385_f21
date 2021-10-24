library(tidyverse)

cupid <- read.csv("https://raw.githubusercontent.com/mjclawrence/soci385_f21/main/data/cupid.csv")


# Show that age values are not normally distributed
hist(cupid$age)

# Define how many repeated samples you want to pull
n <- 1000

# Create an empty bucket for all the sample means to end up
all_means = NULL

# Set up function
for (i in 1:n) {
  my_sample = sample(cupid$age, 2500, replace = TRUE)
  sample_mean = mean(my_sample)
  all_means <- c(all_means, sample_mean)
}

# Plot the sample means

hist(all_means)


# Function

sampling_function <- function(sample_times, sample_size) {
  all_means = NULL
  for (i in 1:sample_times) {
    my_sample = sample(cupid$age, sample_size, replace = TRUE)
    sample_mean = mean(my_sample)
    all_means <- c(all_means, sample_mean)
  }
  hist(all_means, prob = TRUE)
  lines(density(all_means), col = "red", lw = 2)
  rm(all_means)
}

sampling_function(2500, 2500)

