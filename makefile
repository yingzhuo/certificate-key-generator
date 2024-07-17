usage:
	@echo "================================================================="
	@echo "usage (default)         : 显示本菜单"
	@echo "init                    : 初始化目录"
	@echo "gen-rootca              : 生成自签名根证书与秘钥"
	@echo "gen-server              : 生成服务器用秘钥等"
	@echo "gen-client              : 生成客户端用秘钥等"
	@echo "gen-jwt                 : 生成JWT签名所需的秘钥"
	@echo "clean                   : 清理已生成的秘钥 (根证书不删除)"
	@echo "clean-all               : 清理已生成的秘钥 (强制删除根证书)"
	@echo "github                  : 推送本项目的文件到Github"
	@echo "================================================================="

init:
	@bash $(CURDIR)/shells/init.sh

gen-rootca: init
	@bash $(CURDIR)/shells/gen-rootca.sh

gen-server: init
	@bash $(CURDIR)/shells/gen-server.sh

gen-client: init
	@bash $(CURDIR)/shells/gen-client.sh

gen-jwt:
	@bash $(CURDIR)/shells/gen-jwt.sh

clean:
	@bash $(CURDIR)/shells/clean.sh

clean-all:
	@bash $(CURDIR)/shells/clean-all.sh

github:
	@git status
	@git add .
	@git commit -m "$(shell /bin/date "+%F %T")"
	@git push

.PHONY: usage clean clean-all init \
	gen-rootca gen-sever gen-jwt \
	github
