
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

com <- list()
rep <- list()

for (page in seq_along(paginas)) {
# get posts
posts <- getPage(page, fb_oauth, 
                 since='2018/01/01', 
                 until='2018/01/31', n = 1000) 


x <- list()
k = 1
for (i in seq_along(posts$id)) {
# comments
comment <- getPost(post = posts$id[i], fb_oauth, n = 5000)
x[[i]] <- comment$comments$message


# replies
y <- list()
for (j in seq_along(comment$comments$id)) {
  replies <- getCommentReplies(comment_id = comment$comments$id[j], 
                               n = 1000, token = fb_oauth)
  y[[k]] <- replies$replies$message
  k = k + 1
}
}

# bind all

com[[page]] <- unlist(x)
rep[[page]] <- unlist(y)
}



r = sample(x = c(1:length(com)), size = 1)
sample(com[[r]])




write.csv2(com, file='com.csv', row.names=F, fileEncoding = "latin1")











