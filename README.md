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


# DML 2 - Assignments

## Aggregationen

### Einfache Gruppierung von Daten
SELECT column1, COUNT(*) FROM table_name GROUP BY column1;

### Gruppierung über mehrere Spalten
SELECT column1, column2, SUM(column3) FROM table_name GROUP BY column1, column2;

### Verschiedene Aggregationen mit Gruppierung
SELECT column1, AVG(column3), MAX(column3), MIN(column3) FROM table_name GROUP BY column1;

### HAVING nach Gruppierung
SELECT column1, COUNT(*) FROM table_name GROUP BY column1 HAVING COUNT(*) > 5;

### WHERE vor der Gruppierung und HAVING danach
SELECT column1, COUNT(*) FROM table_name WHERE column2 > 10 GROUP BY column1 HAVING COUNT(*) > 3;

## JOINs

### INNER JOIN
SELECT t1.*, t2.* FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.foreign_id;

### LEFT JOIN
SELECT t1.*, t2.* FROM table1 t1 LEFT JOIN table2 t2 ON t1.id = t2.foreign_id;

### RIGHT JOIN (und Vergleich mit LEFT JOIN)
SELECT t1.*, t2.* FROM table1 t1 RIGHT JOIN table2 t2 ON t1.id = t2.foreign_id;

### JOIN mit zusätzlichen Filtern in WHERE
SELECT t1.*, t2.* FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.foreign_id WHERE t2.column3 > 100;

### JOIN mit AND-Bedingung
SELECT t1.*, t2.* FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.foreign_id AND t1.status = 'active';

### JOIN über drei Tabellen mit Transformationstabelle
SELECT t1.*, t2.*, t3.* FROM table1 t1 INNER JOIN transformation_table t2 ON t1.id = t2.t1_id INNER JOIN table3 t3 ON t2.t3_id = t3.id;

## UNION
SELECT column1, column2 FROM table1 WHERE column3 > 10
UNION
SELECT column1, column2 FROM table1 WHERE column3 < 5;

## Unterabfragen
### IN-Anweisung
SELECT * FROM table1 WHERE column1 IN (SELECT column1 FROM table2 WHERE column2 > 50);

### Verschachtelte Abfragen mit Aggregationen
SELECT field2 AS grpvalue, nr, summe FROM (
    SELECT field2, COUNT(*) AS nr, SUM(t1.field1) AS summe FROM (
        SELECT t1.field1, t1.field2, field3 FROM anytable AS t1
        INNER JOIN (SELECT field3 FROM anothertable WHERE field4 LIKE '%whatever') AS t2 
        ON t1.key1 = t2.key2
    ) AS subquery
    GROUP BY field2
) AS final_query
ORDER BY nr;
