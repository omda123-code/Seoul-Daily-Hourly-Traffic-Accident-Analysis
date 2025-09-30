use Seoul_Traffic_Accident
select * from Seoul_Accidents

-- 1️. What are the top 5 hours with the highest number of accidents?
-- Purpose: Identify rush hours with maximum accidents.

SELECT TOP 5 발생시간 AS Hour, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY 발생시간
ORDER BY Total_Accidents DESC;

-- 2️. Which districts (시군구) have the highest accident counts?
-- Purpose: Find the most dangerous districts in Seoul.

SELECT 발생지_시군구 AS District, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY 발생지_시군구
ORDER BY Total_Accidents DESC;

-- 3️. What is the trend of accidents per year?
-- Purpose: Understand whether accidents are increasing or decreasing.

SELECT YEAR(발생일) AS Year, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY YEAR(발생일)
ORDER BY Year;

-- 4️. Which neighborhoods (법정동명) report the most accidents?
-- Purpose: Detect high-risk small areas.

SELECT TOP 10 법정동명 AS Neighborhood, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY 법정동명
ORDER BY Total_Accidents DESC;

-- 5️. What is the average number of fatalities per accident?
-- Purpose: Measure accident severity.

SELECT 
    CAST(SUM(사망자수) AS FLOAT) / NULLIF(SUM(사고건수),0) AS Avg_Fatalities_Per_Accident
FROM Seoul_Accidents;

-- 6️. At which hour do most fatal accidents occur?
-- Purpose: Identify deadly hours for accidents.

SELECT 발생시간 AS Hour, SUM(사망자수) AS Total_Fatalities
FROM Seoul_Accidents
GROUP BY 발생시간
ORDER BY Total_Fatalities DESC;

-- 7️. Which district has the highest number of serious injuries (중상자수)?
-- Purpose: Assess accident severity geographically.

SELECT TOP 5 발생지_시군구 AS District, SUM(중상자수) AS Serious_Injuries
FROM Seoul_Accidents
GROUP BY 발생지_시군구
ORDER BY Serious_Injuries DESC;

-- 8️. What is the ratio of fatalities to total accidents per district?
-- Purpose: Compare accident severity across districts.

SELECT 발생지_시군구 AS District,
       SUM(사망자수) AS Total_Fatalities,
       SUM(사고건수) AS Total_Accidents,
       CAST(SUM(사망자수) AS FLOAT) / NULLIF(SUM(사고건수),0) AS Fatality_Ratio
FROM Seoul_Accidents
GROUP BY 발생지_시군구
ORDER BY Fatality_Ratio DESC;

-- 9️⃣ What are the top 10 days with the highest accident counts?
-- Purpose: Spot unusual spikes in accidents.

SELECT TOP 10 발생일 AS Accident_Date, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY 발생일
ORDER BY Total_Accidents DESC;

-- 10. Compare accidents between weekdays and weekends.
-- Purpose: Understand behavior differences in driving patterns.

SELECT 
    DATENAME(WEEKDAY, 발생일) AS Weekday,
    SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY DATENAME(WEEKDAY, 발생일)
ORDER BY Total_Accidents DESC;

-- 1️0. Which month records the highest number of accidents?
-- Purpose: Detect seasonal effects.

SELECT MONTH(발생일) AS Month, SUM(사고건수) AS Total_Accidents
FROM Seoul_Accidents
GROUP BY MONTH(발생일)
ORDER BY Total_Accidents DESC;

-- 1️2. What is the average number of minor injuries (경상자수) per accident by district?
-- Purpose: Find districts with higher minor-injury ratios.

SELECT 발생지_시군구 AS District,
       CAST(SUM(경상자수) AS FLOAT) / NULLIF(SUM(사고건수),0) AS Avg_Minor_Injuries_Per_Accident
FROM Seoul_Accidents
GROUP BY 발생지_시군구
ORDER BY Avg_Minor_Injuries_Per_Accident DESC;

-- 1️3. Which districts report the most “reported injuries” (부상신고자수)?
-- Purpose: Show where accident reporting is more frequent.

SELECT 발생지_시군구 AS District, SUM(부상신고자수) AS Reported_Injuries
FROM Seoul_Accidents
GROUP BY 발생지_시군구
ORDER BY Reported_Injuries DESC;

-- 1️4.What is the total number of casualties (fatalities + injuries) per year?
-- Purpose: Understand accident impact on people over time.

SELECT YEAR(발생일) AS Year,
       SUM(사망자수 + 중상자수 + 경상자수 + 부상신고자수) AS Total_Casualties
FROM Seoul_Accidents
GROUP BY YEAR(발생일)
ORDER BY Year;

-- 1️5. Which hour of the day has the highest casualty severity ratio (casualties ÷ accidents)?
-- Purpose: Identify dangerous hours beyond accident frequency.

SELECT 발생시간 AS Hour,
       CAST(SUM(사망자수 + 중상자수 + 경상자수 + 부상신고자수) AS FLOAT) / NULLIF(SUM(사고건수),0) AS Casualty_Severity_Ratio
FROM Seoul_Accidents
GROUP BY 발생시간
ORDER BY Casualty_Severity_Ratio DESC;



