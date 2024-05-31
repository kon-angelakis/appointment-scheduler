CREATE TABLE public.appointments (
    app_id integer NOT NULL,
    student_name character varying(15),
    professor_name character varying(15),
    sch_date timestamp without time zone,
    reason character varying(30),
    status character varying(20)
);

CREATE TABLE public.professors (
    username character varying(15) NOT NULL,
    department character varying(20)
);

CREATE TABLE public.schedule (
    schedule_id integer NOT NULL,
    professor_username character varying(10),
    date timestamp without time zone,
    available boolean
);

CREATE TABLE public.students (
    username character varying(15) NOT NULL,
    year integer
);

CREATE TABLE public.users (
    firstname character varying(30),
    lastname character varying(30),
    email character varying(40),
    username character varying(15) NOT NULL,
    password character varying(40),
    type character varying(20)
);

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (app_id);


ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_pkey PRIMARY KEY (username);


ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_professor_username_date_key UNIQUE (professor_username, date);


ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (username);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_professor_name_fkey FOREIGN KEY (professor_name) REFERENCES public.professors(username);


ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_professor_name_sch_date_fkey FOREIGN KEY (professor_name, sch_date) REFERENCES public.schedule(professor_username, date);


ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_student_name_fkey FOREIGN KEY (student_name) REFERENCES public.students(username);


ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);


ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_professor_username_fkey FOREIGN KEY (professor_username) REFERENCES public.professors(username);


ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);
	
