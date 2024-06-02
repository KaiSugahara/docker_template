### How to disable systemd-resolved

参考：https://zenn.dev/devcat/scraps/183412777dda7c

```bash
$ sudo vim /etc/systemd/resolved.conf
[Resolve]
 DNSStubListener=no
 DNS=127.0.0.1
$ sudo systemctl restart systemd-resolved
$ sudo reboot
```