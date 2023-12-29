package pojo;

// 订单项：每一个订单项中记录一个商品对象的信息
public class OrdersItem {
    private String id; // 订单项的编号
    private int num; // 当前商品购买的数量
    private float price; // 当前商品应付的总金额
    private int good_id; // 商品的编号
    private Good good; // 对应商品的信息
    private String order_id; // 所属的订单的编号

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public OrdersItem() {

    }

    public OrdersItem(String id, int num, float price, Good good) {
        this.id = id;
        this.num = num;
        this.price = price;
        this.good = good;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public int getGood_id() {
        return good_id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setGood(Good good) {
        this.good = good;
    }

    public String getId() {
        return id;
    }

    public int getNum() {
        return num;
    }

    public float getPrice() {
        return price;
    }

    public Good getGood() {
        return good;
    }
}
