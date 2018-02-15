
# setup -------------------------------------------------------------------

devtools::install_github("pablobarbera/Rfacebook/Rfacebook")
library(Rfacebook)

library(dplyr)
library(tidyr)

# facebook authorization --------------------------------------------------

fb_oauth <-
  fbOAuth(
    app_id = "[insert your app id here]",
    app_secret = "[insert your app secret here]",
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
posts <- getPage(paginas[page], fb_oauth, 
                 since='2018/01/01', 
                 until='2018/01/31', n = 30) 

x <- list()
k = 1
for (i in seq_along(posts$id)) {
# comments
comment <- getPost(post = posts$id[i], fb_oauth, n = 20)
x[[i]] <- comment$comments$message


# replies
y <- list()
for (j in seq_along(comment$comments$id)) {
  replies <- getCommentReplies(comment_id = comment$comments$id[j], 
                               n = 5, token = fb_oauth)
  y[[k]] <- replies$replies$message
  k = k + 1
}
}

  
# bind all

com[[page]] <- unlist(x)
rep[[page]] <- unlist(y)
print(page)
}

saveRDS(com, file="com.rds")
saveRDS(rep, file="rep.rds")

# Generate a data frame ---------------------------------------------------
choices = c("Lula (PT)", "Bolsonaro (PSL)",
            "Ciro Gomes (PDT)", "Marina Silva (REDE)", 
            "Luciano Huck (s/partido)", "Geraldo Alckmin (PSDB)",
            "Manuela D'Ávila (PCdoB)", "Guilherme Boulos (PSOL)",
            "Plínio Jr. (PSOL)", "Henrique Meirelles (PSD)",
            "Rodrigo Maia (DEM)")

# final binding
df_final <- c()
for (i in seq_along(choices)) {
df1 <- as.data.frame(com[[i]])
colnames(df1) <- "text"
df1$choice <- choices[i]
print(i)
df_final <- rbind(df_final, df1)
}

# save
saveRDS(df_final, file = "./sample_text/df_final.rds")










