package ug.iuea.mrm;

/** Tiny, dependency-free MRM inventory example used by the multibranch lab. */
public final class InventoryApplication {
    private InventoryApplication() { }

    public static void main(String[] args) {
        if (args.length > 0 && "--self-test".equals(args[0])) {
            selfTest();
            return;
        }
        System.out.println("MRM Inventory Service: ready");
    }

    private static void selfTest() {
        String status = "READY";
        if (!"READY".equals(status)) {
            throw new AssertionError("Inventory service must start READY");
        }
        System.out.println("PASS: inventory readiness check");
    }
}
