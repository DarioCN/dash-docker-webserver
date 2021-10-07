FROM dariocn/dash-ws:nginx

# Install required Python packages
COPY requirements.txt /
COPY pip.sh /
RUN bash /pip.sh \
    && rm /pip.sh \
    && rm /requirements.txt

# Copy the Dash app
COPY ./app /app
