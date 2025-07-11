srcdir = /Users/mrz/Documents/home/php-beast
builddir = /Users/mrz/Documents/home/php-beast
top_srcdir = /Users/mrz/Documents/home/php-beast
top_builddir = /Users/mrz/Documents/home/php-beast
EGREP = /usr/bin/grep -E
SED = /usr/bin/sed
CONFIGURE_COMMAND = './configure' '--with-php-config=/usr/local/Cellar/php@8.2/8.2.28_1/bin/php-config' 'PKG_CONFIG_PATH=/usr/local/Cellar/openssl@1.1/1.1.1i/lib/pkgconfig:/usr/local/Cellar/openssl@1.1/1.1.1i/lib/pkgconfig:'
CONFIGURE_OPTIONS = '--with-php-config=/usr/local/Cellar/php@8.2/8.2.28_1/bin/php-config' 'PKG_CONFIG_PATH=/usr/local/Cellar/openssl@1.1/1.1.1i/lib/pkgconfig:/usr/local/Cellar/openssl@1.1/1.1.1i/lib/pkgconfig:'
SHLIB_SUFFIX_NAME = dylib
SHLIB_DL_SUFFIX_NAME = so
AWK = awk
shared_objects_beast = beast.lo aes_algo_handler.lo des_algo_handler.lo base64_algo_handler.lo xxtea_algo_handler.lo beast_mm.lo spinlock.lo cache.lo beast_log.lo global_algo_modules.lo header.lo networkcards.lo xxtea.lo tmpfile_file_handler.lo pipe_file_handler.lo file_handler_switch.lo shm.lo
PHP_PECL_EXTENSION = beast
PHP_MODULES = $(phplibdir)/beast.la
PHP_ZEND_EX =
all_targets = $(PHP_MODULES) $(PHP_ZEND_EX)
install_targets = install-modules install-headers
prefix = /usr/local/Cellar/php@8.2/8.2.28_1
exec_prefix = $(prefix)
libdir = ${exec_prefix}/lib
prefix = /usr/local/Cellar/php@8.2/8.2.28_1
phplibdir = /Users/mrz/Documents/home/php-beast/modules
phpincludedir = /usr/local/Cellar/php@8.2/8.2.28_1/include/php
CC = cc
CFLAGS = -g -O2
CFLAGS_CLEAN = $(CFLAGS) -D_GNU_SOURCE
CPP = cc -E
CPPFLAGS = -DHAVE_CONFIG_H
CXX =
CXXFLAGS =
CXXFLAGS_CLEAN = $(CXXFLAGS)
EXTENSION_DIR = /usr/local/Cellar/php@8.2/8.2.28_1/pecl/20220829
PHP_EXECUTABLE = /usr/local/Cellar/php@8.2/8.2.28_1/bin/php
EXTRA_LDFLAGS =
EXTRA_LIBS =
INCLUDES = -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php/main -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php/TSRM -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php/Zend -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php/ext -I/usr/local/Cellar/php@8.2/8.2.28_1/include/php/ext/date/lib
LFLAGS =
LDFLAGS =
SHARED_LIBTOOL =
LIBTOOL = $(SHELL) $(top_builddir)/libtool
SHELL = /bin/sh
INSTALL_HEADERS =
BUILD_CC = cc
mkinstalldirs = $(top_srcdir)/build/shtool mkdir -p
INSTALL = $(top_srcdir)/build/shtool install -c
INSTALL_DATA = $(INSTALL) -m 644

DEFS = -I$(top_builddir)/include -I$(top_builddir)/main -I$(top_srcdir)
COMMON_FLAGS = $(DEFS) $(INCLUDES) $(EXTRA_INCLUDES) $(CPPFLAGS) $(PHP_FRAMEWORKPATH)

all: $(all_targets)
	@echo
	@echo "Build complete."
	@echo "Don't forget to run 'make test'."
	@echo

build-modules: $(PHP_MODULES) $(PHP_ZEND_EX)

build-binaries: $(PHP_BINARIES)

libphp.la: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(LIBTOOL) --tag=CC --mode=link $(CC) $(LIBPHP_CFLAGS) $(CFLAGS) $(EXTRA_CFLAGS) -rpath $(phptempdir) $(EXTRA_LDFLAGS) $(LDFLAGS) $(PHP_RPATHS) $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@
	-@$(LIBTOOL) --silent --tag=CC --mode=install cp $@ $(phptempdir)/$@ >/dev/null 2>&1

libs/libphp.bundle: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(CC) $(MH_BUNDLE_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(PHP_GLOBAL_OBJS:.lo=.o) $(PHP_SAPI_OBJS:.lo=.o) $(PHP_FRAMEWORKS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@ && cp $@ libs/libphp.so

install: $(all_targets) $(install_targets)

install-sapi: $(OVERALL_TARGET)
	@echo "Installing PHP SAPI module:       $(PHP_SAPI)"
	-@$(mkinstalldirs) $(INSTALL_ROOT)$(bindir)
	-@if test ! -r $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME); then \
		for i in 0.0.0 0.0 0; do \
			if test -r $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME).$$i; then \
				$(LN_S) $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME).$$i $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME); \
				break; \
			fi; \
		done; \
	fi
	@$(INSTALL_IT)

install-binaries: build-binaries $(install_binary_targets)

install-modules: build-modules
	@test -d modules && \
	$(mkinstalldirs) $(INSTALL_ROOT)$(EXTENSION_DIR)
	@echo "Installing shared extensions:     $(INSTALL_ROOT)$(EXTENSION_DIR)/"
	@rm -f modules/*.la >/dev/null 2>&1
	@$(INSTALL) modules/* $(INSTALL_ROOT)$(EXTENSION_DIR)

install-headers:
	-@if test "$(INSTALL_HEADERS)"; then \
		for i in `echo $(INSTALL_HEADERS)`; do \
			i=`$(top_srcdir)/build/shtool path -d $$i`; \
			paths="$$paths $(INSTALL_ROOT)$(phpincludedir)/$$i"; \
		done; \
		$(mkinstalldirs) $$paths && \
		echo "Installing header files:          $(INSTALL_ROOT)$(phpincludedir)/" && \
		for i in `echo $(INSTALL_HEADERS)`; do \
			if test "$(PHP_PECL_EXTENSION)"; then \
				src=`echo $$i | $(SED) -e "s#ext/$(PHP_PECL_EXTENSION)/##g"`; \
			else \
				src=$$i; \
			fi; \
			if test -f "$(top_srcdir)/$$src"; then \
				$(INSTALL_DATA) $(top_srcdir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			elif test -f "$(top_builddir)/$$src"; then \
				$(INSTALL_DATA) $(top_builddir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			else \
				(cd $(top_srcdir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i; \
				cd $(top_builddir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i) 2>/dev/null || true; \
			fi \
		done; \
	fi

PHP_TEST_SETTINGS = -d 'open_basedir=' -d 'output_buffering=0' -d 'memory_limit=-1'
PHP_TEST_SHARED_EXTENSIONS =  ` \
	if test "x$(PHP_MODULES)" != "x"; then \
		for i in $(PHP_MODULES)""; do \
			. $$i; \
			if test "x$$dlname" != "xdl_test.so"; then \
				$(top_srcdir)/build/shtool echo -n -- " -d extension=$$dlname"; \
			fi; \
		done; \
	fi; \
	if test "x$(PHP_ZEND_EX)" != "x"; then \
		for i in $(PHP_ZEND_EX)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d zend_extension=$(top_builddir)/modules/$$dlname"; \
		done; \
	fi`
PHP_DEPRECATED_DIRECTIVES_REGEX = '^(magic_quotes_(gpc|runtime|sybase)?|(zend_)?extension(_debug)?(_ts)?)[\t\ ]*='

test: all
	@if test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
		INI_FILE=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r 'echo php_ini_loaded_file();' 2> /dev/null`; \
		if test "$$INI_FILE"; then \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_FILE" > $(top_builddir)/tmp-php.ini; \
		else \
			echo > $(top_builddir)/tmp-php.ini; \
		fi; \
		INI_SCANNED_PATH=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r '$$a = explode(",\n", trim(php_ini_scanned_files())); echo $$a[0];' 2> /dev/null`; \
		if test "$$INI_SCANNED_PATH"; then \
			INI_SCANNED_PATH=`$(top_srcdir)/build/shtool path -d $$INI_SCANNED_PATH`; \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_SCANNED_PATH"/*.ini >> $(top_builddir)/tmp-php.ini; \
		fi; \
		TEST_PHP_EXECUTABLE=$(PHP_EXECUTABLE) \
		TEST_PHP_SRCDIR=$(top_srcdir) \
		CC="$(CC)" \
			$(PHP_EXECUTABLE) -n -c $(top_builddir)/tmp-php.ini $(PHP_TEST_SETTINGS) $(top_srcdir)/run-tests.php -n -c $(top_builddir)/tmp-php.ini -d extension_dir=$(top_builddir)/modules/ $(PHP_TEST_SHARED_EXTENSIONS) $(TESTS); \
		TEST_RESULT_EXIT_CODE=$$?; \
		rm $(top_builddir)/tmp-php.ini; \
		exit $$TEST_RESULT_EXIT_CODE; \
	else \
		echo "ERROR: Cannot run tests without CLI sapi."; \
	fi

clean:
	find . -name \*.gcno -o -name \*.gcda | xargs rm -f
	find . -name \*.lo -o -name \*.o -o -name \*.dep | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	find . -name .libs -a -type d|xargs rm -rf
	rm -f libphp.la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*
	rm -f ext/opcache/jit/zend_jit_x86.c
	rm -f ext/opcache/jit/zend_jit_arm64.c
	rm -f ext/opcache/minilua

distclean: clean
	rm -f Makefile config.cache config.log config.status Makefile.objects Makefile.fragments libtool main/php_config.h main/internal_functions_cli.c main/internal_functions.c Zend/zend_dtrace_gen.h Zend/zend_dtrace_gen.h.bak Zend/zend_config.h
	rm -f main/build-defs.h scripts/phpize
	rm -f ext/date/lib/timelib_config.h ext/mbstring/libmbfl/config.h ext/oci8/oci8_dtrace_gen.h ext/oci8/oci8_dtrace_gen.h.bak
	rm -f scripts/man1/phpize.1 scripts/php-config scripts/man1/php-config.1 sapi/cli/php.1 sapi/cgi/php-cgi.1 sapi/phpdbg/phpdbg.1 ext/phar/phar.1 ext/phar/phar.phar.1
	rm -f sapi/fpm/php-fpm.conf sapi/fpm/init.d.php-fpm sapi/fpm/php-fpm.service sapi/fpm/php-fpm.8 sapi/fpm/status.html
	rm -f ext/phar/phar.phar ext/phar/phar.php
	if test "$(srcdir)" != "$(builddir)"; then \
	  rm -f ext/phar/phar/phar.inc; \
	fi
	$(EGREP) define'.*include/php' $(top_srcdir)/configure | $(SED) 's/.*>//'|xargs rm -f

prof-gen:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-generate all
	find . -name \*.gcda | xargs rm -f

prof-clean:
	find . -name \*.lo -o -name \*.o | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	rm -f libphp.la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*

prof-use:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-use all

%_arginfo.h: %.stub.php
	@if test -e "$(top_srcdir)/build/gen_stub.php"; then \
		if test ! -z "$(PHP)"; then \
			echo Parse $< to generate $@;\
			$(PHP) $(top_srcdir)/build/gen_stub.php $<; \
		elif test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
			echo Parse $< to generate $@;\
			$(PHP_EXECUTABLE) $(top_srcdir)/build/gen_stub.php $<; \
		fi; \
	fi;

.PHONY: all clean install distclean test prof-gen prof-clean prof-use
.NOEXPORT:
-include beast.dep
beast.lo: /Users/mrz/Documents/home/php-beast/beast.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/beast.c -o beast.lo  -MMD -MF beast.dep -MT beast.lo
-include aes_algo_handler.dep
aes_algo_handler.lo: /Users/mrz/Documents/home/php-beast/aes_algo_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/aes_algo_handler.c -o aes_algo_handler.lo  -MMD -MF aes_algo_handler.dep -MT aes_algo_handler.lo
-include des_algo_handler.dep
des_algo_handler.lo: /Users/mrz/Documents/home/php-beast/des_algo_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/des_algo_handler.c -o des_algo_handler.lo  -MMD -MF des_algo_handler.dep -MT des_algo_handler.lo
-include base64_algo_handler.dep
base64_algo_handler.lo: /Users/mrz/Documents/home/php-beast/base64_algo_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/base64_algo_handler.c -o base64_algo_handler.lo  -MMD -MF base64_algo_handler.dep -MT base64_algo_handler.lo
-include xxtea_algo_handler.dep
xxtea_algo_handler.lo: /Users/mrz/Documents/home/php-beast/xxtea_algo_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/xxtea_algo_handler.c -o xxtea_algo_handler.lo  -MMD -MF xxtea_algo_handler.dep -MT xxtea_algo_handler.lo
-include beast_mm.dep
beast_mm.lo: /Users/mrz/Documents/home/php-beast/beast_mm.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/beast_mm.c -o beast_mm.lo  -MMD -MF beast_mm.dep -MT beast_mm.lo
-include spinlock.dep
spinlock.lo: /Users/mrz/Documents/home/php-beast/spinlock.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/spinlock.c -o spinlock.lo  -MMD -MF spinlock.dep -MT spinlock.lo
-include cache.dep
cache.lo: /Users/mrz/Documents/home/php-beast/cache.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/cache.c -o cache.lo  -MMD -MF cache.dep -MT cache.lo
-include beast_log.dep
beast_log.lo: /Users/mrz/Documents/home/php-beast/beast_log.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/beast_log.c -o beast_log.lo  -MMD -MF beast_log.dep -MT beast_log.lo
-include global_algo_modules.dep
global_algo_modules.lo: /Users/mrz/Documents/home/php-beast/global_algo_modules.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/global_algo_modules.c -o global_algo_modules.lo  -MMD -MF global_algo_modules.dep -MT global_algo_modules.lo
-include header.dep
header.lo: /Users/mrz/Documents/home/php-beast/header.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/header.c -o header.lo  -MMD -MF header.dep -MT header.lo
-include networkcards.dep
networkcards.lo: /Users/mrz/Documents/home/php-beast/networkcards.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/networkcards.c -o networkcards.lo  -MMD -MF networkcards.dep -MT networkcards.lo
-include xxtea.dep
xxtea.lo: /Users/mrz/Documents/home/php-beast/xxtea.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/xxtea.c -o xxtea.lo  -MMD -MF xxtea.dep -MT xxtea.lo
-include tmpfile_file_handler.dep
tmpfile_file_handler.lo: /Users/mrz/Documents/home/php-beast/tmpfile_file_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/tmpfile_file_handler.c -o tmpfile_file_handler.lo  -MMD -MF tmpfile_file_handler.dep -MT tmpfile_file_handler.lo
-include pipe_file_handler.dep
pipe_file_handler.lo: /Users/mrz/Documents/home/php-beast/pipe_file_handler.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/pipe_file_handler.c -o pipe_file_handler.lo  -MMD -MF pipe_file_handler.dep -MT pipe_file_handler.lo
-include file_handler_switch.dep
file_handler_switch.lo: /Users/mrz/Documents/home/php-beast/file_handler_switch.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/file_handler_switch.c -o file_handler_switch.lo  -MMD -MF file_handler_switch.dep -MT file_handler_switch.lo
-include shm.dep
shm.lo: /Users/mrz/Documents/home/php-beast/shm.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/Users/mrz/Documents/home/php-beast $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)   -DZEND_COMPILE_DL_EXT=1 -c /Users/mrz/Documents/home/php-beast/shm.c -o shm.lo  -MMD -MF shm.dep -MT shm.lo
$(phplibdir)/beast.la: ./beast.la
	$(LIBTOOL) --tag=CC --mode=install cp ./beast.la $(phplibdir)

./beast.la: $(shared_objects_beast) $(BEAST_SHARED_DEPENDENCIES)
	$(LIBTOOL) --tag=CC --mode=link $(CC) -shared $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS)  -o $@ -export-dynamic -avoid-version -prefer-pic -module -rpath $(phplibdir) $(EXTRA_LDFLAGS) $(shared_objects_beast) $(BEAST_SHARED_LIBADD)

