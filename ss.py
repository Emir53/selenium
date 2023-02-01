from selenium import webdriver
import chromedriver_autoinstaller
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
import sys


def screenshot(url, fp_out):
    VALID_SELECTORS = ("id", "xpath", "css selector")
    if sys.argv[2] not in VALID_SELECTORS:
        raise TypeError(f"Valid Selectors are : {VALID_SELECTORS}")
    chromedriver_autoinstaller.install()
    options=webdriver.ChromeOptions()
    options.add_argument('headless')
    #options.add_argument('disable-dev-shm-usage')
    options.add_argument('no-sandbox')
    driver=webdriver.Chrome(options=options)
    driver.get(url)
    DELAY = 3
    try:
        ele = WebDriverWait(driver, DELAY).until(EC.presence_of_element_located((sys.argv[2], sys.argv[3])))
        print("SUCCESS")
    except:
        print("ERROR")                                       
    driver.get_screenshot_as_file(fp_out)
    driver.close()

url = sys.argv[1]
fp_out = sys.argv[4]
screenshot(url, fp_out)