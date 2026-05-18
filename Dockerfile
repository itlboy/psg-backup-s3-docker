ARG PG_VERSION=17.5
FROM postgres:${PG_VERSION}-alpine
RUN apk add --no-cache aws-cli
ADD ./endpoint.sh ./
RUN chmod +x ./endpoint.sh
CMD ["sh", "./endpoint.sh"]
