import React, { useEffect, useState } from 'react';
import { useParams, Link, Outlet, useNavigate, useLocation, redirect } from 'react-router-dom';
import AuthService from '../auth/AuthService';
import '../style/chat.css'
import Avatar from 'react-avatar';

export const Conversation = () => {
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const navigate = useNavigate()
    const [users, setUsers] = useState([]);
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const location = useLocation()
    const [groupList, setGroupList] = useState([])
    useEffect(() => {
        async function fetchUsers() {
            if (!user?.username) {
                navigate('/login')
            }
            const res = await fetch(`http://${apiUrl}UserGroup/`, {
                headers: {
                    Authorization: `Token ${user?.token}`
                }
            });
            const data = await res.json();
            if (data?.detail == "Invalid token.") {
                navigate('/login')
            }
            // setUsers(data);
            setGroupList(data.res)
        }
        fetchUsers();
    }, [user])
    useEffect(() => {
        async function fetchUsers() {
            if (!user?.username) {
                navigate('/login')
            }
            const res = await fetch(`http://${apiUrl}users/`, {
                headers: {
                    Authorization: `Token ${user?.token}`
                }
            });
            const data = await res.json();
            setUsers(data);
        }
        fetchUsers();
    }, []);

    const [homepage, setHomepage] = useState()
    useEffect(() => {
        if (location.pathname == '/') {
            setHomepage(true)
        }
        else {
            setHomepage(false)
        }
    }, [location])

    function createConversationName(username) {
        const namesAlph = [user?.username, username].sort();
        return `${namesAlph[0]}__${namesAlph[1]}`;
    }
    const inputStyle = {
        padding: '10px',
        fontSize: '16px',
        border: '2px solid #ccc',
        borderRadius: '30px',
        outline: 'none',
        width: '100%',
        height: "40px"
    };

    const [searchTerm, setSearchTerm] = useState('');
    const filteredData = users?.filter((item) =>
        item.username.toLowerCase().includes(searchTerm.toLowerCase())
    );
    const handleSearch = (e) => {
        setSearchTerm(e.target.value);
    };

    return (

        <div className="row clearfix" >
            <div className="col-lg-12">
                <div className="card chat-app" style={{ backgroundColor: "whitesmoke", display: "flex" }}>
                    <div id="plist" className="people-list"  >
                        <div>
                            <div className="input-group">
                                <input style={inputStyle} placeholder='search user' value={searchTerm}
                                    onChange={handleSearch} /><br></br>
                            </div>
                            <ul className="list-unstyled chat-list mt-2 mb-0" >
                                <p>Groups</p>
                                {groupList
                                    .map((group, index) => (
                                        <div key={index}>
                                            <li className="clearfix" style={{ borderBottom: "1px solid #ddd" }}>
                                                <Link to={`groups/${group}`}>
                                                    <div className="about" style={{ display: "flex" }}>
                                                        <Avatar
                                                            name={group}
                                                            round={true} // Optional: Makes the avatar round
                                                            size="30"   // Optional: Set the size of the avatar
                                                        />&nbsp;&nbsp;
                                                        <p style={{ padding: "5px" }} className="name">{group}</p>
                                                    </div>
                                                </Link>
                                            </li>
                                        </div>
                                    ))}

                                <p>Direct Mssages</p>
                                {users &&
                                    filteredData
                                        .filter((u) => u.username !== user?.username)
                                        .map((user, index) => (
                                            <div key={index}>
                                                <li className="clearfix" style={{ borderBottom: "1px solid #ddd" }}>
                                                    <Link to={`user/${createConversationName(user.username)}`}>
                                                        <div className="about" style={{ display: "flex" }}>
                                                            <Avatar
                                                                name={user.username}
                                                                round={true} // Optional: Makes the avatar round
                                                                size="30"   // Optional: Set the size of the avatar
                                                            />&nbsp;&nbsp;
                                                            <p style={{ padding: "5px" }} className="name">{user.username}</p>
                                                        </div>
                                                    </Link>
                                                </li>
                                            </div>
                                        ))}
                            </ul>
                        </div>

                    </div>
                    <div>
                        {homepage ?
                            <div style={{ marginLeft: '20%', }}>
                                <img style={{ height: '100%', width: '100%' }} src='https://plus.unsplash.com/premium_photo-1661521092142-b03326bcc8bc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' />
                            </div> :
                            <Outlet />
                        }
                    </div>
                </div>
            </div>
        </div>

    );
};

