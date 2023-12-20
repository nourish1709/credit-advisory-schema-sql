DROP TABLE IF EXISTS application;
DROP TYPE IF EXISTS application_status;
DROP TABLE IF EXISTS applicant_phone_number;
DROP TYPE IF EXISTS phone_type;
DROP TABLE IF EXISTS applicant_address;
DROP TABLE IF EXISTS applicant;
DROP TABLE IF EXISTS advisor;
DROP TYPE IF EXISTS role;
DROP TABLE IF EXISTS "user";

CREATE TABLE "user"
(
    id       BIGSERIAL,
    email    TEXT NOT NULL,
    username TEXT NOT NULL,
    CONSTRAINT user_PK PRIMARY KEY (id),
    CONSTRAINT user_email_UQ UNIQUE (email),
    CONSTRAINT user_email_CH CHECK (email LIKE '%@%'),
    CONSTRAINT user_username_UQ UNIQUE (username)
);

CREATE TYPE role AS ENUM ('associate', 'partner', 'senior');

CREATE TABLE advisor
(
    id      BIGSERIAL,
    user_id BIGINT NOT NULL,
    role    role   NOT NULL,
    CONSTRAINT advisor_PK PRIMARY KEY (id),
    CONSTRAINT advisor_user_FK FOREIGN KEY (user_id) REFERENCES "user",
    CONSTRAINT advisor_user_id_UQ UNIQUE (user_id)
);

CREATE TABLE applicant
(
    id         BIGSERIAL,
    user_id    BIGINT NOT NULL,
    first_name TEXT   NOT NULL,
    last_name  TEXT   NOT NULL,
    ssn        TEXT   NOT NULL,
    CONSTRAINT applicant_PK PRIMARY KEY (id),
    CONSTRAINT applicant_user_FK FOREIGN KEY (user_id) REFERENCES "user",
    CONSTRAINT applicant_user_id_UQ UNIQUE (user_id)
);

CREATE TABLE applicant_address
(
    id     BIGINT,
    city   TEXT NOT NULL,
    street TEXT NOT NULL,
    number INT  NOT NULL,
    zip    INT  NOT NULL,
    apt    INT  NOT NULL,
    CONSTRAINT applicant_address_PK PRIMARY KEY (id),
    CONSTRAINT applicant_address_applicant_FK FOREIGN KEY (id) REFERENCES applicant
);

CREATE TYPE phone_type AS ENUM ('home', 'work', 'mobile');

CREATE TABLE applicant_phone_number
(
    id           BIGSERIAL,
    applicant_id BIGINT     NOT NULL,
    type         phone_type NOT NULL,
    value        TEXT       NOT NULL,
    CONSTRAINT applicant_phone_number_PK PRIMARY KEY (id),
    CONSTRAINT applicant_phone_number_applicant_FK FOREIGN KEY (applicant_id) REFERENCES applicant
);

CREATE TYPE application_status AS ENUM ('new', 'assigned', 'on_hold', 'approved', 'canceled', 'declined');

CREATE TABLE application
(
    id           BIGSERIAL,
    applicant_id BIGINT             NOT NULL,
    advisor_id   BIGINT,
    money_amount money              NOT NULL,
    status       application_status NOT NULL,
    created_at   DATE               NOT NULL DEFAULT now(),
    assigned_at  DATE,
    CONSTRAINT application_PK PRIMARY KEY (id),
    CONSTRAINT application_applicant_FK FOREIGN KEY (applicant_id) REFERENCES applicant,
    CONSTRAINT application_advisor_FK FOREIGN KEY (advisor_id) REFERENCES advisor,
    CONSTRAINT application_advisor_id_assigned_at_CH CHECK (
        (advisor_id ISNULL AND assigned_at ISNULL AND status = 'new') OR
        (advisor_id IS NOT NULL AND assigned_at IS NOT NULL AND status IN ('assigned', 'on_hold', 'approved', 'canceled', 'declined'))
        )
);
