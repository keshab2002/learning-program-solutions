import java.util.*;

class Product{
    private int productId;
    private String productName;
    private String category;

    public Product(int productId, String productName, String categoty){
        this.productId = productId;
        this.productName = productName;
        this.category = categoty;
    }

    public String getProductName(){
        return productName;
    }

    public String toString(){
        return "Product[ID=" + productId + ", Name=" + productName + ", Category=" + category + "]";
    }
}

class Search{
    public static Product linearSearch(Product[] products, String targetName){
        for (Product product : products) {
            if (product.getProductName().equalsIgnoreCase(targetName)) {
                return product;
            }
        }
        return null;
    }

        public static Product binarySearch(Product[] products, String targetName) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = (left + right) / 2;
            String midName = products[mid].getProductName();

            int compare = midName.compareToIgnoreCase(targetName);
            if (compare == 0) {
                return products[mid];
            } else if (compare < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
}


public class Main{
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Shirt", "Clothing"),
            new Product(3, "Coffee Mug", "Kitchen"),
            new Product(4, "Headphones", "Electronics"),
            new Product(5, "Sneakers", "Footwear")
        };
        // Linear Search
        Product found1 = Search.linearSearch(products, "Headphones");
        System.out.println("Linear Search Result: " + found1);
        //Binary Search
        Arrays.sort(products, Comparator.comparing(Product::getProductName));
        Product found2 = Search.binarySearch(products, "Headphones");
        System.out.println("Binary Search Result: " + found2);
    }
}


