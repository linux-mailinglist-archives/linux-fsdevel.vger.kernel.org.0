Return-Path: <linux-fsdevel+bounces-32499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D601E9A6ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8221D1F2202D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8B1CBEA3;
	Mon, 21 Oct 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="V/LOjDnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD351CB53E
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526085; cv=none; b=O1po63wcQQJ9mTnQy1s+rAK3jgeA0KF1y6qH1rMfrAse6gx0U5Wy8kNn1ostjtz2DvhRfwBuSKvIZu7YVCsrDGLRyZFH1f7Pln2u1+HODwwTyYFGGJ0H1GDEDy1hD9D4qJ9Id5qN6U91mW3sMhzcnPvLudYVt0i3EaHCbr+hMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526085; c=relaxed/simple;
	bh=gBQfWbaf4DLA9JbnvGS+TC6bwpMceB1mFSgQhwDTciQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRnq4Kp8oUyXSZbtEAkjvZ3szQNAD72ugdKv7zR1Hekurr2+f5OZB/mo2dIH5gJ9Q/DFekWGG6PuQEPVfboTDnMuyXnPzfBUsUceyCNVg2oCRAW/Xc+H5Xtp9DdRe3VARjUb0aF0KWq8CT7QH0lxg1HeIkOmgiCuwzCdSAqurcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=V/LOjDnH; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 9fa29520-8fc4-11ef-87c7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9fa29520-8fc4-11ef-87c7-005056abbe64;
	Mon, 21 Oct 2024 17:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=5D3VbkUQ7hM46foP2QjEQVJ1swXMc0P5i6PKM2lsnqM=;
	b=V/LOjDnH1Lpzr2EZ2BELTDIM4oKrST0y/nofbsf6I6ugSR0pqYcBypMQMPKC1SAytrM+l5d5Ux7sp
	 zo5a+1374f8WdPCwnKMw0PxdUxqiccItKNI5c4CYqCCpbk8KtTFN8uamwNFrq2cppRat6Lpe/OOfgG
	 VzwsLX+7FziWCEVQ=
X-KPN-MID: 33|Izwji7oAFnsuetdNlQhsJ1vaDzzSu+Wv8uGe8Mh4zmjc+IF9DaGcSwT2iE5D5BP
 2oURu1zjbnkQRWxmzr9cGbslK1Byq3OzXtg+WYqEIeew=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Iyk0e0y+ofeSYXIf3pD4+43iESrLzCwfAbi6b57AETqlrs0vD1tUAiLI3IziD2D
 /LUGcMTPaJN201hxQWoxpyA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9f093d81-8fc4-11ef-a2c7-005056abf0db;
	Mon, 21 Oct 2024 17:53:32 +0200 (CEST)
Date: Mon, 21 Oct 2024 17:53:31 +0200
From: Antony Antony <antony@phenome.org>
To: David Howells <dhowells@redhat.com>
Cc: Antony Antony <antony@phenome.org>, Sedat Dilek <sedat.dilek@gmail.com>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <ZxZ4-9guCQdAQLpu@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <2171405.1729521950@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2171405.1729521950@warthog.procyon.org.uk>

On Mon, Oct 21, 2024 at 03:45:50PM +0100, David Howells wrote:
> Can you tell me what parameters you're mounting 9p with?  Looking at the
> backtrace:
>=20
> [   32.390878]  bad_page+0x70/0x110
> [   32.391056]  free_unref_page+0x363/0x4f0
> [   32.391257]  p9_release_pages+0x41/0x90 [9pnet]
> [   32.391627]  p9_virtio_zc_request+0x3d4/0x720 [9pnet_virtio]
> [   32.391896]  ? p9pdu_finalize+0x32/0xa0 [9pnet]
> [   32.392153]  p9_client_zc_rpc.constprop.0+0x102/0x310 [9pnet]
> [   32.392447]  ? kmem_cache_free+0x36/0x370
> [   32.392703]  p9_client_read_once+0x1a6/0x310 [9pnet]
> [   32.392992]  p9_client_read+0x56/0x80 [9pnet]
> [   32.393238]  v9fs_issue_read+0x50/0xd0 [9p]
> [   32.393467]  netfs_read_to_pagecache+0x20c/0x480 [netfs]
> [   32.393832]  netfs_readahead+0x225/0x330 [netfs]
> [   32.394154]  read_pages+0x6a/0x250
>=20
> it's using buffered I/O, but when I try and use 9p from qemu, it wants to=
 use
> unbuffered/direct I/O.

how can I check what it is using?
could you see from the command line?=20

/nix/store/s7zgdx5i9gs4abxjl94jcsw3xn4m861i-qemu-host-cpu-only-for-vm-tests=
-9.1.0/bin/qemu-kvm -cpu max -name machine -m 1024 -smp 1 -device virtio-rn=
g-pci -net nic,netdev=3Duser.0,model=3Dvirtio -netdev user,id=3Duser.0, -vi=
rtfs local,path=3D/nix/store,security_model=3Dnone,mount_tag=3Dnix-store -v=
irtfs local,path=3D/build/shared-xchg,security_model=3Dnone,mount_tag=3Dsha=
red -virtfs local,path=3D/build/vm-state-machine/xchg,security_model=3Dnone=
,mount_tag=3Dxchg -drive cache=3Dwriteback,file=3D/build/vm-state-machine/m=
achine.qcow2,id=3Ddrive1,if=3Dnone,index=3D1,werror=3Dreport -device virtio=
-blk-pci,bootindex=3D1,drive=3Ddrive1,serial=3Droot -device virtio-net-pci,=
netdev=3Dvlan1,mac=3D52:54:00:12:01:01 -netdev vde,id=3Dvlan1,sock=3D/build=
/vde1.ctl -device virtio-keyboard -usb -device usb-tablet,bus=3Dusb-bus.0 -=
kernel /nix/store/i4xrqfq4jrk2chv6iqm2rgxdk8biynlr-nixos-system-machine-tes=
t/kernel -initrd /nix/store/i06b3wvd4c83x8slnd1f85dj7msjy398-initrd-linux-6=
=2E12-rc3/initrd -append console=3DttyS0 console=3Dtty0 panic=3D1 boot.pani=
c_on_fail clocksource=3Dacpi_pm loglevel=3D7 net.ifnames=3D0 init=3D/nix/st=
ore/i4xrqfq4jrk2chv6iqm2rgxdk8biynlr-nixos-system-machine-test/init regInfo=
=3D/nix/store/5ygkzfld2zk20cy95iipmw2xxfvqalaz-closure-info/registration co=
nsole=3DttyS0  -qmp unix:/build/vm-state-machine/qmp,server=3Don,wait=3Doff=
 -monitor unix:/build/vm-state-machine/monitor -chardev socket,id=3Dshell,p=
ath=3D/build/vm-state-machine/shell -device virtio-serial -device virtconso=
le,chardev=3Dshell -device virtio-rng-pci -serial stdio -no-reboot -nograph=
ic

or inside a guest (running similar test an older kernel)

>>> print(alice.execute("mount | grep 9p")[1])
nix-store on /nix/.ro-store type 9p (rw,relatime,dirsync,loose,access=3Dcli=
ent,msize=3D16384,trans=3Dvirtio)
shared on /tmp/shared type 9p (rw,relatime,sync,dirsync,access=3Dclient,msi=
ze=3D16384,trans=3Dvirtio)
xchg on /tmp/xchg type 9p (rw,relatime,sync,dirsync,access=3Dclient,msize=
=3D16384,trans=3Dvirtio)

-antony

