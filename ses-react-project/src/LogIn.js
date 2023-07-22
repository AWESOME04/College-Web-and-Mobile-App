// LogIn.js
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './LogIn.css'; // Import the CSS file for styling
import logo from './school-logo.png'; // Import the school logo image

const LogIn = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const handleLogin = (e) => {
        e.preventDefault();
        // Handle login logic
        // If login is successful, navigate to the dashboard page
        navigate('/student-info-entry');
    };

    return (
        <div className="login-container">
            <div className="login-content">
                <h2>Login</h2>
                <img className="login-logo" src={logo} alt="School Logo" />
                <form className="login-form" onSubmit={handleLogin}>
                    <input
                        className="login-input"
                        type="text"
                        placeholder="Email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                    <input
                        className="login-input"
                        type="password"
                        placeholder="Password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                    />
                    <button className="login-button" type="submit">
                        Log In
                    </button>
                    <p className="registration-link">
                        Not registered yet? <Link to="/">Register here</Link>
                    </p>
                </form>
            </div>
        </div>
    );
};

export default LogIn;
