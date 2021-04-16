#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(sigmoid)

ui <- fluidPage(
    theme = bslib::bs_theme(bootswatch = "united"),
    # Application title
    titlePanel("Passenger Satisfaction Calculator Demo"),
    fluidRow(
        column(5, offset=1,
               sliderInput('flightdist', label='Flight Distance', 
                           min=0, max=5000, value=2500,  step=100, width="100%")
        ),
        column(2, offset=0,
               sliderInput('depdelay', label='Departure Delay in Minutes', 
                           min=1, max=25, value=12, step=1, width="100%")
        ),
        column(2, offset=0,
            sliderInput('arrivaldelay', label='Arrival Delay in Minutes',
                    min=1, max=25, value=12, step=1, width="100%"
                        )
               )
    ),
    
    fluidRow(
        column(2, offset = 2,
               selectInput('gender', 'Gender', c("Male" = 0, "Female" = 1)),
               selectInput('ctype', 'Customer Type', c("Loyal" = 1, "Not Loyal" = 0)),
               selectInput('ttype', 'Travel Type', c("Personal" = 1, "Business" = 0)),
               selectInput('class', 'Class', c("Business" = 1, "Eco Plus" = 0, "Economy" = 1)),
               numericInput('age', 'Age', 25, 0, 100, 1)
               
               ),
        
        column(2, offset = 2,
               radioButtons('wifi', 'Inflight WiFi', c(1,2,3,4,5), inline=TRUE), 
               radioButtons('arrival', 'Convenience of Arrival Time', c(1,2,3,4,5), inline=TRUE),
               radioButtons('onlinebook', 'Ease of Online Booking', c(1,2,3,4,5), inline=TRUE),
               radioButtons('gateloc', 'Gate Location', c(1,2,3,4,5), inline=TRUE),
               radioButtons('onboardservice', 'On-Board Service', c(1,2,3,4,5), inline=TRUE)
        ),
        
        column(1, offset=0,
               numericInput('food', 'Food and Drink', 3, 1, 5, 1),
               numericInput('onlineboard', 'Online Boarding', 3, 1, 5, 1),
               numericInput('seatcomfy', 'Seat Comfort', 3, 1, 5, 1),
               numericInput('inflightent', 'Inflight Entertainment', 3, 1, 5, 1),
               numericInput('legroomservice', 'Leg-Room Service',3, 1, 5, 1)
        ),
        column(1, offset=0,
               numericInput('bag', 'Baggage Service', 3, 1, 5, 1),
               numericInput('checkin', 'Check-In Service',3, 1, 5, 1),
               numericInput('inflightservice', "In-Flight Service", 3, 1, 5, 1),
               numericInput('cleanliness', 'Cleanliness',3, 1, 5, 1)
         
        )
        
    ),
    mainPanel(width = 8, style = "margin-top: 100px; left:37%; font-size: 30px;",
        textOutput("pred_var")
    )
   
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
    prob <- reactive( 
        input$cleanliness + 
            as.numeric(input$ctype)*-2.048e+00  + 
            as.numeric(input$ttype)*3.041e+00  +
            as.numeric(input$class)*-1.941e-01 + 
            as.numeric(input$age)*-7.601e-03 +
            as.numeric(input$gender)*-5.315e-02+
            as.numeric(input$wifi)*3.490e-01 + 
            as.numeric(input$arrival)*-1.251e-01  + 
            as.numeric(input$onlinebook)*-1.291e-01  + 
            as.numeric(input$gateloc)*2.851e-02 + 
            as.numeric(input$onboardservice)*3.247e-01  + 
            input$food*-2.158e-02  +
            input$onlineboard*6.418e-01 +
            input$seatcomfy*8.537e-02 +
            input$inflightent*3.371e-02 +
            input$bag*1.546e-01  +
            input$checkin*3.391e-01  +
            input$inflightservice*1.438e-01 +
            input$cleanliness*2.217e-01 +
            input$legroomservice*2.594e-01 +
            input$arrivaldelay*-9.669e-03  +
            input$depdelay*4.917e-03 +
            input$flightdist*8.388e-05+
            -1.004e+01
        )
    
    
    output$pred_var <- renderText(paste('Probability of Satisfaction: ', sigmoid(prob())))

   
    
}

# Run the application 
shinyApp(ui = ui, server = server)
