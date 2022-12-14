% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/response.R
\name{as_tibble}
\alias{as_tibble}
\title{Convert a \code{httr} response object to a \code{tibble} object}
\usage{
as_tibble(x, ...)
}
\arguments{
\item{x}{A Figma document object (i.e. a \code{figma::figma_document} object),
or, a \code{httr::response} object to parse;}

\item{...}{Further arguments passed by the caller. Only \code{simplified}
argument is currently accepted, other arguments are ignored (See Details section);}
}
\value{
A \code{tibble::tibble()} object with all of the canvas and objects data of your
Figma file.
}
\description{
This function receives a \code{httr::response()} object, and outputs a
\code{tibble::tibble()} object.
}
\details{
The function parses the data from the \code{response} object and tries to fit
it into a tibble object. Each row in the resulting tibble will be describing
an object in your Figma file.

If \code{as_tibble()} receives a \code{response} object as input, it will call
\code{as_figma_document()} to convert this \code{response} object into a \code{figma_document}
object. But, \code{as_tibble()} can receive directly a \code{figma_document} object
and jump this step.

If the Figma file have no objects draw in a specific canvas, \code{as_tibble()}
will return an empty \code{tibble} object for this specific canvas. This means that, if
your Figma file is empty, or, in other words, if all of the canvas/pages of the
file have no objects draw in them, the final result of \code{as_tibble()} will
be an empty \code{tibble} object.

By default, \code{figma::as_tibble()} does not include any document metadata in
the resulting tibble object. But you can pass \code{simplified = FALSE} to the
function to change this behavior.
}
\examples{
\dontrun{
file_key <- "hch8YlkgaUIZ9raDzjPvCz"
token <- "my figma token secret ... "
# Returns a `response` object:
r <- figma::get_figma_file(file_key, token)
result <- figma::as_tibble(r)

# To include all of the document metadata, use `simplified = FALSE`
result <- figma::as_tibble(r, simplified = FALSE)
}
}
