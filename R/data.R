#' An example of a simple Figma file
#'
#' The \code{untitled_file} object is an example of what kind of object the functions from \code{figma} package
#' tend to return to the user. This object was produced by a call to \code{figma::get_figma_file()}, and contains the
#' data of a very simple Figma file entitled "Untitled".
#'
#' @details
#' This "Untitled" Figma file have two canvas/pages, called "Page 1" and "Page 2". There are
#' three objects drawn in Page 1 (a RECTANGLE, a TEXT and a VECTOR object), and, there are two objects
#' drawn in Page 2 (a RECTANGLE and a TEXT object).
#'
#' The \code{untitled_file} object contains the \code{httr::response} object
#' returned by \code{figma::get_figma_file()}. This \code{httr::response} object is just a simple R list
#' with class \code{response}. The elements of this list and their description are:
#'
#' \itemize{
#'   \item{\code{url}: The URL used in the HTTP request made to the Figma API;}
#'   \item{\code{status_code}: The HTTP status code returned by the Figma API;}
#'   \item{\code{headers} and \code{all_headers}: The list of headers returned by the Figma API;}
#'   \item{\code{cookies}: A named list of cookies returned by the Figma API;}
#'   \item{\code{content}: The body of the response, as raw vector. See \code{httr::content()} for various ways to parse this content;}
#'   \item{\code{date} and \code{times}: Timing information about the HTTP request made to the Figma API;}
#'   \item{\code{handle}: The handle associated with the url;}
#'   \item{\code{request}: The URL, HTTP method and options used in the HTTP request made to the Figma API;}
#' }
#'
#' All data of the Figma file is stored in the \code{content} element. However, this data is in raw
#' format (i.e. in raw bytes). To convert these raw bytes into a useful format like a R list, or a
#' string, you should use the \code{httr::content()} function. See \code{vignette("figma")} for a
#' detailed description of the data present in this \code{content} element;
#'
#' @format An object of class \code{response}, produced by \code{httr} HTTP methods (e.g. \code{httr::GET()});
#'
#' @examples
#' library(figma)
#' str(untitled_file)
"untitled_file"