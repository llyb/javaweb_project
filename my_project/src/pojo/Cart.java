package pojo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class Cart {
    // 商品：购买的数量
    private HashMap<Good, Integer> goods;
    // 购物车的总金额
    private double totalPrice;

    public Cart() {
        this.goods = new HashMap<>();
        this.totalPrice = 0.0;
    }

    public void setGoods(HashMap<Good, Integer> goods) {
        this.goods = goods;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public HashMap<Good, Integer> getGoods() {
        return goods;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    // 添加商品到购物车
    public boolean addGoodsInCart(Good good, int number) {
        if (goods.containsKey(good)) { // 如果不是第一次购买当前的商品
            goods.put(good, goods.get(good) + number);
        } else { // 第一次购买当前的商品
            goods.put(good, number);
        }
        goods.put(good, number);
        calTotalPrice();
        return true;
    }

    // 删除商品
    public boolean removeGoodsFromCart(Good good) {
        goods.remove(good);
        calTotalPrice();
        return true;
    }

    // 统计购物车的总金额
    public double calTotalPrice() {
        double sum = 0;
        Set<Good> keys = goods.keySet();
        Iterator<Good> iterator = keys.iterator();
        while (iterator.hasNext()) {
            Good good = iterator.next();
            sum += good.getPrice() * goods.get(good);
        }
        this.setTotalPrice(sum); // 设置购物车的总金额
        return sum;
    }

    public static void main(String[] args) {
        Good good = new Good("沃特篮球鞋", "温州", 200, 500, "001.jpg");
        Good good1 = new Good("沃特篮球鞋", "广州", 300, 500, "002.jpg");

        Cart c = new Cart();
        c.addGoodsInCart(good, 1);
        c.addGoodsInCart(good1, 2);
        System.out.println(c.totalPrice);

        Set<Map.Entry<Good, Integer>> goods = c.getGoods().entrySet();
        for (Map.Entry<Good, Integer> obj : goods) {
            System.out.println(obj);
        }
    }
}
