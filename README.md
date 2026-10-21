# Care Mate

A healthcare solution made of two complementary systems:

- **Care Signal**: an emergency alert device built with Arduino and a GSM module. The patient presses one button and the caregiver receives an alert directly.
- **Care Mate**: a desktop application built with Java (Swing) and MySQL that helps caregivers manage daily patient care, and lets doctors view patient records and add notes.

> The two systems are currently separate. Integrating them is planned future work.

## Features (Care Mate)

- Caregiver and doctor sign up / login
- Patient records and patient list
- Daily care notes
- Medication tracking
- Appointment scheduling and upcoming appointments
- Doctor notes on patient records

## Tech Stack

- Java (Swing, NetBeans project)
- MySQL (JDBC)
- Arduino + GSM module (Care Signal)

## Getting Started

1. Install JDK, NetBeans, and MySQL.
2. Create the database by importing the schema:
   `mysql -u root -p < database.sql`

3. Open `src/DBConnection.java` and set your own MySQL password:
   `String password = "your_password";`
4. Open the project in NetBeans and run `WelcometoCareMate`.

Demo login: `admin` / `1234` (for demonstration only).

## Poster

See `Care_Mate_Poster.pdf` for the project poster, including the database diagram and user interface screenshots.

## Team

Nora Alowaidh, Ibtesam Alqahtani, Rimas Aldosari, Ibtehaj Alqhtani, Aryam Hakami, Ola Yasir Omer

Supervisors: Ms. Elaf Al-Ghamdi, Ms. Sarah Quhal, Dr. Haya Aldossary, Ms. Maha Alghamdi

Imam Abdulrahman Bin Faisal University, College of Science and Humanities

