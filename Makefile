update:
	git pull origin master
	docker-compose rm -f
	docker-compose build --no-cache --force-rm
	docker-compose up -d --remove-orphans

install:
	cp ./systemd/update-mirror.service /etc/systemd/system/
	cp ./systemd/update-mirror.timer /etc/systemd/system/
	cp ./systemd/update-mirror-once-a-day.service /etc/systemd/system/
	cp ./systemd/update-mirror-once-a-day.timer /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable --now update-mirror.service
	systemctl enable --now update-mirror-once-a-day.service
	mkdir -p /srv/mirror/archlinux
	mkdir -p /srv/mirror/manjaro
	mkdir -p /srv/mirror/debian
	mkdir -p /srv/mirror/ubuntu
	mkdir -p /srv/mirror/raspbian
	mkdir -p /srv/mirror/gentoo

uninstall:
	systemctl disable --now update-mirror.service
	systemctl disable --now update-mirror-once-a-day.service
	rm -f /etc/systemd/system/update-mirror.service
	rm -f /etc/systemd/system/update-mirror.timer
	rm -f /etc/systemd/system/update-mirror-once-a-day.service
	rm -f /etc/systemd/system/update-mirror-once-a-day.timer
	systemctl daemon-reload
