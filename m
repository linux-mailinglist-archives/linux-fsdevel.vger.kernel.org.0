Return-Path: <linux-fsdevel+bounces-49101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F032BAB8018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F246F3BAF70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC827BF6D;
	Thu, 15 May 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNX9VG11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CA1ADFFE;
	Thu, 15 May 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297041; cv=none; b=mo1+aV4GpXrXxIfLzfSgUfMmn4Kegc5MfObZDxd7GMLHmla9btxz0qWCs4GmL0+qjSh25rKvQHu6bHx+PeqMDnLEWz3CJ5vRuV8HW0FaJF0aXkcgdqNhbW11MuNBoko1tKc1+eTiQyn9Iw9VKLvzDVwFZ5NjxKnSEhRJYzBYv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297041; c=relaxed/simple;
	bh=vGi9THXEDpvT76QZd9G6tEugzqGz/38PnjMXAVERiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+8KpYMHKvCdrVHHYaQ59LpUzpQmQAk9xDRrMTuZPlCx29jM4AwrYFIm09HOc7NAH6YXpYgsQWpkxL2lBryrItIuC9R/Zkjs5RoqOo6EMNgjRI0LZwhJ3a6VIXq9x3ArOXkKJFEfKDH3akSupUG2PVXGPz3v1f8j0SKlXKLwgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNX9VG11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94C6C4CEE9;
	Thu, 15 May 2025 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747297041;
	bh=vGi9THXEDpvT76QZd9G6tEugzqGz/38PnjMXAVERiPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNX9VG11602jl0A9wuZQi5Jbi8Xwlq4eCDH55qz1Ak5yKnMKSmMWzQOOc5ggf/NkX
	 BtJ3kHTzKG3JL16emyTiXFkH8xm/YEg6VPNLi+jCL0nJy6C+ZlEabL4acFidGClz6B
	 0i/GPSIuPT/8iTEfThxTC3+MUGtTVF2flIAaVyzUQZmVpP8pAntkqlDrp4Al8X7ay8
	 flLbOElwgktnPgUKmmhD1hnxaPqkgy42ivu8rQzGg9ulCI1GLn+F550xXRLzqhDdiS
	 ZkUg72C209ESXzEPQZbihyYUTyi6SWHzvQKZQ8DUiVCht47SMO9fmxNoRrhYI0pJGV
	 t9SBzISOLtYzA==
Date: Thu, 15 May 2025 10:17:15 +0200
From: Joel Granados <joel.granados@kernel.org>
To: syzbot <syzbot+0b62957894976d747660@syzkaller.appspotmail.com>
Cc: kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel paging request in
 drop_sysctl_table
Message-ID: <xftkeek5ydwgnfc3x3nhwzhawbe5blucnuatw5hcnm3gp75scs@nhwpxyh6phjo>
References: <68251af1.a70a0220.3e9d8.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m66n6mjpc65tnocx"
Content-Disposition: inline
In-Reply-To: <68251af1.a70a0220.3e9d8.001f.GAE@google.com>


--m66n6mjpc65tnocx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 03:36:33PM -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    1a33418a69cc Merge tag '6.15-rc5-smb3-client-fixes' of gi=
t..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15c0ccf4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D925afd2bdd38a=
581
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0b62957894976d7=
47660
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D160eecf4580=
000
>=20
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/9=
8a89b9f34e4/non_bootable_disk-1a33418a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b719c768f61/vmlinu=
x-1a33418a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/37b85c3e7f3b/z=
Image-1a33418a.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0b62957894976d747660@syzkaller.appspotmail.com
>=20
> veth1_macvtap: left promiscuous mode
> veth0_macvtap: left promiscuous mode
> veth1_vlan: left promiscuous mode
> veth0_vlan: left promiscuous mode
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address 74756f78 when r=
ead
> [74756f78] *pgd=3D80000080005003, *pmd=3D00000000
> Internal error: Oops: 206 [#1] SMP ARM
> Modules linked in:
> CPU: 1 UID: 0 PID: 3143 Comm: kworker/u8:2 Not tainted 6.15.0-rc5-syzkall=
er #0 PREEMPT=20
> Hardware name: ARM-Versatile Express
> Workqueue: netns cleanup_net
> PC is at __rb_change_child include/linux/rbtree_augmented.h:199 [inline]
> PC is at __rb_erase_augmented include/linux/rbtree_augmented.h:242 [inlin=
e]
> PC is at rb_erase+0x270/0x394 lib/rbtree.c:443
> LR is at 0x0
> pc : [<81a3fb58>]    lr : [<00000000>]    psr: 200f0013
> sp : df9e5d80  ip : 74756f70  fp : df9e5d94
> r10: 82c1f980  r9 : 829d1ec4  r8 : 00000004
> r7 : 838d8b00  r6 : 00000001  r5 : 8517c348  r4 : 8517c300
> r3 : 74756f72  r2 : 00000000  r1 : 838d8b34  r0 : 8517c368
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 30c5387d  Table: 850515c0  DAC: 00000000
> Register r0 information: slab kmalloc-128 start 8517c300 pointer offset 1=
04 size 128
> Register r1 information: slab kmalloc-128 start 838d8b00 pointer offset 5=
2 size 128
> Register r2 information: NULL pointer
> Register r3 information: non-paged memory
> Register r4 information: slab kmalloc-128 start 8517c300 pointer offset 0=
 size 128
> Register r5 information: slab kmalloc-128 start 8517c300 pointer offset 7=
2 size 128
> Register r6 information: non-paged memory
> Register r7 information: slab kmalloc-128 start 838d8b00 pointer offset 0=
 size 128
> Register r8 information: non-paged memory
> Register r9 information: non-slab/vmalloc memory
> Register r10 information: non-slab/vmalloc memory
> Register r11 information: 2-page vmalloc region starting at 0xdf9e4000 al=
located at kernel_clone+0xac/0x3e4 kernel/fork.c:2844
> Register r12 information: non-paged memory
> Process kworker/u8:2 (pid: 3143, stack limit =3D 0xdf9e4000)
> Stack: (0xdf9e5d80 to 0xdf9e6000)
> 5d80: 8517c300 8517c348 df9e5dd4 df9e5d98 80610d54 81a3f8f4 0000000c 600f=
0013
> 5da0: ddde099c 600f0013 00000000 03710a8b 8517cb00 84813a00 8517cb00 0000=
0001
> 5dc0: 8517c300 00000004 df9e5e14 df9e5dd8 80610d88 80610c90 816f4260 829d=
1ec4
> 5de0: 829d1ec4 82aca2a8 df9e5e90 03710a8b df9e5e14 84813a00 df9e5e90 829e=
0224
> 5e00: df9e5e90 829d1ec4 df9e5e2c df9e5e18 80610e58 80610c90 8517cb00 df9e=
5e90
> 5e20: df9e5e3c df9e5e30 81980b1c 80610e3c df9e5e54 df9e5e40 816f45b0 8198=
0b18
> 5e40: 84951b00 df9e5e90 df9e5e74 df9e5e58 81539cdc 816f45a4 829e0224 82c1=
f940
> 5e60: 829d1e80 df9e5e90 df9e5ed4 df9e5e78 8153c160 81539ca8 81a5bd14 8029=
ce24
> 5e80: 82c1f940 829d1e80 808c99b0 81539d04 84951b20 84951b20 00000100 0000=
0122
> 5ea0: 00000000 03710a8b 81c01f84 83b83d80 829d1e98 8301bc00 8300e600 8418=
6000
> 5ec0: 8301bc15 8300f070 df9e5f2c df9e5ed8 802873bc 8153bebc 81c01a44 8418=
6000
> 5ee0: df9e5f14 df9e5ef0 829d1e9c 829d1e98 829d1e9c 829d1e98 df9e5f2c 0000=
0000
> 5f00: 80282cf8 83b83d80 8300e620 8300e600 82804d40 83b83dac 84186000 61c8=
8647
> 5f20: df9e5f6c df9e5f30 80288004 80287214 81a5bd14 8029ce24 df9e5f6c df9e=
5f48
> 5f40: 8028eb98 00000001 84186000 83b83e00 e4935e60 80287e08 83b83d80 0000=
0000
> 5f60: df9e5fac df9e5f70 8028f07c 80287e14 80274ea8 81a5bc9c 84186000 0371=
0a8b
> 5f80: df9e5fac 84986300 8028ef50 00000000 00000000 00000000 00000000 0000=
0000
> 5fa0: 00000000 df9e5fb0 80200114 8028ef5c 00000000 00000000 00000000 0000=
0000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 0000=
0000
> Call trace:=20
> [<81a3f8e8>] (rb_erase) from [<80610d54>] (erase_entry fs/proc/proc_sysct=
l.c:189 [inline])
> [<81a3f8e8>] (rb_erase) from [<80610d54>] (erase_header fs/proc/proc_sysc=
tl.c:225 [inline])
> [<81a3f8e8>] (rb_erase) from [<80610d54>] (start_unregistering fs/proc/pr=
oc_sysctl.c:322 [inline])
> [<81a3f8e8>] (rb_erase) from [<80610d54>] (drop_sysctl_table+0xd0/0x1ac f=
s/proc/proc_sysctl.c:1514)
>  r5:8517c348 r4:8517c300
> [<80610c84>] (drop_sysctl_table) from [<80610d88>] (drop_sysctl_table+0x1=
04/0x1ac fs/proc/proc_sysctl.c:1521)
>  r8:00000004 r7:8517c300 r6:00000001 r5:8517cb00 r4:84813a00
> [<80610c84>] (drop_sysctl_table) from [<80610e58>] (unregister_sysctl_tab=
le fs/proc/proc_sysctl.c:1539 [inline])
> [<80610c84>] (drop_sysctl_table) from [<80610e58>] (unregister_sysctl_tab=
le+0x28/0x38 fs/proc/proc_sysctl.c:1531)
>  r8:829d1ec4 r7:df9e5e90 r6:829e0224 r5:df9e5e90 r4:84813a00
> [<80610e30>] (unregister_sysctl_table) from [<81980b1c>] (unregister_net_=
sysctl_table+0x10/0x14 net/sysctl_net.c:177)
>  r5:df9e5e90 r4:8517cb00
> [<81980b0c>] (unregister_net_sysctl_table) from [<816f45b0>] (sysctl_rout=
e_net_exit+0x18/0x38 net/ipv4/route.c:3632)
> [<816f4598>] (sysctl_route_net_exit) from [<81539cdc>] (ops_exit_list+0x4=
0/0x68 net/core/net_namespace.c:172)
>  r5:df9e5e90 r4:84951b00
> [<81539c9c>] (ops_exit_list) from [<8153c160>] (cleanup_net+0x2b0/0x49c n=
et/core/net_namespace.c:654)
>  r7:df9e5e90 r6:829d1e80 r5:82c1f940 r4:829e0224
> [<8153beb0>] (cleanup_net) from [<802873bc>] (process_one_work+0x1b4/0x4f=
4 kernel/workqueue.c:3238)
>  r10:8300f070 r9:8301bc15 r8:84186000 r7:8300e600 r6:8301bc00 r5:829d1e98
>  r4:83b83d80
> [<80287208>] (process_one_work) from [<80288004>] (process_scheduled_work=
s kernel/workqueue.c:3319 [inline])
> [<80287208>] (process_one_work) from [<80288004>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3400)
>  r10:61c88647 r9:84186000 r8:83b83dac r7:82804d40 r6:8300e600 r5:8300e620
>  r4:83b83d80
> [<80287e08>] (worker_thread) from [<8028f07c>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:83b83d80 r8:80287e08 r7:e4935e60 r6:83b83e00 r5:84186000
>  r4:00000001
> [<8028ef50>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)

I'm looking at https://syzkaller.appspot.com/text?tag=3DReproLog&x=3D11a1b4=
d4580000
and I see that a test failed in neigh_parms_release before all this happened
(output here [1]). Questions:

1. Could the previous test have caused this to show in sysctl
   erase_entry? How do I find out?

2. I don't have clear what commit introduced this. I see a head commit,
   but I cant find the subcommit related to this failure.

Help appreciated.

[1]
  program crashed: BUG: corrupted list in neigh_parms_release
  a never seen crash title: BUG: corrupted list in neigh_parms_release, ign=
ore
  testing program (duration=3D22m39.514192312s, {Threaded:true Repeat:true =
RepeatTimes:0 Procs:1 Slowdown:10 Sandbox:none SandboxArg:0 Leak:false NetI=
njection:true NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true Cl=
oseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true VhciInjection=
:false Wifi:false IEEE802154:false Sysctl:true Swap:true UseTmpDir:true Han=
dleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false FaultCall=
:0 FaultNth:0}}): openat$binderfs-syz_clone
  detailed listing:
  executing program 0:
  openat$binderfs(0xffffffffffffff9c, &(0x7f0000000380)=3D'./binderfs/binde=
r0\x00', 0x0, 0x0)
  syz_clone(0x0, 0x0, 0x0, 0x0, 0x0, 0x0)


Best
--=20

Joel Granados

--m66n6mjpc65tnocx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmglovgACgkQupfNUreW
QU9RVQv7Bus7sJbRzD8N2jAwJEPxk/2i6aB4JSACBGlUv1FZXD2x9gUq3EomrW9A
SiQ2SxspUtTWrdxFhhXGbYABFTKAWGY2PDXRE8TYwARcq6/QDRCSTCT3MRU3zJnl
BIuKHzeBDyMJl8ZeMy0QszKfhLIIFujOend9A+CkCn/fvK7/4WFpzeR0mr+ZToiS
GfKvt0NUcT7fgICceU7wlyR4gnvjdL0zqKy/ZpoYvoH63PKru7i1s8XbTmd1ZWxD
fRqpQs7S8DTNEFL6fUYlNi0xdZg9lQhnm1g9zMCfDVJJ66DwmSj2aOqtA8DGyj0S
11IjDavqVfD4u9IJc8eC7J8Z4SOjRC5AtH8HYypu3efcllbFY2Ud1FFn7zQO41IE
EwYtf8S957w2jIE3NyGWY/I3HhlCndq1LaLPLq3pV7SCJJEyb+oGSHJq8rBhKpWP
NDl4BtaOy/c23QwT5c/h1yIs27m41QxGXdRItiZ/lzIO5laE4dCufYgD0oNpX6Np
ULnwA0yC
=QYTf
-----END PGP SIGNATURE-----

--m66n6mjpc65tnocx--

