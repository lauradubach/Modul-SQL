use mydb;

INSERT INTO Location (Standort) VALUES
('Schlieren'),
('Altstetten'),
('Regensdorf'),
('Glattbrug'),
('Dübendorf');

INSERT INTO Trainer (Name, Vorname, Telefonnummer, Location_idLocation) VALUES
('Müller', 'Thomas', '+41 79 123 45 67', 1),
('Schmid', 'Anna', '+41 78 987 65 43', 2),
('Weber', 'Michael', '+41 76 555 55 55', 3),
('Meier', 'Sophie', '+41 77 111 22 33', 4);

INSERT INTO Session (Name, Trainer_idTrainer) VALUES
('Morning Strength Training', 1),
('Cardio Blast', 2),
('Yoga Flow', 3),
('HIIT Workout', 4),
('Core & Flexibility', 1),
('Powerlifting Basics', 3);

INSERT INTO Member (Name, Vorname, Telefonnummer, Membership_idMembership) VALUES
('Meier', 'Lukas', '+41 78 123 45 67', 1),
('Schneider', 'Anna', '+41 79 234 56 78', 2),
('Fischer', 'Peter', '+41 76 345 67 89', 3),
('Zimmermann', 'Claudia', '+41 77 456 78 90', 1),
('Hoffmann', 'Markus', '+41 78 567 89 01', 2),
('Schwarz', 'Julia', '+41 79 678 90 12', 3),
('Bauer', 'Stefan', '+41 76 789 01 23', 1),
('Wagner', 'Susanne', '+41 77 890 12 34', 2),
('Schmidt', 'Max', '+41 78 901 23 45', 3),
('Keller', 'Simone', '+41 79 012 34 56', 1);

INSERT INTO Membership (Name,Plan_idPlan) VALUES
('Gold', 1),
('Silber', 2),
('Platin', 3);

Insert Into Session_has_Member (Member_idMember, Session_idSession) VALUES
(1, 1),
(1, 2),
(1, 3);

INSERT INTO Plan (Name) VALUES
('Basic Fitness Plan'),
('Advanced Strength Training'),
('Cardio Endurance Program');

Insert Into Member_has_Plan (Member_idMember, Plan_idPlan) VALUES
(3, 1),
(5, 2),
(7, 3);

Insert Into Exercise (Name) VALUES
('Push-up'),
('Squat'),
('Lunges'),
('Deadlift'),
('Plank'),
('Burpees'),
('Jumping Jacks'),
('Leg Press');


Insert Into Exercise_has_Plan (Exercise_idExercise, Plan_idPlan) VALUES
(4, 1),
(2, 3),
(1, 2);

Insert Into Equipment (Name, Location_idLocation) VALUES
('Treadmill', 1),
('Dumbbells', 2),
('Resistance Bands', 3),
('Exercise Bike', 4);

Insert Into Equipment_has_Exercise (Equipment_idEquipment, Exercise_idExercise) VALUES
(1, 3),
(3, 5),
(4, 7);




