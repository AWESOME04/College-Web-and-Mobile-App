import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import StudentRegistration from './StudentRegistration';
import LogIn from './LogIn';
import StudentInfoEntry from './StudentInfoEntry';
import Dashboard from './Dashboard';

const App = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<StudentRegistration />} />
                <Route path="/login" element={<LogIn />} />
                <Route path="/student-info-entry" element={<StudentInfoEntry />} />
                <Route path="/dashboard" element={<Dashboard />} />
            </Routes>
        </Router>
    );
};

export default App;
