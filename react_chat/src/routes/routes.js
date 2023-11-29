import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "../pages/Login";
import { Conversation } from "../pages/Conversation";
import { Chat } from "../pages/Chat";
import { ChatComponent } from "../components/chatComponent";
export const Router_view = () => {
    return (
        <Routes>
            <Route element={<Login />} path="/login" />
            <Route element={<Conversation />} path='/' >
                <Route element={<ChatComponent />} path=":conversationName" />
            </ Route>
            <Route element={<Chat />} path="/chats/:conversationName" />

        </Routes>
    )
}