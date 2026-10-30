CREATE DATABASE Ola;
USE Ola;


-- 1.  Retrieve all successful bookings
SELECT * FROM bookings
WHERE Booking_Status="Success";

-- 2.Find the avearge ride distance for each vehicle type 

SELECT Vehicle_Type, avg(Ride_Distance) as Average_Ride_Distance
FROM bookings
Group By Vehicle_Type;

-- 3. Get the total number of canceled rides by customers
SELECT COUNT(*) AS Total_Canceled_Rides
FROM bookings
WHERE Booking_Status= 'Canceled by Customer';

-- 4.List the top 5 customers who booked the highest number of rides
SELECT Customer_ID, COUNT(Booking_ID) as total_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC LIMIT 5;
-- 5.Get the number of rides canceled by Drivers due to personal and car-related issues
SELECT COUNT(*) AS rides_canceled
FROM bookings
WHERE Canceled_Rides_by_Driver = "Personal & car related issue";

-- 6. Find the maximum and minimum driver ratings for prime sedan bookings
SELECT MAX(Driver_Ratings) AS MAXIMUM_Rating,MIN(Driver_Ratings) AS MINIMUM_Rating
FROM bookings
WHERE Vehicle_Type = "prime Sedan";

-- 7. Retrieve all rides where payment was made using UPI
 SELECT * FROM bookings 
  WHERE Payment_Method="UPI";
 
 -- 8. Find the average customer rating per vehicle type
 SELECT Vehicle_Type, AVG(Customer_Rating) as Avg_Customer_Rating
 FROM bookings
 GROUP BY Vehicle_Type;
 -- 9. Calculate the total booking value of rides completed successfully
 SELECT SUM(Booking_Value) AS Total_booking_value
 FROM bookings
 WHERE Booking_Status="Success";
 
 -- 10. List all incomplete rides along with the reason
 SELECT Booking_ID, Incomplete_Rides_Reason
 FROM bookings
 WHERE Incomplete_Rides="YES";

