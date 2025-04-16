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

# Datenbank-Transaktionen und ACID-Prinzipien

## Grundbegriffe
- **Datenintegrität**: Korrektheit und Konsistenz von Daten.
- **Transaktion**: Gruppe von SQL-Operationen als unteilbare Einheit.
- **ROLLBACK**: Setzt alle Änderungen einer Transaktion zurück.
- **COMMIT**: Bestätigt und speichert Änderungen dauerhaft.
- **LOCK**: Sperre auf Daten, um parallele Änderungen zu verhindern.
- **Deadlock**: Zwei Transaktionen blockieren sich gegenseitig.
- **Timeout**: Eine Transaktion wird abgebrochen, weil sie zu lange auf eine Sperre wartet.
- **IsolationLevel**: Bestimmt, wie Transaktionen voneinander getrennt sind.

## ACID-Prinzipien (Grundlage für Transaktionen)
- **Atomicity**: Alles oder nichts – eine Transaktion wird komplett ausgeführt oder verworfen.
- **Consistency**: Daten bleiben vor und nach der Transaktion in einem gültigen Zustand.
- **Isolation**: Parallele Transaktionen beeinflussen sich nicht.
- **Durability**: Erfolgreiche Transaktionen bleiben dauerhaft gespeichert.

## Problemfälle durch gleichzeitigen Zugriff
- **Dirty Read**: Lesen nicht bestätigter (unbestätigter) Daten.
- **Non-Repeatable Read**: Unterschiedliche Werte beim erneuten Lesen derselben Daten.
- **Phantom Read**: Änderungen in der Anzahl oder Existenz von Datensätzen.

## SQL-Isolationsstufen

| Isolationslevel   | Verhindert Dirty Reads | Verhindert Non-Repeatable Reads | Verhindert Phantom Reads |
|-------------------|----------------------|-----------------------------|-----------------------|
| Read Uncommitted | ❌ | ❌ | ❌ |
| Read Committed   | ✅ | ❌ | ❌ |
| Repeatable Read  | ✅ | ✅ | ❌ |
| Serializable     | ✅ | ✅ | ✅ |

## Transaktionssteuerung
```sql
START TRANSACTION; -- Beginn einer Transaktion

COMMIT; -- Änderungen übernehmen
ROLLBACK; -- Änderungen verwerfen

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- Setzt die gewünschte Isolationsstufe
```

## **Sperren und Konflikte**
- **FOR UPDATE**: Sperrt eine Zeile für Änderungen.
- **Locks und Timeouts**: Sperren können Timeouts verursachen, wenn eine Transaktion zu lange auf eine Freigabe wartet.
- **Deadlocks analysieren**: Informationen über blockierte Transaktionen abrufen:
  ```sql
  SELECT * FROM sys.innodb_lock_waits;
  ```

# Datenbankindex

Ein **Datenbankindex** ist eine Datenstruktur, die die Suche und das Sortieren in einer Datenbank beschleunigt. Er ist eine Art Inhaltsverzeichnis, das auf bestimmte Felder in einer Datenbanktabelle verweist.

## Wie funktioniert ein Datenbankindex?

Ein Index kann für eine einzelne Spalte oder eine Folge von Spalten einer Datenbanktabelle definiert werden.  
Er besteht aus einer oder mehreren **Invertierungslisten**.  
Ein Index enthält in der Regel einen **"Schlüssel"** oder direkten Link zur ursprünglichen Datenzeile.  
Dadurch kann die vollständige Zeile effizient abgerufen werden.

## Execution Plan

SQL-Abfragen werden vom DBMS analysiert (Parsing), woraufhin ein **Execution Plan** erstellt wird. Dieser Plan beschreibt den effizientesten Zugriffspfad für die Ausführung der Anfrage.

### Optimizer
Ein Optimizer bewertet verschiedene mögliche Ausführungspläne und wählt den effizientesten aus.

### Anzeigen des Execution Plans
Je nach Datenbanksystem gibt es verschiedene Befehle:

- **MySQL:** `EXPLAIN SELECT ...` oder `EXPLAIN ANALYZE`  
- **PostgreSQL:** `EXPLAIN SELECT ...` oder `EXPLAIN ANALYZE`  
- **SQL Server:** `SET SHOWPLAN_ALL ON;`, `EXPLAIN` (grafischer Plan in SSMS)

## Performance & Benchmarking

Vor Optimierungen sollte ein Benchmark durchgeführt werden, um die aktuelle Performance zu messen. Mögliche Methoden:

- **MySQL:** `SHOW PROFILES;`
- **PostgreSQL:** `EXPLAIN ANALYZE`
- **SQL Server:** Aktivieren der **Client Statistics** in SSMS

## Indizes

Ein **Index** ist eine Datenstruktur, die die Suche in der Datenbank beschleunigt. Er funktioniert wie ein **Inhaltsverzeichnis** in einem Buch.

### Vorteile:
- Schnellere Abfragen, da weniger Zeilen durchsucht werden müssen.

### Nachteile:
- Erhöhte Schreibkosten, da Indizes bei Änderungen aktualisiert werden müssen.

### Auswahl der Spalten für Indizes:
- **Geeignet:** Spalten in `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`
- **Weniger geeignet:** Selten genutzte Spalten oder Spalten mit vielen Duplikaten

### Typen von Indizes:
- **B-Bäume** (Standard)
- **Hash-Indexe** (schnell bei exakten Vergleichen)
- **Volltextsuche-Indexe** (für Textsuche)
- **Räumliche Indexe** (für geografische Daten)

## Gründe für schlechte Performance

1. **Locks & Blockierungen**  
   - Gleichzeitige Transaktionen blockieren sich gegenseitig.
   
2. **Suboptimale Abfragen**  
   - Unnötige Spalten, komplexe Berechnungen oder verschachtelte Subqueries.

3. **Ineffiziente Joins**  
   - Joins über große Tabellen ohne passende Indizes.

4. **Fehlende oder ineffiziente Indizes**  
   - Zu viele oder schlecht gewählte Indizes verlangsamen Abfragen.

5. **Falsche Datenbankkonfiguration**  
   - Ungünstige Buffergrößen oder Caching-Strategien.

## Benutzerverwaltung (Autorisierung)

Benutzer und Rechteverwaltung variieren je nach RDBMS. Grundlegende Befehle:

```sql
CREATE USER user1@localhost IDENTIFIED BY 'passwort';
DROP USER user1@localhost;
GRANT SELECT, INSERT ON mydb TO 'user2'@'%';
REVOKE DELETE ON mydb FROM 'user2'@'%';
```

**Tipps:**
- Jeder Nutzer sollte eigene Anmeldedaten haben.
- **Least Privilege Prinzip**: Nur notwendige Rechte vergeben.
- Trennung von Lese- und Schreibrechten zur Absicherung gegen SQL-Injection.

## Backup & Recovery

Je nach Umgebung können verschiedene Backup-Methoden genutzt werden:

- **Cloud-Services (PaaS, SaaS):** Integrierte Backup-Funktionen nutzen.
- **Eigene Instanzen:** Nutzung von **Snapshots** oder **Datenbank-eigenen Backup-Tools**.

Ein durchdachtes Backup- und Recovery-Konzept schützt vor Datenverlust.

# Python

Ein Python-Skript mit Zugriff auf eine Datenbank ist grundsätzlich wie folgt aufgebaut:

import mysql.connector

# Verbindungsinformationen

```python
config = {
    'user': '<user>',  # Mit MySQL-Benutzernamen ersetzen
    'password': '<passwort>',  # Passwort ersetzen
    'host': '<Server>',         # IP-Adresse/Hostname des DB-Servers
    'port': '<port>',     # Port-Nummer angeben (Default, falls nicht angegeben: 3306)
    'database': '<dbname>',  # Namen der Datenbank angeben
    'raise_on_warnings': True
}

try:
    # Verbindung zur Datenbank herstellen mit obigen Vorgaben
    conn = mysql.connector.connect(**config)

    # Cursor erstellen
    cursor = conn.cursor()

    # SQL-Anfrage ausführen mittels Cursor
    cursor.execute(f"SELECT * FROM mysql.TABLES")

    for row in cursor.fetchall():
        print(row)

except mysql.connector.Error as err:
    print(f"Fehler: {err}")

finally:
    # Verbindung schließen
    if conn.is_connected():
        cursor.close()
        conn.close()
        print("Verbindung zur Datenbank wurde geschlossen.")
```

