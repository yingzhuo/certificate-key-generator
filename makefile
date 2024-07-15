usage:
	@echo "================================================================="
	@echo "usage                   : 打印本菜单"
	@echo "init                    : 初始化目录"
	@echo "gen-root-ca             : 生成自签名根证书与秘钥"
	@echo "gen-server              : 生成服务器用秘钥等"
	@echo "gen-client              : 生成客户端用秘钥等"
	@echo "gen-jwt                 : 生成JWT签名所需的秘钥"
	@echo "clean                   : 清理已生成的秘钥 (根证书不删除)"
	@echo "clean-all               : 清理已生成的秘钥 (删除根证书)"
	@echo "github                  : 推送本项目的文件到Github"
	@echo "show-server-keystore    : 展示服务器端KeyStore详细信息"
	@echo "show-server-truststore  : 展示服务器端TrustStore详细信息"
	@echo "show-client-keystore    : 展示客户端用KeyStore详细信息"
	@echo "================================================================="

init:
	@bash $(CURDIR)/shells/init.sh

gen-root-ca: init
	@bash $(CURDIR)/shells/gen-root-ca.sh

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

show-server-keystore:
	@bash $(CURDIR)/shells/show-server-keystore.sh

show-server-truststore:
	@bash $(CURDIR)/shells/show-server-truststore.sh

show-client-keystore:
	@bash $(CURDIR)/shells/show-client-keystore.sh

github:
	@git status
	@git add .
	@git commit -m "$(shell /bin/date "+%F %T")"
	@git push

.PHONY: usage \
	clean clean-all \
	init \
	gen-root-ca gen-sever gen-jwt \
	github \
	show-server-keystore show-server-truststore show-client-keystore
