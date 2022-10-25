FROM alpine
RUN apk add --no-cache postgresql-client aws-cli
ADD ./endpoint.sh ./
RUN chmod +x ./endpoint.sh
CMD ["sh", "./endpoint.sh"]