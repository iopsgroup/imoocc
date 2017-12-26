# Copyright (C) 2003-2011  Robey Pointer <robeypointer@gmail.com>
#
# This file is part of paramiko.
#
# Paramiko is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# Paramiko is distrubuted in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Paramiko; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.

"""
I{Paramiko} (a combination of the esperanto words for "paranoid" and "friend")
is a modules for python 2.3 or greater that implements the SSH2 protocol for
secure (encrypted and authenticated) connections to remote machines.  Unlike
SSL (aka TLS), the SSH2 protocol does not require hierarchical certificates
signed by a powerful central authority.  You may know SSH2 as the protocol that
replaced C{telnet} and C{rsh} for secure access to remote shells, but the
protocol also includes the ability to open arbitrary channels to remote
services across an encrypted tunnel.  (This is how C{sftp} works, for example.)

The high-level client API starts with creation of an L{SSHClient} object.
For more direct control, pass a socket (or socket-like object) to a
L{Transport}, and use L{start_server <Transport.start_server>} or
L{start_client <Transport.start_client>} to negoatite
with the remote host as either a server or client.  As a client, you are
responsible for authenticating using a password or private key, and checking
the server's host key.  I{(Key signature and verification is done by paramiko,
but you will need to provide private keys and check that the content of a
public key matches what you expected to see.)}  As a server, you are
responsible for deciding which users, passwords, and keys to allow, and what
kind of channels to allow.

Once you have finished, either side may request flow-controlled L{Channel}s to
the other side, which are python objects that act like sockets, but send and
receive data over the encrypted session.

Paramiko is written entirely in python (no C or platform-dependent code) and is
released under the GNU Lesser General Public License (LGPL).

Website: U{https://github.com/paramiko/paramiko/}
"""

import sys

if sys.version_info < (2, 2):
    raise RuntimeError('You need python 2.2 for this modules.')


__author__ = "Jeff Forcier <jeff@bitprophet.org>"
__version__ = "1.9.0"
__license__ = "GNU Lesser General Public License (LGPL)"


from scanhosts.modules.paramiko.transport import SecurityOptions, Transport
from scanhosts.modules.paramiko.client import SSHClient, MissingHostKeyPolicy, AutoAddPolicy, RejectPolicy, WarningPolicy
from scanhosts.modules.paramiko.auth_handler import AuthHandler
from scanhosts.modules.paramiko.channel import Channel, ChannelFile
from scanhosts.modules.paramiko.ssh_exception import SSHException, PasswordRequiredException, \
    BadAuthenticationType, ChannelException, BadHostKeyException, \
    AuthenticationException, ProxyCommandFailure
from scanhosts.modules.paramiko.server import ServerInterface, SubsystemHandler, InteractiveQuery
from scanhosts.modules.paramiko.rsakey import RSAKey
from scanhosts.modules.paramiko.dsskey import DSSKey
from scanhosts.modules.paramiko.sftp import SFTPError, BaseSFTP
from scanhosts.modules.paramiko.sftp_client import SFTP, SFTPClient
from scanhosts.modules.paramiko.sftp_server import SFTPServer
from scanhosts.modules.paramiko.sftp_attr import SFTPAttributes
from scanhosts.modules.paramiko.sftp_handle import SFTPHandle
from scanhosts.modules.paramiko.sftp_si import SFTPServerInterface
from scanhosts.modules.paramiko.sftp_file import SFTPFile
from scanhosts.modules.paramiko.message import Message
from scanhosts.modules.paramiko.packet import Packetizer
from scanhosts.modules.paramiko.file import BufferedFile
from scanhosts.modules.paramiko.agent import Agent, AgentKey
from scanhosts.modules.paramiko.pkey import PKey
from scanhosts.modules.paramiko.hostkeys import HostKeys
from scanhosts.modules.paramiko.config import SSHConfig
from scanhosts.modules.paramiko.proxy import ProxyCommand

# fix modules names for epydoc
for c in locals().values():
    if issubclass(type(c), type) or type(c).__name__ == 'classobj':
        # classobj for exceptions :/
        c.__module__ = __name__
del c

from scanhosts.modules.paramiko.common import AUTH_SUCCESSFUL, AUTH_PARTIALLY_SUCCESSFUL, AUTH_FAILED, \
     OPEN_SUCCEEDED, OPEN_FAILED_ADMINISTRATIVELY_PROHIBITED,  OPEN_FAILED_CONNECT_FAILED, \
     OPEN_FAILED_UNKNOWN_CHANNEL_TYPE, OPEN_FAILED_RESOURCE_SHORTAGE

from scanhosts.modules.paramiko.sftp import SFTP_OK, SFTP_EOF, SFTP_NO_SUCH_FILE, SFTP_PERMISSION_DENIED, SFTP_FAILURE, \
     SFTP_BAD_MESSAGE, SFTP_NO_CONNECTION, SFTP_CONNECTION_LOST, SFTP_OP_UNSUPPORTED

from scanhosts.modules.paramiko.common import io_sleep

__all__ = [ 'Transport',
            'SSHClient',
            'MissingHostKeyPolicy',
            'AutoAddPolicy',
            'RejectPolicy',
            'WarningPolicy',
            'SecurityOptions',
            'SubsystemHandler',
            'Channel',
            'PKey',
            'RSAKey',
            'DSSKey',
            'Message',
            'SSHException',
            'AuthenticationException',
            'PasswordRequiredException',
            'BadAuthenticationType',
            'ChannelException',
            'BadHostKeyException',
            'ProxyCommand',
            'ProxyCommandFailure',
            'SFTP',
            'SFTPFile',
            'SFTPHandle',
            'SFTPClient',
            'SFTPServer',
            'SFTPError',
            'SFTPAttributes',
            'SFTPServerInterface',
            'ServerInterface',
            'BufferedFile',
            'Agent',
            'AgentKey',
            'HostKeys',
            'SSHConfig',
            'util',
            'io_sleep' ]
