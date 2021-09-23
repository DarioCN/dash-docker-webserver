FROM dash-ws:nginx

# Install required Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U || true\
    && find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf \
    && rm /tmp/requirements.txt

# Copy the Dash app
COPY ./app /app
