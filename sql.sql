CREATE TABLE public.appointments (
    app_id integer NOT NULL,
    student_name character varying(10),
    professor_name character varying(10),
    sch_date timestamp without time zone,
    reason character varying(30),
    status character varying(10)
);

CREATE TABLE public.professors (
    username character varying(10) NOT NULL,
    department character varying(20)
);

CREATE TABLE public.schedule (
    schedule_id integer NOT NULL,
    professor_username character varying(10),
    date timestamp without time zone,
    available boolean
);

CREATE TABLE public.students (
    username character varying(10) NOT NULL,
    year integer
);

CREATE TABLE public.users (
    firstname character varying(20),
    lastname character varying(20),
    email character varying(40),
    username character varying(10) NOT NULL,
    password character varying(40),
    type character varying(20)
);