Return-Path: <linux-fsdevel+bounces-45947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB619A7FC0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB317AC5CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E2266B52;
	Tue,  8 Apr 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2DkVjpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC8266EE5;
	Tue,  8 Apr 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108168; cv=none; b=F++O3d1MwquTFMW4c+JFwQH9IDYFKoM/wF7SZstcf2zUIoszwDF5eT2CWVRpn1OqMoYKm+LTVUYx7zMpIK6y5vjZBKPibpnNb2htBRSvKeUlWSDidATuEg8n+CkWx4caBzcCQYx47XmfUuIFDPeFOMGfRHRCSyoad9fK3Blo8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108168; c=relaxed/simple;
	bh=edxylfQ2WiiwTwhhDLOhVgB9utDb9GDYQ5gc4aOpUlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnD82e0OY5IZIfEh+G5j3bsB6XVfUOifZUEb1lMRPHAcr6xNwEFBrRqgLwwFQROPHRB+rnRN4M79P/1KzDsfzVhXDhNOXqKgG3vyg1nugTH2Xcdx/VZon54pfBsQ1YS1U4ix/8BdTGSqRx9fC1g4N90dDlloKD5CpitOo0fnZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2DkVjpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDBC4CEE8;
	Tue,  8 Apr 2025 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744108167;
	bh=edxylfQ2WiiwTwhhDLOhVgB9utDb9GDYQ5gc4aOpUlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2DkVjpIXREkl9uM95E7Wh+5van1lz4rDd4L7/hcT+oSd+f6n5xt6mFctmr3V328V
	 JLE6kVuxK2nkiFWdbMLsU2OIABs/W1E65sPKLSb2Jy0LwX+kiURChKA3I/iPC7LfDK
	 3eaUtOwH4r8JCxy2Z432a1KdaVLBp2K64+nSq/9nO5hgrR4O5evBKXEjE+Sy2d6kAD
	 cpQ6nQRFsoNjUx1BKZOD0JFTsPvA1NF0O2zjv2k6sm47FUeAmfHeROjJxriVMRumpQ
	 rYL+7Vf12UZxwVLY4WxEvKYH8px9/2bTkDVft7T8VcR1+2Y3L5PUSvb7PUu272x3rq
	 O4ez5LxpcpgXg==
Date: Tue, 8 Apr 2025 12:29:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in file_end_write /
 posix_acl_update_mode
Message-ID: <20250408-stirn-wettkampf-1111f59d44e7@brauner>
References: <67f4e5e9.050a0220.396535.055c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67f4e5e9.050a0220.396535.055c.GAE@google.com>

On Tue, Apr 08, 2025 at 02:01:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c98070580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5bf3e2a48bfe768
> dashboard link: https://syzkaller.appspot.com/bug?extid=dbb3b5b8e91c5be8daad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d90ae40aa6df/disk-0af2f6be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/616ed7a70804/vmlinux-0af2f6be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed2c418afc9a/bzImage-0af2f6be.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dbb3b5b8e91c5be8daad@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in file_end_write / posix_acl_update_mode
> 
> write to 0xffff888118513aa0 of 2 bytes by task 16080 on cpu 1:
>  posix_acl_update_mode+0x220/0x250 fs/posix_acl.c:720
>  simple_set_acl+0x6c/0x120 fs/posix_acl.c:1022
>  set_posix_acl fs/posix_acl.c:954 [inline]
>  vfs_set_acl+0x581/0x720 fs/posix_acl.c:1133
>  do_set_acl+0xab/0x130 fs/posix_acl.c:1278
>  do_setxattr fs/xattr.c:633 [inline]
>  filename_setxattr+0x1f1/0x2b0 fs/xattr.c:665
>  path_setxattrat+0x28a/0x320 fs/xattr.c:713
>  __do_sys_setxattr fs/xattr.c:747 [inline]
>  __se_sys_setxattr fs/xattr.c:743 [inline]
>  __x64_sys_setxattr+0x6e/0x90 fs/xattr.c:743
>  x64_sys_call+0x28e7/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:189
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff888118513aa0 of 2 bytes by task 16073 on cpu 0:
>  file_end_write+0x1f/0x110 include/linux/fs.h:3059
>  vfs_fallocate+0x3a5/0x3b0 fs/open.c:350
>  ksys_fallocate fs/open.c:362 [inline]
>  __do_sys_fallocate fs/open.c:367 [inline]
>  __se_sys_fallocate fs/open.c:365 [inline]
>  __x64_sys_fallocate+0x78/0xc0 fs/open.c:365
>  x64_sys_call+0x295f/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:286
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x8000 -> 0x8072

This race is benign.
file_end_write() and similar helpers check whether this is a regular
file or not. And the type of a file can never change. The only thing
that can change here are the permission bits of course.

The only thing to worry about would be torn writes where somehow the
file type is written back after the permission bits and so S_ISREG()
could fail and the freeze protection semaphore wouldn't be released. If
that is an actual possibility we'd need to READ_ONCE()/WRITE_ONCE() the
hell out of this. Can this really happen with an unsigned short though?

