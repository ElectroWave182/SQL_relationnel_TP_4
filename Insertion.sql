DELETE FROM Reservation;
DELETE FROM Emplacement;
DELETE FROM Bateau;
DELETE FROM Proprietaire;


INSERT INTO Proprietaire VALUES (0, 'b', 'a', 'c');
INSERT INTO Proprietaire VALUES (1, 'JeanMi', 'a', 'emailLol');

INSERT INTO Bateau VALUES ('a', 'bonsoir', 25, 5, 0);
INSERT INTO Bateau VALUES ('c', 'daniel', 18, 5, 0);
INSERT INTO Bateau VALUES ('e', 'jeanmi', 15, 4, 1);
INSERT INTO Bateau VALUES ('ft', 'petit', 7, 4, 1);
INSERT INTO Bateau VALUES ('gt', 'grand', 15, 4, 1);

INSERT INTO Emplacement VALUES (54, 10, 'ft', '18/06/2003', '21/06/2003');
INSERT INTO Emplacement VALUES (42, 20, 'c', '18/06/2003', '21/06/2003');
INSERT INTO Emplacement VALUES (54, 10, NULL, '18/06/2003', '21/06/2003');
INSERT INTO Emplacement VALUES (42, 20, NULL, '18/06/2003', '21/06/2003');

INSERT INTO Reservation VALUES (0, '18/06/2003', '21/06/2003', 54, 'gt');
INSERT INTO Reservation VALUES (0, '18/06/2003', '21/06/2003', 42, 'gt');
UPDATE Reservation SET lEmplacement = 54 WHERE numResa = 0;

UPDATE Emplacement SET leBateau = 'gt' WHERE noEmpl = 42;

