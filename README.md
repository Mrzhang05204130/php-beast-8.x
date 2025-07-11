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

本项目来源于 https://github.com/liexusong/php-beast
