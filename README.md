# 用法说明

本项目为 PHP 源码加密扩展，支持对 PHP 文件进行加密保护。以下为常用的加密用法：

## 1. 批量加密目录下的 PHP 文件

1. 进入 `tools` 目录，编辑 `configure.ini` 文件，配置如下：

```ini
; source path
src_path = "/path/to/your/source"

; destination path
dst_path = "/path/to/your/encrypted"

; expire time
expire = ""  ; 可选，格式为 YYYY-mm-dd HH:ii:ss

; encrypt type
encrypt_type = "DES"  ; 可选：DES、AES、BASE64、XXTEA
```

2. 执行批量加密命令：

```bash
php encode_files.php
```

加密后的 PHP 文件会输出到 `dst_path` 指定的目录。

## 2. 加密单个 PHP 文件

在 `tools` 目录下，使用如下命令：

```bash
php encode_file.php --oldfile 源文件路径 --newfile 加密后文件路径 --encrypt 加密类型 --expire "过期时间"
```

- `--oldfile`：需要加密的 PHP 文件路径
- `--newfile`：加密后输出的文件路径（可选，不填则自动生成）
- `--encrypt`：加密类型（DES、AES、BASE64、XXTEA，默认 DES）
- `--expire`：过期时间（可选，格式为 YYYY-mm-dd HH:ii:ss）

示例：

```bash
php encode_file.php --oldfile /path/a.php --newfile /path/a_enc.php --encrypt AES --expire "2025-12-31 23:59:59"
```

## 3. PHP 扩展函数用法

安装扩展后，可在 PHP 代码中直接调用：

```php
beast_encode_file(string $input_file, string $output_file, int $expire_timestamp, int $encrypt_type);
```

- `$input_file`：原始 PHP 文件路径
- `$output_file`：加密后文件路径
- `$expire_timestamp`：过期时间戳（0 表示不过期）
- `$encrypt_type`：加密类型常量（如 BEAST_ENCRYPT_TYPE_DES、BEAST_ENCRYPT_TYPE_AES 等）

---

## 4. 如何修改加密秘钥

为提升安全性，建议在编译前自定义加密秘钥。不同加密算法的秘钥存放在不同的源码文件中：

### 修改 AES 加密秘钥

1. 打开 `aes_algo_handler.c` 文件。
2. 找到如下代码片段：

```c
static uint8_t key[] = {
    0xcf, 0x81, 0x28, 0x3d, 0x22, 0xf2, 0xf4, 0x46,
    0x23, 0xf8, 0x16, 0x99, 0x0a, 0xdf, 0x25, 0x38,
};
```
3. 按需修改 key 数组的内容（长度为 16 字节）。

### 修改 DES 加密秘钥

1. 打开 `des_algo_handler.c` 文件。
2. 找到如下代码片段：

```c
static char key[8] = {
    0x02, 0x8a, 0x91, 0x33,
    0x06, 0x03, 0x48, 0x0f,
};
```
3. 按需修改 key 数组的内容（长度为 8 字节）。

> 修改秘钥后，需重新编译扩展并部署。

本项目来源于 https://github.com/liexusong/php-beast
