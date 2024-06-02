Return-Path: <linux-fsdevel+bounces-20717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC268D72F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4029281B50
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374715A5;
	Sun,  2 Jun 2024 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky5N6YQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025081F;
	Sun,  2 Jun 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717290968; cv=none; b=XwB6O0Rt9Bn14B1UWEzP772wSTS13jHzdnCy7bvppDCBBMgEV2GbPQmm8jEdvNJHV6muDGRqsLs8nmF7nNkXDSK/CChrGtzRAslSWFSoZaLqpF8x10H2ve6WCdv2LsNPjTFohpvbeg0R9OlIhEbEEaW3J57pv7lq6o1YY/CpiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717290968; c=relaxed/simple;
	bh=+h2UMEJhEKKnxycke6Zrz08AQfPxUqiOwrVkGwExSSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lANi+aTSFwpQl1sSHgBVRg1lTPl2Tb/b1KVOsYOddkfREvFxDpFpCgH3VC9zSqkZV3P/rhq0cP0GA7feLH6t0gzaA61WzCtY4icy7pa7KKXxxdwc3br2iLKl32kGrHRMt9oauX3creJOg1ItsczicFb6WxUEgXhQAM9scBHI3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky5N6YQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7A3C116B1;
	Sun,  2 Jun 2024 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717290968;
	bh=+h2UMEJhEKKnxycke6Zrz08AQfPxUqiOwrVkGwExSSg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ky5N6YQuwr+kShdprTUsb0ntQSMVCe7oiu8C3LzVHbDeKVg1eEeq4ATx5PU0h4Pmd
	 o8XGPijvZblZfBJ96kdoaBj1g3sAtZUfrpE4BGhpLPr37Qd2CBrqKgd+ILSLuPUKig
	 IPENxX4N2vX1cfOibs+3LhsCJNOFl2l6PbUXH2CjxuF2gEsL9QxipwSDNC8S8uQ/YC
	 fxTBaWTkak7YGFExYp1FZASr47DA0STmWYEPHX0ppA4RZmxlYB1cbMk69JKZ/iQOsy
	 UsyNT1APwFTb0Sgt3+v5+b3jFNSrSQSa4p8M7HTWz29Ey5dV+ifvpfIUhHzRXdIJAj
	 fYKFFFAdSTjJw==
Message-ID: <d586a439-4f58-4409-8a60-6a00614ec346@kernel.org>
Date: Sun, 2 Jun 2024 09:16:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
To: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000d0d5e20619d2b486@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <000000000000d0d5e20619d2b486@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip

On 2024/6/1 19:50, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0e1980c40b6e Add linux-next specific files for 20240531
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=146c33d6980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
> dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a9aabc980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d86426980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/44fb1d8b5978/disk-0e1980c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a66ce5caf0b2/vmlinux-0e1980c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8992fc8fe046/bzImage-0e1980c4.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/72a0fa392581/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
> 
> F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inline.c:258!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5090 Comm: syz-executor430 Not tainted 6.10.0-rc1-next-20240531-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
> Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 ff a4 09 fe e9 d6 fc ff ff e8 25 22 9a 07 e8 a0 b7 a3 fd 90 <0f> 0b e8 98 b7 a3 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000343eb00 EFLAGS: 00010293
> RAX: ffffffff83f2c450 RBX: 0000000000000001 RCX: ffff88807f750000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc9000343ec30 R08: ffffffff83f2bf15 R09: 1ffff1100f0ed1ad
> R10: dffffc0000000000 R11: ffffed100f0ed1ae R12: ffffc9000343eb88
> R13: 1ffff1100f0ed1ad R14: ffffc9000343eb80 R15: ffffc9000343eb90
> FS:  000055557674e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002000 CR3: 000000001fb2e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2858
>   f2fs_write_cache_pages fs/f2fs/data.c:3157 [inline]
>   __f2fs_write_data_pages fs/f2fs/data.c:3312 [inline]
>   f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3339
>   do_writepages+0x35d/0x870 mm/page-writeback.c:2657
>   filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
>   __filemap_fdatawrite_range mm/filemap.c:430 [inline]
>   file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
>   f2fs_do_sync_file+0x68a/0x1b10 fs/f2fs/file.c:276
>   generic_write_sync include/linux/fs.h:2810 [inline]
>   f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4935
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xa72/0xc90 fs/read_write.c:590
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd453a5f779
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc94e03488 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffc94e03658 RCX: 00007fd453a5f779
> RDX: 0000000000002000 RSI: 0000000020000040 RDI: 0000000000000006
> RBP: 00007fd453ad8610 R08: 00007ffc94e03658 R09: 00007ffc94e03658
> R10: 00007ffc94e03658 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc94e03648 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
> Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 ff a4 09 fe e9 d6 fc ff ff e8 25 22 9a 07 e8 a0 b7 a3 fd 90 <0f> 0b e8 98 b7 a3 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000343eb00 EFLAGS: 00010293
> RAX: ffffffff83f2c450 RBX: 0000000000000001 RCX: ffff88807f750000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc9000343ec30 R08: ffffffff83f2bf15 R09: 1ffff1100f0ed1ad
> R10: dffffc0000000000 R11: ffffed100f0ed1ae R12: ffffc9000343eb88
> R13: 1ffff1100f0ed1ad R14: ffffc9000343eb80 R15: ffffc9000343eb90
> FS:  000055557674e380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056082271e438 CR3: 000000001fb2e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

