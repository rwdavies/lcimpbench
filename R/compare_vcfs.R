#!/usr/bin/env Rscript 

## this is not meant to be a long term solution
## this is not meant to be robust
## this is wrong because it does not adjust major, minor allele
## this is wrong because it doesn't ensure consistent sites across comparable situations
## ideally we would impute multiple samples at once, then measure average per-site r2

args <- commandArgs(trailingOnly = TRUE)
truth_vcf <- args[1]
test_vcf <- args[2]
log_file <- args[3]
out_file <- args[4]

truth <- read.table(truth_vcf)
test <- read.table(test_vcf)

convert <- function(x) {
    g <- substr(x, 1, 3)
    g <- c(0, 1, 1, 2, NA)[match(g, c("0/0", "0/1", "1/0", "1/1", "./."))]
    return(g)
}
truthG <- convert(truth[, 10])
testG <- convert(test[, 10])

r2 <- cor(truthG, testG, use = "pairwise.complete") ** 2
print(table(truthG, testG, useNA = "always"))
print(r2)

get_elapsed_time_from_log <- function(log_file) {
    if (file.exists(log_file) == FALSE) {
        return(NA)
    } else {
        a <- as.character(read.table(log_file, sep = "\t")[, 1])
        b <- a[grep("Elapsed ", a)]
        if (length(b) == 0)
            return(NA)
        c <- strsplit(b, "Elapsed (wall clock) time (h:mm:ss or m:ss): ", fixed = TRUE)[[1]][2]
        d <- strsplit(c, ":")[[1]]
        if (length(d) == 2) {
            ## minutes and seconds
            return(as.numeric(d[1]) + as.numeric(d[2]) / 60)
        } else if (length(d) == 3) {
            return(60 * as.numeric(d[1]) + as.numeric(d[2]) + as.numeric(d[3]) / 60)
        }
    }
}

time <- get_elapsed_time_from_log(log_file) 
print(time)

to_out <- array(0, c(1, 2))
colnames(to_out) <- c("time", "r2")
to_out[1, 1] <- time
to_out[1, 2] <- r2

write.table(
    to_out,
    file = out_file,
    row.names = FALSE,
    col.names = TRUE,
    sep = "\t",
    quote = FALSE
)
