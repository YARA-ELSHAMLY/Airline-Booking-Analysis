USE [Air Booking];
GO

-- Booking Trends
-- 1.1
SELECT 
    sales_channel, 
    COUNT(*) AS booking_count
FROM [dbo].[Sheet1$]
GROUP BY [sales_channel]
ORDER BY booking_count DESC;

--1.2
SELECT 
    sales_channel, 
    booking,
    COUNT(*) AS count_bookings
FROM [dbo].[Sheet1$]
GROUP BY sales_channel, booking
ORDER BY sales_channel, booking;

--Customer Behavior
--2.1
SELECT
    SUM(CASE WHEN wants_extra_baggage = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS extra_baggage_pct,
    SUM(CASE WHEN wants_preferred_seat = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS preferred_seat_pct,
    SUM(CASE WHEN wants_in_flight_meals = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS meals_pct
FROM [dbo].[Sheet1$];

--2.2
SELECT 
    trip_duration_category,
    COUNT(*) AS trip_count
FROM [dbo].[Sheet1$]
GROUP BY trip_duration_category
ORDER BY trip_count DESC;

--Timing Analysis
--3.1
SELECT 
    AVG(purchase_lead) AS avg_purchase_lead
FROM [dbo].[Sheet1$];

--3.2
SELECT 
    flight_day,
    COUNT(*) AS flights_count
FROM [dbo].[Sheet1$]
GROUP BY flight_day
ORDER BY flights_count DESC;

--3.3
SELECT 
    flight_hour,
    COUNT(*) AS flights_count
FROM [dbo].[Sheet1$]
GROUP BY flight_hour
ORDER BY flights_count DESC;


--Geographic Analysis
--4.1
SELECT 
    booking_origin,
    COUNT(*) AS booking_count
FROM [dbo].[Sheet1$]
GROUP BY booking_origin
ORDER BY booking_count DESC;

--4.2
SELECT 
    booking_origin,
    AVG(flight_duration) AS avg_flight_duration
FROM [dbo].[Sheet1$]
GROUP BY booking_origin
ORDER BY avg_flight_duration DESC;


--Performance Metrics
--5.1
SELECT 
    AVG(num_passengers) AS avg_passengers
FROM [dbo].[Sheet1$];

--5.2
SELECT 
    trip_duration_category,
    AVG(flight_duration) AS avg_flight_duration
FROM [dbo].[Sheet1$]
GROUP BY trip_duration_category
ORDER BY 
    CASE trip_duration_category
        WHEN 'Short' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Long' THEN 3
    END;

--6
SELECT 
    booking_origin,
    SUM(CASE WHEN booking = 'Non Complete' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS non_complete_pct
FROM [dbo].[Sheet1$]
GROUP BY booking_origin
ORDER BY non_complete_pct DESC;

--7
SELECT 
    flight_day,
    AVG(flight_duration) AS avg_duration
FROM [dbo].[Sheet1$]
GROUP BY flight_day
ORDER BY avg_duration DESC;

--8
SELECT 
    flight_day,
    COUNT(*) AS booking_count
FROM [dbo].[Sheet1$]
GROUP BY flight_day
ORDER BY booking_count DESC;

--9
SELECT 
    trip_duration_category,
    AVG(purchase_lead) AS avg_purchase_lead
FROM [dbo].[Sheet1$]
GROUP BY trip_duration_category
ORDER BY avg_purchase_lead DESC;

--10
SELECT 
    day_period,
    trip_duration_category,
    COUNT(*) AS count_flights
FROM [dbo].[Sheet1$]
GROUP BY day_period, trip_duration_category
ORDER BY count_flights DESC;

--11
SELECT 
    booking_origin,
    SUM(num_passengers) AS total_passengers
FROM [dbo].[Sheet1$]
GROUP BY booking_origin
ORDER BY total_passengers DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--------------------------------------------------------

--1. Compare flights on the same day and time period
SELECT 
    a.flight_day,
    a.day_period,
    COUNT(*) AS matching_flights
FROM [dbo].[Sheet1$] a
JOIN [dbo].[Sheet1$] b
    ON a.flight_day = b.flight_day
   AND a.day_period = b.day_period
   AND a.booking_id <> b.booking_id
GROUP BY a.flight_day, a.day_period;

-------------------------------------------------------

















