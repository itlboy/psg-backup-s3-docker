FROM postgres:alpine
RUN apk add --no-cache aws-cli
ADD ./endpoint.sh ./
RUN chmod +x ./endpoint.sh
CMD ["sh", "./endpoint.sh"]