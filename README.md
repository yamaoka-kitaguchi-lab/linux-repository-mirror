# linux-repository-mirror

[![Docker Build](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/workflows/Docker%20Build/badge.svg)](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/actions) [![](https://img.shields.io/github/license/yamaoka-kitaguchi-lab/linux-repository-mirror)](LICENSE) [![](https://img.shields.io/github/issues/yamaoka-kitaguchi-lab/linux-repository-mirror)](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues) [![](https://img.shields.io/github/issues-pr/yamaoka-kitaguchi-lab/linux-repository-mirror)](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/pulls) [![](https://img.shields.io/github/last-commit/yamaoka-kitaguchi-lab/linux-repository-mirror)](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/commits) [![](https://img.shields.io/github/release/yamaoka-kitaguchi-lab/linux-repository-mirror)](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/releases)

Run linux repository mirrors with docker/kubernetes

- This implementation is intended to be used in a small organization and cannot be deployed as a public mirror due to the performance reasons.
- Furthermore, because current configuration has been adjusted for [@yamaoka-kitaguchi-lab](https://github.com/yamaoka-kitaguchi-lab) local environment, if you want to deploy this elsewhere, you'll need to read through all the files and modify them accordingly.

[![](https://raw.githubusercontent.com/yamaoka-kitaguchi-lab/linux-repository-mirror/screenshot/safari.png)](https://raw.githubusercontent.com/yamaoka-kitaguchi-lab/linux-repository-mirror/screenshot/safari.png)

## How to use: configure your linux to fetch from the local mirror

As of August 10th, 2020, following seven linux mirrors are available - see [Mirroring details](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror#mirroring-details) for further information.

### ArchLinux

- http://mirror.intra.net.ict.e.titech.ac.jp/pacman/archlinux
- http://pacman.mirror.intra.net.ict.e.titech.ac.jp/archlinux

Add the below lines to the beginning of your `/etc/pacman.d/mirrorlist` and then run `pacman -Syy` for force syncing.

```
## Tokyo Tech
Server = http://pacman.mirror.intra.net.ict.e.titech.ac.jp/archlinux/$repo/os/$arch
```

### Manjaro

- http://mirror.intra.net.ict.e.titech.ac.jp/pacman/manjaro
- http://pacman.mirror.intra.net.ict.e.titech.ac.jp/manjaro

Add the below lines to the beginning of your `/etc/pacman.d/mirrorlist` and then run `pacman -Syy` for force syncing.

```
## Tokyo Tech
Server = http://pacman.mirror.intra.net.ict.e.titech.ac.jp/manjaro/$repo/os/$arch
```

### Ubuntu

For both server and desktop editions of AMD64 and i386 architecture. Only available in 20.04 LTS (focal) and 18.04 LTS (bionic).

- http://mirror.intra.net.ict.e.titech.ac.jp/apt/ubuntu
- http://apt.mirror.intra.net.ict.e.titech.ac.jp/ubuntu

Use the following command to replace the repository URLs from Japanese official archive to the local mirror.

```
% sed -i.bak -e "s%jp.archive.ubuntu.com%apt.mirror.intra.net.ict.e.titech.ac.jp%g" /etc/apt/sources.list
```

### Debian

Testing and stable release of 11 (bullseye), 10 (buster), and 9 (strech) are available.

- http://mirror.intra.net.ict.e.titech.ac.jp/apt/debian
- http://apt.mirror.intra.net.ict.e.titech.ac.jp/debian

Use the following command to replace the repository URLs from Japanese official archive to the local mirror.

```
% sed -i.bak -e "s%ftp.jp.debian.org%apt.mirror.intra.net.ict.e.titech.ac.jp%g" /etc/apt/sources.list
```

### Raspbian

- http://mirror.intra.net.ict.e.titech.ac.jp/apt/raspbian
- http://apt.mirror.intra.net.ict.e.titech.ac.jp/raspbian

Use the following command to replace the repository URLs from the official archive to the local mirror.

```
% sed -i.bak -e "s%raspbian.raspberrypi.org%apt.mirror.intra.net.ict.e.titech.ac.jp%g" /etc/apt/sources.list
```

### Cumulus

This repository is for lab's external router [FS N5850-48S6Q](https://www.fs.com/products/75874.html) and is not intended to be used on any other machine.

- http://mirror.intra.net.ict.e.titech.ac.jp/apt/cumulus
- http://apt.mirror.intra.net.ict.e.titech.ac.jp/cumulus

Use the following command to replace the repository URLs from the official archive to the local mirror - also refer to [the official documentation](https://support.cumulusnetworks.com/hc/en-us/articles/201787436-Hosting-an-Internal-Cumulus-Linux-Repository) as appropriate.

```
% sed -i.bak -e "s%repo3.cumulusnetworks.com/repo%apt.mirror.intra.net.ict.e.titech.ac.jp/cumulus%g" /etc/apt/sources.list
```

### Gentoo

- http://mirror.intra.net.ict.e.titech.ac.jp/portage/gentoo
- http://portage.mirror.intra.net.ict.e.titech.ac.jp/gentoo

Check and follow the instructions of [official handbook](https://wiki.gentoo.org/wiki/Handbook:Parts/Installation/Base).

## How to deploy

There are two ways to deploy; both ways are very simple and easy, but if you're not familiar with kubernetes, deploying with docker-compose is recommended.

**NOTE:** You need at least **2.5TB** of free disk space to deploy all mirrors. The initial synchronization may take a few days because of the bandwidth limitation on upstream servers.

### Deploy using docker-compose with systemd

If you don't have [docker-compose](https://docs.docker.com/compose/install/) (1.26.0 or higher), get it first.
All commands must be executed as root (use sudo).

```
% make install-compose
```

Then deploy mirrors on your system with:

```
% make install
```

It's done. All mirrors are automatically synchronized and kept up to date by [systemd/Timers](https://wiki.archlinux.org/index.php/Systemd/Timers).
Of course, you can initiate git updates or mirror synchronization anytime you want.
The following commands may help you:

```
% make update   # Update git repository and rebuild docker images
% make sync     # Sync all mirrors with their upstream servers
% make publish  # Publish mirrors (start Web server)
% make log      # Show syncing logs
```

Type `make uninstall` to unregister automatic mirror syncing, and type `make destroy` to purge all of local repositories.

### Deploy using helm3

Prior to the deployment, install and setup [microk8s](https://microk8s.io), then prepare PVs. Check [hint](hint) if necessary.

Add chart repository.

```
% microk8s helm3 repo add linux-repository-mirror https://yamaoka-kitaguchi-lab.github.io/linux-repository-mirror/chart
% microk8s helm3 repo list
NAME                    URL
linux-repository-mirror https://yamaoka-kitaguchi-lab.github.io/linux-repository-mirror/chart
```

Instead of the above commands, you can clone this repository and move directory to `chart`.

```
% git clone --depth 1 https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror
% cd linux-repository-mirror/chart
```

Deploy mirrors. All mirrors are automatically synchronized and kept up to date by [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).

```
% microk8s helm3 install linux-repository-mirror linux-repository-mirror
% microk8s kubectl get all,pv,pvc --namespace default
```

[![](https://raw.githubusercontent.com/yamaoka-kitaguchi-lab/linux-repository-mirror/screenshot/iterm2.png)](https://raw.githubusercontent.com/yamaoka-kitaguchi-lab/linux-repository-mirror/screenshot/iterm2.png)

## Mirroring details

Each repository size is as of June 20, 2020.
ALL means that the local mirror is a complete replication of the upper server.

| Distribution | Upstream Server | Syncing Repositories | Update Interval | Size |
| :--- | :--- | :--- | :--- | :--- |
| ArchLinux | [jpn.mirror.pkgbuild.com](https://jpn.mirror.pkgbuild.com/) | **ALL** (only 64bit binaries) | every 20 min. | 96GB |
| Manjaro | [ftp.tsukuba.wide.ad.jp](http://ftp.tsukuba.wide.ad.jp/Linux/manjaro/) | **ALL** (only 64bit binaries) | every 20 min. | 322GB |
| Ubuntu | • [jp.archive.ubuntu.com](http://jp.archive.ubuntu.com/)<br>• [ftp.jaist.ac.jp](http://ftp.jaist.ac.jp/pub/Linux/ubuntu/) (for i18n support) | 20.04 LTS, 18.04 LTS | every 20 min. | 419GB |
| Debian | • [ftp.jp.debian.org](http://ftp.jp.debian.org/debian/)<br>• [hanzubon.jp](https://hanzubon.jp/debian/) (for i18n support) | testing, 11, 10, 9 | every 20 min. | 365GB |
| Raspbian | [archive.raspbian.org](http://archive.raspbian.org/raspbian/) | **ALL** | every 20 min. | 228GB |
| Cumulus | [repo3.cumulusnetworks.com](http://repo3.cumulusnetworks.com/repo/) | w/o early-access | every 20 min. | - |
| Gentoo | • [rsync.jp.gentoo.org](rsync://rsync.jp.gentoo.org/gentoo-portage/)<br>• [ftp.iij.ad.jp](http://ftp.iij.ad.jp/pub/linux/gentoo) (for source) | **ALL**<br> (w/ distfiles and packages) | [every day](https://www.gentoo.org/support/rsync-mirrors/) | 819GB |

## Hints and tips

### When you decided to make a new mirror somewhere

Why don't you set the lab mirror as your upstream server. You can download packages without annoying bandwidth limitation.
This is especially useful for the initial synchronization, which requires a lot of data transfer.

## Coming soon

1. Add FreeBSD repository mirror (Of course BSD is not Linux, though) ([#1](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues/1))
1. Allow rsync client to pull packages from this local mirror ([#2](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues/2))

## Known issues

1. ArchLinux repository has not been updated due to the upper mirror failure ([#4](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues/4))
1. I18n support of Debian has been freezed due to the upper mirror failure ([#5](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues/5))
1. [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) doesn't work with microk8s ([#3](https://github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/issues/3))

## Versioning

Releases are managed in [CalVer](https://calver.org/) scheme and it is independent of chart versioning.
For the versions available, see the [tags on this repository](https://github.com/SINDAN/sindan-docker/tags).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
