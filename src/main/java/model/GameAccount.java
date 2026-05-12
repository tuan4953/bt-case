package model;

public class GameAccount {

    private int id;

    private String gameName;

    private String accountName;

    private double price;

    private String status;

    private String image;

    // =========================
    // OPTIONAL (CHO MỞ RỘNG SAU)
    // =========================
    private int categoryId;

    public GameAccount() {
    }

    public GameAccount(String gameName,
                       String accountName,
                       double price,
                       String status,
                       String image) {

        this.gameName = gameName;
        this.accountName = accountName;
        this.price = price;
        this.status = status;
        this.image = image;
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

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // =========================
    // OPTIONAL CATEGORY
    // =========================
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // =========================
    // DEBUG (RẤT HỮU ÍCH)
    // =========================
    @Override
    public String toString() {
        return "GameAccount{" +
                "id=" + id +
                ", gameName='" + gameName + '\'' +
                ", accountName='" + accountName + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                ", image='" + image + '\'' +
                ", categoryId=" + categoryId +
                '}';
    }
}