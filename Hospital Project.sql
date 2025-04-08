drop table if  exists Hospitals;


create  table Hospitals(
Hospital_Name	varchar(100),
Location	varchar(50),
Department	varchar(50),
Doctors_Count int,
Patients_Count int,
Admission_Date date,
Discharge_Date date,
Medical_Expenses numeric(10,2)

);

select *from Hospitals ;

-- Q 1.  Total Number  of  Patients 
        -- Write an SQl queary to find  the  total number of  patients across all hospital.

  select  sum(Patients_Count) as total_no_of_patient
  from Hospitals;	

-- Q 2. Average Number Of Doctors Per Hospital 
     --  Retrive the average count of doctors available in each hospital.

select Hospital_Name , avg(Doctors_Count) as  avg_dr_each_hospital
from Hospitals 
group by  Hospital_Name;


 --3. Top 3 Departments with the Highest Number of Patients
     -- Find the top 3 hospital departments that have the highest number of patients.
 select Department  , sum(Patients_Count ) as  top_Patients_dapartment 
 from Hospitals
 group by Department  
 order by top_Patients_dapartment desc  limit 3 ;

--4. Hospital with the Maximum Medical Expenses
   -- Identify the hospital that recorded the highest medical expenses.

select  Hospital_Name , sum (Medical_Expenses) as  highest_medical_expenses
from  Hospitals 
group  by Hospital_Name 
order by highest_medical_expenses desc limit 1;


--5. Daily Average Medical Expenses
  --  Calculate the average medical expenses per day for each hospital.

  
SELECT Hospital_Name, 
 sum (Medical_Expenses) as total_Medical_Expenses ,
 sum (Discharge_Date - Admission_Date) AS Total_Days ,
  round (
   sum (Medical_Expenses) /nullif (sum (Discharge_Date - Admission_Date),0),2) as per_day_avg_Medical_Expenses
   FROM Hospitals
   group by  Hospital_Name ;


-- 6. Longest Hospital Stay
   -- Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
   
  select  
    Hospital_Name,
    Location,
    Department,
    Admission_Date,
    Discharge_Date,(Discharge_Date :: Date - Admission_Date ::Date) as logest_stay_date
  from Hospitals  
  order by logest_stay_date desc limit 1 ;



-- 7. Total Patients Treated Per City
    -- Count the total number of patients treated in each city.

	select  Location as  City  , sum (Patients_Count) as total_Patients_per_city 
	from Hospitals 
	group by Location 
	order by total_Patients_per_city desc ;


-- 8. Average Length of Stay Per Department
   -- Calculate the average number of days patients spend in each department.

   select   Department , round (avg (Discharge_Date - Admission_Date ),2) as avg_length_of_stay_days
   from  Hospitals 
   group by Department 
   order  by avg_length_of_stay_days desc ;

-- 9. Identify the Department with the Lowest Number of Patients
 -- Find the department with the least number of patients.

   select Department , sum (Patients_Count ) as  lowest_no_Patients 
   from  Hospitals 
   group by Department 
   order by lowest_no_Patients asc limit 1 ;
   

 -- 10. Monthly Medical Expenses Report
 --  Group the data by month and calculate the total medical expenses for each month.
 
SELECT 
    TO_CHAR(Discharge_Date::date, 'Month') AS month_name,
    DATE_TRUNC('month', Discharge_Date::date) AS month_start,
    SUM(REPLACE(Medical_Expenses::TEXT, ',', '')::NUMERIC) AS total_medical_expenses
FROM Hospitals
GROUP BY month_name, month_start
ORDER BY month_start;





   


