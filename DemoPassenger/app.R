#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(

    # Application title
    titlePanel("Passenger Satisfaction Calculator Demo"),
    fluidRow(
        column(5, offset=1,
               sliderInput('flightdist', label='Flight Distance', 
                           min=0, max=5000, value=2500,  step=100, width="100%")
        ), 
        column(5, offset=0,
            sliderInput('arrivaldelay', label='Arrival Delay in Minutes',
                    min=1, max=25, value=12, step=1, width="100%"
                        )
               )
    ),
    
    fluidRow(
        column(2, offset = 1,
               selectInput('gender', 'Gender', c("Male", "Female")),
               selectInput('ctype', 'Customer Type', c("Mail", "Female")),
               selectInput('ttype', 'Travel Type', c("Personal", "Business")),
               selectInput('class', 'Class', c("Business", "Eco Plus", "Economy")),
        ),
        
        column(2, offset = 3,
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
               numericInput('cleanliness', 'Cleanliness',3, 1, 5, 1),
               numericInput('depdelay', 'Leg-Room Service',3, 1, 5, 1)
        )
        
    ),
    
    mainPanel(
        textOutput("pred_var")
    )
   
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$pred_var <- renderText({
        paste("Selected", input$gender)
    })
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
