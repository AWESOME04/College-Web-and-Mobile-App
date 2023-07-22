// StudentRegistration.js
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './StudentRegistration.css'; // Import the CSS file for styling
import logo from './school-logo.png'; // Import the school logo image

const StudentRegistration = () => {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [registered, setRegistered] = useState(false);
    const navigate = useNavigate();

    const handleRegistration = (e) => {
        e.preventDefault();
        // Handle registration logic
        // If registration is successful, set "registered" to true
        setRegistered(true);
    };

    return (
        <div className="registration-container">
            <div className="registration-content">
                <h1 className="registration-heading">Student Registration</h1>
                <img className="registration-logo" src={logo} alt="School Logo" />
                {!registered ? (
                    <form className="registration-form" onSubmit={handleRegistration}>
                        <input
                            className="registration-input"
                            type="text"
                            placeholder="Name"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                        />
                        <input
                            className="registration-input"
                            type="email"
                            placeholder="Email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                        />
                        <input
                            className="registration-input"
                            type="password"
                            placeholder="Password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                        />
                        <button className="registration-button" type="submit">
                            Register
                        </button>
                        <p className="login-link">
                            Already registered? <Link to="/login">Login here</Link>
                        </p>
                    </form>
                ) : (
                    <div className="registration-success">
                        <p>Registration successful!</p>
                        <p>
                            Please proceed to <Link to="/login">Login</Link>.
                        </p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default StudentRegistration;
