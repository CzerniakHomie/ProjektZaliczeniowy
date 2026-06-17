# Wizarding World
Aplikacja mobilna stworzona we Flutterze wyświetlająca dane z Harry Potter API.

## Opis
Aplikacja pozwala przeglądać postacie ze świata Harry Pottera oraz zaklęcia.
Działa w trybie offline dzięki lokalnej bazie danych Hive CE.

## Użyte API
https://hp-api.onrender.com/

## Ekrany
- **Lista postaci** — wyświetla bohaterów z imionami, domami i gatunkiem
- **Szczegóły postaci** — zdjęcie, dom, aktor, gatunek, status życia
- **Lista zaklęć** — zaklęcia z opisami

## Technologie
- Flutter / Dart
- http ^1.0.0 — komunikacja z REST API
- hive_ce ^2.19.3 — lokalna baza danych (tryb offline)

## Funkcje
- Pobieranie danych z dwóch endpointów REST API
- Tryb offline — dane zapisywane lokalnie w Hive CE
- Obsługa stanu ładowania (CircularProgressIndicator)
- Obsługa błędów sieciowych
- Nawigacja między trzema ekranami