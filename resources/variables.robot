*** Variables ***
${BASE_URL}           https://www.saucedemo.com
${API_BASE_URL}       https://reqres.in
${BROWSER}            chrome
# Headless Chrome. The password-manager prefs stop Chrome's leaked-password bubble (SauceDemo's
# public password is on that list) from covering the page after login.
${CHROME_OPTIONS}     add_argument("--headless=new");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--window-size=1920,1080");add_argument("--disable-features=PasswordLeakDetection");add_experimental_option("prefs", {"credentials_enable_service": False, "profile.password_manager_enabled": False, "profile.password_manager_leak_detection": False})
${TIMEOUT}            10s
${STANDARD_USER}      standard_user
${PASSWORD}           secret_sauce
${LOCKED_USER}        locked_out_user
