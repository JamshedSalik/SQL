/*CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');*/

-- Wriet an SQL query to get the list of student who scored above the marks in each subject.


with cte as(
Select subject,avg(marks) avg_marks 
from students group by subject
)
Select students.*
from cte 
join students 
on cte.subject = students.subject and students.marks > cte.avg_marks;


-- Write an SQL query to get the percentage of students who score more than 90 in any subject amongst the total students.


Select  CAST(Count(distinct case when marks > 90 then studentid  else null end)*1.0/count(distinct studentid)  * 100 as decimal(5,2)) as Student_percent
from students





-- Write an sql query to get the second highest and second -lowest marks for each student
/*
Subject      Second_highest_marks  Second_lowest_marks
Subject1		91						63
Subject2		71						60
Subject3		29						68
*/

with cte as(
Select  *,
		Rank() over(partition by subject order by Marks desc) as maximum_marks
		
from students),
cte2 as(
Select  *,
		Rank() over(partition by subject order by Marks asc) as minimum_marks	
from students)

	Select cte.subject,cte.marks as second_highest_marks, cte2.marks as second_minimum_marks
	from cte 
	join cte2
	on cte.subject = cte2.subject
	where cte.maximum_marks = 2 and  cte2.minimum_marks=2;


-- For each student and test, Identify if their marks increase or decreased from the pervious test
Select *
from students
order by 1


Select *,case when marks > pervious_marks then 'inc' 
			  when pervious_marks > marks then 'dec' 
			  else 'Nothing' end as Stats
from(
Select *,lag(Marks) over(Partition by studentid order by testid ) as pervious_marks
from students)a



----------------------------------------------------------------------------------------------

Select *,case when marks > 
from students
order by 1,5




