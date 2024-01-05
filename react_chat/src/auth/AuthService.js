import axios from "axios";

class AuthService {
  setUserInLocalStorage(data) {
    localStorage.setItem("user", JSON.stringify(data));
  }
  async login(username, password) {
    const apiUrl = process.env.REACT_APP_API_BASE_URL;

    try {
      const response = await axios.post(`http://${apiUrl}auth-token/`, { username, password });
      if (!response.data.token) {
        return response.data;
      }
      this.setUserInLocalStorage(response.data);
      this.getCurrentUser()
      return response.data;
    }
    catch (e) {
      console.log(e)
    }
  }

  logout() {
    localStorage.removeItem("user");
  }

  getCurrentUser() {
    const user = localStorage.getItem("user");
    return JSON.parse(user);
  }
}

export default new AuthService();