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
