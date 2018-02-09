
# setup -------------------------------------------------------------------

devtools::install_github("pablobarbera/Rfacebook/Rfacebook")
library(Rfacebook)

library(dplyr)
library(tidyr)

# facebook authorization --------------------------------------------------

fb_oauth <-
  fbOAuth(
    app_id = "437994209933601",
    app_secret = "327a6e06bfdb9616c82ec8d91a73b5ec",
    extended_permissions = TRUE
  )

# salvar
save(fb_oauth, file = "fb_oauth")

# Nas próximas vezes, ir direto para:

load("fb_oauth")

# paginas -----------------------------------------------------------------


paginas <-
  c(
    "Lula",
    "jairmessias.bolsonaro",
    "cirogomesoficial",
    "marinasilva.oficial",
    "LucianoHuck",
    "geraldoalckmin",
    "manueladavila",
    "guilhermeboulos.oficial",
    "PlinioSampaioJr",
    "hmeirellesoficial",
    "RodrigoMaiaRJ")


# raspagem ----------------------------------------------------------------

i = 3

posts <- getPage("nexo.jornal", token = fb_oauth, n = 100) 
comment <- getPost(post = posts$id[i], token = fb_oauth)
y <- comment$post
x <- comment$comments

a <- Rfacebook::searchPages("nexo", token = fb_oauth, n = 10)


replies <- getCommentReplies(comment_id = comment$comments$id[1], token = fb_oauth)

a <- replies$comment
b <- replies$replies


page_token = getPageToken("nexo.jornal", token = fb_oauth)
c <- getInsights("nexo.jornal", token=page_token, metric='page_fans_country', period='lifetime')






