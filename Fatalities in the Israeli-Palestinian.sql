SELECT *
FROM Project.dbo.fatalities_isr_pse

----Citizenship Distribution of Fatalities
SELECT COUNT(*) as number_of_death,YEAR(date_of_event) as year ,citizenship
FROM Project.dbo.fatalities_isr_pse  
GROUP BY date_of_event ,citizenship
ORDER BY date_of_event

----Palestinian and Israeli deaths are in the Conflict
SELECT COUNT(*) as number_of_death,citizenship 
FROM Project.dbo.fatalities_isr_pse  
GROUP BY citizenship 

----find out how many males and females
SELECT gender , count(*) as number_of_death ,(count(*)*100 /(select count(*) from Project.dbo.fatalities_isr_pse  where gender ='m'or gender='f')) as pourcentage
FROM Project.dbo.fatalities_isr_pse
where gender ='m'or gender='f'
group by gender

----find out how many deaths occurred in each event_location
SELECT COUNT(*) as total_people_killed, event_location_district,YEAR(date_of_event) as year
FROM Project.dbo.fatalities_isr_pse  
GROUP BY event_location_district,date_of_event
ORDER BY date_of_event 

----the distribution based on whether individuals took part in hostilities
SELECT COUNT(*) as number_of_fatalities, took_part_in_the_hostilities , citizenship, YEAR(date_of_death) as year
FROM Project.dbo.fatalities_isr_pse  
where took_part_in_the_hostilities is not null
GROUP BY took_part_in_the_hostilities, citizenship, date_of_death
ORDER BY date_of_death

----find out the types of injuries that led to deaths for both Palestinians and Israelis
SELECT COUNT(*) as count, type_of_injury , citizenship
FROM Project.dbo.fatalities_isr_pse  
GROUP BY type_of_injury, citizenship
ORDER BY count

----find out which groups were responsible for the deaths of Palestinians and Israelis
SELECT COUNT(*) as count, killed_by,YEAR(date_of_event) as year
FROM Project.dbo.fatalities_isr_pse  
GROUP BY killed_by, date_of_event
ORDER BY date_of_event
----distribution of fatalities based on age groups
SELECT 
CASE 
WHEN age <18  THEN 'children'
WHEN age >=18 and age<20 THEN 'teenagers'
WHEN age >=19 and age<25 THEN 'young adults'
WHEN age >=25 and age<60 THEN 'adults'
WHEN age >= 60 THEN 'elderly' ELSE 'unknown' END AS age_group,COUNT(*)  as death_count
FROM Project.dbo.fatalities_isr_pse  
where age is not null
GROUP BY CASE 
WHEN age <18  THEN 'children'
WHEN age >=18 and age<20 THEN 'teenagers'
WHEN age >=19 and age<25 THEN 'young adults'
WHEN age >=25 and age<60 THEN 'adults'
WHEN age >= 60 THEN 'elderly' ELSE 'unknown' END
ORDER BY MIN(age) ;
