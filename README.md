# DATABASE DRIVEN WEB AND MOBILE APPLICATION

![4-Things-to-Watch-Out](https://github.com/AWESOME04/Database-Driven-Web-and-Mobile-Application/assets/102630199/aee629cd-0248-4818-a186-5455f7ca9594)

The project is a Database Driven Web and Mobile Application developed using Spring Boot, Postgresql React, and Flutter. It aims to provide a platform for managing student registrations, courses, exams, and other related functionalities.

# [Live React Website](https://ses-react-project.vercel.app/)

## Problem Statement

This project aims to develop a comprehensive database-backed web and mobile application for an educational institution. The application will cater to both students and faculty members, providing them with a user-friendly interface to manage various aspects of their academic journey. The key problem this application seeks to address includes:

1. **Student Information Management**: Efficiently handle student information, including registration, course enrollment, and academic performance.

2. **Course Management**: Enable faculty members to create and manage courses, including scheduling, assignments, and grading.

3. **Event Tracking**: Facilitate tracking and notification of upcoming events and important dates.

4. **Authentication and Security**: Ensure secure user authentication and role-based access to different functionalities.

5. **Seamless User Experience**: Create a seamless user experience for both web and mobile platforms to enhance user satisfaction.

## Requirements

The application is required to fulfill the following functional and non-functional requirements:

### Functional Requirements:

1. User Registration and Authentication:
   - Students and faculty members can register and log in to the application using their credentials.

2. Student Information:
   - Students can provide and update their personal details, including name, email, level, and department.
   - Faculty members can access student information related to their respective courses.

3. Academic Performance:
   - Faculty members can record and update students' grades for assessments and assignments.
   - Students can view their academic performance and grades.

4. Event Tracking:
   - Users will receive notifications for upcoming events, such as exams, meetings, or academic deadlines.

### Non-functional Requirements:

1. User Interface:
   - The application should have an intuitive and user-friendly interface for both web and mobile platforms.

2. Performance:
   - The application should be responsive and provide quick responses to user actions.

3. Security:
   - User data and passwords must be securely stored and transmitted using encryption.
   - Role-based access control should be implemented to restrict access to specific features.

4. Scalability:
   - The application should be designed to handle a growing number of users and data efficiently.

## Software Process

The software development process for this project follows an Agile methodology. The team collaborates using Scrum principles, conducting regular sprints and meetings to manage tasks and adapt to changes effectively. Continuous integration and delivery (CI/CD) practices are employed to ensure frequent deployments and timely feedback.

## Software Modelling

The project employs UML diagrams to model the software architecture and flow. Key UML diagrams used in the project include:
      
      - Class Diagrams: To illustrate the relationships between classes in the application.
      - Use Case Diagrams: To depict the interactions between users and the system for different use cases.
      - Sequence Diagrams: To visualize the sequence of actions between different components.

## Software System Architecture

The application follows a three-tier architecture, consisting of the following components:

1. Front End (React): Further Details can be Found at [SES-React-Project](https://github.com/AWESOME04/SES-React-Project)
   - The React-based front end provides an interactive user interface for both web and mobile platforms.
   - Redux is used for state management, ensuring efficient data flow and consistent user experiences.

2. Backend/Web Service (Spring Boot):
   - The Spring Boot-based backend serves as the web service, handling API requests from the front end.
   - It manages user authentication, database interactions, and business logic implementation.

3. Mobile App (Flutter): Further Details can be found at [SES-Mobile-Application](https://github.com/AWESOME04/SES-Mobile-Application)
   - The Flutter-based mobile app offers a native user experience for Android and iOS devices.
   - State management is achieved using the Provider package, ensuring smooth app performance.

4. Database (PostgreSQL): Further Details can be found at [GROUP2_SES_Database_Project-3](https://github.com/AWESOME04/GROUP2_SES_Database_Project-3)
   - PostgreSQL is chosen as the relational database to store and manage application data.

The interaction between these components is facilitated through RESTful API endpoints.

## Design and Implementation

### Front End (React)

The React front end is structured using components, where each component represents a specific part of the application. Redux is utilized for state management, ensuring a single source of truth for the application's data. Axios is used for API calls to interact with the backend.

- **Student Registration**: 
    New students can register by providing their name, email, password, and confirming the password.     
    Validation is performed to ensure that all required fields are filled and that the password and confirm password match.
    Upon successful registration, the student is redirected to the login page.

![Student Registration Page](https://github.com/AWESOME04/SES-React-Project/assets/102630199/56df1153-f931-4fe5-9202-4f70cb048e01)

- **Login**: 
    Registered students can log in using their ID and PIN.
    Authentication is performed to validate the entered ID and PIN.
    If the login is successful, the student is directed to the Student Information Entry page.

![Login Page](https://github.com/AWESOME04/SES-React-Project/assets/102630199/61c3dffd-b21c-492c-988b-8cdbfaa6d688)

- **Student Information Entry**: 
     After logging in, students can enter their name, email, password, level, and department.
     Validation is performed to ensure that all required fields are filled.
     Upon successful information entry, the student is directed to the Dashboard page.

![Student Info Entry Page](https://github.com/AWESOME04/SES-React-Project/assets/102630199/da09d015-b5f8-4e83-b283-3a39688ef3b4)

- **Dashboard**: 
     Upon successful information entry, students are directed to a dashboard that displays a welcome message and their information.
     The student's information, including name, email, level, and department, is displayed on the Dashboard.
     
![Dashboard](https://github.com/AWESOME04/SES-React-Project/assets/102630199/a1f39dd5-93ea-413e-98c3-d267e585c0b4)

### Backend/Web Service (Spring Boot)

The Spring Boot backend serves as the web service, exposing RESTful API endpoints to communicate with the front end. It includes controllers to handle user registration, authentication, student information, course management, and event tracking. Data validation is implemented to ensure data integrity and security.



### Mobile App (Flutter)

The Flutter mobile app provides a native user experience and shares a codebase with the web application. It utilizes the Provider package for state management, allowing efficient data sharing across the app. API calls are made using the HTTP package to communicate with the backend.

### User authentication
        Users can log in to the app using their email and password.
    
![login](https://github.com/AWESOME04/SES-Mobile-Application/assets/102630199/752ae247-f01d-4130-8686-a1543c6f39da)

### Student registration
        New students can register by providing their name, email, and password.
    
![stud reg](https://github.com/AWESOME04/SES-Mobile-Application/assets/102630199/9a5599a0-641a-4294-8446-eb7964fb35fe)

### Student information entry
        Registered students can enter their personal and academic information.

![stud info entry](https://github.com/AWESOME04/SES-Mobile-Application/assets/102630199/29916cc8-3ef5-4f5c-8942-f22bd158bf61)

### Dashboard
        The app provides a dashboard with the following features:
        Carousel slider displaying images related to the field of study.
        Upcoming events section displaying important events and their dates.
        Navigation drawer for accessing different sections of the app, including home, profile, courses, grades, and schedule.
        
![dash](https://github.com/AWESOME04/SES-Mobile-Application/assets/102630199/86737f4f-3a6e-4ba3-9e71-65581ff7940c)

### Database (PostgreSQL)

The PostgreSQL database stores and manages the application's data. It includes tables for user information, student details, course information, and grades. Foreign key constraints ensure data consistency and integrity.

## Testing

The application is thoroughly tested to ensure its quality and reliability. The testing approach includes:

1. Unit Testing: Individual components are tested in isolation to verify their correctness.
2. Integration Testing: Interaction between various modules is tested to ensure seamless communication.
3. End-to-End Testing: The entire application flow is tested to verify its behavior under different scenarios.

Test cases are documented and automated testing frameworks are utilized to enhance testing efficiency.

## Software Project Management

The project is managed using Agile principles, with regular sprints, stand-ups, and retrospectives. Tasks are managed using project management tools like Jira or Trello. The project plan includes the following phases:

      1. Requirement Analysis: Gathering and documenting project requirements.
      2. Design and Planning: Creating software models, architecture, and project schedule.
      3. Implementation: Developing the application according to the design.
      4. Testing and Quality Assurance: Thoroughly testing the application for quality assurance.
      5. Deployment: Deploying the application to production and staging environments.
      6. Maintenance: Providing ongoing support and bug fixes.

## Deployment

To deploy the application:

- Front End: The React application can hosted on a cloud platform (e.g., Netlify, Vercel). See the [LIVE WEBSITE HERE](https://ses-react-project.vercel.app/)
- Backend/Web Service: The Spring Boot backend can deployed on a cloud platform (e.g., AWS, Heroku).
- Mobile App: The Flutter mobile app can be distributed through app stores (e.g., Google Play Store, Apple App Store).

## Conclusion

This project successfully develops a comprehensive database-backed web and mobile application for an educational institution, addressing key problems related to student information management, course management, and event tracking. The implementation of React, Spring Boot, Flutter, and PostgreSQL ensures a seamless and user-friendly experience for students and faculty members.

## Contributors - GROUP 2

    EVANS ACHEAMPONG
    BENTIL B. REXFORD
    MICHELLE OWUSU
    MENSAH NYANYO HUBERT 
    ANANE GEORGE NYARKO
    DERY-KUUZUME SANDRA
    APPIAH YAW FRIMPONG
    
## Contributing

We welcome contributions to the Mobile System App project. If you would like to contribute, please follow these guidelines:

    Fork the repository.
    Create a new branch for your feature or bug fix.
    Commit your changes and push them to your branch.
    Submit a pull request detailing your changes.

## License

This project is licensed under the [MIT License](LICENSE).

