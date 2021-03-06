dir = getwd()
setwd(dir)
library(RSQLite)
database = dbConnect(SQLite(), dbname = "train.sqlite3")
dbGetInfo(database)
head_data = dbGetQuery(database, "SELECT * FROM train LIMIT 100")
head_data = head_data[-1,] #solução para os headers duplos.
## 1a solucao para amostragem aleatoria
data_random = dbGetQuery(database, "SELECT * FROM train WHERE random() % 100 = 0 LIMIT 1000")
View(table(data_random[[2]]))
#2a solucao para amostragem aleatoria
n = 37670294 #tamanho de train
indices_random = data.frame(sample(n, 1e6))
query_random = "SELECT * from train WHERE ROWID = ?"
data_random_2 = dbGetPreparedQuery(database, query_random, indices_random)
View(data_random_2)