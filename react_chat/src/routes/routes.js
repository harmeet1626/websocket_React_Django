import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "../pages/Login";
import { Conversation } from "../pages/Conversation";
import { Chat } from "../pages/Chat";
import { Chat_test } from "../pages/Chat_test";
export const Router_view = () => {
    return (
        <Routes>
            <Route element={<Login />} path="/login" />
            <Route element={<Conversation />} path='/' />
            <Route element={<Chat />} path="/chats/:conversationName" />
            <Route element={<Chat_test />} path="/test" /> 
        </Routes>
    )
}