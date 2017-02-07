# add.sh hehe会添加local.hehe.com

function help() {
    echo "请输入要添加的域名"
}
if [[ $1 == "" ]]; then
    help
    exit
fi
source_file=./nginx/servers/autoloan.conf
target_file=./nginx/servers/$1.conf

cp $source_file $target_file

sed -i "s/autoloan/$1/g" $target_file

echo "127.0.0.1    local.$1.com" >> /c/WINDOWS/System32/drivers/etc/hosts

docker-compose restart
