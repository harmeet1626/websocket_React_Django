import React, { useEffect, useState } from 'react';
import { useParams, Link, Outlet, useNavigate } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
import '../style/chat.css'
export const Conversation = () => {

  const [welcomeMessage, setWelcomeMessage] = useState("");
  const [messageHistory, setMessageHistory] = useState([]);
  const [message, setMessage] = useState("");
  const [user, setUser] = useState(() => AuthService.getCurrentUser())

  const [page, setPage] = useState(2);
  const [hasMoreMessages, setHasMoreMessages] = useState(false);

  const [participants, setParticipants] = useState([]);

  const [conversation, setConversation] = useState(null);

  const [typing, setTyping] = useState(false);

  // const { conversationName } = useParams();
  const conversationName = 'admin__harmeet'
    const navigate = useNavigate()

  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function fetchUsers() {
      const res = await fetch("http://127.0.0.1:8000/users/", {
        headers: {
          Authorization: `Token ${user?.token}`
        }
      });
      const data = await res.json();
      setUsers(data);
    }
    fetchUsers();
  }, [user]);

  function createConversationName(username) {
    const namesAlph = [user?.username, username].sort();
    return `${namesAlph[0]}__${namesAlph[1]}`;
  }










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
      console.log('message sent', data)
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
    sendJsonMessage({
      type: "chat_message",
      message
    });
    setMessage("");

  };
  function test() {
    console.log(messageHistory, 33333)
  }
  const listMessage = messageHistory.map((message) =>
    <h1>{message.content}</h1>
  )

  return (
    <div>
      <div className="container">
        <div className="row clearfix">
          <div className="col-lg-12">
            <div className="card chat-app">
              <div id="plist" className="people-list">
                <div className="input-group">
                  {/* <div className="input-group-prepend">
                    <span className="input-group-text"><i className="fa fa-search"></i></span>
                  </div>
                  <input type="text" className="form-control" placeholder="Search..." /> */}
                </div>
                <div className='list-container'>
                  <ul className="list-unstyled chat-list mt-2 mb-0 " >
                    {users &&
                      users
                        .filter((u) => u.username !== user?.username)
                        .map((user) => (
                          <li className="clearfix" key={user.username}>
                            <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar" />
                            <div className="about">
                              <Link to={`user/${createConversationName(user.username)}`} className="name">{user.username}</Link>
                              {/* <div className="status"> <i className="fa fa-circle offline"></i> offline since Oct 28 </div> */}
                            </div>
                          </li>
                        ))
                    }
                  </ul>
                </div>
              </div>
              <Outlet />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

