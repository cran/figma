# Figma API infos and handlers to URLs
#
# This file contains all functions for basic
# URL manipulation, and, global variables that stores
# basic informations of the Figma API, like the base URL
# of the API, and the implemented endpoints in this
# package.


api_base_url <- "https://api.figma.com"

api_endpoints <- list(
  files = "/v1/files",
  file_nodes = "/v1/files"
)


implemented_endpoints <- names(api_endpoints)


#' Get the URL to a endpoint of Figma API
#'
#' @export
#' @param endpoint A single string with the name of the desired endpoint
#'   (needs to be one of the values present in \code{figma::implemented_endpoints}).
#'   Defaults to NULL;
#' @returns A string with the URL to the given endpoint, or, a list with all of
#'   the implemented endpoints;
#' @details
#'
#' If the function is called without any arguments, \code{get_endpoint_url()}
#' will output a list with all of the implemented endpoints.
#'
#' However, the function accepts a single string value with the name of,
#' a specific endpoint. In this case, \code{get_endpoint_url()} will
#' output a single string with the endpoint you selected. Is worth
#' mentioning, that this string must be one of the values present
#' in \code{figma::implemented_endpoints}.
#'
#' If the user provided any type of value that does
#' not fit in this description, the function
#' will prompt the user with an error message.
#'
#' @examples
#' # Returns the URL to the `files` endpoint of Figma API
#' library(figma)
#' figma::get_endpoint_url("files")
#'
get_endpoint_url <- function(endpoint = NULL){
  check_endpoint(endpoint)
  urls <- purrr::map_chr(
    api_endpoints,
    function(x) paste0(api_base_url, x, collapse = "")
  )
  urls <- if (is.null(endpoint)) urls else urls[[endpoint]]
  return(urls)
}


check_endpoint <- function(endpoint, call = rlang::caller_env()){
  not_a_single_string <- !is_single_string(endpoint)
  if (not_a_single_string) {
    rlang::abort("The `endpoint` argument should be a single string.", call = call)
  }

  not_implemented <- !endpoint %in% implemented_endpoints
  if (not_implemented) {
    msg_components <- c(
      "The given endpoint ('%s') is not available in `figma` package. ",
      "Check `print(figma::implemented_endpoints)` to see the available values ",
      "for `endpoint` argument."
    )
    msg_format <- paste(msg_components, collapse = "")
    rlang::abort(sprintf(msg_format, endpoint), call = call)
  }
}





#' Build the request URL
#'
#' Add multiple "components" to a base URL, to build
#' the complete URL that will be used in the HTTP request (non-exported function).
#'
#' @param base_url A single string with the base URL that you want add components to;
#' @param path A vector of strings (or a single string) with "path" components;
#' @param ... Key-value pairs that will compose the query string section of the URL;
#' @returns A single string with the complete URL.
#' @details
#' This function receives as input, a set of pieces (or components) of
#' the URL that will be used in the HTTP request. Then, it tries to combine
#' (or "collapse") all these pieces together to form a single string with
#' the complete URL.
#'
#' There are three main types of pieces (or components) accepted by this function.
#' First, the base URL, which is the initial portion of the URL. Usually, this is
#' the base URL for the Figma API.
#'
#' Second, we have the "path" components,
#' which are all the small bits that compose the path and resource sections
#' of the URL. Each element of the vector given to \code{path} is separated
#' by a slash character (\code{"/"}) in the final result.
#'
#' For example, if I give the vector \code{c("path1", "path2", "path3")}
#' to \code{path}, the end result will be structured like this:
#'
#' \code{base_url/path1/path2/path3}
#'
#' Third, a query string, which is usually composed by a set of
#' key-value pairs. \code{build_request_url()} collects all these
#' key-value pairs through the \code{...} argument, and then, combines
#' all these pairs together to form a query string.
#'
build_request_url <- function(base_url, path = NULL, ...){
  check_single_string(base_url, argument_name = "base_url")
  url <- base_url
  if (is_not_null(path) && is.character(path)) {
    url <- add_paths_to_url(url, path)
  }
  url <- add_query_string_to_url(url, ...)
  return(url)
}





add_paths_to_url <- function(url, path){
  check_single_string(url, argument_name = "url")
  path <- paste0(path, collapse = "/")
  path <- sprintf("/%s", path)
  url <- paste0(url, path, collapse = "")
  return(url)
}



add_query_string_to_url <- function(url, ...){
  parameters <- list(...)
  if (length(parameters) == 0) {
    return(url)
  }
  check_parameters(parameters)
  query_string <- build_query_string(parameters)
  url <- paste0(
    url, "?", query_string,
    collapse = ""
  )
  return(url)
}


check_single_string <- function(x,
                                argument_name,
                                call = rlang::caller_env()){
  msg <- sprintf(
    "Argument `%s` should be a single string!",
    argument_name
  )
  if ( !is_single_string(x) ) {
    rlang::abort(msg, call = call)
  }
}



is_single_string <- function(x){
  is.character(x) && length(x) == 1 && !is.na(x)
}

is_not_null <- function(x){
  !is.null(x) && !all(is.na(x))
}




check_parameters <- function(parameters, call = rlang::caller_env()){

  if (is.null(names(parameters)) || any(names(parameters) == "")) {
    msg <- c(
      "Looks like you provided a unnamed argument to `...`. ",
      "You need to make sure that all arguments passed to `...` ",
      "are named arguments."
    )
    rlang::abort(paste0(msg, collapse = ""), call = call)
  }

  any_null_na <- any(purrr::map_lgl(
    parameters, function(x) is.null(x) | any(is.na(x))
  ))
  if (any_null_na) {
    msg <- "One of the named arguments contains a `NULL` or `NA` value!"
    rlang::abort(msg, call = call)
  }
}



#' Build a query string from a set of named parameters
#'
#' Utility function used to build query strings (non-exported function).
#'
#' @param parameters A list with a set of key-value pairs to compose the query string
#' @returns A single string with the query string produced.
#' @details
#' This function takes a set of key-value pairs (or in other words,
#' a set of named arguments), to build a query string. It basically
#' combine (or "collapse") all key-value pairs together, to form
#' the resulting query string.
#'
#' Logical values (TRUE or FALSE) are automatically converted to
#' a lower-case version ("true" or "false"), since these versions are
#' more typically used in standard query strings.
#'
build_query_string <- function(parameters){
  keys <- names(parameters)
  key_value_pairs <- vector("character", length(parameters))
  for (i in seq_along(parameters)) {
    key <- keys[i]
    value <- parameters[[i]]
    if (is.logical(value)) value <- tolower(as.character(value))
    key_value_pairs[i] <- sprintf("%s=%s", key, value)
  }
  query_string <- paste0(key_value_pairs, collapse = "&")
  return(query_string)
}



