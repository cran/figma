## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(figma)

## ----file_example, echo = FALSE, fig.cap = "An example of Figma file", out.width="120%"----
knitr::include_graphics("example-figma-file.png")

## ---- echo = FALSE, fig.cap = "Settings of Figma platform"--------------------
knitr::include_graphics("figma-settings.png")

## ---- echo = FALSE, fig.cap = "Personal access token section in settings", out.width="100%"----
knitr::include_graphics("create-token.png")

## ---- eval = FALSE------------------------------------------------------------
#  file_key <- "hch8YlkIrYbU3raDzjPvCz"
#  # Insert your personal token:
#  token <- "Your personal token ..."
#  
#  result <- figma::get_figma_file(
#    file_key, token
#  )
#  # A `response` object:
#  print(result)

## -----------------------------------------------------------------------------
str(untitled_file)

## -----------------------------------------------------------------------------
head(untitled_file$content)

## -----------------------------------------------------------------------------
list_of_nodes <- httr::content(untitled_file)
names(list_of_nodes)

## -----------------------------------------------------------------------------
first_canvas_node <- list_of_nodes$document$children[[1]]
first_object_node <- first_canvas_node[["children"]][[1]]

## ---- eval = FALSE------------------------------------------------------------
#  file_key <- "hch8YlkIrYbU3raDzjPvCz"
#  # Insert your personal token:
#  token <- "Your personal token ..."
#  
#  figma_document <- figma::get_figma_file(
#    file_key, token,
#    .output_format = "figma_document"
#  )
#  # A `figma_document` object:
#  print(figma_document)

## -----------------------------------------------------------------------------
figma_document <- figma::as_figma_document(untitled_file)
figma_document

## -----------------------------------------------------------------------------
str(figma_document$document)

## -----------------------------------------------------------------------------
names(figma_document$canvas[[1]])

## -----------------------------------------------------------------------------
first_canvas_node <- figma_document$canvas[[1]]
first_object_node <- first_canvas_node$objects[[1]]
str(first_object_node)

## ---- eval = FALSE------------------------------------------------------------
#  file_key <- "hch8YlkIrYbU3raDzjPvCz"
#  # Insert your personal token:
#  token <- "Your personal token ..."
#  
#  tibble <- figma::get_figma_file(
#    file_key, token,
#    .output_format = "tibble"
#  )
#  # A `tibble` object:
#  print(tibble)

## -----------------------------------------------------------------------------
tibble <- figma::as_tibble(untitled_file)
tibble

