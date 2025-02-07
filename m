Return-Path: <linux-fsdevel+bounces-41141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F0BA2B75E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8900C1670CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4182D627;
	Fri,  7 Feb 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UvAVLyV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2A17E4;
	Fri,  7 Feb 2025 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889646; cv=none; b=JHd/zrRdf8mqoJFGHAt08Xv+kXq7i+RXY5fIqo4DHb4B3Sm4ud6oUDyq/3CpcgDFokmgn3BAVbsxY9P9+f6TtkvX2jqxHJtroqmvHNachM2tGlcHl1tfdOqFS8r8//tJ3mARGuZ2gCy4h7EkKTqY+HodhbO8hBqXwd8I2+c4Pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889646; c=relaxed/simple;
	bh=ZKlTFKBvV5jUD9tVHqZ6N0mpAeuGrS5gLLeh5evbldI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IDRMyGBHSCz0nJ4C1UuaIEsYNCJW20pYa57TyETpbxxF05g3K7KnqFulxAK5Avz08+cqb3VrXguxoWlQsssa6l5EpZRm7i85/70R2/aeDJ/NMQ62osPT/+xF7Dapmn8Eu4rJvJdYSpqh+eZcDklVcPVNbTARdkwKsL2kHp4hdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UvAVLyV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B05EC4CEDD;
	Fri,  7 Feb 2025 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738889645;
	bh=ZKlTFKBvV5jUD9tVHqZ6N0mpAeuGrS5gLLeh5evbldI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvAVLyV/r5UuNhnPza1lTCInH+QqEjrwZcD6aIE4c2ycWO6NJAvj9ouCEYIi6ojcR
	 IgraYoOmZ+jl9Q0iQqy232Ho9KPur2oUom5G5BbpfSMBn0ajLt68yiufd0VHqxE/kF
	 t7+ViKF+03GiD8bweqOUnWlIKNEQEqA8m8CveNJ4=
Date: Thu, 6 Feb 2025 16:54:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in fsnotify_file_area_perm
Message-Id: <20250206165404.495fd127b4dc32a62574841a@linux-foundation.org>
In-Reply-To: <67a487f7.050a0220.19061f.05fc.GAE@google.com>
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Thanks.  Let me cc linux-fsdevel and a few others who might help with
this.


On Thu, 06 Feb 2025 01:59:19 -0800 syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=135c1724580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
> dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> XFS: ikeep mount option is deprecated.
> XFS (loop0): Mounting V5 Filesystem a2f82aab-77f8-4286-afd4-a8f747a74bab
> XFS (loop0): Ending clean mount
> XFS (loop0): Quotacheck needed: Please wait.
> XFS (loop0): Quotacheck: Done.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5321 at ./include/linux/fsnotify.h:145 fsnotify_file_area_perm+0x1e5/0x250 include/linux/fsnotify.h:145
> Modules linked in:
> CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:fsnotify_file_area_perm+0x1e5/0x250 include/linux/fsnotify.h:145
> Code: c3 cc cc cc cc e8 fb 8f c6 ff 49 83 ec 80 4c 89 e7 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 9f 00 00 e8 dc 8f c6 ff 90 <0f> 0b 90 e9 0a ff ff ff 48 c7 c1 10 73 1b 90 80 e1 07 80 c1 03 38
> RSP: 0018:ffffc9000d416320 EFLAGS: 00010283
> RAX: ffffffff81f8dce4 RBX: 0000000000000001 RCX: 0000000000100000
> RDX: ffffc9000e5c2000 RSI: 00000000000008fa RDI: 00000000000008fb
> RBP: 0000000000008000 R08: ffffffff81f8dbdc R09: 1ffff110087dca2e
> R10: dffffc0000000000 R11: ffffed10087dca2f R12: ffff888033d4b1c0
> R13: 0000000000000010 R14: dffffc0000000000 R15: ffffc9000d416460
> FS:  00007f5bca7346c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 0000000033fd2000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  filemap_fault+0x14a9/0x16c0 mm/filemap.c:3509
>  __do_fault+0x135/0x390 mm/memory.c:4977
>  do_read_fault mm/memory.c:5392 [inline]
>  do_fault mm/memory.c:5526 [inline]
>  do_pte_missing mm/memory.c:4047 [inline]
>  handle_pte_fault mm/memory.c:5889 [inline]
>  __handle_mm_fault+0x4c44/0x70f0 mm/memory.c:6032
>  handle_mm_fault+0x3e5/0x8d0 mm/memory.c:6201
>  faultin_page mm/gup.c:1196 [inline]
>  __get_user_pages+0x1a92/0x4140 mm/gup.c:1491
>  __get_user_pages_locked mm/gup.c:1757 [inline]
>  __gup_longterm_locked+0xe64/0x17f0 mm/gup.c:2529
>  gup_fast_fallback+0x2266/0x29c0 mm/gup.c:3430
>  pin_user_pages_fast+0xcc/0x160 mm/gup.c:3536
>  iov_iter_extract_user_pages lib/iov_iter.c:1844 [inline]
>  iov_iter_extract_pages+0x3bb/0x5c0 lib/iov_iter.c:1907
>  __bio_iov_iter_get_pages block/bio.c:1181 [inline]
>  bio_iov_iter_get_pages+0x4f1/0x1460 block/bio.c:1263
>  iomap_dio_bio_iter+0xc9c/0x1740 fs/iomap/direct-io.c:406
>  __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
>  iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:792
>  xfs_file_dio_write_unaligned+0x2ef/0x6f0 fs/xfs/xfs_file.c:692
>  xfs_file_dio_write fs/xfs/xfs_file.c:725 [inline]
>  xfs_file_write_iter+0x5c6/0x720 fs/xfs/xfs_file.c:876
>  do_iter_readv_writev+0x71a/0x9d0
>  vfs_writev+0x38b/0xbc0 fs/read_write.c:1050
>  do_pwritev fs/read_write.c:1146 [inline]
>  __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>  __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5bc998cda9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5bca734038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
> RAX: ffffffffffffffda RBX: 00007f5bc9ba5fa0 RCX: 00007f5bc998cda9
> RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000007
> RBP: 00007f5bc9a0e2a0 R08: 0000000000000000 R09: 0000000000000003
> R10: 0000000000007c00 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f5bc9ba5fa0 R15: 00007fff90caf808
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

