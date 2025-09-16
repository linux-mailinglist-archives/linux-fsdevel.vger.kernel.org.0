Return-Path: <linux-fsdevel+bounces-61855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB46B7EB4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9211B24A42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8E2D373F;
	Tue, 16 Sep 2025 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="O3CQsZx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYutQu8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568D36D;
	Tue, 16 Sep 2025 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067169; cv=none; b=SEQZZxFT80BYBrrruSRkpvBW06oCyiVXocECZxM1/QAXC3p13MubcANdIKgND6soFfLypaNR7KV4UZbS8R92lMhoisOiBLEE3AUhDkFKNAwUyVKVI/XmaqlxETOvww9xtH/xoOrtTqrbV8Ub+cM04pEHWguf7Ma18J4qVhsQkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067169; c=relaxed/simple;
	bh=+8zaMMV3T6EoZfOA8D69GwX/UBqPE2EJSXGicAyH978=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHDDtPdRHPdCAyHG36Pk0i6Um/b7x8BSz2+W+abTIuojL9jmL3yrPenXwP1TrqINO4EhMBeJDVUvxQCXYxSQq/PN/BGOKihZy6q1tD/VUS4BXKqaIcF24nGEsKio5vVUvjNPrKJpF/7GFM1g3IHgEj9+iJoHZCYXA80SL+quiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=O3CQsZx4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYutQu8g; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D44141D002F8;
	Tue, 16 Sep 2025 19:59:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 19:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758067165;
	 x=1758153565; bh=DeqvTAVJZs8kmAzF9JBr74N4gch5my6l5YGk030/rVI=; b=
	O3CQsZx4iLdcse1WZipL4T0mlZSYKoUfusrGGFLRr3jm60tr7KalZDsE6SLcs+b1
	zj3oYLGDbHT5p3kycuyK+sTGImLGZC9nXvN9c//ouaTgkqks6oxLQV9yRmZn8+U3
	T32eVM7ZBkSjfwA7/wmSqQMYYKTqpEt0bSUq7GVthY7PBwtvZEqOCtWski///lZJ
	wSmVus7r82sKINMmaGt5y1p2CxtnkwwptbR74xeEtwErjdRTlyyy7bxgbFRyi9h9
	JyFIEHNpHA94h/olJ7veD6eq/ZkOmD81DRDE/cKjdpEFo0iry0MFfhKUHUWWwH1Q
	fMQJ0kAol+LVzGDXnDqemw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758067165; x=
	1758153565; bh=DeqvTAVJZs8kmAzF9JBr74N4gch5my6l5YGk030/rVI=; b=P
	YutQu8gSnWPNhvoTqEd33YM3h+VsDX61rcor1lAE9A78jlRkKFSQcbWF20djkV2d
	1zFsQRfne551LOs0hpca9tEDH/JeYDsw8NUeWJu4VU0wp3jVhzT/nRZL3RQfGBCQ
	ajLx6jEzJzzSgZW9+qOQKdxxhzT4T82Pj1FhH8BC3LO2ndBrFBOxQDx4viYSUVHp
	iomn82PPel9DUvB6zr1g4Boo6q6r1p02a9mwDinU4Us4AsCmP6CrKHvVwPvl0ArI
	D6Ng+wYRb+1C4aACgTGrnJn5SGTXrSm3QdwYbmJ4mkiP0HoC0bFoQaIUVYcc0dio
	xFFy8UkvOcTK2cDUCMQkA==
X-ME-Sender: <xms:3PnJaHlntwyOjtKGLfbZCOMqJL3-hzW5AShkKUbVWvGOFqwlErxuvg>
    <xme:3PnJaGpkYC9S5VIhma125yIzgQRx5azK6Nu1EfEnoTm3PwxrQSbFZShZm3VgbeqUK
    puYVvy9GCw8yJSaIaU>
X-ME-Received: <xmr:3PnJaEEhYV9ZBRlTgueJ1uVfE_uO63exoe3pEnfGGVsj19aaIPgatcxIe4sH8Rn17HXBu0z4s3Q_NDre2d86oo8y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtoheprg
    hsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepmhhitgesughi
    ghhikhhougdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhs
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:3PnJaMSTUnrICQq9MwrkSqycj8p39QHYUL7ZJvGw5IEa6cJ9Efdxow>
    <xmx:3PnJaKN1RapJMK3ggba5I5J9ZywOIHNrPnJsde592chGinxRST15GA>
    <xmx:3PnJaJn4ahR9g5SFlOZj13KtF981dBfFVLsB0INTcFpWx0t5gNa9yg>
    <xmx:3PnJaMYeg_6bX9IXbRWOw_Ezcl5fAx3tk_4C3WQ_bqdXVtkmIy6h5w>
    <xmx:3fnJaKffWnkb60wQqVwLjeeGBLVm8ojc-e0hWfae1Iwhj8EAeGo2QMFQ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 19:59:23 -0400 (EDT)
Message-ID: <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org>
Date: Wed, 17 Sep 2025 00:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Christian Schoenebeck <linux_oss@crudebyte.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <aMih5XYYrpP559de@codewreck.org> <aMlnpz7TrbXuL0mc@codewreck.org>
 <a98c14f5-4b28-4f7b-86a2-94e3d66bbf26@maowtm.org> <3070012.VW4agfvzBM@silver>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <3070012.VW4agfvzBM@silver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 20:22, Christian Schoenebeck wrote:
> On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
>> On 9/16/25 14:35, Dominique Martinet wrote:
>>> Tingmao Wang wrote on Tue, Sep 16, 2025 at 01:44:27PM +0100:
>>>> [...]
>>>>
>>>> Note that in discussion with Mickaël (maintainer of Landlock) he
>>>> indicated
>>>> that he would be comfortable for Landlock to track a qid, instead of
>>>> holding a inode, specifically for 9pfs.
>>>
>>> Yes, I saw that, but what you pointed out about qid reuse make me
>>> somewhat uncomfortable with that direction -- you could allow a
>>> directory, delete it, create a new one somewhere else and if the
>>> underlying fs reuse the same inode number the rule would allow an
>>> intended directory instead so I'd rather not rely on qid for this
>>> either.
>>> But if you think that's not a problem in practice (because e.g. landlock
>>> would somehow detect the dir got deleted or another good reason it's not
>>> a problem) then I agree it's probably the simplest way forward
>>> implementation-wise.
>>
>> Sorry, I forgot to add that this idea would also involve Landlock holding
>> a reference to the fid (or dentry, but that's problematic due to breaking
>> unmount unless we can have a new hook) to keep the file open on the host
>> side so that the qid won't be reused (ignoring collisions caused by
>> different filesystems mounted under one 9pfs export when multidev mapping
>> is not enabled)
> 
> I see that you are proposing an option for your proposed qid based re-using of 
> dentries. I don't think it should be on by default though, considering what we 
> already discussed (e.g. inodes recycled by ext4, but also not all 9p servers 
> handling inode collisions).

Just to be clear, this approach (Landlock holding a fid reference, then
using the qid as a key to search for rules when a Landlocked process
accesses the previously remembered file, possibly after the file has been
moved on the server) would only be in Landlock, and would only affect
Landlock, not 9pfs (so not sure what you meant by "re-using of dentries").

The idea behind holding a fid reference within Landlock is that, because
we have the file open, the inode would not get recycled in ext4, and thus
no other file will reuse the qid, until we close that reference (when the
Landlock domain terminates, or when the 9p filesystem is unmounted)

> 
>> (There's the separate issue of QEMU not seemingly keeping a directory open
>> on the host when the guest has a fid to it tho.  I checked that if the dir
>> is renamed on the host side, any process in the guest that has a fd to it
>> (checked via cd in a shell) will not be able to use that fd to read it
>> anymore.  This also means that another directory might be created with the
>> same qid.path)
> 
> For all open FIDs QEMU retains a descriptor to the file/directory.
> 
> Which 9p message do you see sent to server, Trename or Trenameat?
> 
> Does this always happen to you or just sometimes, i.e. under heavy load? 

Always happen, see log: (no Trename since the rename is done on the host)

    qemu flags: -virtfs "local,path=/tmp/test,mount_tag=test,security_model=passthrough,readonly=off,multidevs=remap"
    qemu version: QEMU emulator version 10.1.0 (Debian 1:10.1.0+ds-5)
    guest kernel version: 6.17.0-rc5 (for the avoidance of doubt, this is clean 6.17-rc5 with no patches)
    qemu pid: 511476

    root@host # ls -la /proc/511476/fd | grep test
    lr-x------ 1 root root 64 Sep 17 00:35 41 -> /tmp/test

    root@guest # mount --mkdir -t 9p -o trans=virtio,cache=none,inodeident=qid,debug=13 test /tmp/test
    root@guest # mkdir /tmp/test/dir1
    root@guest # cd /tmp/test/dir1
     9pnet: -- v9fs_vfs_getattr_dotl (183): dentry: ffff888102ed4d38
     9pnet: -- v9fs_fid_find (183):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000183) >>> TGETATTR fid 1, request_mask 16383
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=160 type: 25 tag: 0
     9pnet: (00000183) <<< RGETATTR st_result_mask=6143
     <<< qid=80.3.68c9c8a3
     <<< st_mode=000043ff st_nlink=3
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=3c st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758065706 st_atime_nsec=857221735
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758065827 st_ctime_nsec=745359877
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_vfs_lookup (183): dir: ffff8881090e0000 dentry: (dir1) ffff888102e458f8 flags: 1
     9pnet: -- v9fs_fid_find (183):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000183) >>> TWALK fids 1,2 nwname 1d wname[0] dir1
     9pnet: (00000183) >>> size=23 type: 110 tag: 0
     9pnet: (00000183) <<< size=22 type: 111 tag: 0
     9pnet: (00000183) <<< RWALK nwqid 1:
     9pnet: (00000183) <<<     [0] 80.5.68c9dca3
     9pnet: (00000183) >>> TGETATTR fid 2, request_mask 6143
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=160 type: 25 tag: 0
     9pnet: (00000183) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758065827 st_atime_nsec=745359877
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758065827 st_ctime_nsec=749830521
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_vfs_getattr_dotl (183): dentry: ffff888102e458f8
     9pnet: -- v9fs_fid_find (183):  dentry: dir1 (ffff888102e458f8) uid 0 any 0
     9pnet: (00000183) >>> TGETATTR fid 2, request_mask 16383
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=160 type: 25 tag: 0
     9pnet: (00000183) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758065827 st_atime_nsec=745359877
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758065827 st_ctime_nsec=749830521
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_dentry_release (183):  dentry: dir1 (ffff888102e458f8)
     9pnet: (00000183) >>> TCLUNK fid 2 (try 0)
     9pnet: (00000183) >>> size=11 type: 120 tag: 0
     9pnet: (00000183) <<< size=7 type: 121 tag: 0
     9pnet: (00000183) <<< RCLUNK fid 2
     9pnet: -- v9fs_vfs_lookup (183): dir: ffff8881090e0000 dentry: (dir1) ffff888102e45a70 flags: 3
     9pnet: -- v9fs_fid_find (183):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000183) >>> TWALK fids 1,2 nwname 1d wname[0] dir1
     9pnet: (00000183) >>> size=23 type: 110 tag: 0
     9pnet: (00000183) <<< size=22 type: 111 tag: 0
     9pnet: (00000183) <<< RWALK nwqid 1:
     9pnet: (00000183) <<<     [0] 80.5.68c9dca3
     9pnet: (00000183) >>> TGETATTR fid 2, request_mask 6143
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=160 type: 25 tag: 0
     9pnet: (00000183) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758065827 st_atime_nsec=745359877
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758065827 st_ctime_nsec=749830521
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0

     (fid 2 is now a persistent handle pointing to /dir1, not sure why the
     walk was done twice)

    root@host # ls -la /proc/511476/fd | grep test
    lr-x------ 1 root root 64 Sep 17 00:35 41 -> /tmp/test
    (no fd points to dir1)

    root@host # mv -v /tmp/test/dir1 /tmp/test/dir2
    renamed '/tmp/test/dir1' -> '/tmp/test/dir2'

    root@guest:/tmp/test/dir1# ls
     9pnet: -- v9fs_vfs_getattr_dotl (183): dentry: ffff888102e45a70
     9pnet: -- v9fs_fid_find (183):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000183) >>> TGETATTR fid 2, request_mask 16383
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=11 type: 7 tag: 0
     9pnet: (00000183) <<< RLERROR (-2)
     9pnet: -- v9fs_file_open (188): inode: ffff888102e80640 file: ffff88810af45340
     9pnet: -- v9fs_fid_find (188):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000188) >>> TWALK fids 2,3 nwname 0d wname[0] (null)
     9pnet: (00000188) >>> size=17 type: 110 tag: 0
     9pnet: (00000188) <<< size=11 type: 7 tag: 0
     9pnet: (00000188) <<< RLERROR (-2)
    ls: cannot open directory '.': No such file or directory

It looks like as soon as the directory was moved on the host, TGETATTR on
the guest-opened fid 2 fails, even though I would expect that if QEMU
opens a fd to the dir and use that fd whenever fid 2 is used, that
TGETATTR should succeed.  The fact that I can't see anything pointing to
dir1 in /proc/511476/fd was also suspicious.

Also, if I remove the dir on the host, then repoen it in the guest, ls
starts working again:

    root@host # mv -v /tmp/test/dir2 /tmp/test/dir1
    renamed '/tmp/test/dir2' -> '/tmp/test/dir1'

    root@guest:/tmp/test/dir1# ls
     9pnet: -- v9fs_file_open (189): inode: ffff888102e80640 file: ffff88810af47100
     9pnet: -- v9fs_fid_find (189):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000189) >>> TWALK fids 2,3 nwname 0d wname[0] (null)
     9pnet: (00000189) >>> size=17 type: 110 tag: 0
     9pnet: (00000189) <<< size=9 type: 111 tag: 0
     9pnet: (00000189) <<< RWALK nwqid 0:
     9pnet: (00000189) >>> TLOPEN fid 3 mode 100352
     9pnet: (00000189) >>> size=15 type: 12 tag: 0
     9pnet: (00000189) <<< size=24 type: 13 tag: 0
     9pnet: (00000189) <<< RLOPEN qid 80.5.68c9dca3 iounit 0
     9pnet: -- v9fs_vfs_getattr_dotl (189): dentry: ffff888102e45a70
     9pnet: -- v9fs_fid_find (189):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000189) >>> TGETATTR fid 2, request_mask 16383
     9pnet: (00000189) >>> size=19 type: 24 tag: 0
     9pnet: (00000189) <<< size=160 type: 25 tag: 0
     9pnet: (00000189) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758065827 st_atime_nsec=745359877
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758066075 st_ctime_nsec=497687251
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_dir_readdir_dotl (189): name dir1
     9pnet: (00000189) >>> TREADDIR fid 3 offset 0 count 131072
     9pnet: (00000189) >>> size=23 type: 40 tag: 0
     9pnet: (00000189) <<< size=62 type: 41 tag: 0
     9pnet: (00000189) <<< RREADDIR count 51
     9pnet: (00000189) >>> TREADDIR fid 3 offset 2147483647 count 131072
     9pnet: (00000189) >>> size=23 type: 40 tag: 0
     9pnet: (00000189) <<< size=11 type: 41 tag: 0
     9pnet: (00000189) <<< RREADDIR count 0
     9pnet: -- v9fs_dir_readdir_dotl (189): name dir1
     9pnet: (00000189) >>> TREADDIR fid 3 offset 2147483647 count 131072
     9pnet: (00000189) >>> size=23 type: 40 tag: 0
     9pnet: (00000189) <<< size=11 type: 41 tag: 0
     9pnet: (00000189) <<< RREADDIR count 0
     9pnet: -- v9fs_dir_release (189): inode: ffff888102e80640 filp: ffff88810af47100 fid: 3
     9pnet: (00000189) >>> TCLUNK fid 3 (try 0)
     9pnet: (00000189) >>> size=11 type: 120 tag: 0
     9pnet: (00000189) <<< size=7 type: 121 tag
    root@guest:/tmp/test/dir1# echo $?
    0

Somehow if I rename in the guest, it all works, even though it's using the
same fid 2 (and it didn't ask QEMU to walk the new path)

    root@guest:/tmp/test/dir1# mv /tmp/test/dir1 /tmp/test/dir2
     9pnet: -- v9fs_vfs_getattr_dotl (183): dentry: ffff888102e45a70
     9pnet: -- v9fs_fid_find (183):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000183) >>> TGETATTR fid 2, request_mask 16383
     9pnet: (00000183) >>> size=19 type: 24 tag: 0
     9pnet: (00000183) <<< size=160 type: 25 tag: 0
     9pnet: (00000183) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758066561 st_atime_nsec=442431580
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758066559 st_ctime_nsec=570428555
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_vfs_lookup (194): dir: ffff8881090e0000 dentry: (dir2) ffff888102edca48 flags: e0000
     9pnet: -- v9fs_fid_find (194):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000194) >>> TWALK fids 1,3 nwname 1d wname[0] dir2
     9pnet: (00000194) >>> size=23 type: 110 tag: 0
     9pnet: (00000194) <<< size=11 type: 7 tag: 0
     9pnet: (00000194) <<< RLERROR (-2)
     9pnet: -- v9fs_dentry_release (194):  dentry: dir2 (ffff888102edca48)
     9pnet: -- v9fs_vfs_lookup (194): dir: ffff8881090e0000 dentry: (dir2) ffff888102edcbc0 flags: 0
     9pnet: -- v9fs_fid_find (194):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000194) >>> TWALK fids 1,3 nwname 1d wname[0] dir2
     9pnet: (00000194) >>> size=23 type: 110 tag: 0
     9pnet: (00000194) <<< size=11 type: 7 tag: 0
     9pnet: (00000194) <<< RLERROR (-2)
     9pnet: -- v9fs_dentry_release (194):  dentry: dir2 (ffff888102edcbc0)
     9pnet: -- v9fs_vfs_lookup (194): dir: ffff8881090e0000 dentry: (dir2) ffff888102edcd38 flags: a0000
     9pnet: -- v9fs_fid_find (194):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000194) >>> TWALK fids 1,3 nwname 1d wname[0] dir2
     9pnet: (00000194) >>> size=23 type: 110 tag: 0
     9pnet: (00000194) <<< size=11 type: 7 tag: 0
     9pnet: (00000194) <<< RLERROR (-2)
     9pnet: -- v9fs_vfs_rename (194): 
     9pnet: -- v9fs_fid_find (194):  dentry: dir1 (ffff888102e45a70) uid 0 any 0
     9pnet: -- v9fs_fid_find (194):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000194) >>> TWALK fids 1,3 nwname 0d wname[0] (null)
     9pnet: (00000194) >>> size=17 type: 110 tag: 0
     9pnet: (00000194) <<< size=9 type: 111 tag: 0
     9pnet: (00000194) <<< RWALK nwqid 0:
     9pnet: -- v9fs_fid_find (194):  dentry: / (ffff888102ed4d38) uid 0 any 0
     9pnet: (00000194) >>> TWALK fids 1,4 nwname 0d wname[0] (null)
     9pnet: (00000194) >>> size=17 type: 110 tag: 0
     9pnet: (00000194) <<< size=9 type: 111 tag: 0
     9pnet: (00000194) <<< RWALK nwqid 0:
     9pnet: (00000194) >>> TRENAMEAT olddirfid 3 old name dir1 newdirfid 4 new name dir2
     9pnet: (00000194) >>> size=27 type: 74 tag: 0
     9pnet: (00000194) <<< size=7 type: 75 tag: 0
     9pnet: (00000194) <<< RRENAMEAT newdirfid 4 new name dir2
     9pnet: (00000194) >>> TCLUNK fid 4 (try 0)
     9pnet: (00000194) >>> size=11 type: 120 tag: 0
     9pnet: (00000194) <<< size=7 type: 121 tag: 0
     9pnet: (00000194) <<< RCLUNK fid 4
     9pnet: (00000194) >>> TCLUNK fid 3 (try 0)
     9pnet: (00000194) >>> size=11 type: 120 tag: 0
     9pnet: (00000194) <<< size=7 type: 121 tag: 0
     9pnet: (00000194) <<< RCLUNK fid 3
     9pnet: -- v9fs_dentry_release (194):  dentry: dir2 (ffff888102edcd38)
    root@guest:/tmp/test/dir1# ls
     9pnet: -- v9fs_file_open (195): inode: ffff888102e80640 file: ffff88810b2b1500
     9pnet: -- v9fs_fid_find (195):  dentry: dir2 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000195) >>> TWALK fids 2,3 nwname 0d wname[0] (null)
     9pnet: (00000195) >>> size=17 type: 110 tag: 0
     9pnet: (00000195) <<< size=9 type: 111 tag: 0
     9pnet: (00000195) <<< RWALK nwqid 0:
     9pnet: (00000195) >>> TLOPEN fid 3 mode 100352
     9pnet: (00000195) >>> size=15 type: 12 tag: 0
     9pnet: (00000195) <<< size=24 type: 13 tag: 0
     9pnet: (00000195) <<< RLOPEN qid 80.5.68c9dca3 iounit 0
     9pnet: -- v9fs_vfs_getattr_dotl (195): dentry: ffff888102e45a70
     9pnet: -- v9fs_fid_find (195):  dentry: dir2 (ffff888102e45a70) uid 0 any 0
     9pnet: (00000195) >>> TGETATTR fid 2, request_mask 16383
     9pnet: (00000195) >>> size=19 type: 24 tag: 0
     9pnet: (00000195) <<< size=160 type: 25 tag: 0
     9pnet: (00000195) <<< RGETATTR st_result_mask=6143
     <<< qid=80.5.68c9dca3
     <<< st_mode=000041ed st_nlink=2
     <<< st_uid=0 st_gid=0
     <<< st_rdev=0 st_size=28 st_blksize=131072 st_blocks=0
     <<< st_atime_sec=1758066561 st_atime_nsec=442431580
     <<< st_mtime_sec=1758065827 st_mtime_nsec=745359877
     <<< st_ctime_sec=1758066568 st_ctime_nsec=562443096
     <<< st_btime_sec=0 st_btime_nsec=0
     <<< st_gen=0 st_data_version=0
     9pnet: -- v9fs_dir_readdir_dotl (195): name dir2
     9pnet: (00000195) >>> TREADDIR fid 3 offset 0 count 131072
     9pnet: (00000195) >>> size=23 type: 40 tag: 0
     9pnet: (00000195) <<< size=62 type: 41 tag: 0
     9pnet: (00000195) <<< RREADDIR count 51
     9pnet: (00000195) >>> TREADDIR fid 3 offset 2147483647 count 131072
     9pnet: (00000195) >>> size=23 type: 40 tag: 0
     9pnet: (00000195) <<< size=11 type: 41 tag: 0
     9pnet: (00000195) <<< RREADDIR count 0
     9pnet: -- v9fs_dir_readdir_dotl (195): name dir2
     9pnet: (00000195) >>> TREADDIR fid 3 offset 2147483647 count 131072
     9pnet: (00000195) >>> size=23 type: 40 tag: 0
     9pnet: (00000195) <<< size=11 type: 41 tag: 0
     9pnet: (00000195) <<< RREADDIR count 0
     9pnet: -- v9fs_dir_release (195): inode: ffff888102e80640 filp: ffff88810b2b1500 fid: 3
     9pnet: (00000195) >>> TCLUNK fid 3 (try 0)
     9pnet: (00000195) >>> size=11 type: 120 tag: 0
     9pnet: (00000195) <<< size=7 type: 121 tag: 0
     9pnet: (00000195) <<< RCLUNK fid 3

If this is surprising, I'm happy to take a deeper look over the weekend
(but I've never tried to debug QEMU itself :D)

> Because even though QEMU retains descriptors of open FIDs; when the QEMU 
> process approaches host system's max. allowed number of open file descriptors 
> then v9fs_reclaim_fd() [hw/9pfs/9p.c] is called, which closes some descriptors 
> of older FIDs to (at least) keep the QEMU process alive.
> 
> BTW: to prevent these descriptor reclaims to happen too often, I plan to do 
> what many other files servers do: asking the host system on process start to 
> increase the max. number of file descriptors.

Note that the above is reproduced with only 1 file open (the dir being
renamed around)

Kind regards,
Tingmao

> 
> /Christian
> 
> 

