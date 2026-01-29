
---creating and inserting


CREATE TABLE PATIENTS(
patient_id int  primary key,
patient_name varchar(50),
dob date,
gender varchar(10),
phone_number varchar(15),
email varchar(50),
address varchar(50),
registration_date date);

CREATE TABLE DOCTORS(
doctor_id int  primary key auto_increment,
doctor_name varchar(50),
specialization varchar(50),
phone_number varchar(15),
email varchar(100),
available_days varchar(16),
consultaion_fee decimal(10,2)
);


CREATE TABLE APPOINTMENTS (
    appointment_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    appointment_date datetime,
    status varchar(20),
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
);
show tables;
CREATE TABLE MEDICAL_RECORDS (
    record_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    diagnosis varchar(255),
    prescription varchar(255),
    treatment_date date,
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
);


CREATE TABLE BILLING(
    invoice_id int primary key auto_increment,
    patient_id int,
    appointment_id int,
    amount decimal(10,2),
    payment_status varchar(20),
    payment_date date,
    foreign key (patient_id) references patients(patient_id),
    foreign key (appointment_id) references appointments(appointment_id)
);

CREATE TABLE DEPARTMENTS (
    department_id int primary key auto_increment,
    department_name varchar(100)
);


CREATE TABLE DOCTOR_DEPARTMENT (
    doctor_id int,
    department_id int,
    primary key (doctor_id, department_id),
    foreign key (doctor_id) references doctors(doctor_id),
    foreign key (department_id) references departments(department_id)
);

insert into patients (patient_name, dob, gender, phone_number, email, address, registration_date)
values
('rahul sharma', '2002-05-10', 'male', '9876543210', 'rahul@gmail.com', 'delhi', '2024-02-10'),
('priya singh', '2000-08-15', 'female', '9876543222', 'priya@gmail.com', 'mumbai', '2023-11-20'),
('amit verma', '1998-12-01', 'male', '9876543333', 'amit@gmail.com', 'pune', '2024-06-05'),
('neha gupta', '2001-03-22', 'female', '9876543444', 'neha@gmail.com', 'jaipur', '2025-01-12'),
('rohit jamal', '1999-07-18', 'male', '9876543555', 'rohit@gmail.com', 'bhopal', '2023-09-30');

insert into doctors (doctor_name, specialization, phone_number, email, available_days, consultaion_fee) 
values
('dr mehta', 'cardiology', '9123000001', 'mehta@gmail.com', 'mon-fri', 1500),
('dr roy', 'neurology', '9123000002', 'roy@gmail.com', 'tue-sat', 1800),
('dr patel', 'orthopedics', '9123000003', 'patel@gmail.com', 'mon-thu', 1200),
('dr khan', 'dermatology', '9123000004', 'khan@gmail.com', 'wed-sun', 1000),
('dr james', 'general', '9123000005', 'oksn@gmail.com', 'mon-sat', 800);

insert into departments (department_name)
values
('cardiology'),
('neurology'),
('orthopedics'),
('dermatology'),
('general');

insert into doctor_department (doctor_id, department_id)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

insert into appointments (patient_id, doctor_id, appointment_date, status)
values
(1, 1, '2025-01-10 10:00:00', 'completed'),
(2, 2, '2025-02-15 11:00:00', 'completed'),
(3, 3, '2025-03-20 12:00:00', 'scheduled'),
(4, 4, '2024-06-10 09:30:00', 'cancelled'),
(5, 5, '2025-01-25 01:00:00', 'completed');

insert into medical_records (patient_id, doctor_id, diagnosis, prescription, treatment_date) 
values
(1, 1, 'heart pain', 'tablet a', '2025-01-10'),
(2, 2, 'migraine', 'balm', '2025-02-15'),
(3, 3, 'fracture', 'calcium tablets', '2025-03-20'),
(4, 4, 'skin allergy', 'gc', '2024-06-10'),
(5, 5, 'fever', 'paracetamol', '2025-01-25');

insert into billing (patient_id, appointment_id, amount, payment_status, payment_date)
values
(1, 1, 1500, 'paid', '2025-01-10'),
(2, 2, 1800, 'paid', '2025-02-15'),
(3, 3, 1200, 'pending', null),
(4, 4, 1000, 'cancelled', null),
(5, 5, 800, 'paid', '2025-01-25');

------crud

update patients
set address ='surat'
where patient_id = 3;


delete from appointments
where status = 'cancelled'
and appointment_date < '2025-07-29';


---clauses
select * from patients where registration_date >= '2025-01-01';

select patient_id,sum(amount) as t_payment
from billing
group by patient_id 
order by t_payment desc
limit 5;

select * from doctors where consultaion_fee>1000;

----- and or not
select *
from appointments
where status = 'scheduled'
and doctor_id =3;

select * from doctors where specialization = 'cardiology' or 'neurology';

select distinct patient_id from appointments where appointment_date  >= '2025-01-01';

----sorting

select * from doctors order by specialization;

select doctor_id,count(patient_id) as total_patients
from appointments
group by doctor_id;

select department_name, sum(amount) as total_revenue
from departments d, billing b
group by department_name;

-----agg functions
select  sum(amount) as t_r
from billing;

select doctor_id,count(*) as visits
from appointments
group by doctor_id
order by  visits desc
limit 1;

select avg(consultaion_fee) as avg_c_f
from doctors;

---joins

select d.doctor_name, d.department_name
from doctors as d
inner join doctor_department as dd on doc.doctor_id = dd.doctor_id
inner join departments d on dd.department_id = d.department_id;

select distinct p.patient_name
from patients as p
left join appointments as a
on p.patient_id =a.patient_id
where a.status = 'completed';

select a.appointment_id,a.patient_id,a.doctor_id
from billings as b
right join appointments a
on b.appointment_id = a.appointment_id
where b.invoice_id is null;

select p.patient_name
from patients p
left join appointments a on p.patient_id = a.patient_id
where a.appointment_id is null;

----subqueries
select doctor_id, doctor_name
from doctors
where doctor_id in (
    select doctor_id
    from appointments
    group by doctor_id
    having count(patient_id) > 50
);

select *
from appointments
where doctor_id in (
    select doctor_id
    from doctors
    where specialization = 'dermatology'
);

------date and time
select month(appointment_date) as month, count(*) as tv
from appointments
group by month(appointment_date);

select date_format(treatment_date, '%d-%m-%Y') as treatment_date
from medical_records;

---- str functions
select upper(patient_name) as large
from patients;

select trim(doctor_name) as tr
from doctors;

update patients
set phone_number = 'not available'
where phone_number is null;

-----window functions
select d.doctor_id, d.doctor_name,
rank() over(order by count(a.patient_id))
from doctors d
join appointments a on d.doctor_id = a.doctor_id;

select appointment_date,
count(*) over (order by appointment_date) as running_total
from appointments;

----caswe
select patient_id,
case
    when count(record_id) > 5 then 'high'
    when count(record_id) >= 3 then 'medium'
    else 'low'
end as patient_risk_level
from medical_records
group by patient_id;



