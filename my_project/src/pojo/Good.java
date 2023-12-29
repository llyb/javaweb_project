package pojo;

public class Good {
    private int id;
    private String name;
    private String city;
    private int price;
    private int number;
    private String picture;

    public Good(String name, String city, int price, int number, String picture) {
        this.name = name;
        this.city = city;
        this.price = price;
        this.number = number;
        this.picture = picture;
    }

    public Good() {

    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getCity() {
        return city;
    }

    public int getPrice() {
        return price;
    }

    public int getNumber() {
        return number;
    }

    public String getPicture() {
        return picture;
    }

    @Override
    public String toString() {
        return "Good{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", city='" + city + '\'' +
                ", price=" + price +
                ", number=" + number +
                ", picture='" + picture + '\'' +
                '}';
    }

    @Override
    public int hashCode() { // 规范：对下面判断相等的条件转化成哈希码
        return this.getId() + this.getName().hashCode();
    }

    @Override
    public boolean equals(Object obj) { // 对象判断相等的方式
        if (this == obj) {
            return true;
        }
        if (obj instanceof Good) {
            Good good = (Good) obj;
            if (this.getId() == good.getId() && this.getName().equals(good.getName())) {
                return true;
            } else {
                return false;
            }
        }
        else {
            return false;
        }
    }
}
