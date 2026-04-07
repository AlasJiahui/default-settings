
# 编译目标
all: po2lmo

# 链接生成可执行文件
po2lmo: src/po2lmo.o src/template_lmo.o
	$(CC) -o $@ $^ $(LDFLAGS)

# 编译源码为目标文件
src/%.o: src/%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

# 安装程序到系统路径
install:
	$(INSTALL) -d $(DESTDIR)$(PREFIX)
	$(INSTALL) -m 755 po2lmo $(DESTDIR)$(PREFIX)/po2lmo

# 清理编译产物
clean:
	rm -f po2lmo src/*.o

.PHONY: all install clean
