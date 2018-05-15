---
title: "Supplementary Document 2"
subtitle: "Primers"
author: "Jason T. Serviss"
date: "2017-12-09"
output:
  html_document:
    theme: flatly
    code_folding: hide
    keep_md: true
vignette: >
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---



## Figure 1b


```r
tibble(
    name=c(
        "miR34a asRNA F1",
        "miR34a asRNA R1",
        "miR34a HG F",
        "miR34a HG R",
        "ß-actin Fwd",
        "ß-actin Rev"
    ),
    sequence=c(
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT",
        "TCT GCT CCA GTG GCT GAT GAG AAA",
        "GTT CAC TGG CCT CAA AGT TGG CAT",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA"
    )
)
```



name              sequence                        
----------------  --------------------------------
miR34a asRNA F1   AGC GGC ATC TCC TCC ACC TGA AA  
miR34a asRNA R1   TTG CCT CGT GAG TCC AAG GAG AAT 
miR34a HG F       TCT GCT CCA GTG GCT GAT GAG AAA 
miR34a HG R       GTT CAC TGG CCT CAA AGT TGG CAT 
ß-actin Fwd       AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev       CTT TGC GGA TGT CCA CGT CA      

## Figure 1d 


```r
tibble(
  name = c(
    "miR34a asRNA F10",
    "polyT T7 FAM",
    "miR34a asRNA F1",
    "FAM primer"),
  sequence = c(
    "ACG CGT CTC TCC AGC CCG GGA T",
    "CAG TGA ATT GTA ATA CGA CTC ACT ATA GGG ACA TCC GTA GCT CGT CCA GGA CCC TTT TTT TTT TTT TTT TTT VN",
    "AGC GGC ATC TCC TCC ACC TGA AA",
    "CCG TAG CTC GTC CAG GAC CC"
  )
)
```



name               sequence                                                                                           
-----------------  ---------------------------------------------------------------------------------------------------
miR34a asRNA F10   ACG CGT CTC TCC AGC CCG GGA T                                                                      
polyT T7 FAM       CAG TGA ATT GTA ATA CGA CTC ACT ATA GGG ACA TCC GTA GCT CGT CCA GGA CCC TTT TTT TTT TTT TTT TTT VN 
miR34a asRNA F1    AGC GGC ATC TCC TCC ACC TGA AA                                                                     
FAM primer         CCG TAG CTC GTC CAG GAC CC                                                                         

## Figure 2a


```r
tibble(
    name=c(
        "ß-actin Fwd",
        "ß-actin Rev",
        "miR34a HG F",
        "miR34a HG R",
        "miR34a AS F1",
        "miR34a AS R1"
        
    ),
    sequence=c(
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TCG GGA TGT CCA CGT CA",
        "TCT GCT CCA GTG GCT GAT GAG AAA",
        "GTT CAC TGG CCT CAA AGT TGG CAT",
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT"
        
    )
)
```



name           sequence                        
-------------  --------------------------------
ß-actin Fwd    AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev    CTT TCG GGA TGT CCA CGT CA      
miR34a HG F    TCT GCT CCA GTG GCT GAT GAG AAA 
miR34a HG R    GTT CAC TGG CCT CAA AGT TGG CAT 
miR34a AS F1   AGC GGC ATC TCC TCC ACC TGA AA  
miR34a AS R1   TTG CCT CGT GAG TCC AAG GAG AAT 

## Figure 2b


```r
tibble(
    name=c(
        "ß-actin Fwd",
        "ß-actin Rev",
        "miR34a HG F",
        "miR34a HG R",
        "miR34a as F1",
        "miR34a as R1"
        
    ),
    sequence=c(
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TCG GGA TGT CCA CGT CA",
        "TCT GCT CCA GTG GCT GAT GAG AAA",
        "GTT CAC TGG CCT CAA AGT TGG CAT",
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT"
        
    )
)
```



name           sequence                        
-------------  --------------------------------
ß-actin Fwd    AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev    CTT TCG GGA TGT CCA CGT CA      
miR34a HG F    TCT GCT CCA GTG GCT GAT GAG AAA 
miR34a HG R    GTT CAC TGG CCT CAA AGT TGG CAT 
miR34a as F1   AGC GGC ATC TCC TCC ACC TGA AA  
miR34a as R1   TTG CCT CGT GAG TCC AAG GAG AAT 

## Figure 2c


```r
tibble(
    name=c(
        "Luc setII F",
        "Luc setII R",
        "Renilla pBiDir F1",
        "Renilla pBiDir R1",
        "ß-actin Fwd",
        "ß-actin Rev"
    ),
    sequence=c(
        "AAG ATT CAA AGT GCG CTG CTG",
        "TTG CCT GAT ACC TGG CAG ATG",
        "TAA CGC GGC CTC TTC TTA TTT",
        "GAT TTG CCT GAT TTG CCC ATA",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA"
    )
)
```



name                sequence                       
------------------  -------------------------------
Luc setII F         AAG ATT CAA AGT GCG CTG CTG    
Luc setII R         TTG CCT GAT ACC TGG CAG ATG    
Renilla pBiDir F1   TAA CGC GGC CTC TTC TTA TTT    
Renilla pBiDir R1   GAT TTG CCT GAT TTG CCC ATA    
ß-actin Fwd         AGG TCA TCA CCA TTG GCA ATG AG 
ß-actin Rev         CTT TGC GGA TGT CCA CGT CA     

## Figure 2d


```r
tibble(
    name=c(
        "Luc set II F",
        "Luc set II R",
        "Renilla pBiDir F1",
        "Renilla pBiDir R1",
        "ß-actin Fwd",
        "ß-actin Rev"
    ),
    sequence=c(
        "AAG ATT CAA AGT GCG CTG CTG",
        "TTG CCT GAT ACC TGG CAG ATG",
        "TAA CGC GGC CTC TTC TTA TTT",
        "GAT TTG CCT GAT TTG CCC ATA",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA"
    )
)
```



name                sequence                       
------------------  -------------------------------
Luc set II F        AAG ATT CAA AGT GCG CTG CTG    
Luc set II R        TTG CCT GAT ACC TGG CAG ATG    
Renilla pBiDir F1   TAA CGC GGC CTC TTC TTA TTT    
Renilla pBiDir R1   GAT TTG CCT GAT TTG CCC ATA    
ß-actin Fwd         AGG TCA TCA CCA TTG GCA ATG AG 
ß-actin Rev         CTT TGC GGA TGT CCA CGT CA     

## Figure 3a

Cloning primers


```r
tibble(
    name=c(
        "miR34aAS cloning F4",
        "miR34aAS cloning Ex3_1"
    ),
    sequence=c(
        "ACG CGT CTC TCC AGC CCG GGA T",
        "AAT GAT GGC CGC AAC TAA TGA CGG"
    )
)
```



name                     sequence                        
-----------------------  --------------------------------
miR34aAS cloning F4      ACG CGT CTC TCC AGC CCG GGA T   
miR34aAS cloning Ex3_1   AAT GAT GGC CGC AAC TAA TGA CGG 

QPCR primers


```r
tibble(
    name=c(
        "ß-actin Fwd",
        "ß-actin Rev",
        "miR34a AS F1",
        "miR34a AS R1"
        
    ),
    sequence=c(
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TCG GGA TGT CCA CGT CA",
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT"
        
    )
)
```



name           sequence                        
-------------  --------------------------------
ß-actin Fwd    AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev    CTT TCG GGA TGT CCA CGT CA      
miR34a AS F1   AGC GGC ATC TCC TCC ACC TGA AA  
miR34a AS R1   TTG CCT CGT GAG TCC AAG GAG AAT 

## Figure 3d


```r
tibble(
    name=c(
        "miR34a ChIP F1",
        "miR34a ChIP R1"
    ),
    sequence=c(
       "AAA GTT TGC AAA GAA GGA GGC GGG",
       "AGG GAA GAA AGA ACT AGC CGA GCA"
    )
)
```



name             sequence                        
---------------  --------------------------------
miR34a ChIP F1   AAA GTT TGC AAA GAA GGA GGC GGG 
miR34a ChIP R1   AGG GAA GAA AGA ACT AGC CGA GCA 

## Figure 1 Supplement 2a


```r
tibble(
    name=c(
        "miR34a AS F10",
        "miR34a AS F11",
        "miR34a AS F12",
        "miR34a AS F13",
        "miR34a AS F14",
        "miR34a AS F15",
        "miR34a AS R1"
    ),
    sequence=c(
        "ACG CGT CTC TCC AGC CCG GGA T",
        "ATC TGC GTG GTC ACC GAG AAG CA",
        "CGC ACG GAC TGA GAA ACA CAA G",
        "ACG GAG GCT ACA CAA TTG AAC AGG",
        "AGG GAA GAA AGA ACT AGC CGA GCA",
        "CAT TTG CTG CAA TAT CAC CGT GGC",
        "TTG CCT CGT GAG TCC AAG GAG AAT"
    )
)
```



name            sequence                        
--------------  --------------------------------
miR34a AS F10   ACG CGT CTC TCC AGC CCG GGA T   
miR34a AS F11   ATC TGC GTG GTC ACC GAG AAG CA  
miR34a AS F12   CGC ACG GAC TGA GAA ACA CAA G   
miR34a AS F13   ACG GAG GCT ACA CAA TTG AAC AGG 
miR34a AS F14   AGG GAA GAA AGA ACT AGC CGA GCA 
miR34a AS F15   CAT TTG CTG CAA TAT CAC CGT GGC 
miR34a AS R1    TTG CCT CGT GAG TCC AAG GAG AAT 

## Figure 1 Supplement 2b


```r
tibble(
    name=c(
        "miR34a AS F1",
        "miR34a AS R1",
        "miR34a AS int1 R1",
        "miR34a HG F",
        "miR34a HG R",
        "ß-actin Fwd",
        "ß-actin Rev",
        "U48 F",
        "U48 R"
    ),
    sequence=c(
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT",
        "TGC GCA AAC TAC GCG CTC T",
        "TCT GCT CCA GTG GCT GAT GAG AAA",
        "GTT CAC TGG CCT CAA AGT TGG CAT",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA",
        "AGT GAT GAT GAC CCC AGG TA",
        "GGT CAG AGC GCT GCG GTG AT"
    )
)
```



name                sequence                        
------------------  --------------------------------
miR34a AS F1        AGC GGC ATC TCC TCC ACC TGA AA  
miR34a AS R1        TTG CCT CGT GAG TCC AAG GAG AAT 
miR34a AS int1 R1   TGC GCA AAC TAC GCG CTC T       
miR34a HG F         TCT GCT CCA GTG GCT GAT GAG AAA 
miR34a HG R         GTT CAC TGG CCT CAA AGT TGG CAT 
ß-actin Fwd         AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev         CTT TGC GGA TGT CCA CGT CA      
U48 F               AGT GAT GAT GAC CCC AGG TA      
U48 R               GGT CAG AGC GCT GCG GTG AT      

## Figure 1 Supplement 2c


```r
tibble(
    name=c(
        "miR34a AS F12",
        "miR34a AS R1",
        "miR34a AS R2",
        "miR34a AS R3",
        "miR34a AS Ex3 R1"
    ),
    sequence=c(
        "AAA CAC AAG CGT TTA CCT GGG TGC",
        "TTG CCT CGT GAG TCC AAG GAG AAT",
        "ATA GGT TCA TTT GCC CGA TGT GCC",
        "CCA CAG CTG TTG CTT CTG AAT GCT",
        "TGA TGG CCG CAA CTA ATG ACG GAT"
    )
)
```



name               sequence                        
-----------------  --------------------------------
miR34a AS F12      AAA CAC AAG CGT TTA CCT GGG TGC 
miR34a AS R1       TTG CCT CGT GAG TCC AAG GAG AAT 
miR34a AS R2       ATA GGT TCA TTT GCC CGA TGT GCC 
miR34a AS R3       CCA CAG CTG TTG CTT CTG AAT GCT 
miR34a AS Ex3 R1   TGA TGG CCG CAA CTA ATG ACG GAT 

## Figure 2 Supplement 2a


```r
 tibble(
    name=c(
        "Luc setII F",
        "Luc setII R",
        "Renilla pBiDir F1",
        "Renilla pBiDir R1",
        "ß-actin Fwd",
        "ß-actin Rev"
    ),
    sequence=c(
        "AAG ATT CAA AGT GCG CTG CTG",
        "TTG CCT GAT ACC TGG CAG ATG",
        "TAA CGC GGC CTC TTC TTA TTT",
        "GAT TTG CCT GAT TTG CCC ATA",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA"
    )
)
```



name                sequence                       
------------------  -------------------------------
Luc setII F         AAG ATT CAA AGT GCG CTG CTG    
Luc setII R         TTG CCT GAT ACC TGG CAG ATG    
Renilla pBiDir F1   TAA CGC GGC CTC TTC TTA TTT    
Renilla pBiDir R1   GAT TTG CCT GAT TTG CCC ATA    
ß-actin Fwd         AGG TCA TCA CCA TTG GCA ATG AG 
ß-actin Rev         CTT TGC GGA TGT CCA CGT CA     

## Figure 3 Supplement 1a

Cloning primers


```r
tibble(
    name=c(
        "miR34aAS cloning F4",
        "miR34aAS cloning Ex3_1"
    ),
    sequence=c(
        "ACG CGT CTC TCC AGC CCG GGA T",
        "AAT GAT GGC CGC AAC TAA TGA CGG"
    )
)
```



name                     sequence                        
-----------------------  --------------------------------
miR34aAS cloning F4      ACG CGT CTC TCC AGC CCG GGA T   
miR34aAS cloning Ex3_1   AAT GAT GGC CGC AAC TAA TGA CGG 

QPCR primers


```r
tibble(
    name=c(
        "ß-actin Fwd",
        "ß-actin Rev",
        "miR34a AS F1",
        "miR34a AS R1"
        
    ),
    sequence=c(
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TCG GGA TGT CCA CGT CA",
        "AGC GGC ATC TCC TCC ACC TGA AA",
        "TTG CCT CGT GAG TCC AAG GAG AAT"
        
    )
)
```



name           sequence                        
-------------  --------------------------------
ß-actin Fwd    AGG TCA TCA CCA TTG GCA ATG AG  
ß-actin Rev    CTT TCG GGA TGT CCA CGT CA      
miR34a AS F1   AGC GGC ATC TCC TCC ACC TGA AA  
miR34a AS R1   TTG CCT CGT GAG TCC AAG GAG AAT 

## Figure 3 Supplement 2a


```r
tibble(
    name=c(
        "CCND1 Fwd",	
        "CCND1 Rev",
        "ß-actin Fwd",
        "ß-actin Rev"
    ),
    sequence=c(
        "CGT GGC CTC TAA GAT GAA GG",
        "CTG GCA TTT TGG AGA GGA AG",
        "AGG TCA TCA CCA TTG GCA ATG AG",
        "CTT TGC GGA TGT CCA CGT CA"
    )
)
```



name          sequence                       
------------  -------------------------------
CCND1 Fwd     CGT GGC CTC TAA GAT GAA GG     
CCND1 Rev     CTG GCA TTT TGG AGA GGA AG     
ß-actin Fwd   AGG TCA TCA CCA TTG GCA ATG AG 
ß-actin Rev   CTT TGC GGA TGT CCA CGT CA     
