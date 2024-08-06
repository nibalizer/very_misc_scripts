# tailscale networking notes

> Note route table 52

```bash
ip route show
ip rule list
sudo systemctl stop tailscaled
ip rule list
sudo systemctl start tailscaled
ip rule list
ip -d route show table all
```
