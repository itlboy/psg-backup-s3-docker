FROM alpine
RUN apk add --no-cache mariadb-client aws-cli
ADD ./endpoint.sh ./
RUN chmod +x ./endpoint.sh
CMD ["sh", "./endpoint.sh"]