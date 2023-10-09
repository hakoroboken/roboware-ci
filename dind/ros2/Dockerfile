FROM ghcr.io/roboware-org/roboware-ci:main

RUN apt install -y wget libudev-dev

COPY ws /ws

COPY entrypoint.bash /bin/entrypoint.bash
RUN chmod +x /bin/entrypoint.bash

ENTRYPOINT ["entrypoint.bash"]
