# webtree
# See LICENSE file for copyright and license details.
.POSIX:

clean:
	rm -f webtree-*.tar.zst
install: webtree
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f webtree $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/webtree

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/webtree
	rm -f /usr/share/doc/${pkgname}/README.md

.PHONY: clean install uninstall
