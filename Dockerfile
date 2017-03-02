FROM rethinkdb:2.3.5
MAINTAINER xkodiak

RUN apt update && apt install curl

COPY assets/run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]