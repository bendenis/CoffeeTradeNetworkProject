categorize_triplet2 = function(code){
        
        code = as.character(code)
        
        if(code %in% list("3")){
                return("ABD")
        }else if(code %in% list("34:34","3:24","13:4","4:13")){
                return("AAD")
        }else if(code %in% list("34","13","24","3:4","4:3")){
                return("ACD")
        }else if(code %in% list("2")){
                return("BAD")
        }else if(code %in% list("1234:34","34:1234","1234:12","1234:1234","12:1234")){
                return("CCC")
        }else if(code %in% list("2:3","3:2","1234")){
                return("CCD")
        }else if(code %in% list("24:3","1:4")){
                return("ABC")
        }else if(code %in% list("12")){
                return("CAD")
        }else if(code %in% list("12:34","34:12","12:12","24:13","13:24")){
                return("ACC")
        }else if(code %in% list("13:2","4:1","2:13")){
                return("ACB")
        }else if(code %in% list("1:2","2:1")){
                return("AAB")
        }else{
                return(code)
        }
        
}