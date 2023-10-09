FROM ghcr.io/roboware-org/roboware-ci:main

COPY ws /ws

COPY entrypoint.bash /bin/entrypoint.bash
RUN chmod +x /bin/entrypoint.bash

ENTRYPOINT ["entrypoint.bash"]
