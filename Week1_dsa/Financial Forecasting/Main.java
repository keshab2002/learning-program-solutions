public class Main {

    public static double futureValue(double presentValue, double rate, int years) {
        if (years == 0) {
            return presentValue;
        }
        return (1 + rate) * futureValue(presentValue, rate, years - 1);
    }

    public static void main(String[] args) {
        double presentValue = 1000.0;
        double growthRate = 0.05;  
        int years = 10;

        double futureVal = futureValue(presentValue, growthRate, years);
        System.out.printf("Future Value after %d years: %.2f%n", years, futureVal);
    }
}
