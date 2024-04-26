drop database assessment_db;
create database assessment_db;
use assessment_db;

create table accounts(
id int not null auto_increment,
username varchar(20) not null unique,
password varchar(40) not null,
role char(1) not null, -- S, T ili A; S - student, T - teacher, A - admin
last_seen datetime, -- ppc ne e zaduljitelno, no go slojih za mejdu drugoto; shte ima stoinost NULL ako v momenta e aktiven
online_status char(1) not null, -- 1 ili 0; dali e aktiven sega ili ne; sushto ne e zaduljitelno
primary key(id)
);

create table courses(
id int not null auto_increment,
faculty varchar(30) not null,
specialty varchar(30) not null,
subject varchar(30) not null,
primary key(id)
);

create table admins(
id int not null auto_increment,
full_name varchar(50) not null, -- 2 imena
phone_no char(13) not null, -- +359 format 
email varchar(40) not null,
account_id int not null,
country varchar(20) not null,
sex char(1) not null, -- F ili M
primary key (id),
constraint foreign key(account_id) references accounts(id)
);

create table teachers(
id int not null auto_increment,
full_name varchar(50) not null, -- 2 imena
phone_no char(13) not null, -- +359 format
email varchar(40) not null,
account_id int not null,
country varchar(20) not null,
sex char(1) not null, -- F ili M
primary key (id),
constraint foreign key(account_id) references accounts(id)
);

create table students(
id int not null auto_increment,
account_id int not null,
course_id int not null,
full_name varchar(50) not null, -- 2 imena
phone_no char(13) not null, -- +359 format
email varchar(40) not null,
country varchar(20) not null,
sex char(1) not null, -- F ili M
semester int not null,
primary key (id),
constraint foreign key(course_id) references courses(id),
constraint foreign key(account_id) references accounts(id)
);


create table quizes(
id int not null auto_increment,
name_of_quiz varchar(25) not null,
teacher_id int not null,
primary key(id),
constraint foreign key(teacher_id) references teachers(id)
);

create table quiz_questions(
id int not null auto_increment,
quiz_id int not null,
question_no int not null,
question varchar(40) not null,
answerA varchar(40) not null,
answerB varchar(40) not null,
answerC varchar(40) not null,
answerD varchar(40) not null,
correct_ans char(1) not null, -- A, B, C ili D
points int not null,
primary key(id),
constraint foreign key(quiz_id) references quizes(id)
);

create table grades_of_student(
id int not null auto_increment,
student_id int not null,
quiz_id int not null,
grade float(10,2) not null,
date_written datetime not null,
primary key(id),
constraint foreign key(student_id) references students(id),
constraint foreign key(quiz_id) references quizes(id)
);

create table quizes_attended(
id int not null auto_increment,
student_id int not null,
quiz_id int not null, 
points_earned int not null,
primary key(id),
constraint foreign key(student_id) references students(id),
constraint foreign key(quiz_id) references quizes(id)
);

create table quizes_for_course(
id int not null auto_increment,
quiz_id int not null,
course_id int not null,
from_date datetime not null,
to_date datetime not null,
primary key(id),
constraint foreign key(quiz_id) references quizes(id),
constraint foreign key(course_id) references courses(id)
);

create table quizes_info( -- za assignments / calendar
id int not null auto_increment,
teacher_id int not null, -- ot kogo e suzdaden
student_id int not null,
intended_quiz int not null,
color varchar(15) not null, -- ime na cveta
primary key(id),
constraint foreign key(student_id) references students(id),
constraint foreign key(intended_quiz) references quizes_for_course(id),
constraint foreign key(teacher_id) references teachers(id)
);

create table teaching_courses( -- tazi tablica kato cqlo ne e vajna, no q dobavih za vseki sluchai
id int not null auto_increment,
teacher_id int not null,
course_id int not null,
primary key(id),
constraint foreign key(teacher_id) references teachers(id),
constraint foreign key(course_id) references courses(id)
);
