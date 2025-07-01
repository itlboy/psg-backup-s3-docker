FROM 17.5-alpine3.22
RUN apk add --no-cache aws-cli
ADD ./endpoint.sh ./
RUN chmod +x ./endpoint.sh
CMD ["sh", "./endpoint.sh"]
