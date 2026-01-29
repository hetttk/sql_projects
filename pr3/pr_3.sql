
create table departments (
    departmentid int primary key,
    departmentname varchar(100)
);

create table students (
    studentid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    birthdate date,
    enrollmentdate date
);

create table courses (
    courseid int primary key,
    coursename varchar(100),
    departmentid int,
    credits int,
    foreign key (departmentid) references departments(departmentid)
);

create table instructors (
    instructorid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    departmentid int,
    foreign key (departmentid) references departments(departmentid)
);

create table enrollments (
    enrollmentid int primary key,
    studentid int,
    courseid int,
    enrollmentdate date,
    foreign key (studentid) references students(studentid),
    foreign key (courseid) references courses(courseid)
);


-- insert data


insert into departments values
(1, 'computer science'),
(2, 'mathematics');

insert into students values
(1, 'john', 'doe', 'john@gmail.com', '2000-01-15', '2022-08-01'),
(2, 'jane', 'smith', 'jane@gmail.com', '1999-05-25', '2021-08-01'),
(3, 'rahul', 'sharma', 'rahul@gmail.com', '2001-03-10', '2022-07-10'),
(4, 'amit', 'verma', 'amit@gmail.com', '2000-11-20', '2022-08-02'),
(5, 'priya', 'singh', 'priya@gmail.com', '2001-02-12', '2023-01-10'),
(6, 'neha', 'patel', 'neha@gmail.com', '2000-09-18', '2022-08-01'),
(7, 'rohit', 'mehta', 'rohit@gmail.com', '1999-12-30', '2021-08-01'),
(8, 'karan', 'malhotra', 'karan@gmail.com', '2002-06-21', '2022-08-01');

insert into courses values
(101, 'introduction to sql', 1, 3),
(102, 'data structures', 1, 4),
(103, 'calculus', 2, 4),
(104, 'linear algebra', 2, 3);

insert into instructors values
(1, 'alice', 'johnson', 'alice@univ.com', 1),
(2, 'bob', 'lee', 'bob@univ.com', 2);

insert into enrollments values
(1, 1, 101, '2022-08-01'),
(2, 2, 101, '2021-08-01'),
(3, 3, 101, '2022-08-01'),
(4, 4, 101, '2022-08-01'),
(5, 5, 101, '2023-01-10'),
(6, 6, 101, '2022-08-01'),
(7, 7, 101, '2021-08-01'),
(8, 1, 102, '2022-08-01'),
(9, 3, 102, '2022-08-01'),
(10, 2, 103, '2021-08-01'),
(11, 6, 104, '2022-08-01'),
(12, 8, 104, '2022-08-01');


--Queries too be performed

-- 1. crud example (insert)
insert into students values (9, 'test', 'user', 'test@gmail.com', '2000-01-01', '2024-01-01');

-- 2. students enrolled after 2022
select * from students
where enrollmentdate > '2022-01-01';

-- 3. mathematics courses (limit 5)
select * from courses
where departmentid = 2
limit 5;

-- 4. courses with more than 5 students
select courseid, count(studentid) as total_students
from enrollments
group by courseid
having count(studentid) > 5;

-- 5. students enrolled in both sql and data structures
select s.studentid, s.firstname
from students s
join enrollments e1 on s.studentid = e1.studentid and e1.courseid = 101
join enrollments e2 on s.studentid = e2.studentid and e2.courseid = 102;

-- 6. students enrolled in either sql or data structures
select distinct s.studentid, s.firstname
from students s
join enrollments e on s.studentid = e.studentid
where e.courseid in (101, 102);

-- 7. average credits
select avg(credits) as average_credits from courses;

-- 8. max instructor id (as salary substitute)
select max(instructorid) from instructors
where departmentid = 1;

-- 9. count students per department
select c.departmentid, count(e.studentid) as total_students
from courses c
join enrollments e on c.courseid = e.courseid
group by c.departmentid;

-- 10. inner join students and courses
select s.firstname, c.coursename
from students s
inner join enrollments e on s.studentid = e.studentid
inner join courses c on e.courseid = c.courseid;

-- 11. left join students and courses
select s.firstname, c.coursename
from students s
left join enrollments e on s.studentid = e.studentid
left join courses c on e.courseid = c.courseid;

-- 12. subquery (courses with more than 10 students)
select * from students
where studentid in (
    select studentid from enrollments
    group by courseid
    having count(studentid) > 10
);

-- 13. extract year from enrollmentdate
select studentid, year(enrollmentdate) as enroll_year
from students;

-- 14. concatenate instructor name
select concat(firstname, ' ', lastname) as fullname
from instructors;

-- 15. total students per course
select courseid, count(studentid) as total_students
from enrollments
group by courseid;

-- 16. senior / junior students
select s.studentid, s.firstname, e.enrollmentdate,
case
    when e.enrollmentdate < date_sub(curdate(), interval 4 year) then 'senior'
    else 'junior'
end as status
from students s
join enrollments e on s.studentid = e.studentid;
