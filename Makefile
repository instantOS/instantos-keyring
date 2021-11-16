V=20211116

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 instantos.gpg $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 instantos-trusted $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 instantos-revoked $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/instantos{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=instantos-keyring-$(V)/ $(V) | gzip -9 > instantos-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent instantos-keyring-$(V).tar.gz


.PHONY: install uninstall dist
