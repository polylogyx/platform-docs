Troubleshooting Known Issues
=================================
1. Restarting the server - If for any maintenance reasons, the PolyLogyx Server is required to be restarted, perform the following options after the restart.

- Login with the server root credentials
- cd to the extracted zip folder
- Run the command **docker-compose -p 'plgx_docker' up**

2. Server showing very high RAM usage - PolyLogyx Server manages the endpoint data at scale and to do so efficiently, it leverages [Celery](https://github.com/celery/) threads. The Celery threads have a known issue regarding a [memory leak](https://github.com/celery/celery/issues/4843) which can occur due to unpredictable reasons. While the correct RCA is being determined, in the meantime if the server exhibits any unresponsiveness due to high RAM usage, following maintenance commands can be used to restart the celery thread.

- Open the maintenance port 5555 on the server
- Login to the server using https://<IP_ADDRESS>:5555 with the username and password.
- Click on the **celery worker**
- Click on **restart pool** on the right hand

For support, send request to open@polylogyx.com

