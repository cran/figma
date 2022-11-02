## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(figma)

## ---- eval = FALSE------------------------------------------------------------
#  node_id <- "wrongID"
#  file_key <- "hch8YlkIrYbU3raDzjPvCz"
#  token <- "My valid personal access token... "
#  result <- get_figma_page(
#    file_key, token, node_id
#  )

## ---- eval = FALSE------------------------------------------------------------
#  file_key <- "This key does not exist"
#  token <- "A valid personal token ..."
#  
#  result <- figma::get_figma_file(
#    file_key, token
#  )

## ---- eval = FALSE------------------------------------------------------------
#  file_key <- "hch8YlkIrYbU3raDzjPvCz"
#  token <- "This is an incorrect token"
#  
#  result <- figma::get_figma_file(
#    file_key, token
#  )

