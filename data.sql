INSERT INTO "user" (email, username)
VALUES ('user1@email.com', 'user1'),
       ('user2@email.com', 'user2'),
       ('user3@email.com', 'user3'),
       ('user4@email.com', 'user4'),
       ('user5@email.com', 'user5'),
       ('user6@email.com', 'user6');

INSERT INTO advisor (user_id, role)
VALUES (1, 'associate'),
       (2, 'partner'),
       (3, 'senior');

INSERT INTO applicant (user_id, first_name, last_name, ssn)
VALUES (4, 'applicant1', 'testing', '111-111'),
       (5, 'applicant2', 'testing', '222-222'),
       (6, 'applicant3', 'testing', '333-333');

INSERT INTO applicant_address (id, city, street, number, zip, apt)
VALUES (1, 'city', 'street', 1, 1, 1),
       (2, 'city', 'street', 1, 1, 1),
       (3, 'city', 'street', 1, 1, 1);

INSERT INTO applicant_phone_number (applicant_id, type, value)
VALUES (1, 'home', '111111'),
       (2, 'work', '222222'),
       (3, 'mobile', '333333');

INSERT INTO application (applicant_id, advisor_id, money_amount, status, assigned_at)
VALUES (1, NULL, '120.04', 'new', NULL),
       (2, 1, '1000000.00', 'assigned', now()),
       (2, 2, '999999999.00', 'declined', now()),
       (2, 2, '50.123', 'approved', now()),
       (2, 3, '5000', 'on_hold', now());
