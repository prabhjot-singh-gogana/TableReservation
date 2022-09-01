# Mobile App Dev Guide

## Building


*developed this **Table Reservation** App in 5 screens.*

1. Reservation List - This is the root screen where all the reservation will get saved and shown in tableview which binds with shared reservation model. After clicking on + button Select Time screen gets pushed. 
2. Select Time - This screen shows the time from 3 PM till 10 PM with 15 minutes interval. Also tells the time available or not. Following validations are applied
    1. Only available time can be selected. 
    2. It should available for an Hour at least.
3. Select Party Size - This screens has static 5 party size afte selecting this party sizes screen will move tp Guest Detail screen.
4. Guest Details - This screen is form to fill the guest details like guest name, guest phone no and notes. All text fields are binds with the view models relay or observable objects. Saving the reservation object stores the value in share object and screen returns to Reservation screen with data. Following validations are applied.-
    1. Formatting the phone number.
    2. Phone number and guest name should not be empty.
    3. guest name can fill upto 100 characters
    4. phone no. can fill upto 10 characters.
5. Reservation Details- It just simply shows the details of reservation


## Testing

*Developed 2 unit test cases*
1. test15MinDateInterval - In this test case check the dates or times returning from start date to endDate with 15 minutes interval
2. testAvailabilities - In this test case available times and non available times. Also checks if single time is available or has available for an Hour at least or not available

## Known issues

1. No UIUnitTest cases due to lack of time.
