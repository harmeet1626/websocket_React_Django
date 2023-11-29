import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
import '../style/chat.css'
export const Chat_test = () => {

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
                  <div className="input-group-prepend">
                    <span className="input-group-text"><i className="fa fa-search"></i></span>
                  </div>
                  <input type="text" className="form-control" placeholder="Search..." />
                </div>
                <ul className="list-unstyled chat-list mt-2 mb-0">
                  { users &&
                      users
                        .filter((u) => u.username !== user?.username)
                        .map((user) => (
                            <li className="clearfix"  key={user.username}>
                              <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar" />
                              <div className="about">
                                <Link to={`chats/${createConversationName(user.username)}`} className="name">{user.username}</Link>
                                {/* <div className="status"> <i className="fa fa-circle offline"></i> offline since Oct 28 </div> */}
                              </div>
                            </li>
                        ))
                    }
                  {/* <li className="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Vincent Porter</div>
                            <div className="status"> <i className="fa fa-circle offline"></i> left 7 mins ago </div>                                            
                        </div>
                    </li>
                    <li className="clearfix active">
                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Aiden Chavez</div>
                            <div className="status"> <i className="fa fa-circle online"></i> online </div>
                        </div>
                    </li>
                    <li className="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Mike Thomas</div>
                            <div className="status"> <i className="fa fa-circle online"></i> online </div>
                        </div>
                    </li>                                    
                    <li className="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Christian Kelly</div>
                            <div className="status"> <i className="fa fa-circle offline"></i> left 10 hours ago </div>
                        </div>
                    </li>
                    <li className="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar8.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Monica Ward</div>
                            <div className="status"> <i className="fa fa-circle online"></i> online </div>
                        </div>
                    </li> */}
                  {/* <li className="clearfix">
                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar" />
                        <div className="about">
                            <div className="name">Dean Henry</div>
                            <div className="status"> <i className="fa fa-circle offline"></i> offline since Oct 28 </div>
                        </div>
                    </li> */}
                </ul>
              </div>
              <div className="chat">
                <div className="chat-header clearfix">
                  <div className="row">
                    <div className="col-lg-6">
                      <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar" />
                      </a>
                      <div className="chat-about">
                        <h6 className="m-b-0">Aiden Chavez</h6>
                        <small>Last seen: 2 hours ago</small>
                      </div>
                    </div>
                    <div className="col-lg-6 hidden-sm text-right">
                      <a href="javascript:void(0);" className="btn btn-outline-secondary"><i className="fa fa-camera"></i></a>
                      <a href="javascript:void(0);" className="btn btn-outline-primary"><i className="fa fa-image"></i></a>
                      <a href="javascript:void(0);" className="btn btn-outline-info"><i className="fa fa-cogs"></i></a>
                      <a href="javascript:void(0);" className="btn btn-outline-warning"><i className="fa fa-question"></i></a>
                    </div>
                  </div>
                </div>
                <div className="chat-history">
                  <ul className="m-b-0">
                    <li className="clearfix">
                      <div className="message-data text-right">
                        <span className="message-data-time">10:10 AM, Today</span>
                        <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar" />
                      </div>
                      <div className="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div>
                    </li>
                    <li className="clearfix">
                      <div className="message-data">
                        <span className="message-data-time">10:12 AM, Today</span>
                      </div>
                      <div className="message my-message">Are we meeting today?</div>
                    </li>
                    <li className="clearfix">
                      <div className="message-data">
                        <span className="message-data-time">10:15 AM, Today</span>
                      </div>
                      <div className="message my-message">Project has been already finished and I have results to show you.</div>
                    </li>
                  </ul>
                </div>
                <div className="chat-message clearfix">
                  <div className="input-group mb-0">
                    <div className="input-group-prepend">
                      <span className="input-group-text"><i className="fa fa-send"></i></span>
                    </div>
                    <input type="text" className="form-control" placeholder="Enter text here..." />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

