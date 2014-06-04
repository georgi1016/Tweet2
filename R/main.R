StartToThink <- function(fun,...){
  
  
  switch(fun, 
         TwitterAuth={
           
           status  <- TwitterAuth(...)
           
           
           
         },
         SentimentCloud={
           
           SentimentCloud(...)  
           
           
         },
         
         
{
  print("No function defined")}
)
}
  
