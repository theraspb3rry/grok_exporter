FROM golang

EXPOSE 9144

COPY . /src
RUN apt update && apt install -y libonig-dev && apt-get clean
RUN cd /src && go build -v -o /src/grok_exporter -buildvcs=false


FROM debian:12

EXPOSE 9144
COPY --from=0 /src/grok_exporter /bin/grok_exporter

CMD ["/bin/grok_exporter"]
