// api.js
const BASE_URL = 'http://localhost:8673/api'; // Update the base URL with your Spring Boot backend URL

export const registerUser = async (userData) => {
    try {
        const response = await fetch(`${BASE_URL}/users/register`, { // Updated endpoint to "/users/register"
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        });

        if (!response.ok) {
            throw new Error('Registration failed.'); // You can customize the error message here
        }

        return await response.json();
    } catch (error) {
        console.error('Error occurred during registration:', error); // Log the actual error message to the console
        throw new Error('Error occurred during registration.'); // You can customize the error message here
    }
};


export const loginUser = async (userData) => {
    try {
        const response = await fetch(`${BASE_URL}/users/login`, { // Updated endpoint to "/users/login"
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        });

        if (!response.ok) {
            throw new Error('Login failed.'); // You can customize the error message here
        }

        return await response.json();
    } catch (error) {
        throw new Error('Error occurred during login.'); // You can customize the error message here
    }
};

// ... (Additional API functions for submitting student info and fetching data)
