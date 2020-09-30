## Best available seat locator

Best Available Seat
Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.
The list of open seats, number of rows and columns (seats) is based on a JSON input.
{
   "venue": {
       "layout": {
           "rows": 10,
           "columns": 50
       }
   },
   "seats": {
       "a1": {
           "id": "a1",
           "row": "a",
           "column": 1,
           "status": "AVAILABLE"
       },
       "b5": {
           "id": "b5",
           "row": "b",
           "column": 5,
           "status": "AVAILABLE"
       },
       "h7": {
           "id": "h7",
           "row": "h",
           "column": 7,
           "status": "AVAILABLE"
       }
   }
}
The solution should find the best open seat (closest to the front & middle) given the input JSON and number of requested seats. Imagine a concert, people want to be as close as possible to the stage.
For example, for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6.
If a group of seats is requested, the algorithm needs to find the best open group of seats together. In the example above, for 3 seats, it would be A5, A6, and A7.
For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.
Requirements
Start by a single seat request (not a group of seats together)
You should build a Rails app.




