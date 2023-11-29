import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';

export const Chat = () => {

  const [welcomeMessage, setWelcomeMessage] = useState("");
  const [messageHistory, setMessageHistory] = useState([]);
  const [message, setMessage] = useState("");
  const [user, setUser] = useState(() => AuthService.getCurrentUser())

  const [page, setPage] = useState(2);
  const [hasMoreMessages, setHasMoreMessages] = useState(false);

  const [participants, setParticipants] = useState([]);

  const [conversation, setConversation] = useState(null);

  const [typing, setTyping] = useState(false);

  const { conversationName } = useParams();

  const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://127.0.0.1:8000/chats/${conversationName}/` : null, {
    queryParams: {
      token: user ? user.token : "",
    },
    onOpen: () => {
      console.log("Connected!");
    },
    onClose: () => {
      console.log("Disconnected!");
    },
    // onMessage handler
    onMessage: (e) => {
      const data = JSON.parse(e.data);
      switch (data.type) {
        case "welcome_message":
          setWelcomeMessage(data.message);
          break;
        case "chat_message_echo":
          setMessageHistory((prev) => [data.message, ...prev]);
          sendJsonMessage({ type: "read_messages" });
          break;
        case "last_50_messages":
          setMessageHistory(data.messages);
          setHasMoreMessages(data.has_more);
          break;
        case "user_join":
          setParticipants((pcpts) => {
            if (!pcpts.includes(data.user)) {
              return [...pcpts, data.user];
            }
            return pcpts;
          });
          break;
        case "user_leave":
          setParticipants((pcpts) => {
            const newPcpts = pcpts.filter((x) => x !== data.user);
            return newPcpts;
          });
          break;
        case "online_user_list":
          setParticipants(data.users);
          break;

        case 'typing':
          // updateTyping(data);
          break;

        default:
          console.error("Unknown message type!");
          break;
      }
    }
  });



  useEffect(() => {
    async function fetchConversation() {
      console.log(user)
      const apiRes = await fetch(`http://127.0.0.1:8000/conversations/${conversationName}/`, {
        method: "GET",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          Authorization: `Token ${user?.token}`
        }
      });
      if (apiRes.status === 200) {
        const data = await apiRes.json();
        setConversation(data);
      }
    }
    fetchConversation();
  }, [conversationName, user]);




  const connectionStatus = {
    [ReadyState.CONNECTING]: "Connecting",
    [ReadyState.OPEN]: "Open",
    [ReadyState.CLOSING]: "Closing",
    [ReadyState.CLOSED]: "Closed",
    [ReadyState.UNINSTANTIATED]: "Uninstantiated"
  }[readyState];
  useEffect(() => {
    if (connectionStatus === "Open") {
      sendJsonMessage({
        type: "read_messages"
      });
    }
  }, [connectionStatus, sendJsonMessage]);

  function handleChangeMessage(e) {
    setMessage(e.target.value);
    // onType();
  }

  const handleSubmit = () => {
    if (message.length === 0) return;
    if (message.length > 512) return;
    sendJsonMessage({
      type: "chat_message",
      message
    });
    setMessage("");

  };
  const listMessage = messageHistory.map((message) =>
    <h1>{message.content}</h1>
  )

  return (
    <div>
      <span>The WebSocket is currently {connectionStatus}</span>
      <div>
        <input
          type="text"
          value={message}
          onChange={(e) => setMessage(e.target.value)}
        />
        <button onClick={() => { handleSubmit() }}>Send Message</button>
        <button onClick={() => test()}>Test</button> <br></br>
        <h1>{listMessage}</h1>
        {/* {messageHistory.map((message)=>{
          <h1>{message?.content}hi</h1>
        })} */}
      </div>
    </div>
  );
};

