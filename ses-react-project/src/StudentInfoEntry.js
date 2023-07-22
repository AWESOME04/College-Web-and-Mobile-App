import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './StudentInfoEntry.css'; // Import the CSS file for styling

const StudentInfoEntry = () => {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [level, setLevel] = useState('');
    const [department, setDepartment] = useState('');
    const navigate = useNavigate();

    const handleInfoEntry = (e) => {
        e.preventDefault();
        // Handle student information entry logic
        // If successful, navigate to the Dashboard page
        navigate('/dashboard');
    };

    return (
        <div className="info-entry-container">
            <h1 className="info-entry-heading">Student Information Entry</h1>
            <form className="info-entry-form" onSubmit={handleInfoEntry}>
                <input
                    className="info-entry-input"
                    type="text"
                    placeholder="Name"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                />
                <input
                    className="info-entry-input"
                    type="email"
                    placeholder="Email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                />
                <input
                    className="info-entry-input"
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
                <input
                    className="info-entry-input"
                    type="text"
                    placeholder="Level"
                    value={level}
                    onChange={(e) => setLevel(e.target.value)}
                />
                <input
                    className="info-entry-input"
                    type="text"
                    placeholder="Department"
                    value={department}
                    onChange={(e) => setDepartment(e.target.value)}
                />
                <button className="info-entry-button" type="submit">
                    Submit
                </button>
            </form>
        </div>
    );
};

export default StudentInfoEntry;
