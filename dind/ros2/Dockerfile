FROM ghcr.io/hakoroboken/rwci:latest

COPY ws /ws

COPY entrypoint.bash /bin/entrypoint.bash
RUN chmod +x /bin/entrypoint.bash

ENTRYPOINT ["entrypoint.bash"]
