#!/usr/bin/env python3
import argparse
import os
import sys

import pynvim


AUTOCMD_EVENT = 'nvim-remote-edit-bufdelete'

def add_wait_autocmd(nvim, event, *, buffer=None):
    bufnr = buffer if buffer is not None else 0
    aubuffer = f'<{buffer=}>' if buffer is not None else '<buffer>'
    nvim.api.exec(f'''
        call nvim_buf_set_option({bufnr}, 'bufhidden', 'delete')
        augroup nvim-remote-edit-wait
            autocmd BufDelete {aubuffer} ++once call rpcnotify({nvim.channel_id}, {event!r})
        augroup END
    ''', False)


def main():
    parser = argparse.ArgumentParser(
        description='Open files in the parent neovim instance.')

    parser.add_argument(
        'filenames', nargs='*')

    parser.add_argument(
        '-o', dest='hsplit', action='store_true')
    parser.add_argument(
        '-O', dest='vsplit', action='store_true')
    parser.add_argument(
        '-p', dest='tabs', action='store_true')

    parser.add_argument(
        '-w', '--wait', action='store_true',
        help="Don't wait for the edited buffer to be deleted")

    args = parser.parse_args()

    if sum((args.hsplit, args.vsplit, args.tabs)) > 1:
        print('Only one of -o, -O and -p must be specified')
        return


    nvim_address = (os.environ.get('NVIM')
        or os.environ.get('NVIM_LISTEN_ADDRESS'))

    if nvim_address is None:
        print('nvim.py must be run with $NVIM_LISTEN_ADDRESS defined',
              file=sys.stderr)
        return

    nvim = pynvim.attach('socket', path=nvim_address)
    nvim.command('lcd ' + nvim.funcs.fnameescape(os.getcwd()))
    event = f'{AUTOCMD_EVENT}-{nvim.channel_id}'

    command = ('tabedit' if args.tabs else
               'vsplit'  if args.vsplit else
               'split'   if args.hsplit else
               'argedit')

    if len(args.filenames) == 0:
        command = ('tabedit'  if args.tabs else
                   'vert new' if args.vsplit else
                   'new'      if args.hsplit else
                   'enew')
        args.filenames.append('')

    count = len(args.filenames)

    for filename in args.filenames:
        nvim.command('{} {}'.format(command, filename))

        if args.wait:
            add_wait_autocmd(nvim, event)

    if args.wait:
        def notification_handler(rpc_event, args):
            nonlocal count

            if rpc_event != event:
                return

            count -= 1
            if count <= 0:
                nvim.stop_loop()

        nvim.run_loop(None, notification_handler)


if __name__ == '__main__':
    main()
