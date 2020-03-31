public class Main {
    public static void main(String[] args) {
        SomeResource res = new SomeResource();
        try {
            System.out.println("This is my other app. :)");
        } finally {
            res.close();
        }
    }
}

class SomeResource {
    public void close() {
        System.out.printf("Hello from Java %s!%n", System.getProperty("java.version"));
    }
}
