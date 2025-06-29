package exercise;

import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;

public class AppTest {

    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = mock(ExternalApi.class);   // Step 1: Mock
        App service = new App(mockApi);                  // Inject mock
        service.fetchData();                             // Step 2: Call method
        verify(mockApi).getData();                       // Step 3: Verify interaction
    }
}
