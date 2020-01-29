# A SCTIPT FOR GENERATING HW 2 PLOTS

library(tidyverse)
library(plyr)

################################## MAKING DATA TABLE FOR REGULAR BF #####

# Initializing data.frame with first row of data from manual benchmarking
N <- 1000
fpr <- 0.01
query_type <- as.character("100pct")
avg_query_time <- 1.4286041259765625e-05
emperical_fpr <- NA
my_data <- data.frame(N, fpr, query_type, avg_query_time, emperical_fpr)

# Converting query_type column from factor to character
i <- sapply(my_data, is.factor)
my_data[i] <- lapply(my_data[i], as.character)
class(my_data$query_type)

# adding in the rest of the data from the manual benchmarking step
my_data[2,] <- c(1000, 0.01, "50pct", 1.389026641845703e-05, 0)
my_data[3,] <- c(1000, 0.01, "0pct", 1.1897087097167968e-05, 0)
my_data[4,] <- c(1000, 0.05, "100pct", 1.556396484375e-05, NA)
my_data[5,] <- c(1000, 0.05, "50pct", 1.5816688537597657e-05, 1/50)
my_data[6,] <- c(1000, 0.05, "0pct", 1.0061264038085938e-05, 1/100)
my_data[7,] <- c(1000, 0.10, "100pct", 2.9213428497314453e-05, NA)
my_data[8,] <- c(1000, 0.10, "50pct", 3.090858459472656e-05, 6/50)
my_data[9,] <- c(1000, 0.10, "0pct", 8.666515350341797e-06, 10/100)
my_data[10,] <- c(1000, 0.20, "100pct", 4.556417465209961e-05, NA)
my_data[11,] <- c(1000, 0.20, "50pct", 1.4600753784179688e-05, 11/50)
my_data[12,] <- c(1000, 0.20, "0pct", 1.0983943939208984e-05, 18/100)
my_data[13,] <- c(1000, 0.25, "100pct", 1.7316341400146483e-05, NA)
my_data[14,] <- c(1000, 0.25, "50pct", 8.156299591064453e-06, 16/50)
my_data[15,] <- c(1000, 0.25, "0pct", 7.843971252441406e-06, 26/100)

my_data[16,] <- c(10000, 0.01, "100pct", 1.554727554321289e-05, NA)
my_data[17,] <- c(10000, 0.01, "50pct", 1.4011859893798829e-05, 2/50)
my_data[18,] <- c(10000, 0.01, "0pct", 3.876686096191406e-05, 2/100)
my_data[19,] <- c(10000, 0.05, "100pct", 2.263784408569336e-05, NA)
my_data[20,] <- c(10000, 0.05, "50pct", 9.140968322753907e-06, 1/50)
my_data[21,] <- c(10000, 0.05, "0pct", 8.7432861328125e-05, 3/100)
my_data[22,] <- c(10000, 0.10, "100pct", 1.2786388397216797e-05, NA)
my_data[23,] <- c(10000, 0.10, "50pct", 1.792430877685547e-05, 2/50)
my_data[24,] <- c(10000, 0.10, "0pct", 1.1322498321533204e-05, 7/100)
my_data[25,] <- c(10000, 0.20, "100pct", 1.6396045684814452e-05, NA)
my_data[26,] <- c(10000, 0.20, "50pct", 1.7063617706298826e-05, 10/50)
my_data[27,] <- c(10000, 0.20, "0pct", 1.7175674438476564e-05, 18/100)
my_data[28,] <- c(10000, 0.25, "100pct", 1.0364055633544922e-05, NA)
my_data[29,] <- c(10000, 0.25, "50pct", 1.30462646484375e-05, 20/50)
my_data[30,] <- c(10000, 0.25, "0pct", 2.9942989349365235e-05, 28/100)

my_data[31,] <- c(100000, 0.01, "100pct", 1.8932819366455077e-05, NA)
my_data[32,] <- c(100000, 0.01, "50pct", 0.00015411138534545898, 1/50)
my_data[33,] <- c(100000, 0.01, "0pct", 2.0501613616943358e-05, 1/100)
my_data[34,] <- c(100000, 0.05, "100pct", 3.7050247192382814e-05, NA)
my_data[35,] <- c(100000, 0.05, "50pct", 1.1687278747558594e-05, 3/50)
my_data[36,] <- c(100000, 0.05, "0pct", 1.0633468627929688e-05, 6/100)
my_data[37,] <- c(100000, 0.10, "100pct", 1.0132789611816406e-05, NA)
my_data[38,] <- c(100000, 0.10, "50pct", 1.2278556823730469e-05, 5/50)
my_data[39,] <- c(100000, 0.10, "0pct", 1.3484954833984376e-05, 12/100)
my_data[37,] <- c(100000, 0.20, "100pct", 2.088308334350586e-05, NA)
my_data[38,] <- c(100000, 0.20, "50pct", 1.0318756103515625e-05, 8/50)
my_data[39,] <- c(100000, 0.20, "0pct", 1.287221908569336e-05, 17/100)
my_data[40,] <- c(100000, 0.25, "100pct", 1.1949539184570312e-05, NA)
my_data[41,] <- c(100000, 0.25, "50pct", 1.6663074493408203e-05, 18/50)
my_data[42,] <- c(100000, 0.25, "0pct", 7.770061492919923e-06, 33/100)

my_data[43,] <- c(1000000, 0.01, "100pct", 6.130933761596679e-05, NA)
my_data[44,] <- c(1000000, 0.01, "50pct", 2.8376579284667968e-05, 2/50)
my_data[45,] <- c(1000000, 0.01, "0pct", 9.937286376953125e-06, 3/100)
my_data[46,] <- c(1000000, 0.05, "100pct", 0.000145721435546875, NA)
my_data[47,] <- c(1000000, 0.05, "50pct", 9.331703186035156e-06, 6/50)
my_data[48,] <- c(1000000, 0.05, "0pct", 1.36566162109375e-05, 7/100)
my_data[49,] <- c(1000000, 0.10, "100pct", 1.1293888092041015e-05, NA)
my_data[50,] <- c(1000000, 0.10, "50pct", 8.0108642578125e-06, 6/50)
my_data[51,] <- c(1000000, 0.10, "0pct", 2.1681785583496093e-05, 8/100)
my_data[52,] <- c(1000000, 0.20, "100pct", 1.0230541229248046e-05, NA)
my_data[53,] <- c(1000000, 0.20, "50pct", 5.941152572631836e-05, 10/50)
my_data[54,] <- c(1000000, 0.20, "0pct", 1.2857913970947266e-05, 15/100)
my_data[55,] <- c(1000000, 0.25, "100pct", 1.2454986572265625e-05, NA)
my_data[56,] <- c(1000000, 0.25, "50pct", 1.3475418090820313e-05, 12/50)
my_data[57,] <- c(1000000, 0.25, "0pct", 1.8765926361083983e-05, 29/100)

my_data[58,] <- c(10000000, 0.01, "100pct", 2.0058155059814452e-05, NA)
my_data[59,] <- c(10000000, 0.01, "50pct", 1.928567886352539e-05, 1/50)
my_data[60,] <- c(10000000, 0.01, "0pct", 3.383874893188477e-05, 1/100)
my_data[61,] <- c(10000000, 0.05, "100pct", 1.8460750579833986e-05, NA)
my_data[62,] <- c(10000000, 0.05, "50pct", 3.373146057128906e-05, 3/50)
my_data[63,] <- c(10000000, 0.05, "0pct", 1.7735958099365235e-05, 7/100)
my_data[64,] <- c(10000000, 0.10, "100pct", 1.3723373413085938e-05, NA)
my_data[65,] <- c(10000000, 0.10, "50pct", 1.3756752014160157e-05, 4/50)
my_data[66,] <- c(10000000, 0.10, "0pct", 3.484964370727539e-05, 10/100)
my_data[67,] <- c(10000000, 0.20, "100pct", 2.8040409088134765e-05, NA)
my_data[68,] <- c(10000000, 0.20, "50pct", 1.4312267303466797e-05, 14/50)
my_data[69,] <- c(10000000, 0.20, "0pct", 8.912086486816407e-06, 24/100)
my_data[70,] <- c(10000000, 0.25, "100pct", 0.00019004106521606446, NA)
my_data[71,] <- c(10000000, 0.25, "50pct", 4.042625427246094e-05, 13/50)
my_data[72,] <- c(10000000, 0.25, "0pct", 1.0347366333007812e-05, 32/100)

# Converting query_type column from char to numeric
my_data$avg_query_time <-  as.numeric(my_data$avg_query_time)
my_data$emperical_fpr <-  as.numeric(my_data$emperical_fpr)
my_data$fpr <- as.numeric(my_data$fpr)

################################## MAKING DATA TABLE FOR BLOCKED BF #####
# Initializing data.frame with first row of data from manual benchmarking
N <- 1000
fpr <- 0.01
query_type <- as.character("100pct")
avg_query_time <- 2.8884410858154298e-05
emperical_fpr <- NA
my_data_blocked <- data.frame(N, fpr, query_type, avg_query_time, emperical_fpr)

# Converting query_type column from factor to character
i <- sapply(my_data_blocked, is.factor)
my_data_blocked[i] <- lapply(my_data_blocked[i], as.character)
class(my_data_blocked$query_type)

# adding in the rest of the data from the manual benchmarking step
my_data_blocked[2,] <- c(1000, 0.01, "50pct", 2.778291702270508e-05, 1/50)
my_data_blocked[3,] <- c(1000, 0.01, "0pct", 1.919984817504883e-05, 2/100)
my_data_blocked[4,] <- c(1000, 0.1, "100pct", 1.7490386962890625e-05, NA)
my_data_blocked[5,] <- c(1000, 0.1, "50pct", 2.0210742950439452e-05, 2/50)
my_data_blocked[6,] <- c(1000, 0.1, "0pct", 1.6140937805175782e-05, 5/100)
my_data_blocked[7,] <- c(1000, 0.2, "100pct", 1.504659652709961e-05, NA)
my_data_blocked[8,] <- c(1000, 0.2, "50pct", 1.676321029663086e-05, 9/50)
my_data_blocked[9,] <- c(1000, 0.2, "0pct", 1.6384124755859375e-05, 15/100)
my_data_blocked[10,] <- c(10000, 0.01, "100pct", 2.9616355895996093e-05, NA)
my_data_blocked[11,] <- c(10000, 0.01, "50pct", 2.3522377014160155e-05, 0/50)
my_data_blocked[12,] <- c(10000, 0.01, "0pct", 1.9330978393554687e-05, 1/100)
my_data_blocked[13,] <- c(10000, 0.1, "100pct", 2.556324005126953e-05, NA)
my_data_blocked[14,] <- c(10000, 0.1, "50pct", 1.9555091857910155e-05, 5/50)
my_data_blocked[15,] <- c(10000, 0.1, "0pct", 2.2649765014648438e-05, 8/100)
my_data_blocked[16,] <- c(10000, 0.2, "100pct", 1.7397403717041015e-05, NA)
my_data_blocked[17,] <- c(10000, 0.2, "50pct", 1.3225078582763672e-05, 7/50)
my_data_blocked[18,] <- c(10000, 0.2, "0pct", 1.5981197357177735e-05, 20/100)
my_data_blocked[19,] <- c(100000, 0.01, "100pct", 2.8278827667236328e-05, NA)
my_data_blocked[20,] <- c(100000, 0.01, "50pct", 2.2618770599365235e-05, 1/50)
my_data_blocked[21,] <- c(100000, 0.01, "0pct", 2.1474361419677733e-05, 1/100)
my_data_blocked[22,] <- c(100000, 0.1, "100pct", 1.9581317901611327e-05, NA)
my_data_blocked[23,] <- c(100000, 0.1, "50pct", 3.81779670715332e-05, 3/50)
my_data_blocked[24,] <- c(100000, 0.1, "0pct", 1.1525154113769532e-05, 9/100)
my_data_blocked[25,] <- c(100000, 0.2, "100pct", 2.874135971069336e-05, NA)
my_data_blocked[26,] <- c(100000, 0.2, "50pct", 2.066612243652344e-05, 8/50)
my_data_blocked[27,] <- c(100000, 0.2, "0pct", 1.555919647216797e-05, 16/100)
my_data_blocked[28,] <- c(1000000, 0.01, "100pct", 2.203226089477539e-05, NA)
my_data_blocked[29,] <- c(1000000, 0.01, "50pct", 2.0973682403564453e-05, 0/50)
my_data_blocked[30,] <- c(1000000, 0.01, "0pct", 1.5177726745605468e-05, 1/100)
my_data_blocked[31,] <- c(1000000, 0.1, "100pct", 2.155780792236328e-05, NA)
my_data_blocked[32,] <- c(1000000, 0.1, "50pct", 2.2029876708984376e-05, 6/50)
my_data_blocked[33,] <- c(1000000, 0.1, "0pct", 1.3380050659179687e-05, 11/100)
my_data_blocked[34,] <- c(1000000, 0.2, "100pct", 1.645803451538086e-05, NA)
my_data_blocked[35,] <- c(1000000, 0.2, "50pct", 2.0339488983154297e-05, 8/50)
my_data_blocked[36,] <- c(1000000, 0.2, "0pct", 1.1172294616699219e-05, 16/100)

# Converting query_type column from char to numeric
my_data_blocked$avg_query_time <-  as.numeric(my_data_blocked$avg_query_time)
my_data_blocked$emperical_fpr <-  as.numeric(my_data_blocked$emperical_fpr)
my_data_blocked$fpr <- as.numeric(my_data_blocked$fpr)


# ====================================================================== #

########################### MAKING PLOTS for REGULAR BF ##################

## average query time plot for 3 different streams:
data_summary <- function(data, varname, groupnames){
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE),
      se = sd(x[[col]], na.rm=TRUE) / sqrt(length(x[[col]])))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

# summarizing data for plotting
avg_query_time_summary <- data_summary(my_data, varname = "avg_query_time", groupnames = "query_type")

# changing query_type to factor and releveling
avg_query_time_summary$query_type <- factor(avg_query_time_summary$query_type, levels = c("100pct", "50pct", "0pct"))
ggplot(avg_query_time_summary, aes(x = query_type, y = avg_query_time)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2)) + 
  ggtitle("Average query time by type") + ylab("avg_query_time (sec)") 

## emperical fpr plot by theoretical fpr

# summarizing data for plotting
emp_fdr_summary <- data_summary(my_data, "emperical_fpr", "fpr")
ggplot(emp_fdr_summary, aes(x = fpr, y = emperical_fpr, group = 1)) + 
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = emperical_fpr - sd, ymax = emperical_fpr + sd, width = 0.02)) +
  ggtitle("Emperical FPR vs. Theoretical FPR") + xlab("False Positive Rate (FPR)") + ylab("Emperical FPR")

## separating for different N's (shouldn't change much)
q_time_vary_N <- data_summary(my_data, varname = "avg_query_time", groupnames = c("N", "query_type"))
ggplot(q_time_vary_N, aes(x = N, y = avg_query_time, fill = query_type)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) + 
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2), position = position_dodge(0.9)) + 
  ggtitle("Average query time by N and query type") + 
  xlab("N (num. of input keys)") + ylab("avg_query_time (sec)")

## separating for different N's and fpr's (shouldn't change much)
q_time_vary_N_fpr <- data_summary(my_data, varname = "avg_query_time", groupnames = c("N", "fpr"))
q_time_vary_N_fpr$fpr <- factor(q_time_vary_N_fpr$fpr)
ggplot(q_time_vary_N_fpr, aes(x = N, y = avg_query_time, fill = fpr)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9", "red", "green")) + 
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2), position = position_dodge(0.9)) + 
  ggtitle("Average query time by N and fpr") + 
  xlab("N (num. of input keys)") + ylab("avg_query_time (sec)")

########################### MAKING PLOTS for BLOCKED BF ############
# summarizing data for plotting
avg_query_time_summary <- data_summary(my_data_blocked, varname = "avg_query_time", groupnames = "query_type")

# changing query_type to factor and releveling
avg_query_time_summary$query_type <- factor(avg_query_time_summary$query_type, levels = c("100pct", "50pct", "0pct"))
ggplot(avg_query_time_summary, aes(x = query_type, y = avg_query_time)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2)) + 
  ggtitle("Average query time by type") + ylab("avg_query_time (sec)") 

## emperical fpr plot by theoretical fpr

# summarizing data for plotting
emp_fdr_summary <- data_summary(my_data_blocked, "emperical_fpr", "fpr")
ggplot(emp_fdr_summary, aes(x = fpr, y = emperical_fpr, group = 1)) + 
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = emperical_fpr - sd, ymax = emperical_fpr + sd, width = 0.02)) +
  ggtitle("Emperical FPR vs. Theoretical FPR") + xlab("False Positive Rate (FPR)") + ylab("Emperical FPR")

## separating for different N's (shouldn't change much)
q_time_vary_N <- data_summary(my_data_blocked, varname = "avg_query_time", groupnames = c("N", "query_type"))
ggplot(q_time_vary_N, aes(x = N, y = avg_query_time, fill = query_type)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) + 
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2), position = position_dodge(0.9)) + 
  ggtitle("Average query time by N and query type") + 
  xlab("N (num. of input keys)") + ylab("avg_query_time (sec)")

## separating for different N's and fpr's (shouldn't change much)
q_time_vary_N_fpr <- data_summary(my_data_blocked, varname = "avg_query_time", groupnames = c("N", "fpr"))
q_time_vary_N_fpr$fpr <- factor(q_time_vary_N_fpr$fpr)
ggplot(q_time_vary_N_fpr, aes(x = N, y = avg_query_time, fill = fpr)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9", "red", "green")) + 
  geom_errorbar(aes(ymin = avg_query_time - se, ymax = avg_query_time + se, width = 0.2), position = position_dodge(0.9)) + 
  ggtitle("Average query time by N and fpr") + 
  xlab("N (num. of input keys)") + ylab("avg_query_time (sec)")
