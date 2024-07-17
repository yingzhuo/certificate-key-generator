## Certificate & Key Generator

本项目用于生成应用程序需要的SSL自签名证书，秘钥等。

### (1) 工具

* make
* openssl
* keytool

### (2) 用法

```bash
# 生成自签名根证书
make gen-rootca

# 生成服务器端用证书和秘钥
make gen-server

# 生成客户端用证书和秘钥 (可选)
# 如果您的应用程序不需要SSL双向认证，您无需此功能。
make gen-client

# 生成JWT签名用证书和秘钥 (可选)
# 若您的应用程序用不到JWT，您无需此功能。
make gen-jwt

# 清除已生成的文件 (根证书和秘钥不会被删除)
make clean

# 清除已生成的文件 (根证书和秘钥也被删除) (危险!)
make clean-all

# 查看更多功能
make usage
```

**注意:** 可按照实际需求更改[变量文件](/shells/env.sh)。强烈建议您在`Java`工程中使用使用`PKCS#12`格式的文件。

### (3) 其他

如果不愿意使用本项目，不妨使用开源工具[KeyStore Explorer](https://keystore-explorer.org/index.html)来生成证书和秘钥等。

### (4) 参考文献

* [https://www.baeldung.com/x-509-authentication-in-spring-security](https://www.baeldung.com/x-509-authentication-in-spring-security)
* [https://www.golinuxcloud.com/openssl-subject-alternative-name/](https://www.golinuxcloud.com/openssl-subject-alternative-name/)

### (5) 许可证

[Apache-2.0](./LICENSE)