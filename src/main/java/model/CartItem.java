package model;

public class CartItem {

    private int accountId;
    private String accountName;
    private double price;
    private String image;

    public CartItem() {}

    public CartItem(int accountId, String accountName, double price, String image) {
        this.accountId = accountId;
        this.accountName = accountName;
        this.price = price;
        this.image = image;
    }

    // getter + setter
}