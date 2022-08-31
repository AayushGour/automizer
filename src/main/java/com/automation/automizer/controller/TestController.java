package com.automation.automizer.controller;

import java.net.MalformedURLException;
import java.net.URL;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class TestController {
	@Value("${driverPath}")
	private String driverPath;

	@Value("${gridUrl}")
	private String gridUrl;

	@GetMapping(value = "/test")
	public boolean testController() {
		// System.setProperty("webdriver.chrome.driver", driverPath);
		// System.setProperty("webdriver.chrome.whitelistedIps", "");
		// // Initiating your chromedriver
		// ChromeOptions options = new ChromeOptions();
		// options.addArguments("--no-sandbox");
		// options.addArguments("--disable-setuid-sandbox");
		// options.addArguments("--disable-gpu"); // applicable to windows os only
		// options.addArguments("--disable-dev-shm-usage"); // overcome limited resource
		// problems
		// options.addArguments("start-maximized"); // open Browser in maximized mode
		// options.addArguments("disable-infobars"); // disabling infobars
		// options.addArguments("--disable-extensions"); // disabling extensions
		// // options.addArguments("--headless");
		// options.addArguments("--remote-debugging-port=55972");

		// WebDriver driver = new ChromeDriver(options);
		// // Applied wait time
		// driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		// // maximize window
		// driver.manage().window().maximize();

		// // open browser with desried URL
		// driver.get("https://www.google.com");

		// // closing the browser
		// driver.close();

		try {
			ChromeOptions chromeOptions = new ChromeOptions();

			// chromeOptions.setCapability("browserVersion", "100");
			// chromeOptions.setCapability("platformName", "Windows");
			// // Other type of metadata can be seen in the Grid UI by clicking on the
			// // session info or via GraphQL
			// chromeOptions.setCapability("se:sampleMetadata", "Sample metadata value");
			WebDriver driver = new RemoteWebDriver(new URL(gridUrl), chromeOptions);
			driver.get("http://www.google.com");
			driver.quit();
			// https://dev.to/automationbro/docker-selenium-grid-setup-1lg4
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}

}