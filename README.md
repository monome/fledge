# fledge

crow updater for norns

## open maiden for much more info when updating

- checks for `pip3` and needed python modules
- fetches current crow firmware
- activates bootloader
- flashes new firwmare

caveats:

- inelegant brute force approach
- redundant work/downloading
- no error checking
- no checking versions prior to update
- no progress bars, only stages reported
