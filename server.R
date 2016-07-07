library("dplyr")

### The following instructions will be executed just once, when runApp() is called

# Read the data: the first is the dataset with the fish catches values, the second 
# will be used to build the species table
dataset <- read.csv("data/fish_catches.csv")
legend <- read.csv(file="data/species.csv", sep = "\t")

# Get the fish species from the dataset
species <- unique(dataset$Species)

# create a new dataset excluding the columns we are not interested in
legend <- select(legend, X3A_CODE, English_name, Scientific_name)
names(legend) <- c("Species", "English name", "Scientific name")
dataset2 <- merge(x=dataset, y=legend, by.x = "Species")

# create the species table that will be displayed by the app
species_table <- data.frame(unique(dataset2$Species))
colnames(species_table) <- c("Species")
species_table <- merge(x=species_table, y = legend, by.x ="Species")
rm(dataset,legend)

# define the central function of the app: this function takes the species and the year
# selected by the user and, after a series of operations, returns the value of the 
# corrisponding fish catches

search_species <- function(inp_species, inp_year)
{
    if (inp_year == "14") y <- "X2014"
    else if (inp_year == "13") y <- "X2013"
    else if (inp_year == "12") y <- "X2012"
    else if (inp_year == "11") y <- "X2011"
    else if (inp_year == "10") y <- "X2010"
    else if (inp_year == "09") y <- "X2009"
    else if (inp_year == "08") y <- "X2008"
    else if (inp_year == "07") y <- "X2007"
    else if (inp_year == "06") y <- "X2006"
    
    
    # if no species is selected, calculate the sum of the catches of all species
    # for the selected year (the year is stored in the y variable)
    if (is.null(inp_species))  
    {
        s <- sum(dataset2[,y])
    }
    
    # else, build a temporary dataset containing just the selected species and 
    # calculate the sum
    else
    {
        species_name <- species_table[inp_species,1]
        prov_dataset <- filter(dataset2, Species == species_name)
        s <- sum(prov_dataset[,y])
    }
    
    
    # format the result and return it
    s <- format(s, big.mark = ",")
    s
}


# in the shinyServer() part we set the instructions to display the table and the result
# of the search_species() function
shinyServer(
    function(input, output) 
    {
        options(DT.options = list(pageLength = 15, bLengthChange = FALSE))
        output$x11 = DT::renderDataTable(species_table,server = FALSE, selection = 'single')
        
        output$ospecies <- renderText({search_species(input$x11_rows_selected, input$years)})
    }
)