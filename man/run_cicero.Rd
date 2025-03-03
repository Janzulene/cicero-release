% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runCicero.R
\name{run_cicero}
\alias{run_cicero}
\title{Run Cicero}
\usage{
run_cicero(
  cds,
  genomic_coords,
  window = 5e+05,
  silent = FALSE,
  sample_num = 100
)
}
\arguments{
\item{cds}{Cicero CDS object, created using \code{\link{make_cicero_cds}}}

\item{genomic_coords}{Either a data frame or a path (character) to a file
with chromosome lengths. The file should have two columns, the first is
the chromosome name (ex. "chr1") and the second is the chromosome length
in base pairs. See \code{data(human.hg19.genome)} for an example. If a
file, should be tab-separated and without header.}

\item{window}{Size of the genomic window to query, in base pairs.}

\item{silent}{Whether to print progress messages}

\item{sample_num}{How many sample genomic windows to use to generate
\code{distance_parameter} parameter. Default: 100.}
}
\value{
A table of co-accessibility scores
}
\description{
A wrapper function that runs the primary functions of the Cicero pipeline
with default parameters. Runs \code{\link{estimate_distance_parameter}},
\code{\link{generate_cicero_models}} and \code{\link{assemble_connections}}.
See the manual pages of these functions for details about their function and
parameter options. Defaults in this function are designed for mammalian data,
those with non-mammalian data should read about parameters in the above
functions.
}
\examples{
  data("cicero_data")
  data("human.hg19.genome")
  sample_genome <- subset(human.hg19.genome, V1 == "chr18")
  sample_genome$V2[1] <- 100000
  input_cds <- make_atac_cds(cicero_data, binarize = TRUE)
  input_cds <- preprocess_cds(input_cds, method = "LSI")
  input_cds <- reduce_dimension(input_cds, preprocess_method = "LSI")
  umap_coords <- reducedDims(input_cds)$UMAP
  cicero_cds <- make_cicero_cds(input_cds,
                                reduced_coordinates = umap_coords)
  cons <- run_cicero(cicero_cds, sample_genome, sample_num=2)

}
