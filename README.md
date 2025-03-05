# Modul-SQL


## DB angeben
use mydb

## DB bereinigen
drop database mydb

### Spalte zur Tabelle 'meine_tabelle' hinzufügen
ALTER TABLE meine_tabelle ADD neue_spalte VARCHAR(255);

### Datentyp der hinzugefügten Spalte ändern
ALTER TABLE meine_tabelle MODIFY neue_spalte INT;

### Die hinzugefügte Spalte wieder löschen
ALTER TABLE meine_tabelle DROP COLUMN neue_spalte;

### Values in eine Tabelle schreiben
INSERT INTO Equipment (Name, Location_idLocation) VALUES
('Treadmill', 1),
('Dumbbells', 2),

### Lese eine Tabelle als gesamtes aus (ohne WHERE) und zeige alle Spalten (`*`-Operator)
SELECT * FROM Trainer;

### Filtern mit einem Vergleichsoperator `=`
SELECT * FROM Member WHERE Name = 'Meier';

### Filtern mit der `OR`-Anweisung
SELECT * FROM Session WHERE Name = 'Cardio Blast' OR Name = 'Yoga Flow';

### Filtern mit der `UND`-Anweisung
SELECT * FROM Equipment WHERE Name = 'Treadmill' AND Location_idLocation = 1;

### Filtern mit der `LIKE`-Anweisung
SELECT * FROM Exercise WHERE Name LIKE 'Push%';

### Filtern nach einem Datum mit `<=`, `>=` und `BETWEEN`
SELECT * FROM Session WHERE Datum >= '2025-01-01' AND Datum <= '2025-12-31';
-- Oder
SELECT * FROM Session WHERE Datum BETWEEN '2025-01-01' AND '2025-06-30';

### Sortiere die Resultate mit `ORDER BY` (aufsteigend und absteigend)
Aufsteigend (ASC)
SELECT * FROM Member ORDER BY Vorname ASC;

Absteigend (DESC)
SELECT * FROM Member ORDER BY Vorname DESC;