import static org.junit.Assert.assertEquals;
import org.junit.Test;
public class IntMultiplierTest {
    @Test
    public void testIntMultiplier() throws Exception {
        IntMultiplier im = new IntMultiplier(3, 4);
        assertEquals(12, im.getProduct());
    }
    @Test
    public void testIntMultiplierAgain() throws Exception {
        IntMultiplier im = new IntMultiplier(4, 5);
        assertEquals(20, im.getProduct());
    }
}
