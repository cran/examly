
comment_overall <- function(dict, ap, ar){
  ptxt <- if (is.na(ap)) {
    ""
  } else if (ap < .4) {
    i18n_t(dict, "comment_overall.difficulty.low")
  } else if (ap > .8) {
    i18n_t(dict, "comment_overall.difficulty.high")
  } else {
    i18n_t(dict, "comment_overall.difficulty.mid")
  }
  
  rtxt <- if (is.na(ar)) {
    ""
  } else if (ar < .2) {
    paste0("\n", i18n_t(dict, "comment_overall.discrimination.low"))
  } else if (ar > .4) {
    paste0("\n", i18n_t(dict, "comment_overall.discrimination.high"))
  } else {
    paste0("\n", i18n_t(dict, "comment_overall.discrimination.mid"))
  }
  
  paste0(ptxt, rtxt)
}


difficulty_label <- function(dict, p){
  ifelse(
    is.na(p), "",
    ifelse(
      p < .40,  i18n_t(dict, "labels.difficulty.hard"),
      ifelse(p <= .80, i18n_t(dict, "labels.difficulty.medium"), i18n_t(dict, "labels.difficulty.easy"))
    )
  )
}

discrimination_decision <- function(dict, r){
  ifelse(
    is.na(r), "",
    ifelse(
      r < .20,  i18n_t(dict, "labels.discrimination.remove"),
      ifelse(r < .30, i18n_t(dict, "labels.discrimination.consider_remove"), i18n_t(dict, "labels.discrimination.keep"))
    )
  )
}
