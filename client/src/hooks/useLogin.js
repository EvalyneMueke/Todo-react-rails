import React, { useState } from "react";
import { login } from "../services/webApis";

export const useLogin = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async (e) => {
    e.preventDefault();

    // login payload
    const loginPayload = {
        email,
        password
    }

    // hit the endpoint
    try {
        const response = await login(loginPayload)

        console.log(response)
        // destructure the user & token
        const {data: {token, user}} = response;  
        // set the user and token to the localstorage 

        // redirect the user to the protected page
    } catch (error) {
        console.log(error)
    }
  };

  return {
    email,
    setEmail,
    password,
    setPassword,
    handleLogin,
  };
};