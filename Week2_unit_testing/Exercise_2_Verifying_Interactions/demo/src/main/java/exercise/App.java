package exercise;

public class App {
    private ExternalApi api;

    public App(ExternalApi api) {
        this.api = api;
    }

    public void fetchData() {
        api.getData();  // We want to verify this method gets called
    }
}
