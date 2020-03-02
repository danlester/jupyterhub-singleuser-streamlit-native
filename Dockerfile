FROM python:3.7
RUN pip3 install \
    jupyterhub \
    jhsingle-native-proxy>=0.0.7 \
    streamlit

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

EXPOSE 8888

WORKDIR /app

COPY intro.py /app/intro.py

CMD ["jhsingle-native-proxy", "--destport", "8505", "streamlit", "hello", "{--}server.port", "{port}", "{--}server.headless", "True", "{--}server.enableCORS", "False"]