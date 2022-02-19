melb_df <- read.table(
  file = "melbourne.csv",
  header = TRUE,
  sep = ",",
  skip = 11)

mean_rainfall_melb <- as.numeric(melb_df[24,2:13])

ox_df <- read.table(
  file = "oxford.txt",
  header = FALSE,
  col.names = c("year", "month", "x1", "x2", "x3", "rain", "x4"),
  skip = 7,
  na.strings = "---",
  nrows = 12 * (2020 - 1853))

year_mask <- (1855 <= ox_df$year) & (ox_df$year <= 2015)
tmp <- ox_df[year_mask,c("month","rain")]
tmp$rain <- as.numeric(
  gsub(
    pattern = "\\*",
    replacement = "",
    x = tmp$rain))

mean_rainfall_ox <- aggregate(
  x = tmp,
  by = list(month = tmp$month),
  FUN = mean)$rain

months <- c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December")

plot_df <- data.frame(
  month = rep(months, 2),
  month_num = rep(1:12, 2),
  location = rep(c("Melbourne", "Oxford"), each = 12),
  average_rainfall = c(mean_rainfall_melb, mean_rainfall_ox))

write.table(x = plot_df,
            file = "average-rainfall.csv",
            sep = ",",
            row.names = FALSE)
