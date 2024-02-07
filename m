Return-Path: <linux-fsdevel+bounces-10540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2784C13A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89891F254B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058DD2F0;
	Wed,  7 Feb 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="Ic4QP5to"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C28F48
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264520; cv=none; b=Vnhk1OXVG0WfxvZU08NOj5dKsNdp8b5XKvFt7Vs4fjiyI+A/VxTyllieE7As0HrjrN9gxGKod4oCS7STBiyp0PSXRoMBxGtoB4fgAxGM9RfopFl+tgJboPlHIKKPlvkkU9E4rhabuFCl/IG6r145lbOL9VDd8RpSsaZ6mWH/Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264520; c=relaxed/simple;
	bh=XRG0RYGcjzEyEp6nbMLXUuNkUT+ih7GMb+Q/j2mhucc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5FpBkRO9Qp8evcyOUCCxmaVzC8TUMK/vGC7cD1wMh2nFWkeU64oPtCo3AY6XVAdiBOxgyI1+IgHLf0O07RMBwai9jo+1FxgaqsY5cILRbdDUFM8gB/Sxk0dPp+t3PgdH9GbvcKiM0M2NMr0MIV4h5FFj1JEifT8M2lr8zmzmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=Ic4QP5to; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1707264509; x=1707523709;
	bh=i3rnShWU8zEk2BMkn887UYfphHn0iynA1DfrITvhw60=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ic4QP5toqFZKKUkd9VGvzCCwPcLMVXQNT81bJjTB6DLQzTuw4fpJgYo41lMBdZwib
	 Khn88FqmmZyDL5kKNGfLlF71H/2QrDNs1K8rREKkK3CuFSh8WPRyNouAkubxdS/ee2
	 CEvWDVHYnLoOwJaqlGZMYtW5I3cTGlYhDTSb4hzuGei7+77eBbxQndtfwWZTUqdwmc
	 YmaiIh4LKKrxu1W76mqEiYgKnJGC5nKs2AG89kkFmY2SI8XXKmZfI/jSRizMVdf9sW
	 EzFSzHkPjnLFaeRaoUGjdBGONelPU2cTOpJIsnJp0/C/oHmr0CwQZE3HZxuMxqPxF7
	 jDUke3UeuE5bg==
Date: Wed, 07 Feb 2024 00:08:16 +0000
To: Amir Goldstein <amir73il@gmail.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: fuse-devel <fuse-devel@lists.sourceforge.net>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <764a49b0-9a82-4042-8e03-10219b152e77@spawn.link>
In-Reply-To: <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/24 00:53, Amir Goldstein wrote:
> On Tue, Feb 6, 2024 at 4:52=E2=80=AFAM Antonio SJ Musumeci <trapexit@spaw=
n.link> wrote:
>> Hi,
>>
>> Anyone have users exporting a FUSE filesystem over NFS? Particularly
>> from Proxmox (recent release, kernel 6.5.11)? I've gotten a number of
>> reports recently from individuals who have such a setup and after some
>> time (not easily reproducible, seems usually after software like Plex or
>> Jellyfin do a scan of media or a backup process) starts returning EIO
>> errors. Not just from NFS but also when trying to access the FUSE mount
>> as well. One person noted that they had moved from Ubuntu 18.04 (kernel
>> 4.15.0) to Proxmox and on Ubuntu had no problems with otherwise the same
>> settings.
>>
>> I've not yet been able to reproduced this issue myself but wanted to see
>> if anyone else has run into this. As far as I can tell from what users
>> have reported the FUSE server is still running but isn't receiving most
>> requests. I do see evidence of statfs calls coming through but nothing
>> else. Though the straces I've received typically are after the issues st=
art.
>>
>> In an effort to rule out the FUSE server... is there anything the server
>> could do to cause the kernel to return EIO and not forward anything but
>> statfs? Doesn't seem to matter if direct_io is enabled or attr/entry
>> caching is used.
>>
> This could be the outcome of commit 15db16837a35 ("fuse: fix illegal
> access to inode with reused nodeid") in kernel v5.14.
>
> It is not an unintended regression - this behavior replaces what would
> have been a potentially severe security violation with an EIO error.
>
> As the commit says:
> "...With current code, this situation will not be detected and an old fus=
e
>      dentry that used to point to an older generation real inode, can be =
used to
>      access a completely new inode, which should be accessed only via the=
 new
>      dentry."
>
> I have made this fix after seeing users get the content of another
> file from the one that they opened in NFS!
>
> libfuse commit 10ecd4f ("test/test_syscalls.c: check unlinked testfiles
> at the end of the test") reproduces this problem in a test.
> This test does not involve NFS export, but NFS export has higher
> likelihood of exposing this issue.
>
> I wonder if the FUSE filesystems that report the errors have
> FUSE_EXPORT_SUPPORT capability?
> Not that this capability guarantees anything wrt to this issue.
>
> IMO, the root of all evil wrt NFS+FUSE is that LOOKUP is by ino
> without generation with FUSE_EXPORT_SUPPORT, but worse
> is that FUSE does not even require FUSE_EXPORT_SUPPORT
> capability to export to NFS, but this is legacy FUSE behavior and
> I am sure that many people export FUSE filesystems, as your
> report proves.
>
> There is now a proposal for opt-out of NFS export:
> https://lore.kernel.org/linux-fsdevel/20240126072120.71867-1-jefflexu@lin=
ux.alibaba.com/
> so there will be a way for a FUSE filesystem to prevent misuse.
>
> Some practical suggestions for users running existing FUSE filesystems:
>
> - Never export a FUSE filesystem with a fixed fsid
> - Everytime one wants to export a FUSE filesystem generate
>    a oneshot fsid/uuid to use in exportfs
> - Then restarting/re-exporting the FUSE filesystem will result in
>    ESTALE errors on NFS client, but not security violations and not EIO
>    errors
> - This does not give full guarantee, unlinked inodes could still result
>    in EIO errors, as the libfuse test demonstrates
> - The situation with NFSv4 is slightly better than with NFSv3, because
>     with NFSv3, an open file in the client does not keep the FUSE file
>     open and increases the chance of evicted FUSE inode for an open
>     NFS file
>
> Thanks,
> Amir.

Thank you Amir for such a detailed response. I'll look into this further=20
but a few questions. To answer your question: yes, the server is setting=20
EXPORT_SUPPORT.

1. The expected behavior, if the above situation occurred, is that the=20
whole of the mount would return EIO? All requests going forward? What=20
about FUSE_STATFS? From what I saw that was coming through.

2. Regarding the tests. I downloaded the latest libfuse, compiled, and=20
ran test_syscalls against the FUSE server. I get no failures when=20
running `./test_syscalls /mnt/fusemount :/mnt/ext4mount -u` or=20
`./test_syscalls /mnt/fusemount -u` where ext4mount is the underlying=20
filesystem and fusemount is the FUSE server's. No error is reported. A=20
strace shows the fstat returning ESTALE at the end but the tests all=20
pass. The mount continues to work after running the test. This is on=20
kernel 6.5.0. Is that expected? It sounds from your description that I=20
should be seeing EIOs somewhere.

3. Thank you for the "practical suggestions". I will compare them to=20
what my users are doing... but are there specific guidelines somewhere=20
for building a FUSE server to ensure NFS export can be supported? This=20
topic has had limited details available over the years and I/users have=20
had odd behaviors at times that were unclear of the cause. Like this=20
situation or when NFS somehow triggered a request for '..' of the root=20
nodeid (1). Some questions that come to mind: is the generation strictly=20
necessary (practically) for things to work so long as nodeid is unique=20
during a session (64bit nodeid space can last a long time)? Is there=20
possibility of conflict if multiple fuse servers used the same=20
nodeid//gen pairs at the same time? To what degree does the inode value=20
matter? Should old node/gen pairs be kept around forever as noforget=20
libfuse option suggests for NFS? Perhaps some of this is obvious but=20
given changes to FUSE over time and the differences between kernel and=20
userspace fs experiences it would be nice to have some of these more=20
niche/complicated situations better flushed out in the official docs.

Thanks again.



