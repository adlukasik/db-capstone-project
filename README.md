# Little Lemon Capstone Project 

Kompletny system zarządzania danymi dla restauracji, stworzony w ramach certyfikacji **Meta Database Engineer**. Projekt integruje relacyjną bazę danych, skrypty Python oraz analitykę biznesową.

## Technologie
* **MySQL** (Projektowanie bazy, Procedury składowane, Transakcje)
* **Python** (Connector, Jupyter Notebook)
* **Tableau** (Wizualizacja danych, Dashboard)
* **Git/GitHub** (Kontrola wersji)

## Kluczowe pliki
* `LittleLemonDB.sql` – Pełny zrzut bazy danych (struktura + dane).
* `LittleLemonDM.png` – Diagram ER (Entity Relationship Diagram).
* `LittleLemon_Client.ipynb` – Klient Python do łączenia z bazą i wykonywania zapytań.
* `LittleLemon_Analysis.twbx` – Skoroszyt Tableau z interaktywnym dashboardem.

## Główne funkcjonalności
1. **Baza Danych:** Znormalizowany schemat (Bookings, Orders, Customers, Menu, Staff).
2. **Logika Biznesowa:**
   * Procedury składowane (np. `CheckBooking`, `AddValidBooking`).
   * Transakcje SQL z mechanizmem Rollback.
   * Widoki (Views) i Prepared Statements.
3. **Klient Python:** Aplikacja w Jupyter Notebook łącząca się z bazą (MySQL Connector) i wykonująca złożone zapytania (JOIN).
4. **Analityka:** Dashboard w Tableau analizujący sprzedaż wg regionu, kuchni i trendów rocznych.

## Jak uruchomić?
1. Zaimportuj `LittleLemonDB.sql` w MySQL Workbench.
2. Zainstaluj zależności: `pip install jupyter mysql-connector-python`.
3. Uruchom analizę w Pythonie: `jupyter notebook LittleLemon_Client.ipynb`.
4. Otwórz wizualizacje w **Tableau**.


