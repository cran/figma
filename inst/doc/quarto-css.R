## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- include = FALSE---------------------------------------------------------
library(figma)

## ---- eval = FALSE------------------------------------------------------------
#  library(figma)
#  quarto_website

## ---- echo = FALSE, fig.cap = 'A screenshot of a Figma file named "Quarto-Website"', out.width="100%"----
knitr::include_graphics("figma-quarto-website.png")

## -----------------------------------------------------------------------------
fd <- figma::as_figma_document(quarto_website)
fd

## -----------------------------------------------------------------------------
objects <- fd$canvas[[1]][["objects"]]
length(objects)

## -----------------------------------------------------------------------------
objects[[1]][["name"]]

## -----------------------------------------------------------------------------
nav_bar <- objects[[2]]
str(nav_bar)

## -----------------------------------------------------------------------------
css_selector <- function(object) {
  name <- object$name
  prefix <- "."
  css <- paste0(prefix, name)
  return(css)
}

css_selector(nav_bar)

## -----------------------------------------------------------------------------
bck_color <- function(object) {
  color <- object$fills[[1]][["color"]]
  as_hex <- rgb(
    color$r, color$g, color$b, color$a,
    maxColorValue = 1
  )
  return(as_hex)
}

bck_color(nav_bar)

## -----------------------------------------------------------------------------
css_statement <- function(selector, attributes) {
  key_values <- vector("character", length(attributes))
  for (i in seq_along(attributes)) {
    key <- attributes[[i]][["key"]]
    value <- attributes[[i]][["value"]]
    kv <- sprintf("\t%s: %s;", key, value)
    key_values[i] <- kv
  }
  body <- paste(key_values, collapse = "\n")
  first_line <- sprintf("%s {", selector)
  # Add curly braces
  body <- paste(
    first_line, body, "}", 
    sep = "\n", collapse = ""
  )
  return(body)
}

## -----------------------------------------------------------------------------
attrs <- list(
  list(key = "text-align", value = "center"),
  list(key = "color", value = "purple"),
  list(key = "width", value = "100px")
)

css_statement("body", attrs) |> cat()

## -----------------------------------------------------------------------------
css_bck_color <- function(object) {
  selector <- css_selector(object)
  color <- bck_color(object)
  color_specs <- list(
    list(key = "background-color", value = color)
  )
  css_statement <- css_statement(selector, color_specs)
  return(css_statement)
}

nav_bar |> 
  css_bck_color() |> 
  cat()

