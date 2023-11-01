Return-Path: <linux-fsdevel+bounces-1727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFA67DE08E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB2D2818A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983111CA1;
	Wed,  1 Nov 2023 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Pnw3+9M2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3DY1HJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0E15B9
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 11:53:07 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AEFD;
	Wed,  1 Nov 2023 04:52:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C93063200922;
	Wed,  1 Nov 2023 07:52:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 Nov 2023 07:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698839577; x=1698925977; bh=UUCVuGrNRCpcYFlCbcFf5lEpE2lBBdg3YBm
	yL9tLv7w=; b=Pnw3+9M2zJBysq/HCrWzx++7ioXU9uVt9gLf1TTb65umX/Z6dOV
	SG17X48MblnRmVI41ZNT/JpWQAS0FKfHWv7Ewfq69XeVHp1o+20611cF9pTq+okA
	7TzsfvQrVFFnDos8SOAbchT6lomSWwCqAK+1kGYJMy9q09pv7pANZsMOlrJYK8LC
	8jQ5sG3489NO3cDvYOiA0Fy4g3b882mo2ByojssF5Wi5dyphDuf3v0YCDG/w3byo
	UBEs7pLgUky5Ax2brNploXC3yf9o5OiQYC2BwVLeqkTrzSljeafU4Row5iQ1RzoV
	LEo0PdpTLCYPfvr8mIVAhvoRiCaG2cd3X3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698839577; x=1698925977; bh=UUCVuGrNRCpcYFlCbcFf5lEpE2lBBdg3YBm
	yL9tLv7w=; b=j3DY1HJpugv1lnyf3YyQZd9LwANx1zrD0s9o9OWQwCl4UWNUJj1
	+Z/N7cmBYHwaHWi9qx5KaVq7j+Ob8BIssvpyvEO/IOykqgZxJq2EaWQZZD6Xa0jX
	vqFAX3a4Towiyd93qBkd8z0IlIrdjy/dguh1UFTKq0hJAGH+VWSGVMoYh2mvc+C0
	y53v+2VNjdz5zgYkM0yDMyJSEoRGGDC1T1+rzCxQo/I2WfCuHuJLg0p3UGCOvWlx
	HMUmHueKPRHL+/F1FMOV9l6ygDPirpokP6Wcz6y+wNNbh5oc2L+Gw+PrBMK8je8B
	hM/qslLy94j3DYrgyJ2UCEwi10ORO2EZb7g==
X-ME-Sender: <xms:GDxCZSVDRhakPUwHplcfCdn8-0e2PhOPLYDGGqox1mDlqlUG5pyG1g>
    <xme:GDxCZenwT-BwnaS8Ar2pKF-v-TqgPwUPw4iJT7wH_07WPtDfQoZlY9_7b7RWgVLVd
    W_wW6MP4xw5>
X-ME-Received: <xmr:GDxCZWZBp3A8Z_ICpzAdODM99RENy_x-LkA3DVeLkNod880-Cvb3sH0SOFSRaXRW0rTS4MAkcAHH-OEnPCB3vXlEy5Q_K-UuTZOZU2zIBPimlFFaH1fq6LLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epueegveehueejjedvgeeiheekueduhffgueejgfevgedujeeiieegteehkeehvdeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:GDxCZZXo4z5kNc6XnNyH4o0miOeP6iTv9TfcdFsdrY6G95Tjba3h5g>
    <xmx:GDxCZcmpn2Uh44xi6H5exAuw0b8VrQDA8N65yEXNZv85Rsw-xlkZ5g>
    <xmx:GDxCZed8uAsJ2BfDDbcucJRdj_HIrDNECoekeV7-TZeJ_ykg1Je_DA>
    <xmx:GTxCZX-EHKpQt_nr_DkCej8VOQIUrVVTbkN_8GL9Z2m4z-YblRG5Bg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 07:52:49 -0400 (EDT)
Message-ID: <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
Date: Wed, 1 Nov 2023 19:52:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/6] querying mount attributes
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/10/23 22:01, Miklos Szeredi wrote:
> Implement mount querying syscalls agreed on at LSF/MM 2023.
>
> Features:
>
>   - statx-like want/got mask
>   - allows returning ascii strings (fs type, root, mount point)
>   - returned buffer is relocatable (no pointers)
>
> Still missing:
>   - man pages
>   - kselftest
>
> Please find the test utility at the end of this mail.
>
>    Usage: statmnt [-l|-r] [-u] (mnt_id|path)
>
> Git tree:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#statmount-v4
>
>
> Changes v3..v4:
>
>   - incorporate patch moving list of mounts to an rbtree
>   - wire up syscalls for all archs
>   - add LISTMOUNT_RECURSIVE (depth first iteration of mount tree)
>   - add LSMT_ROOT (list root instead of a specific mount ID)
>   - list_for_each_entry_del() moved to a separate patchset
>
> Changes v1..v3:
>
>   - rename statmnt(2) -> statmount(2)
>   - rename listmnt(2) -> listmount(2)
>   - make ABI 32bit compatible by passing 64bit args in a struct (tested on
>     i386 and x32)
>   - only accept new 64bit mount IDs
>   - fix compile on !CONFIG_PROC_FS
>   - call security_sb_statfs() in both syscalls
>   - make lookup_mnt_in_ns() static
>   - add LISTMOUNT_UNREACHABLE flag to listmnt() to explicitly ask for
>     listing unreachable mounts
>   - remove .sb_opts
>   - remove subtype from .fs_type
>   - return the number of bytes used (including strings) in .size
>   - rename .mountpoint -> .mnt_point
>   - point strings by an offset against char[] VLA at the end of the struct.
>     E.g. printf("fs_type: %s\n", st->str + st->fs_type);
>   - don't save string lengths
>   - extend spare space in struct statmnt (complete size is now 512 bytes)
>
>
> Miklos Szeredi (6):
>    add unique mount ID
>    mounts: keep list of mounts in an rbtree
>    namespace: extract show_path() helper
>    add statmount(2) syscall
>    add listmount(2) syscall
>    wire up syscalls for statmount/listmount
>
>   arch/alpha/kernel/syscalls/syscall.tbl      |   3 +
>   arch/arm/tools/syscall.tbl                  |   3 +
>   arch/arm64/include/asm/unistd32.h           |   4 +
>   arch/ia64/kernel/syscalls/syscall.tbl       |   3 +
>   arch/m68k/kernel/syscalls/syscall.tbl       |   3 +
>   arch/microblaze/kernel/syscalls/syscall.tbl |   3 +
>   arch/mips/kernel/syscalls/syscall_n32.tbl   |   3 +
>   arch/mips/kernel/syscalls/syscall_n64.tbl   |   3 +
>   arch/mips/kernel/syscalls/syscall_o32.tbl   |   3 +
>   arch/parisc/kernel/syscalls/syscall.tbl     |   3 +
>   arch/powerpc/kernel/syscalls/syscall.tbl    |   3 +
>   arch/s390/kernel/syscalls/syscall.tbl       |   3 +
>   arch/sh/kernel/syscalls/syscall.tbl         |   3 +
>   arch/sparc/kernel/syscalls/syscall.tbl      |   3 +
>   arch/x86/entry/syscalls/syscall_32.tbl      |   3 +
>   arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>   arch/xtensa/kernel/syscalls/syscall.tbl     |   3 +
>   fs/internal.h                               |   2 +
>   fs/mount.h                                  |  27 +-
>   fs/namespace.c                              | 573 ++++++++++++++++----
>   fs/pnode.c                                  |   2 +-
>   fs/proc_namespace.c                         |  13 +-
>   fs/stat.c                                   |   9 +-
>   include/linux/mount.h                       |   5 +-
>   include/linux/syscalls.h                    |   8 +
>   include/uapi/asm-generic/unistd.h           |   8 +-
>   include/uapi/linux/mount.h                  |  65 +++
>   include/uapi/linux/stat.h                   |   1 +
>   28 files changed, 635 insertions(+), 129 deletions(-)

Looks ok to me,covers the primary cases I needed when I worked

on using fsinfo() in systemd.


Karel, is there anything missing you would need for adding

libmount support?


Reviewed-by: Ian Kent <raven@themaw.net>


>

