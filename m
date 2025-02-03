Return-Path: <linux-fsdevel+bounces-40557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD12A25117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 02:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FB618847D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B117996;
	Mon,  3 Feb 2025 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="pjSeePmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E0566A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738546649; cv=none; b=rhviYPXqPqCzmbR+RajU9LDlirBMRZ+c5pehq+nlD8AMFyUI14bFlrlYzLng10WmJF6KVBJNWeBJi3BWfn/KFguLS8IKfJfqTYbp+ATYeMDbnsuW3enCG7cuhh4lYTlLoLAx5V5gggnqM/OGuBWnXmVrAzZHhsZVbQWgM11dUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738546649; c=relaxed/simple;
	bh=lKFqnOLMiCtpNmYJkU7K/TBuaKv1pbeWhDU29+Qd/2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C6r7zpCzAmuGsHvfd7Tm2EG5RKd8bfvqVf9arXGSTAJQ+iVs2nhms7ujAvIv2tD/XRwU3qaMzf6fiAHTa9a288hQGXVOBplp5OQ9vc6jVTTAxqTzvN1WCvdXJiDaY6wot34ML0Y0HE6EXKbJBdwTpZrsC3clrUgava/3RPQ46NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=pjSeePmw; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5B2AE240028
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 02:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738546639; bh=lKFqnOLMiCtpNmYJkU7K/TBuaKv1pbeWhDU29+Qd/2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=pjSeePmwfBx2X6iyvMmutIcJgET6k+tWssMsg+yIKQLvj1zAboUa1AD0CDNA0k9Yz
	 VwolRNY8WMXm99+TBSC28S5Ie9Zj2kSKVq66CyWkJtfWL+gWgWmTqNeFqUPpMiGs1r
	 EhO/2Gxv19jzDapJAQJ8JWCJ4IEtoGwnZ/4XUrQLLcKSocoQyoGZ2Zp7+82eQy/QD/
	 urmmkvSaL1Fyb9iYb3/Wda4q7OB5n6d66LvSbBiGlEUhXQncKqv4FjTr7MUdFLrcdE
	 x92ZkTgdVXV2Hfp2LXz3xfngoxK1ZJfocYt49oSbTArlnPXe0nbBzs9zkBLgUU/oU9
	 ARRaV/p6qx6Kw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YmTd94HqTz9rxB;
	Mon,  3 Feb 2025 02:37:17 +0100 (CET)
Message-ID: <c7e1d6c7-8f91-4aa7-a887-98047e904ade@posteo.net>
Date: Mon,  3 Feb 2025 01:37:16 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [fs?] KMSAN: uninit-value in full_proxy_poll
To: syzbot <syzbot+a84ce0b8e1f3da037bf7@syzkaller.appspotmail.com>,
 dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67a01871.050a0220.d7c5a.007b.GAE@google.com>
Content-Language: en-US
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <67a01871.050a0220.d7c5a.007b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/2/25 3:14 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b4b0881156fb Merge tag 'docs-6.14-2' of git://git.lwn.net/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=146c5ddf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d0bb5e08cf54aa2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a84ce0b8e1f3da037bf7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cb8518580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122a0b24580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4dbe3cd3dcb8/disk-b4b08811.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/592d90859f86/vmlinux-b4b08811.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4cfde2b63c7f/bzImage-b4b08811.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a84ce0b8e1f3da037bf7@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in full_proxy_poll+0xdf/0x3b0 fs/debugfs/file.c:411
>   full_proxy_poll+0xdf/0x3b0 fs/debugfs/file.c:411
>   vfs_poll include/linux/poll.h:82 [inline]
>   ep_item_poll fs/eventpoll.c:1060 [inline]
>   ep_insert+0x19c7/0x2740 fs/eventpoll.c:1736
>   do_epoll_ctl+0xd83/0x17f0 fs/eventpoll.c:2394
>   __do_sys_epoll_ctl fs/eventpoll.c:2445 [inline]
>   __se_sys_epoll_ctl fs/eventpoll.c:2436 [inline]
>   __x64_sys_epoll_ctl+0x1b5/0x210 fs/eventpoll.c:2436
>   x64_sys_call+0x1658/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:234
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>   __debugfs_file_get+0xe86/0xef0 fs/debugfs/file.c:122
>   full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
>   do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
>   vfs_open+0x53/0x5b0 fs/open.c:1085
>   do_open fs/namei.c:3830 [inline]
>   path_openat+0x56a1/0x6250 fs/namei.c:3989
>   do_filp_open+0x268/0x600 fs/namei.c:4016
>   do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
>   do_sys_open fs/open.c:1442 [inline]
>   __do_sys_openat fs/open.c:1458 [inline]
>   __se_sys_openat fs/open.c:1453 [inline]
>   __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
>   x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>   __debugfs_file_get+0xe59/0xef0 fs/debugfs/file.c:120
>   full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
>   do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
>   vfs_open+0x53/0x5b0 fs/open.c:1085
>   do_open fs/namei.c:3830 [inline]
>   path_openat+0x56a1/0x6250 fs/namei.c:3989
>   do_filp_open+0x268/0x600 fs/namei.c:4016
>   do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
>   do_sys_open fs/open.c:1442 [inline]
>   __do_sys_openat fs/open.c:1458 [inline]
>   __se_sys_openat fs/open.c:1453 [inline]
>   __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
>   x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>   __debugfs_file_get+0xdff/0xef0 fs/debugfs/file.c:118
>   full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
>   do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
>   vfs_open+0x53/0x5b0 fs/open.c:1085
>   do_open fs/namei.c:3830 [inline]
>   path_openat+0x56a1/0x6250 fs/namei.c:3989
>   do_filp_open+0x268/0x600 fs/namei.c:4016
>   do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
>   do_sys_open fs/open.c:1442 [inline]
>   __do_sys_openat fs/open.c:1458 [inline]
>   __se_sys_openat fs/open.c:1453 [inline]
>   __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
>   x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>   slab_post_alloc_hook mm/slub.c:4121 [inline]
>   slab_alloc_node mm/slub.c:4164 [inline]
>   __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   __debugfs_file_get+0x31d/0xef0 fs/debugfs/file.c:101
>   full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
>   do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
>   vfs_open+0x53/0x5b0 fs/open.c:1085
>   do_open fs/namei.c:3830 [inline]
>   path_openat+0x56a1/0x6250 fs/namei.c:3989
>   do_filp_open+0x268/0x600 fs/namei.c:4016
>   do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
>   do_sys_open fs/open.c:1442 [inline]
>   __do_sys_openat fs/open.c:1458 [inline]
>   __se_sys_openat fs/open.c:1453 [inline]
>   __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
>   x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 5778 Comm: syz-executor303 Not tainted 6.13.0-syzkaller-09585-gb4b0881156fb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> =====================================================
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
>

|#syz test: |git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git|57b314752ec0ad42685bc78b376326f1f4c04669|


