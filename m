Return-Path: <linux-fsdevel+bounces-8045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8682EC3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2F91F24384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5F134D5;
	Tue, 16 Jan 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="E0X/tHWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2A134A1;
	Tue, 16 Jan 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1705398486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VCLSujzzlDwuQlHwmx12Nj9mX+R3Jv83uQp+uToPts=;
	b=E0X/tHWCKP+I7eyjg29dLJkauXq79JyGU0MK8In7XKzm4VDEmrdqTc7dxx6so8eYcL53gf
	Nwhgz0OCj2RZ4EMqm4cBJVv+cwNETy7TDwSefwODFUXjgDw6u+HYRWMZ5BDqzU9veqE+FB
	MnYtekoPtvzsXOZZa7VducunC5Fbg8s=
From: Sven Eckelmann <sven@narfation.org>
To: linus.luessing@c0d3.blue
Cc: b.a.t.m.a.n@lists.open-mesh.org, clm@fb.com, davem@davemloft.net,
 dsterba@suse.com, edumazet@google.com, josef@toxicpanda.com, kuba@kernel.org,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Tue, 16 Jan 2024 10:48:03 +0100
Message-ID: <23660052.EfDdHjke4D@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9125406.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9125406.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linus.luessing@c0d3.blue
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Tue, 16 Jan 2024 10:48:03 +0100
Message-ID: <23660052.EfDdHjke4D@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
MIME-Version: 1.0

@Linus, this looks like something for you.

On Tuesday, 16 January 2024 10:27:20 CET syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14620debe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a7031f9e71583b4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a344c1e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/82a7201eef4c/disk-052d5343.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ca12b4c31826/vmlinux-052d5343.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f07360ba5a8/bzImage-052d5343.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

The relevant line is the batadv_mcast_forw_tracker_tvlv_handler registration 
in batadv_mcast_init() which was introduced in
commit 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")

And I can't find the batadv_tvlv_handler_unregister for 
BATADV_TVLV_MCAST_TRACKER in batadv_mcast_free()

Kind regards,
	Sven

> 
> BUG: memory leak
> unreferenced object 0xffff88811c71a980 (size 64):
>   comm "syz-executor.7", pid 5063, jiffies 4294953937
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 20 8e 7e 1c 81 88 ff ff  ........ .~.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 9f8721dd):
>     [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
>     [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
>     [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
>     [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
>     [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
>     [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
>     [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
>     [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
>     [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
>     [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
>     [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
>     [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
>     [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
>     [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
>     [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
>     [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
>     [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
>     [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>     [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
>     [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
>     [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
>     [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
>     [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
>     [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
>     [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
>     [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199


--nextPart9125406.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWmUNMACgkQXYcKB8Em
e0ak3w//d9HRSZJiTWYrWkiOMLEoDd7oWa9shGcdm9qS+bmJ4RWkqyLQKWiLl6yz
CcGxtbDBUXvVgMUHX9BuctKnigZ7VA+7wMY1ZLVE0KUPOlqkvlW9GvkOutwa2f1d
hwFa2uPCSXqWbIaU6JjxNvHM0sEJou392MebhV5n9M9zJlS8/v5t7lwgKa3tnLL2
vhyqSKKs7BESIvUhI399nPr2AfOhw+qqndV35B5gAJVeHC+iSWBycKolP/LstaJq
Z7JE1eusP50i3vrSVIglwiefF7kUq1Y088F1nq2ommuVXFfPAxss5bwUupG7Jmtf
gIYIslX/eLNpahJvVIKNTMPBjfcaeEbT8e87xIzhT1H4quv2oApKfWTM5u0XryDK
29ICqroEH4DCv+gEYF4Miip40m982YtZlB1wnShFK3icFZaEGipgqxJ67/XJNkfP
GXdNnzWlEl6PXsS388TYLkQlxWdFNsSM08IPZjolOEgIDhZaM3AUCDUe22BWiN5Z
BdbeU3sWmiy3BaZ2fUh6M0Cawd1Oz4QneJl3rPce1jeDI4ee9CtTdgWd1/ziG8yH
0QhMTljzGz5WEaPBT9L7PsKf33/s/IY1GwXzB/maObFi10G6nn+743btOlCodOb3
i4lTc8Z3Vl+4CCl78CUfQemr/nd8irtzCJk/OJuUlOSmepgs+J4=
=A35g
-----END PGP SIGNATURE-----

--nextPart9125406.EvYhyI6sBW--




