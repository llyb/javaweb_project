package pojo;

public class User {
    int user_id;
    String username;
    String password;
    boolean islogin;

    public User() {
    }

    public User(String username, String password, boolean islogin) {
        this.username = username;
        this.password = password;
        this.islogin = islogin;
    }

    public int getId() {
        return user_id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public boolean isIslogin() {
        return islogin;
    }

    public void setId(int id) {
        this.user_id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setIslogin(boolean islogin) {
        this.islogin = islogin;
    }
}
