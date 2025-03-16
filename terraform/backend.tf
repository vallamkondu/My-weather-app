terraform { 
  cloud { 
    
    organization = "expedi123" 

    workspaces { 
      name = "aws-weather-app" 
    } 
  } 
}