i18n_decode_unicode_tags <- function(x) {
  if (!is.character(x)) return(x)

  vapply(x, function(value) {
    if (is.na(value) || !grepl("<U\\+[0-9A-Fa-f]{4,6}>", value)) return(value)

    matches <- gregexpr("<U\\+[0-9A-Fa-f]{4,6}>", value, perl = TRUE)[[1]]
    if (matches[1] == -1) return(value)

    pieces <- regmatches(value, list(matches))[[1]]
    replacements <- vapply(pieces, function(piece) {
      code <- sub("^<U\\+([0-9A-Fa-f]{4,6})>$", "\\1", piece)
      intToUtf8(strtoi(code, base = 16L))
    }, character(1), USE.NAMES = FALSE)

    for (i in seq_along(pieces)) {
      value <- sub(pieces[[i]], replacements[[i]], value, fixed = TRUE)
    }
    value
  }, character(1), USE.NAMES = FALSE)
}

#' Load translation dictionary
#'
#' Finds `<lang>.json` under the installed package's `i18n/` folder and,
#' if not found (during development), falls back to `inst/i18n/<lang>.json`.
#'
#' @param lang Character scalar language code. Currently `"tr"` or `"en"`.
#' @return A named list (key -> string) parsed from the JSON file.
#' @examples
#' # Always-fast: locate the installed TR dictionary (empty string if not installed)
#' system.file("shinyapp", "i18n", "tr.json", package = "examly")
#'
#' # Safe example that runs only if the file actually exists
#' p <- system.file("shinyapp", "i18n", "tr.json", package = "examly")
#' if (nzchar(p) && file.exists(p)) {
#'   d <- i18n_load("tr")
#'   i18n_t(d, "ui.title", "Baslik")
#' }
#' @importFrom jsonlite fromJSON
#' @noRd
i18n_load <- function(lang = "tr") {
  stopifnot(is.character(lang), length(lang) == 1L)
  if (!lang %in% c("tr", "en")) {
    stop("Unsupported language: ", lang)
  }
  fn <- paste0(lang, ".json")
  # installed package path
  path <- system.file("shinyapp", "i18n", fn, package = "examly")
  # dev fallback
  if (!nzchar(path)) path <- file.path("inst", "shinyapp", "i18n", fn)
  if (!file.exists(path)) {
    stop("i18n not found: ", fn, " (looked in ", path, ")")
  }
  json <- rawToChar(readBin(path, what = "raw", n = file.info(path)[["size"]]))
  Encoding(json) <- "UTF-8"
  dict <- jsonlite::fromJSON(json, simplifyVector = TRUE)
  dict[] <- lapply(dict, function(value) i18n_decode_unicode_tags(enc2utf8(value)))
  dict
}

#' Translate a UI/message key
#'
#' Returns the value for `key` from a dictionary produced by `i18n_load()`.
#' If the key is missing, returns `default` when provided, otherwise the key itself.
#'
#' @param dict Named list produced by `i18n_load()`.
#' @param key Character scalar; lookup key.
#' @param default Optional fallback value if the key is not present.
#' @return Character scalar.
#' @examples
#' # A quick, fully automatic check:
#' p <- system.file("shinyapp", "i18n", "en.json", package = "examly")
#' if (nzchar(p) && file.exists(p)) {
#'   d <- i18n_load("en")
#'   i18n_t(d, "buttons.download", "Download")
#' }
#' @noRd
i18n_t <- function(dict, key, default = NULL) {
  if (!is.list(dict)) stop("`dict` must be a list returned by i18n_load()")
  if (!is.character(key) || length(key) != 1L) stop("`key` must be a character scalar")
  val <- dict[[key]]
  if (!is.null(val)) return(val)
  if (!is.null(default)) return(default)
  key
}
