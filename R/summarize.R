#!/usr/bin/env Rscript 

## todo - re-write using e.g. knitr

args <- commandArgs(trailingOnly = TRUE)
covs <- args[1]
refs <- args[2]
region <- args[3]
out_file <- args[4]
method <- "beagle"
print(args)

## am here
## abstract this out
## pass in covs, refs
## then read in, make table
## then maybe use knitr to spit out results

covs <- strsplit(covs, "-")[[1]]
refs <- strsplit(refs, "-")[[1]]

print(covs)
print(refs)
## load all summaries
## make table
## dump to new markdown file
cols <- c("method", "ref", "cov", "time_min", "r2")
out <- array(NA, c(length(covs) * length(refs), length(cols)))
colnames(out) <- cols
c <- 1
for(cov in covs) {
    for(ref in refs) {
        table <- read.table(paste0("results/", method, ".", ref, ".", cov, "X.", region, ".summary"), header = TRUE)
        table <- round(table, 2)
        out[c, c("method", "ref", "cov", "time_min", "r2")] <- c(method, ref, cov, table[, "time"], table[, "r2"])
        c <- c + 1
    }
}

write.table(
    out,
    file = out_file,
    row.names = FALSE,
    col.names = TRUE,
    sep = "\t",
    quote = FALSE
)

