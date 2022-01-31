import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
public class PG1 {
    public static void main(String[] args) {
      
    	System.setProperty("webdriver.gecko.driver","/root/selenium setup/root/selenium setup");
		WebDriver driver = new FirefoxDriver();
        String baseUrl = "http://54.89.189.41:8080/hello";
        driver.get(baseUrl);
        driver.close();
       
    }

}
