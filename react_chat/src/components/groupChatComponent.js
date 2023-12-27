import { useEffect, useState, useRef } from "react"
import { useParams } from "react-router-dom"
import Avatar from 'react-avatar';
import AuthService from '../auth/AuthService';
import InputEmoji from 'react-input-emoji'
import useWebSocket, { ReadyState } from "react-use-websocket";

export const GroupChat = () => {
    const params = useParams()
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const [messageHistory, setMessageHistory] = useState([]);
    const [message, setMessage] = useState("");
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const reverced_messageHistory = [...messageHistory].reverse()
    const containerRef = useRef(null);
    const fileInputRef = useRef(null);
    const group_name = params.groupName
    const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://${apiUrl}groupChat/${group_name}/` : null, {
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
            console.log('websocket triggered')
            switch (data.type) {
                case "welcome_message":
                    // setWelcomeMessage(data.message);
                    break;
                case 'file':
                    console.log("file event triggered onMessage")
                    // const fileUrlOrIdentifier = data.file_url_or_identifier;
                    break;
                case "chat_message_echo":
                    console.log(data, 'event is wotking for message')
                    setMessageHistory(data.message)
                    // setMessageHistory((prev) => [data.message, ...prev]);
                    // sendJsonMessage({ type: "read_messages" });
                    break;
                case "last_50_messages":
                    console.log(data.messages)
                    setMessageHistory(data.messages);
                    // setHasMoreMessages(data.has_more);
                    break;
                case "user_join":
                    console.log('user join')
                    // setParticipants((pcpts) => {
                    //     if (!pcpts.includes(data.user)) {
                    //         return [...pcpts, data.user];
                    //     }
                    //     return pcpts;
                    // });
                    break;
                case "user_leave":
                    // setParticipants((pcpts) => {
                    //     const newPcpts = pcpts.filter((x) => x !== data.user);
                    //     return newPcpts;
                    // });
                    break;
                case "online_user_list":
                    // setParticipants(data.users);
                    break;

                case 'typing':
                    console.log('user typing')
                    // updateTyping(data);
                    break;

                default:
                    console.error("Unknown message type!");
                    break;
            }
        }
    });
    function formatTime(timestamp) {
        const date = new Date(timestamp);
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const formattedTime = `${hours}:${minutes}`;
        return formattedTime
    }
    const handleSubmit = () => {
        if (message.length === 0) return;
        if (message.length > 512) return;
        sendJsonMessage({
            type: "group_chat_message",
            message
        });
        setMessage("");
    };
    const handleKeyPress = (e) => {
        handleSubmit()
    };
    useEffect(() => {
        scrollToBottom()
    }, [])
    useEffect(() => {
        scrollToBottom();
    }, [messageHistory]);
    const scrollToBottom = async () => {
        const containerHeight = containerRef.current.scrollHeight;
        await containerRef.current.scrollTo({
            top: containerHeight,
            behavior: 'instant',
        })
    };
    const handleFileChange = (e) => {
        const selectedFile = e.target.files[0];

        if (selectedFile) {
            uploadDocument(selectedFile)
        }
    };
    async function uploadDocument(fileName) {
        const apiEndpoint = `http://${apiUrl}documentUpload/`;

        const form_Data = new FormData()
        form_Data.append("image", fileName)

        await fetch(apiEndpoint, {
            method: 'PUT',
            body: form_Data

        })
            .then(response => response.json())
            .then(data => {
                console.log(data, "file uploaded")
                let file_url = data.response[0].file.file
                sendJsonMessage({
                    type: "group_file",
                    file_url
                })
            })
            .catch(error => {
                console.error('API Error:', error);
            });
    }
    return (
        <>
            <div className="chat" >
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke", height: '65px' }}>
                    <div className="row">
                        <div className="col-lg-6">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                            </a>
                            <div className="chat-about" style={{ display: "flex" }}>
                                <Avatar
                                    name={params.groupName}
                                    round={true}
                                    size="30"
                                />&nbsp;&nbsp;
                                <h6 style={{ padding: "5px", textTransform: 'uppercase' }} className="m-b-0">{params.groupName}</h6>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="chat-history" ref={containerRef} style={{
                    height: '70vh',
                    width: '100%',
                    overflow: 'auto',
                    border: '1px solid #C0C0C0',
                    backgroundColor: '#e3e3e3',
                    borderRadius: "30px"
                }}>
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message, index) => (
                            <li className="clearfix" key={index}>
                                <div>
                                    <div style={{ padding: "5px 20px", wordBreak: "break-word", backgroundColor: message.from_user_id === user.username ? "rgb(133 196 235)" : "#f3f3f3" }} className={message.from_user_id === user.username ? "message other-message float-right" : "message my-message"}>
                                        {message.from_user_id == user.username ? "" :
                                            <div style={{ fontWeight: "bold", color: 'maroon', textTransform: 'capitalize', fontSize: '12px', height: '20px' }}>{message.from_user_id}</div>
                                        }
                                        {message.content == "" ?
                                            <img style={{ height: "150px" }} src={'http://127.0.0.1:8000' + message.file} />
                                            :
                                            message.content
                                        }

                                        <br />
                                        <span style={{ fontSize: "10px", alignSelf: "flex-end", width: '170px', textAlign: "end" }} className={message.from_user_id === user.username ? "message-data-time float-right" : "message-data-time float-right"}>
                                            <div style={{ display: "flex", float: 'right' }}>
                                                <span style={{ marginLeft: '5px', display: message.from_user_id === user.username ? "block" : "none" }}>✓</span>
                                                <span style={{ marginLeft: '-3px', color: 'green', float: 'right', display: message.read == true && message.from_user_id === user.username ? 'block' : 'none' }}>✓</span>
                                            </div>
                                            {formatTime(message.timestamp)}
                                        </span>
                                    </div>
                                </div>
                            </li>
                        ))}
                    </ul>
                </div>


                <div className="input-group mb-0" style={{ flexWrap: "unset" }}>
                    <InputEmoji
                        cleanOnEnter
                        onChange={setMessage}
                        onEnter={handleKeyPress}
                        value={message}
                        type="text"
                        className="form-control"
                        placeholder="Enter text here..."
                        style={{ backgroundColor: 'white' }}
                    />
                    <input
                        type="file"
                        ref={fileInputRef}
                        style={{ display: 'none' }}
                        onChange={handleFileChange}
                        accept="image/png, image/jpeg"
                    />
                    <div className="input-group-prepend" style={{ padding: '2px' }}>

                        <span style={{
                            backgroundColor: "white",
                            padding: "5px",
                            marginTop: '10px',
                            cursor: 'pointer',
                            border: 'none',
                        }}
                            onClick={() => {
                                fileInputRef.current.click();
                            }} class="material-symbols-outlined">
                            attachment
                        </span>
                    </div>

                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span style={{ marginTop: '10px', cursor: 'pointer', padding: "5px" }}
                            onClick={() => { handleSubmit() }} class="material-symbols-outlined">
                            send
                        </span>
                    </div>
                </div>
            </div>
        </>
    )
}