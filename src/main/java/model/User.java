package model;

public class User {

    private int id;

    private String username;

    private String password;

    private String email;

    private double balance;

    private String role;

    // =========================
    // OPTIONAL: AUDIT FIELD
    // =========================
    private String createdAt;

    public User() {
    }

    public User(String username,
                String password,
                String email) {

        this.username = username;
        this.password = password;
        this.email = email;
    }

    public User(int id,
                String username,
                String password,
                String email,
                double balance,
                String role) {

        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.balance = balance;
        this.role = role;
    }

    // =========================
    // GETTER / SETTER
    // =========================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // =========================
    // OPTIONAL CREATED TIME
    // =========================
    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    // =========================
    // DEBUG
    // =========================
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", balance=" + balance +
                ", role='" + role + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}