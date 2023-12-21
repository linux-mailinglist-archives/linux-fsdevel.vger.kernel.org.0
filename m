Return-Path: <linux-fsdevel+bounces-6614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEA81ACE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863E71F2473D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503105248;
	Thu, 21 Dec 2023 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="DXdlXzR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB24416;
	Thu, 21 Dec 2023 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128121;
	bh=5pox7i0LMU5pswbZv4sORhQwC0BFgjzW/OuspbzrSpE=;
	h=Date:From:Cc:Subject:From;
	b=DXdlXzR/L5iIRsDgYOWlaiLPjOc+fnFTfX+ltbyhDtkXM/SxONn7FPJLXGLuLOrzK
	 Pg5fkjgCgX0VbDEwsDvDTxmshnruk1Kbey43wgtPpmbXlJd66IFzC/KdRcacVGXUyX
	 Ae/HVgQw0TjmPmwlMwr6yAdUkMN8fCxx1VrMUDmoHUF2/GMMJ514kIJ8x5/ZkskMNm
	 rgc/iDLOax+DC5ZJbYklMCTj4K7tdaGWmdK4UcgLDm/Up0UiM/Pb9oqyPyslXr+3xk
	 gnLgzMVzEUw/qRsfiM8F300FP7jlbvCCnmQ4YVZ/wPjuslpgG9hyT7a10bgUm9G7sp
	 qSkA2UsVKz2Kw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AB3F313C4C;
	Thu, 21 Dec 2023 04:08:41 +0100 (CET)
Date: Thu, 21 Dec 2023 04:08:41 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Peilin Ye <peilin.ye@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org
Subject: [PATCH v2 00/11] Avoid unprivileged splice(file->)/(->socket) pipe
 exclusion
Message-ID: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvvwnibat3ajd753"
Content-Disposition: inline
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--wvvwnibat3ajd753
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As it stands, splice(file -> pipe):
1. locks the pipe,
2. does a read from the file,
3. unlocks the pipe.

When the file resides on a normal filesystem, this isn't an issue
because the filesystem has been defined as trusted by root having
mounted it.

But when the file is actually IPC (FUSE) or is just IPC (sockets)
or is a tty, this means that the pipe lock will be held for an
attacker-controlled length of time, and during that time every
process trying to read from, write to, open, or close the pipe
enters an uninterruptible sleep, and will only exit it if the
splicing process is killed.

This trivially denies service to:
* any hypothetical pipe-based log collexion system
* all nullmailer installations
* me, personally, when I'm pasting stuff into qemu -serial chardev:pipe

A symmetric situation happens for splicing(pipe -> socket):
the pipe is locked for as long as the socket is full.

This follows:
1. https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2e=
kkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
2. a security@ thread rooted in
   <irrrblivicfc7o3lfq7yjm2lrxq35iyya4gyozlohw24gdzyg7@azmluufpdfvu>
3. https://nabijaczleweli.xyz/content/blogn_t/011-linux-splice-exclusion.ht=
ml
4. https://lore.kernel.org/lkml/cover.1697486714.git.nabijaczleweli@nabijac=
zleweli.xyz/t/#u  (v1)
   https://lore.kernel.org/lkml/1cover.1697486714.git.nabijaczleweli@nabija=
czleweli.xyz/t/#u (resend)
   https://lore.kernel.org/lkml/2cover.1697486714.git.nabijaczleweli@nabija=
czleweli.xyz/t/#u (reresend)
5. https://lore.kernel.org/lkml/dtexwpw6zcdx7dkx3xj5gyjp5syxmyretdcbcdtvrnu=
kd4vvuh@tarta.nabijaczleweli.xyz/t/#u
   (relay_file_splice_read removal)

1-7/11 request MSG_DONTWAIT (sockets)/IOCB_NOWAIT (generic) on the read

  8/11 removes splice_read from tty completely

  9/11 removes splice_read from FUSE filesystems
       (except virtiofs which has normal mounting security semantics,
        but is handled via FUSE code)

 10/11 allows splice_read from FUSE filesystems mounted by real root
       (this matches the blessing received by non-FUSE network filesystems)

 11/11 requests MSG_DONTWAIT for splice(pipe -> socket).

 12/11 has the man-pages patch with draft wording.

All but 5/11 (AF_SMC) have been tested and embed shell programs to
repro them. AIUI I'd need an s390 machine for it? It's trivial.

6/11 (AF_KCM) also fixes kcm_splice_read() passing SPLICE_F_*-style
flags to skb_recv_datagram(), which takes MSG_*-style flags. I don't
think they did anything anyway? But.

There are two implementations that definitely sleep all the time
and I didn't touch them:
  tracing_splice_read_pipe
  tracing_buffers_splice_read (dropped in v2, v1 4/11)
the semantics are lost on me, but they're in debugfs/tracefs, so
it doesn't matter if they block so long as they work, and presumably
they do right now.

There is also relay_file_splice_read (dropped in v2, v1 5/11),
which isn't an implementation at all because it's dead code, broken,
and removed in -mm.

The diffs in 1-7,11/11 are unchanged, save for a rebase in 7/11.
8/11 replaces the file type test in v1 10/11.
9/11 and 10/11 are new in v2.

Ahelenia Ziemia=C5=84ska (11):
  splice: copy_splice_read: do the I/O with IOCB_NOWAIT
  af_unix: unix_stream_splice_read: always request MSG_DONTWAIT
  fuse: fuse_dev_splice_read: use nonblocking I/O
  net/smc: smc_splice_read: always request MSG_DONTWAIT
  kcm: kcm_splice_read: always request MSG_DONTWAIT
  tls/sw: tls_sw_splice_read: always request non-blocking I/O
  net/tcp: tcp_splice_read: always do non-blocking reads
  tty: splice_read: disable
  fuse: file: limit splice_read to virtiofs
  fuse: allow splicing from filesystems mounted by real root
  splice: splice_to_socket: always request MSG_DONTWAIT

 drivers/tty/tty_io.c |  2 --
 fs/fuse/dev.c        | 10 ++++++----
 fs/fuse/file.c       | 17 ++++++++++++++++-
 fs/fuse/fuse_i.h     |  4 ++++
 fs/fuse/inode.c      |  2 ++
 fs/fuse/virtio_fs.c  |  1 +
 fs/splice.c          |  5 ++---
 net/ipv4/tcp.c       | 32 +++-----------------------------
 net/kcm/kcmsock.c    |  2 +-
 net/smc/af_smc.c     |  6 +-----
 net/tls/tls_sw.c     |  5 ++---
 net/unix/af_unix.c   |  5 +----
 12 files changed, 39 insertions(+), 52 deletions(-)

base-commit: 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
--
2.39.2

--wvvwnibat3ajd753
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrDQACgkQvP0LAY0m
WPEekg/9F4adsL71PkFdGw11nhaSsR5MlS4f0o0RB/vJ8ovxAphdBOm3/tw+nNZF
s8aO5IMhGs2S/CNTrib2VxnptiRy4Z9zYEaZ84QIvk5W4ZjymxfwFo4gCFpY2A2v
x8B2/eyaI3mMfkfR7XLcZEoVJzoqk3mQg+Izp3eJ6LEzqqrn+CSIGnb/x8WgItv/
bHX4swZp5YSfFOf3nDtcFV7SNCQDj+2pUqHxiJ/Lg0sgsp9OuEroQTXg31sL/haO
nyKBCqz7X/vqteRxk1XeVjXKKl0J9s32/ZXc8TliW0NAIweTK6IRMNQgiNMMPj3M
oO0PmLO0DJklimGE/zIpnhZ2n33FkmU2AjBm8C4v+AJIsmFGcOO9/76tDwxr1qiu
zXp8mZKclgMeEIlPm6i3NONyZ6iB1sS5+FTh5nRuWGocU5FNq7fD3pij6sK7fYnt
NiyM+78LHOO3mYHkOy369j7YU4F4TA8B1kLxAYJcSgK8Sd0DzrS3E20GgxATBVbA
RX8LHM8mbhI/yqc6EfBrhTnaZwzjR+lZcXCwu23rnVvy7t9Qjndrp+d+bVuXF14f
9urOe+GfktjuCQEtsEe3BihoXwir6Mu89xJPldUwrTzrPbOiskDJY3jfqjNAkb8D
t0OMbEFJyrwqeV8rbzGl04F9wg5ETnAeIfkj56H//PnU0VzbKaI=
=zGSt
-----END PGP SIGNATURE-----

--wvvwnibat3ajd753--

