dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt: START CONFIG AWS:"

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile default && aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile default && aws configure set region "$AWS_REGION" --profile default && aws configure set output "text" --profile default

echo "HOST: $DB_SERVER"
echo "USER: $DB_USER"
echo "PORT: $DB_PORT"
echo "DBNAME: $DB_NAME"
echo "TABLES: $TABLES"

BACKUP_FILE=$( date '+%F_%H-%M-%S' ).sql.zip
echo "BACKUP FILE: $BACKUP_FILE"

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt: START DUMP DB"

PGPASSWORD="$DB_PASS" pg_dump  -h "$DB_SERVER" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME" | gzip -9 > "$BACKUP_FILE"

du -skh "$BACKUP_FILE";
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt: END DUMP DB, START UPLOAD TO S3"

aws --profile default --region default --endpoint-url "$AWS_ENDPOINT_URL" s3 cp "$BACKUP_FILE" "$DB_DUMP_TARGET"

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt: END UPLOAD TO S3"