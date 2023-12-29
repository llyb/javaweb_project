package pojo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Orders {
    private String id; // 订单的编号,随机生成
    private float total_price; // 当前订单的支付金额
    private int num; // 当前订单中商品的数量
    private int state; // 0表示未发货，1表示发货
    private String time; // 订单创建的时间
    private List<OrdersItem> items = new ArrayList<OrdersItem>(); // 存储当前订单的订单项
    private User user; // 当前订单的所有者

    public Orders() {

    }

    public Orders(String id, float total_price, int num, int state, String time, List<OrdersItem> items, User user) {
        this.id = id;
        this.total_price = total_price;
        this.num = num;
        this.state = state;
        this.time = time;
        this.items = items;
        this.user = user;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getNum() {
        return num;
    }

    public void setTotal_price(float total_price) {
        this.total_price = total_price;
    }

    public float getTotal_price() {
        return total_price;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setState(int state) {
        this.state = state;
    }

    public void setItems(List<OrdersItem> items) {
        this.items = items;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getId() {
        return id;
    }


    public int getState() {
        return state;
    }

    public List<OrdersItem> getItems() {
        return items;
    }

    public User getUser() {
        return user;
    }
}
