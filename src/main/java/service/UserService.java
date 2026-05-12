package service;

import dao.UserDAO;
import model.User;

import java.util.regex.Pattern;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    // EMAIL PATTERN BASIC
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    // =========================
    // REGISTER
    // =========================
    public boolean register(User user) throws Exception {

        validateRegister(user);

        // check duplicate username
        if (userDAO.isUsernameExist(user.getUsername())) {
            throw new Exception("Username already exists");
        }

        return userDAO.register(user);
    }

    // =========================
    // LOGIN
    // =========================
    public User login(String username, String password) throws Exception {

        if (isEmpty(username)) {
            throw new Exception("Username is empty");
        }

        if (isEmpty(password)) {
            throw new Exception("Password is empty");
        }

        User user = userDAO.login(username, password);

        if (user == null) {
            throw new Exception("Wrong username or password");
        }

        return user;
    }

    // =========================
    // VALIDATION REGISTER
    // =========================
    private void validateRegister(User user) throws Exception {

        if (user == null) {
            throw new Exception("User is null");
        }

        if (isEmpty(user.getUsername())) {
            throw new Exception("Username is empty");
        }

        if (isEmpty(user.getPassword())) {
            throw new Exception("Password is empty");
        }

        if (user.getPassword().length() < 6) {
            throw new Exception("Password must be >= 6 characters");
        }

        if (isEmpty(user.getEmail())) {
            throw new Exception("Email is empty");
        }

        if (!EMAIL_PATTERN.matcher(user.getEmail()).matches()) {
            throw new Exception("Invalid email format");
        }
    }

    // =========================
    // HELPER
    // =========================
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}