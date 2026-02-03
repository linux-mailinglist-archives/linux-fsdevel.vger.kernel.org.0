Return-Path: <linux-fsdevel+bounces-76209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIrNLWQggmlIPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:20:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCBDBD4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 743EC3177E10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7B3C1998;
	Tue,  3 Feb 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q0RF4LZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB23C1961;
	Tue,  3 Feb 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135146; cv=none; b=mN5iXyC9FrBKWQfhvourYp9RwNOpNJ6Lk1nHIVMM+F7HFfePYHSwoogPxrJlPHOOoeQfnatjDy1ILpI7m4KqcNTBjAEyW5SGEQPmG1vE67SFRmotr0xN9n/m+tvaJirxVF+ZA91m79Rc5BeDCAYcG4Zld6OspFhs6H0CGxvQSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135146; c=relaxed/simple;
	bh=R0xn/ph76keQkirSk8vJn5LNC+ZuEE02jOlzNQ5lMcg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dvCtAEThV5m4f0CKevrBqEsmbnoemwocwB5RJd7f6V+eNh1oGgbUzSnrQrg89aYUIJ6/dLLVma0vwPt9NoBrCaOPThDssvTgaiy7S3fhxRli8YoE0VC6L8PdVY3yE8pcVyP1+792v0lBR+pD//u0ii6eiOdN2K2pTqF1tY2FWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Q0RF4LZp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 613GBxBI3465813
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 08:11:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 613GBxBI3465813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770135120;
	bh=QeXaSNMyaXFBNUH1ojI9c1CisP1DJE8s7Y+PWQeSj4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q0RF4LZpy0WWpQZismHHgtW2AS4pAAuH1tRF+Y83DQ+lckhgjT7bjjzRyWdGUobTn
	 zgjfkWwJ/Xh6GDgdTHIz5W2Dfz956qUjK9SKFlJsGIhkQfiNbFjd7DNb3ElpJSgws8
	 tQc9a19Y2i4ohjuFKvHizoKh43okVLH4ADfvtJYKSguODZUZJLU0dqrCIy3Sw9he+i
	 ZDI2vZtaPDpizoDk7Zavi3KdvS6c1QynF0ySWnKwDBfWeNJpR1ZPqPf3ZgG59c9t3j
	 7oHPsLpDg2byl+uJzmozezg1PAnYRSsu8ohuJsigQxvdwC81+S5/huWswk5RFLPg25
	 uF6ufRPydUZnQ==
Date: Tue, 03 Feb 2026 08:11:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Windl, Ulrich" <u.windl@ukr.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_=5Bsystemd-devel=5D?=
 =?US-ASCII?Q?_=5BPATCH_0/3=5D_Add_the_abil?=
 =?US-ASCII?Q?ity_to_mount_filesystems_during_initramfs_expansion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <51265a7170d7408a92192c5112c1e613@ukr.de>
References: <20260124003939.426931-1-hpa@zytor.com> <51265a7170d7408a92192c5112c1e613@ukr.de>
Message-ID: <7F889C39-4D60-4A12-9F60-D4F4B7B75474@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76209-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,poettering.net:email,linux.org.uk:email,lists.freedesktop.org:email,lwn.net:email,ukr.de:email]
X-Rspamd-Queue-Id: 16DCBDBD4C
X-Rspamd-Action: no action

On February 1, 2026 11:38:23 PM PST, "Windl, Ulrich" <u=2Ewindl@ukr=2Ede> w=
rote:
>Hi!
>
>I wonder: wouldn't it be nicer to use a subdirectory like "=2Esystemd-mag=
ic" to place such magic files there that are interpreted by systemd? Then "=
!!!MOUNT!!!" would become a simple "mount" or maybe "fstab" or "mountttab",=
 =2E=2E=2E
>
>Kind regards,
>Ulrich Windl
>
>> -----Original Message-----
>> From: systemd-devel <systemd-devel-bounces@lists=2Efreedesktop=2Eorg> O=
n
>> Behalf Of H=2E Peter Anvin
>> Sent: Saturday, January 24, 2026 1:40 AM
>> To: Alexander Viro <viro@zeniv=2Elinux=2Eorg=2Euk>; Christian Brauner
>> <brauner@kernel=2Eorg>; Jan Kara <jack@suse=2Ecz>; Jonathan Corbet
>> <corbet@lwn=2Enet>; H=2E Peter Anvin <hpa@zytor=2Ecom>
>> Cc: linux-fsdevel@vger=2Ekernel=2Eorg; linux-doc@vger=2Ekernel=2Eorg; l=
inux-
>> kernel@vger=2Ekernel=2Eorg; Lennart Poettering <lennart@poettering=2Ene=
t>;
>> systemd-devel@lists=2Efreedesktop=2Eorg
>> Subject: [EXT] [systemd-devel] [PATCH 0/3] Add the ability to mount
>> filesystems during initramfs expansion
>>=20
>>=20
>> At Plumber's 2024, Lennart Poettering of the systemd project requested
>> the ability to overmount the rootfs with a separate tmpfs before
>> initramfs expansion, so the populated tmpfs can be unmounted=2E
>>=20
>> This patchset takes this request and goes one step further: it allows
>> (mostly) arbitrary filesystems mounts during initramfs processing=2E
>>=20
>> This is done by having the initramfs expansion code detect the special
>> filename "!!!MOUNT!!!" which is then parsed into a simplified
>> fstab-type mount specification and the directory in which the
>> !!!MOUNT!!! entry is used as the mount point=2E
>>=20
>> This specific method was chosen for the following reasons:
>>=20
>> 1=2E This information is specific to the expectations of the initramfs;
>>    therefore using kernel command line options is not
>>    appropriate=2E This way the information is fully contained within th=
e
>>    initramfs itself=2E
>> 2=2E The sequence !!! is already special in cpio, due to the "TRAILER!!=
!"
>>    entries=2E
>> 3=2E The filename "!!!MOUNT!!!" will typically be sorted first, which
>>    means using standard find+cpio tools to create the initramfs still
>>    work=2E
>> 4=2E Similarly, standard cpio can still expand the initramfs=2E
>> 5=2E If run on a legacy kernel, the !!!MOUNT!!! file is created, which
>>    is easy to detect in the initramfs code which can then activate
>>    some fallback code=2E
>> 6=2E It allows for multiple filesystems to be mounted, possibly of
>>    different types and in different locations, e=2Eg=2E the initramfs c=
an
>>    get started with /dev, /proc, and /sys already booted=2E
>>=20
>> The patches are:
>>=20
>>     1/3: fs/init: move creating the mount data_page into init_mount()
>>     2/3: initramfs: support mounting filesystems during initramfs expan=
sion
>>     3/3: Documentation/initramfs: document mount points in initramfs
>>=20
>> ---
>>  =2E=2E=2E/driver-api/early-userspace/buffer-format=2Erst   | 60 ++++++=
+++++++-
>>  fs/init=2Ec                                          | 23 +++++-
>>  include/linux/init_syscalls=2Eh                      |  3 +-
>>  init/do_mounts=2Ec                                   | 17 +---
>>  init/initramfs=2Ec                                   | 95 ++++++++++++=
+++++++++-
>>  5 files changed, 175 insertions(+), 23 deletions(-)
>

The point is that this is done during initramfs deencapsulation=2E

Either way, it doesn't seem like there is interest=2E

