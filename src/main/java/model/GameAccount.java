package model;

public class GameAccount {

    private int id;

    private int gameId;

    private String gameName;

    private String accountName;

    // TÀI KHOẢN GAME
    private String accountUser;

    private String accountPass;

    // MÔ TẢ
    private String description;

    // RANK
    private String rankName;

    // GIÁ
    private double price;

    // STATUS
    private String status;

    // ẢNH
    private String image;

    // CATEGORY OPTIONAL
    private int categoryId;

    // =========================
    // CONSTRUCTOR
    // =========================

    public GameAccount() {
    }

    public GameAccount(
            String gameName,
            String accountName,
            double price,
            String status,
            String image
    ) {

        this.gameName = gameName;
        this.accountName = accountName;
        this.price = price;
        this.status = status;
        this.image = image;
    }

    // =========================
    // ID
    // =========================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // =========================
    // GAME ID
    // =========================

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    // =========================
    // GAME NAME
    // =========================

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    // =========================
    // ACCOUNT NAME
    // =========================

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    // =========================
    // ACCOUNT USER
    // =========================

    public String getAccountUser() {
        return accountUser;
    }

    public void setAccountUser(String accountUser) {
        this.accountUser = accountUser;
    }

    // =========================
    // ACCOUNT PASS
    // =========================

    public String getAccountPass() {
        return accountPass;
    }

    public void setAccountPass(String accountPass) {
        this.accountPass = accountPass;
    }

    // =========================
    // DESCRIPTION
    // =========================

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // =========================
    // RANK
    // =========================

    public String getRankName() {
        return rankName;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    // =========================
    // PRICE
    // =========================

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // =========================
    // STATUS
    // =========================

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // =========================
    // IMAGE
    // =========================

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // =========================
    // CATEGORY
    // =========================

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // =========================
    // DEBUG
    // =========================

    @Override
    public String toString() {

        return "GameAccount{" +
                "id=" + id +
                ", gameId=" + gameId +
                ", gameName='" + gameName + '\'' +
                ", accountName='" + accountName + '\'' +
                ", accountUser='" + accountUser + '\'' +
                ", accountPass='" + accountPass + '\'' +
                ", description='" + description + '\'' +
                ", rankName='" + rankName + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                ", image='" + image + '\'' +
                ", categoryId=" + categoryId +
                '}';
    }


}