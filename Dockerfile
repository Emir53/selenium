FROM python:3.8.5
RUN apt-get update

# BASIC PACKAGES
RUN python -m pip install --upgrade setuptools pip
RUN apt-get install git

# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Install Google Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

#RUN apt install chromium-driver -y

#RUN wget -nc https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN apt install -f ./google-chrome-stable_current_amd64.deb -y


# TODO: replace it with requirements.txt when we have more dependencies
RUN python -m pip install selenium
RUN python -m pip install chromedriver-autoinstaller
RUN python -m pip install webdriver-manager

RUN mkdir -p /mnt/scripts
RUN chmod 777 -R /mnt/scripts

COPY ss.py .
RUN chmod +x ./ss.py