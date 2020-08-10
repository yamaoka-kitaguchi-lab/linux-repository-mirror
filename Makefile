install-compose:
	curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

update:
	git pull origin master
	docker-compose rm -f
	docker-compose build --no-cache --force-rm
	docker-compose up -d --remove-orphans

sync:
	docker-compose rm -f
	docker-compose up -d  update-archlinux update-manjaro update-debian update-ubuntu update-raspbian update-cumulus update-gentoo

publish:
	docker-compose rm -f
	docker-compose up -d  nginx-all nginx-pacman nginx-apt nginx-portage

log:
	docker-compose logs -f update-archlinux update-manjaro update-debian update-ubuntu update-raspbian update-cumulus update-gentoo

install:
	cp ./systemd/update-mirror.service /etc/systemd/system/
	cp ./systemd/update-mirror.timer /etc/systemd/system/
	cp ./systemd/update-mirror-once-a-day.service /etc/systemd/system/
	cp ./systemd/update-mirror-once-a-day.timer /etc/systemd/system/
	systemctl daemon-reload
	systemctl enable --now update-mirror.service
	systemctl enable --now update-mirror-once-a-day.service
	systemctl enable --now update-mirror.timer
	systemctl enable --now update-mirror-once-a-day.timer
	mkdir -p /srv/mirror/archlinux
	mkdir -p /srv/mirror/manjaro
	mkdir -p /srv/mirror/debian
	mkdir -p /srv/mirror/ubuntu
	mkdir -p /srv/mirror/raspbian
	mkdir -p /srv/mirror/gentoo

uninstall:
	systemctl disable --now update-mirror.timer
	systemctl disable --now update-mirror-once-a-day.timer
	systemctl disable --now update-mirror.service
	systemctl disable --now update-mirror-once-a-day.service
	rm -f /etc/systemd/system/update-mirror.service
	rm -f /etc/systemd/system/update-mirror.timer
	rm -f /etc/systemd/system/update-mirror-once-a-day.service
	rm -f /etc/systemd/system/update-mirror-once-a-day.timer
	systemctl daemon-reload

destroy:
	rm -rf /srv/mirror
