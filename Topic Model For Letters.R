library(car)

# clear global environment
rm(list=ls())

setwd("~/Desktop/clean txt")

cname <- file.path("~", "Desktop", "clean txt")   
cname 

dir(cname)

library(tm) 
library(topicmodels)
docs <- Corpus(DirSource(cname))
filenames <- list.files(getwd(),pattern="*.txt")
docs
writeLines(as.character(docs[[1]]))

## Preprocessing for topic model    
docs <- tm_map(docs, removePunctuation)   # *Removing punctuation:*    
docs <- tm_map(docs, removeNumbers)      # *Removing numbers:*    
docs <- tm_map(docs, content_transformer(tolower))   # *Converting to lowercase:*    

docs <- tm_map(docs, removeWords, stopwords("english"))   # *Removing "stopwords" 
library(SnowballC)   
docs <- tm_map(docs, stemDocument)   # *Removing common word endings* (e.g., "ing", "es") 
myStopwords <- c("model"  ,"research"   ,"work",       "student"  , "postdoctor"   ,
"climat" ,     "data" ,    
 "phd"    ,    "earth" ,     "project"   , "recommend" ,  "year"   ,   "graduat"      ,   "also"   ,        
 "isotop"           ,     "studi"  ,"field"  ,      "one",    "paper"        , "will"   ,   "interest"     
,     "project"  ,   "geophys" ,  "lamontdoherti",     "program"  ,   "seismic"      ,  "environment",  "cours"        
,"new"      ,    "phd"          ,"sediment"  , "fellowship" , "mantl" ,   "earthquak" ,      "high"   ,             
 "applic"  ,  "dissert"      ,     "committe"     , "two"      ,              "water"  ,    "institut"  ,                    
"thesi"   ,      "atmospher"  ,         "wave"   ,   "undergradu"   ,  "applic", 
    
"ocean" ,"univers"   ,     
"time" ,          "write"  ,     "intern"   ,   "process"  ,  "chang"     
,   "geolog"    ,  "result"   ,
 "lab"    ,     "journal"   
,   "letter"  ,    "result"    
,   "observ" ,   
      "doctor"    , "complet"   ,
"present"  ,   "group"     
,   "depart"    ,  "melt"   ,    "januari"   
,  "physic" ,    "mani"      
,   "sincer"   ,   "seismolog" ,    
   "sinc"   ,  
"ldeo",     "observatori" ,        
   "may"   ,         
  "experiment",     
"discuss"   ,  "degre"    ,   "structur"  ,    
"public"   , "mechan"   ,  "may"       
,      "code"  ,   
"postdoc"  ,       "lamont"    ,   "measur"   ,   
"get", "supervis"  ,  "flow"  ,       
 "scienc"  ,   "use"    ,       "develop" ,        
   "remot"      
,  "sens"  , 
"system",   
 "pleas"  ,  "method"  ,     "laboratori"
, "imag"  ,     "set"  ,"class"     
,   "show"      , "nation"    
, "question" ,     "forest"  ,  
"area" ,   
  "base"  ,   "columbia" , "satellit",  "region"  ,    
  "recent"  ,   "area"   ,    
"contact" ,   "gis"   ,    "last" ,     
"dear"   
       
,"fault"          , "diffus"        ,  "lithospher"  , "tropic"    ,     "msc"        ,      "lake"     ,        "nitrogen"  ,   "particl"        
, "mineralog"   ,    "turbul"    ,   "monsoon"  ,      "enso"      ,       "metal"       ,     "fluid"    ,    "plant"          
,"ruptur"    ,      "plume"   ,        "ozon"      ,   "oxygen"    ,     "coral"       ,     "arctic"      ,     "viscos"            
,      "geomorpholog" ,"hyperspectr" ,   "veget"     ,       "cruis"        ,    "drought"   ,   "physiolog"      
,"ridg"       ,        "grain"      ,        "foraminifera"  ,   "pollut"      ,     "metamorph"  ,  "diamond"        
,      "cyclon"  ,        "anisotrop" ,   "sst"    ,        "dust"     ,        "alkenon"      ,    "cave"         
,   "indian"     ,    "gas"       ,       "biomark"    ,      "treer"   ,     "paleontolog"    
,              "peridotit"  ,  "airsea"      ,   "fire"       ,      "compound"            
,"mercuri"       ,        "cooper"     ,  "oceanatmospher" ,"benthic"    ,      "air"      ,        "ring"     ,    "vent"           
,"plate"        ,   "geoid"      ,     "martian"    ,  "eros"        ,   "fossil"       ,         "tree"   ,      "molecular"      
,"station"     ,      "anisotropi"   ,"stratospher" ,              "silic"   ,     "jet"            
,"gps"        ,       "moistur"   ,   "peatland"     ,  "geographi"   ,     "plant"          ,  "sedimentolog", "hydrotherm"     
,"granit"      ,         "forecast" ,    "radar"   ,       "bedrock"   ,              "fixat"     ,   "french"         
,"midocean"        ,      "agricultur"  , "forecast"  ,     "hydrat"     ,      "radiocarbon"   ,       "board"          
,"kinemat"    ,     "trilobit"     ,  "geospati"   ,    "seawat"       ,    "zircon"   ,        "landslid"   ,  "electrostat"    
,        "basalt"   ,       "migrat"    ,   "compress"   ,    "sensor"   ,        "ice"          ,    "plateau"    ,  "march"          
,"plume"       ,    "ion"      ,       "landscap" ,    "eddi"      ,     "canopi"       ,    "sphagnum"   ,      "invas"   ,     "estuari"        
,"volcano"       ,       "mar"    ,      "retriev"   ,     "morpholog"  ,      "clay"   ,              "sink"           
,"foraminifera"  ,            "march"   ,     "rem"     ,       "iron"       ,      "arid"    ,         "dri"         
,"hydrotherm"   ,   "olivin"   ,     "intraseason" ,      "turbidit"   ,      "greenhous"  ,  "chromium"       
,"segment"    ,       "stratospher"  ,"groundwat"     , "eros"      ,       "peatland"    ,     "glaucophan" ,  "kimberlit"      
,"stz"      ,       "larmontdoherti" , "geographi"   ,         "polici"     ,             "microwear"      
,"adcp"     ,      "enso"  ,         "foraminifer"  ,           "foraminifera" ,"kit"            
,"torsion"    ,     "tidal"   ,        "rheolog" ,     "optic"       ,   "agricultur"    ,   "wrf"       ,     "crop"           
,       "viscos"      ,     "tropospher"  ,   "dri"     ,         "ent"    ,      "color"          
,"campaign"      ,  "keel"         ,      "plateau"     ,       "cellulos"    ,          "fossil"         
,         "nino"        ,       "lunar"    ,        "canopi"    ,   "fortran"        
,        "cooper"     ,     "sedimentolog" ,"aew"        ,    "acid"           ,  "diatom"        ,   "slide"   ,     "eddi"           
,"nucleat"      ,   "moon"      ,      "diploma"  ,    "methan"    ,     "shell"    ,        "reduct"    ,       "shelf"    ,    "tomographi"     
,"rheolog"  ,       "cell"     ,            "interannu"  ,         "paleointens"  ,    "agricultur"  , "evolutionari"   
     ,  "gase"   ,         "crop"     ,    "cloud"     ,     "biodivers"     ,   "tropic"     ,    "dinosaur"       
,"shelf"     ,      "dissolv"    ,     "meteorit"   ,  "radiat"    ,     "cruis"   ,         "raman"      ,      "ing"    ,      "tidal"          
,          "graviti"       ,  "volatil"    ,        "excurs"   ,        "radionuclid"    ,  "proactiv"    , "microbiolog"    
,"lithospher"   ,   "tide"     ,       "elast"     ,   "som"      ,      "assemblag"  ,      "pollen"  ,         "particl"        
,"nois"      ,      "useri"       ,    "viscos"     ,    "canal"  ,          "ion"      ,        "hydrous" ,     "diplodocoid"    
,        "geotechn" ,    "titl"      ,     "les"     ,                "entitl"    ,   "biotechnolog"   
,"geometri"     ,   "drill"     ,      "station"  ,    "gcm"    ,        "uplift"   ,        "piston"    ,       "ice"      ,    "sulfat"         
,"paleoseism"   ,   "paleontolog"   ,  "deplet"      , "teleconnect"   , "tropic"    ,       "strait"   ,        "igneous"       
,           "amplitud"  ,   "cell"       ,    "postgradu"    ,    "juli"     ,        "uplift"   ,    "score"          
,"tomographi"  ,    "bay"        ,      "ester"    ,      "fluid"        ,    "african"   ,       "estuari"  ,    "tooth"          
,"cruis"       ,    "hydraul"     ,         "arsenic"     ,   "bsc"         ,     "pine"        ,     "microbiolog" , "mgca"           
, "turbidit"   ,          "zooplankton" ,   "dinosaur"  ,       "paleomagnet" ,     "pdf"   ,       "sauropod"       
,"propag"       ,   "equilibria"  ,    "pdf"    ,      "noaa"     ,      "clump"         ,   "teleseism"   ,     "shale"     ,   "leaf"           
,"shell"        ,   "eddi"      ,      "cpx"      ,    "throughflow"  ,  "bone"    ,         "color"     ,       "plate"    ,    "cooper"         
,"dept"       ,     "nonhydrostat"   ,       "chlorophyl"    , "agentbas"      ,   "optic"   ,         "geochronolog" ,"devic"          
,"msc"       ,      "fossil" ,         "urban"    ,    "emiss"      ,    "forecast"   ,      "coccolith"      ,  "rhyolit"  ,    "vertebr"        
,"erupt"       ,    "laramid"   ,      "citi"       ,  "hydrogeolog"  ,  "landscap"  ,        "prism"     ,   "cell"           
,"crystallographi" ,"orbit"         ,       "graviti"     ,     "paleoseismolog" ,  "grape"    ,    "sphere"         
,"fire"       ,     "waveform" ,       "olivin"    ,   "landscap"    ,       "lgm"          ,    "adjoint"       
,"finit"      ,     "abroad"    ,      "geomagnet"  ,  "rom"       ,     "stratigraphi"  ,   "dust"        ,     "tropic"  ,     "plate"          
,"sedimentolog"  ,     "fabric"   ,    "cruis"   ,       "micropaleontolog", "sulfur"     ,      "speciat"    ,  "msc"            
,"cooper"  ,          "ophiolit"  ,   "abrupt"      ,   "fisheri"     ,     "hematit"     ,     "geomorpholog", "plankton"       
,        "mobil"     ,      "delamin"   ,   "particl"  ,      "aragonit" ,        "station"     ,     "msc"      ,    "foraminifera"   
,"pollut"       ,   "grad"     ,       "hydrogeolog" , "board"       ,   "semicircular"   ,  "molecular"   ,     "biochem"      
,"lava"  ,          "hotspot"  ,       "textur"     ,  "isol"      ,     "suppli"  ,         "oxid"   ,          "faci"    ,     "toxic"          
,"tsunami"     ,    "swave"        ,   "geomorph"    , "fluid"     ,     "treer"         ,   "silic"     ,       "emiss"            
,"basalt"   ,       "unfortun"    ,    "flexibl"    ,  "acid"    ,       "particl"  ,        "oxygen"     ,      "titl"      
,"arc"          ,   "urban"      ,"sensor"     ,    "sedimentolog"    ,  "desert"     ,  "centr"          
,"discharg"     ,   "prototyp"    ,    "tsunami"    ,  "estuari"     ,   "plant"  ,          "iodp"     ,        "iron" ,        "paleomagnet"    
,"diagenesi"    ,   "clinopyroxen"   ,     "ozon"    ,       "attenu" ,          "leaf"     ,            "palaeontolog"   
,"quarter"    ,     "radiocarbon" ,    "basalt"     ,  "molecular"  ,    "plateau"      ,    "protein"     ,     "citi"     ,    "dental"         
,"anisotropi"     , "testimoni"    ,   "arc"      ,    "helium"    ,      "glass"     ,       "european"   ,  "wear"           
,"seedl"        ,   "reef"   ,         "palaeoclim"  , "vapor"      ,    "orbit"       ,     "easter" ,          "useri" ,       "crw"            
,"terrain"     ,   "morain"  ,     "caviti"   ,      "phytoplankton"   , "photosynthesi" ,          "reservoir"      
,          "msc" ,            "anelast"  ,    "moc"        ,    "biogeosci"     ,   "craton"     ,      "fossil"   ,    "harbor"         
,"optic"      ,        "gpr"     ,       "phosphat"     ,    "frustul"      ,    "viticultur"        
,       "net"     ,        "strain"    ,   "ico"         ,      "vascular"    ,     "liquefact"  ,  "bloom"          
,"plastic"     ,    "centr"      ,     "grid"    ,      "southeastern"  ,   "aros" ,            "comm"   ,      "trap"           
,"graviti"   ,              "air"       ,     "immens"       ,           "accretionari" ,"titl"           
,"elast"      ,     "evolutionari"   , "igneous"    ,         "burn"      ,       "isol"   ,          "lithium"   ,   "waveform"       
,         "stratigraphi", "urban"      ,      "sedimentolog"   ,  "maar"      ,   "petroleum"      
,"reservoir"    ,   "phytoplankton",   "flood"    ,      "index"      ,"cruis"      ,  "agricultur"     
,"oxid"         ,   "orogeni"       ,  "divis"       , "african"    ,           "urban"             
,"onr"       ,      "microbiolog"   ,    "drought"     ,   "shelf"    ,        "aerosol"     ,     "wedg"          
,"alkalin"   ,      "lunar" ,          "oxygen"     ,      "northeast"  ,      "attenu"        
,"alaska"      ,    "suntan"   ,       "postgradu"  ,       "compound" ,    "rotat"          
,"coulomb"       ,  "verif"     ,      "diffus"     ,  "bacteri",        "mesozo"   ,        "micropaleontolog", "airsea"  ,     "inorgan"        
,"magnet"      ,    "intrapl"      ,   "fractur"     , "inorgan"  ,      "metal"      ,      "dna"      ,        "oxid"   ,      "angl"           
,"broadband"    ,   "nuclear"   ,      "ostracod"   ,        "programm"  ,       "srca"    ,         "liquid" ,      "propag"         
,"plankton"     ,   "branch"      ,    "ebsd"      ,   "bacteria"   ,    "emiss"        ,    "phytoplankton"          
,"plot"      ,      "fortran"     ,   "wester"   ,                  "phylogeni"    
,       "plant"      ,     "petrophys"   ,       "seawat"      ,   "jurass"         
,    "microbi" ,     "robot"        ,  "algal"        ,    "whenev"    ,   "compound"       
,"gyre"          ,  "proud"       ,    "biogen"      ,   "genet"      ,      "pah"           
,"geodesi"     ,    "rheolog"   ,      "autonom" ,     "reminer"    ,    "skeleton"    ,     "cascadia" ,        "shell"    ,    "antioxid"       
,"glider"     ,"erupt"  ,         "curvatur",   "loess"       ,     "snowpack" ,        "southwest"    ,"reactor"        
,"quartz"      ,    "specimen"     ,   "tcs"        ,    "aeolian"   ,       "ftms"      ,       "isol"     ,    "palaeontologist"
,"branch"     ,     "coral"  ,         "split"     ,   "deforest"  ,     "finitefrequ"   ,   "whoi"   ,          "inorgan" ,     "phylogenet"     
, "brittl"   ,        "metamorph"  ,  "carotenoid" ,    "saltat"   ,        "titl"     ,        "stratigraphi", "bca"            
,"wes"      ,            "graviti"    ,  "dreissenid"  ,   "omp"    ,          "drought"    ,      "dust"          
,"rainforest"   ,   "ftir"          ,  "calib"       , "hdo"         ,   "sublay"    ,       "wetland"  ,        "broadband"   , "sand"           
, "bight"      ,     "multiscal"  ,     "lagoon" ,      "rsm"       ,           "cyclon"    ,       "drill"         
,       "echo"         ,      "crustacean"    , "evolutionari"    , "diurnal"     ,     "friday"     ,  "rural"          
,"ethiopia"    ,    "spectrophotomet", "meltrock"  ,   "omz"           , "methan"      ,     "dri"          ,    "buildup"  ,    "phytoplankton"  
,"hypocent"     ,   "tabl"         ,   "catalog"    ,        "net"   ,           "shell"    ,        "grain"    ,    "oxid"           
,  "pyroclast"   ,    "emplac"   ,    "biooptic"     ,  "tomographi"    ,   "electr"      ,     "groundwat"    
,"coseism"    ,     "dec"       ,      "eho"       ,   "pollut"   ,      "taxonomi"    ,     "biomass",          "gase"    ,     "lithospher"     
,"sgd"      ,       "elo"       ,   "geodesi"   ,     "geo"      ,        "plot"        ,     "clim"       ,  "ecophysiolog"   
,"interseism"    ,  "geodesi"          ,"editor"     ,    "aerosol"    ,      "seaic"  ,          "sab"        ,  "tropic"         
,"auv"         ,    "oxid"      ,   "cyclon"    ,     "molecular"    ,    "varianc" ,         "kudzu"     ,   "urban"          
,         "fffe"            
,"glaciolog"    ,   "immens"          
    
,"gps"                  
,"geochronolog"        
     
, "sheet"    ,       "cooper"          
,"cell"            
,"block"       
,"anisotropi"  ,    "sharp"           
,"dendrochronolog"        
, "volcano"              
,"radar"           
,"arctic"    ,      "dispers"         
,"blueschist"             
,"propag"        ,  "postgradu"       
,"arar"                 
,"lake"       ,     "fax"             
,"erupt"           
,"station"    ,     "peninsula"       
,"volcanolog"             
,"calv"      ,      "biophys"         
   ,      "vast"            
, "msc"            
,"radiat"               
,"plant"            
,"bsc"           
,       "persuas"         
,"geomorpholog"   , "ree"             
,"zircon"    ,      "forestri"        
,"drill"   ,        "subtrop"         
,"raman"            
, "electrod"            
,"chile"    ,       "tropic"          
,"cosmogen"          
,"iceberg"                 
,"centr"      ,     "feb"             
, "cooper"       ,   "afterward"       
,"melang"       ,   "zonal"           
, "unansw"          
, "microbi"                 
, "optic"       ,    "tongu"           
,"fjord"      ,     "sirma"           
,"fuel"                  
,"fossil"     ,     "multipath"       
,"electr"        
,"pollut"              
,"upb"              
,"tomographi"           
,"electrochem"   ,  "plankton"        
,"finit"           
,"diamond"      ,   "icpa"            
,"viscous"               
,"predat"      ,    "dendroecolog"    
,"broadband"                 
,"juli"               
,       "asymmetri"       
,    "foraminif"       
, "petrograph"    ,  "juli"            
, "pterosaur"    ,   "sep"             
,"eutect"      ,    "machineri"       
,"lowermost"               
,     "glp"             
, "seaic"              
,"isol"      ,      "coretop"         
    ,  "imperi"          
,"ring"       ,     "iit"             
,"magnet"        ,  "bombay"          
,        "oxid"    ,        "paleoreconstruct"
,"arc"        
, "miriam"      ,    "rayleigh"        
, "bison"     ,      "breviti"         
,"cryogen"         
, "icequak"          
,"basalt"         
,"compound"             
,  "abovement"       
,"wood"               
,"treer"            
,"iron"        ,    "dendroclimatolog"
,"fluid"          
,"synchrotron"    , "sept"            
,"drainag"                 
,"plate"              
,"fax"          
,     "undersign"       
,      "botani"          
,"cinquegrana"             
,"hma"              
,"borondop"       , "ecophysiolog"    
,    "reloc"         
,"poc"      ,       "electr"          
,"terrain"   ,      "sub"   
,          "coastal"     ,  "magma"     ,   "ecosystem" , "soil"     ,   "glacier",        "coastal"    
,    "rift"  ,      "volcan"  ,     "inner"  ,    "geodynam" ,   "meteorolog"       
, "invers"    ,   "soil"    ,   "wind"     ,   "octob"  ,        "colleg"     
,"wind"      ,   "geodynam"   , "atlant"      , "storm"    ,  "chronolog"  ,         "paramet"    
,"invers"  ,     "climatolog" , "crustal"  ,      "paramet"          
,"estuarin"    ,   "deepsea"  ,  "volcan"   ,   "cretac"     
,"hurrican"  ,   "crustal"   ,  "coastal" ,     "invers"   
,"mesoscal"   ,  "slip"     ,     "novemb"    
,"contamin"   ,  "releas"    ,   "mesoscal"      
,"densiti"    ,  "colleg"    ,   "evolv"   ,   "slope"     ,  "snow"          
, "geoscientist" ,    "gulf"   ,       "crustal"     
,"atlant"   ,   "sem"         , "refere"   ,      "hazard" ,        "august"     
,      "paramet"   ,   "pore"      
,"gene"      ,   "friction"
, "lcpa"    
,  "black"        
,  "idm"       ,  "physicist"   
, "invers"   ,   "midlatitud" 
,"august"    ,      "seismogram"     
,    "soil"      ,  "pleistocen"        
,"lcms"        
, "nanosim"   ,    "chamber"    ,   "ecosystem" ,  "wind"     ,      "inventori"  
,"chamber"     , "ecosystem"   ,"geodynam"     ,"export"   ,        "octob"      
,   "ship"      
,          "strikeslip",  "fish"       
,   "octob"    ,   "microscop"   ,   "nutrient"  
,"biochemistri" ,"ore"    ,  "paleontologist"    
,"limnolog"   ,  "paramet"   ,    "novemb"    , "coastal"  
,       "land"   ,      "land"           
,  "island"    ,        "masterd"            
,   "beneath"           
,"peat"    ,     "decay"             
, "biogeochemistri"
, "thrust"                
,"geodet"   ,     "abstract"                
,    "plagioclas" , "biogeochemistri"      
, "cosupervisor"      
,  "land"       , "death"         
, "tas"        ,     "ambit"           
,  "petrographi"        
,   "eight"          
,   "width"    ,   "instal"  ,    "till"           
,"risk"    ,     "entranc"  ,   "san"         
,         "wavelet"       ,  "land"         
,"frontier"   ,     "shall"          
, "candidatur"   ,"forthcom"    
,"paid"     ,    "authigen"  ,     "hplc"             
,"idv"      ,     "continuum"  , "besid"       ,    "anyth"    ,   "fulltim"        
, "insitu"     ,  "thin"  ,      "perman"         
,"monitor"    ,     "hous"     ,   "modi"       ,     "widespread"         
,"equilibrium" , "fragment"  ,  "stochast"  ,"mechanist" ,  "advisori"       
,         "compani" ,     "reanalysi"      
,"land"        ,     "bayesian"   ,      "packag"     
, "stratosph" , "visco"   ,     "crui"    ,   "inver"     ,   "lithosph"    
,"bear"   ,   "divi"   ,    "bear"   ,     "transform"       
,"crui"    ,  "crui"   
,"reaction"  ,"troposph"   ,"deadlin"  ,  "ero"  ,        "head"        
,  "mesosc" ,     "error"    
,  "granular"        
,   "icpm"     ,  "math"   ,      "paleointen"     
,"biodiv"  ,  "rice" ,      "lithosph"      
,"conserv"  ,    "remin"     , "noi"           
,"disturb" ,  "noi"  ,      "cellulo"    ,  "plagiocla" ,  "disper"      
,"suscept"  , "pluton"  ,   "oceanatmosph"      
,    "teles"   
,  "atom"    ,     "oceanatmosph"   
,    "whomsoev"    ,  "divi"    
, "excur"   ,   "xenolith"       
,     "genom"     
,"lherzolit" ,"taxa"           
,"safeti" ,   "vortex"  ,   "agentba"   ,   "bivalv" ,    "multisc"  
,  "biomin"    ,  "retreat"   , "parallel"      
,"book"     , "medicin" ,   "degrad"     ,  "pigment" ,     "ref"         
, "geoenviron", "trigger",     "divi"     
, "moor"   ,      "stack"    ,  "contract"    , "wherev"      
,"cation"   , "altimetri" , "dye"     ,     "disturb"   
,  "petrophi"    , "canyon"  
,  "boat"      ,     "paleos"             
,   "rocki"   ,   "rain"   ,      "deepwat"  ,  "tomograph"    
,   "northeastern"       
, "autonomi"     
,    "amino"    ,     "compo"        )
docs <- tm_map(docs, removeWords, myStopwords)
docs <- tm_map(docs, stripWhitespace)   # *Stripping whitespace   
#docs <- tm_map(docs, PlainTextDocument)   
## *This is the end of the preprocessing stage.* 
writeLines(as.character(docs[[1]]))
writeLines(as.character(docs[[2]]))

### Stage the Data 
dtm <- DocumentTermMatrix(docs) # what is the number of terms?
dtm
#convert rownames to filenames
rownames(dtm) <- filenames
rownames(dtm)
dim(dtm)

library(slam)
## tf-idf
term_tfidf <- tapply(dtm$v / row_sums(dtm)[dtm$i], dtm$j, mean) * 
  log2(nDocs(dtm)/col_sums(dtm > 0))
summary(term_tfidf)
# pick between median and mode
plot(density(term_tfidf))
alpha <- 0.05 # here is the training, between 0.07-0.03 breaks out by fields of study...0.03 looks best. 
dtmms <- dtm[row_sums(dtm) > 0, term_tfidf >= alpha]
dim(dtmms)
rowTotals <- apply(dtmms , 1, sum) #Find the sum of words in each Document
dtmms   <- dtmms[rowTotals> 0, ]
dim(dtmms)

### Remove sparse terms 
#  Start by removing sparse terms: 
dtms <- removeSparseTerms(dtm, .999) # If terms appear in 0.1% (more than 10 documents) or more of the documents, they will be removed., .999 most interesting, where are all the words? 
# non-redundant that is whay it's so low?
# https://stackoverflow.com/questions/28763389/how-does-the-removesparseterms-in-r-work
dim(dtms) 
inspect(dtms)
rowTotals <- apply(dtms , 1, sum) #Find the sum of words in each Document
dtmss   <- dtms[rowTotals> 0, ]

# one letter dropped because contained no words in dtmss refinement 
dtmss
inspect(dtmss)
rownames(dtmss)

## analysis

library(topicmodels)
# NEED TO VERIFY, this finds the best iterations where to start in the data
control_CTM_VEM1 <- list(
  estimate.beta = TRUE, verbose=0, prefix=tempfile(),save=0,keep=0,
  seed=1421313709,nstart=1L,best=TRUE,
  var=list(iter.max=500,tol=10^-6),
  em=list(iter.max=1000,tol=10^-4),
  cg=list(iter.max=500,tol=10^5)
)

CTM6 <- CTM(dtmms, k = 6, control = control_CTM_VEM1)

Out <- as.matrix(topics(CTM6))
Out

terms <- as.matrix(terms(CTM6, 50))
terms

## let's look at the probability of each letter fit into each of the 5 topics.
## look to see who has used gendered words in topic model, make a dictionary of gendered words based on literature. 
## Let's meet with Alex. 
## Look at Trix and Pensca article for thier dictionary. 
## also Scmader et al 2007 has a dictionary. 

topics6 <- posterior(CTM6)$topics
topics6 <- as.data.frame(topics6)
print(topics6)
print(topics6)>0.8

# read in gender data
Gender <- read.csv("26Oct2014 Normlzd VALU database.csv")
Gender$S..No
head(Gender)
# remove columns that have no Gender
Gender <- Gender[!is.na(Gender$Word),]

Gender$Appl.Gend[Gender$Appl.Gend==""]=NA
Gender$Appl.Gend = droplevels(Gender$Appl.Gend)
levels(Gender$Appl.Gend)


# create data.frame from topics
write.csv(Out,file=paste("Topic.csv"))
Top <- read.csv("Topic.csv")
Top

# rename columns in docs.topic
library(plyr)
Top <-rename(Top, c("X"="Participant", "V1"="Topic"))
head(Top)
Top

# Drop .txt from particpant ID
t <- gsub(".txt", "", Top$Participant)
Top$Participant <- t
Top$Participant
class(Top$Participant)

# Add first zeros to Gender serial numbers to make full five digits
library(stringr)
Gender$S..No <- str_pad(Gender$S..No, width=5, side="left", pad="0")
Gender$S..No
class(Gender$S..No)

# adding gender to docs.topic
Gen <- Gender$Appl.Gend
head(Gen)
names(Gen) <- Gender$S..No
Top$Gender <- Gen[as.character(Top$Participant)]
head(Top) 
Top

# get probabilities of topic by gender
ftable(x1 <- xtabs(~ Topic + Gender, data=Top))
round(100*ftable(prop.table(x1, margin = 1)), 1)
round(100*ftable(prop.table(x1, margin = 2)), 1)
levels(Top$Gender)

###########################################

# analysis
# Use multinomial. right for this data, multinomial logistic regression. Suggested by Brian Keller
# The topic an individual ends up in depends on their gender. IV = Gender, DV = Topic. 
library(nnet)

Topp <- factor(Top$Topic)
Top$Ftop <- Topp
Top$Ftop <- relevel(Top$Ftop, ref = "6") 
# 6 topics, alpha= 0.05: 1 vs. 3, 2 vs. 5, 3 vs. 5, 4 vs. 5, 3 vs. 6
#       Gender Female Male
#Topic                   
#1              15.2 16.2
#2              21.7 19.6
#3              21.4 15.2
#4              18.6 17.4
#5              11.0 17.4
#6              12.1 14.2
# 8 topics is interesting as well: 2 vs. 4, 1 vs. 5, 4 vs. 5, 4 vs. 7, 5 vs. 6 
# Gender Female Male
#Topic                   
#1              13.8 11.8
#2              12.1 14.8
#3              13.8 13.0
#4              16.9 12.4
#5               8.5 12.2
#6              17.5 14.6
#7              13.0 15.9
#8               4.5  5.2
# 9 topics is good too, but few percent of applicants in a few topics.
head(Top)
str(Top)
mn <- multinom(Ftop ~Gender, Top)
summary(mn)
exp(coef(mn))
# z test for significance from: https://stats.idre.ucla.edu/r/dae/multinomial-logistic-regression/
z <- summary(mn)$coefficients/summary(mn)$standard.errors
z
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p
#  Men in topic 2, women in topic 1. 
# The odds of being put in topic six relative to topic one are 50% times higher for men than women. Topic 1 is the reference group. 
# to get sig test divide estimate by s.e. and calculate equation for Z stat.
# does not matter that n for men and women is different because I am looking at odds of being in a topic. 

#######################################


# to try a chi.square for proportions 
perc <- round(100*ftable(prop.table(x1, margin = 2)), 1)
fem <- perc[,1]
male <- perc[,2]
df <- data.frame(fem, male)
df
# Chi Square for proportions: http://www.r-tutor.com/elementary-statistics/inference-about-two-populations/comparison-two-population-proportions
# also do chi-square for gender or recommender 
# In the case of small samples (low value of n), you must specify correct = TRUE, 
# so as to change the computation of chi-square based on the continuity of Yates

# test

library(dplyr)
df$fem
df  %>%
  rowwise() %>% 
  mutate(
    test_stat = chisq.test(c(fem, male))$statistic,
    p_val = chisq.test(c(fem, male))$p.value
  )

# testing to see if each percent is different from one another. 
# learned method from https://www.youtube.com/watch?v=L9YDB1LRK5I
perc
Fem.male.prop <- c(5.3,17.1)
pe <- c(100, 100)
prop.test(Fem.male.prop, pe)
chisq.test(Fem.male.prop)

# topic six is sig different for females and males
# last p_val matches individual chi.test

############################

## 10-fold cross validation, NEED TO VERIFY

control_CTM_VEM <- list(
  estimate.beta = TRUE, verbose = 0, prefix = tempfile(), save = 0, keep = 0,
  seed = as.integer(Sys.time()), nstart=1L, best = TRUE,
  var = list(iter.max=100, tol=10^-6),
  em = list(iter.max=500, tol=10^-4),
  cg = list(iter.max=100, tol=10^5)
)

set.seed(100)
topics <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 15) ##set k equals to 2 3 4 5 6 7 8 9 10 15.
seed <- 2
D <- 54 # 54
folding <-sample(rep(seq_len(10), ceiling(D))[seq_len(D)])
table(folding)

perp_by_col <- vector()
for (k in topics) {
  perp_by_row <- vector()
  for (chain in seq_len(10)) {
    training <- CTM(dtmss[folding != chain,], k = k,
                    control = control_CTM_VEM)
    testing <- CTM(dtmss[folding == chain,], model = training,
                   control = control_CTM_VEM)
    perp_by_row <- rbind(perp_by_row,perplexity(testing))
  }
  perp_by_col <- cbind(perp_by_col,perp_by_row)
}

## Plot the perplexity

transpose <- t(perp_by_col)
matplot(transpose, type = "l", col = rainbow(9), lty = 2, lwd = 2, ylab = "Perplexity", xlab = "K", main = "CTM - 10-fold cross validation", xaxt="n")
axis(1, at=1:10, labels = c("k=2", "k=3", "k=4", "k=5", "k=6", "k=7", "k=8", "k=9", "k=10", "k=15"), cex=0.5)

perp_by_col_mean <- colMeans(perp_by_col)

lines(perp_by_col_mean, col="black", lwd=4, lty=1)
led <- c("fold=2", "fold=3", "fold=4", "fold=5", "fold=6", "fold=7", "fold=8", "fold=9", "fold=10", "Average")
legend("topright", led, lwd=2, lty=2, col=c(rainbow(9), 'black'), cex=0.65)
abline(v = 4, col = "gray60", lty=2)
abline(v = 5, col = "gray60", lty=2)

dev.new()
plot(perp_by_col_mean, pch=20, ylab='Perplexity', xlab="K", main="CTM - 10-fold cross validation", xaxt="n") 
axis(1, at=1:10, labels=c("k=2","k=3","k=4","k=5","k=6","k=7","k=8","k=9","k=10","k=15"), cex=0.5)
lines(perp_by_col_mean, lwd=1, lty=2, col="red")

### Sentiment analysis

setwd("~/Desktop/letters txt")

cname <- file.path("~", "Desktop", "letters txt")   
cname 

dir(cname)

docs <- Corpus(DirSource(cname))
filenames <- list.files(getwd(),pattern="*.txt",full.names=TRUE)



####################### finding out who is missing from data that Kuheli sent

setwd("~/Desktop/clean txt")

cname <- file.path("~", "Desktop", "clean txt")   
cname 

dir(cname)

docs <- Corpus(DirSource(cname))
filenames <- list.files(getwd(),pattern="*.txt",full.names=FALSE)

fil <- as.data.frame(filenames)
# Drop .txt from particpant ID
t <- gsub(".txt", "", filenames)
t <- as.data.frame(t)

t$t <- as.character(t$t)
head(t)
class(t$t)

Gender <- read.csv("26Oct2014 Normlzd VALU database.csv")
Gender$S..No
# Add first zeros to Gender serial numbers to make full five digits
library(stringr)
Gender$S..No <- str_pad(Gender$S..No, width=5, side="left", pad="0")
Gender$S..No
class(Gender$S..No)
nrow(subset(Gender, Appl.Gend == "Male"))
nrow(subset(Gender, Appl.Gend == "Female"))
nrow(subset(Gender, Ref.Gend == "Male"))
nrow(subset(Gender, Ref.Gend == "Female"))

var1 <- as.vector(t$t)
var2 <- as.vector(Gender$S..No)
matched <- intersect(var1, var2)
all <-  union(var1, var2)
non.matched <- all[!all %in% matched]
non.matched

non.matched <- as.data.frame(non.matched)
non.matched$non.matched <- as.character(non.matched$non.matched)

non.matched$non.matched



write.csv(non.matched,file=paste("Missing.Letters.csv"))

#######################

################################ to do a sentiment analysis

#  modify text to fit with tidytext package
library(dplyr)
library(tidytext)
dtm <- DocumentTermMatrix(docs) 
dtm

### how can i do the analysis by sentences?

# analysis by word
Let_td <- tidy(dtm)
Let_sentiments <- Let_td %>%
  inner_join(get_sentiments("bing"), by = c(term = "word")) # need to look at sentences, not words

Let_sentiments

# sentiment by doc
library(tidyr)

sents <- Let_sentiments %>%
  count(document, sentiment, wt = count) %>%
  ungroup() %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  arrange(sentiment)

class(sents)

Tops <- as.data.frame(sents)

head(Tops)

# read in gender data
Gender <- read.csv("26Oct2014 Normlzd VALU database.csv")
Gender$S..No


# rename columns in docs.topic
detach(package:dplyr)
library(plyr)

# Drop .txt from particpant ID
t <- gsub(".txt", "", Tops$document)
Tops$document <- t
Tops$document
class(Tops$document)

# Add first zeros to Gender serial numbers to make full five digits
library(stringr)
Gender$S..No <- str_pad(Gender$S..No, width=5, side="left", pad="0")
Gender$S..No
class(Gender$S..No)

# adding gender to docs.topic
Gen <- Gender$Appl.Gend
names(Gen) <- Gender$S..No
Tops$Gender <- Gen[as.character(Tops$document)]
head(Tops) 
Tops

tapply(Tops$sentiment , Tops$Gender, mean) 

# Compute the analysis of variance
res.aov <- aov(sentiment ~ Gender, data = Tops)
# Summary of the analysis
summary(res.aov)

######################################################

