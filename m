Return-Path: <linux-fsdevel+bounces-18250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764248B68AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCD281FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6010A0D;
	Tue, 30 Apr 2024 03:29:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB83DDA6
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447770; cv=none; b=HX9qp05+BITEaebSkE8nQ+n7I0yl/qKTETRDSREx9XR+BoxtjfVCvPTVC2ipt8G7gxncMEMmiVkmHV5oJLOgznOS+oVgSvyY9qa5Zu05nvmcp9AN3cXGiYTbbWS3HP0bko3Uvm71nu1JmM+r5LZy+He2jt6R8ppMG0WOMJEdz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447770; c=relaxed/simple;
	bh=gdjQ/HknQhZhW7VPQvu3OzuLykGrzSNJlhyLC0G6FFg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lwed9hWJePhmTonhLshylHFq8fFLWoWuuY88d5ykQfn7DcUdq9jyAqTNcQz6hYrShmfhqm7ouW6/eehd19UuC6fJ49vz+2yPpLMKxI7eimL1/GGX7Gmf+ZsKG30wZ6vly0/KWHg5vMtcbQR4DjVA1B+YyiiU3RaIOqcbW28B5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so547721539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 20:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714447768; x=1715052568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGZYM7fIOCjqq/sIgx3m3cfyOGljeSWlPvaaYvYTxFI=;
        b=R+wqTt8SDU2M3vujDVlOk/8hDMy00Ub6T29H7VNaFrezTOQnpA7HeiqXCeW6QXcY+n
         7p2L5VsVKTGzPrFbFhFtJc7KY9hBktn8bPLO6d80HViz4dC6JdYF8NK2dDMk/x8Pggxb
         MmpQ9O6QpF+ofX5gT/OyNapkBblQS0PZbnP8dQQlgLVi3OV+6HPVhGaKk8iX2oLFFrgO
         DUGFgbqZoef1ZX0UESkAsTjLKJcYLM+3hAZra1nBcaGqMdSlTA4eWC7+nXw4KbOIbxAj
         gm7cQAuAJY+TuZzSBUYTIIcAW4gz9x6WHidN2kvWSQ63vx9B7MGeV6fKsMDOT/egdfCj
         otpw==
X-Forwarded-Encrypted: i=1; AJvYcCUYqjNy6puTGhLS1fMsfJjDKlVwpjBi7v2vaCkCWM6hYVTQ8O4chRnMOcRVMDNFgmY36scK7JaQ0E0sHLFNf8jHCpytcqi1RdaLO9Sa5A==
X-Gm-Message-State: AOJu0Yz6Ro9NuTh4Gc3VILu8Hgiqitu428NNCBumA/L/+HIGExJDGz3x
	y03fPVI/r0XTyGZc9Z1JFg6OT+UgJBnNjrRCNAAWvW8WqaXs+qAY3pEockfg/BAhQjsjqlpU+7I
	Dgj4nqllyNhRT7pzZAdYlaR9G86CPdqg6ynN6Gla3pYauwqMJI4zAJ94=
X-Google-Smtp-Source: AGHT+IEAbcFmC2NaitoJiGEScuVYmYguRAVc/2x1TTrbfkhctU0w7du2uas0kYSZqNTSB2bwTMugtGmxxkp854U5YsXxO9y/jMoA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1411:b0:7cc:cc9:4332 with SMTP id
 t17-20020a056602141100b007cc0cc94332mr591548iov.4.1714447766422; Mon, 29 Apr
 2024 20:29:26 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a94c3061747fabd@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a032a0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0ce27d8874a/disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4f35a65c416/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1c3abd538d5/bzImage-e33c4963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+016b09736213e65d106e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0 Not tainted
------------------------------------------------------
kswapd0/87 is trying to acquire lock:
ffff88820b27c128 (&wnd->rw_lock/1){+.+.}-{3:3}, at: ntfs_mark_rec_free+0x2f4/0x400 fs/ntfs3/fsntfs.c:742

but task is already holding lock:
ffffffff8d9304a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       __do_kmalloc_node mm/slub.c:3965 [inline]
       __kmalloc_node+0xbb/0x480 mm/slub.c:3973
       kmalloc_node include/linux/slab.h:648 [inline]
       kvmalloc_node+0x9d/0x1a0 mm/util.c:634
       kvmalloc include/linux/slab.h:766 [inline]
       run_add_entry+0x759/0xbe0 fs/ntfs3/run.c:389
       attr_allocate_clusters+0x213/0x720 fs/ntfs3/attrib.c:181
       attr_set_size+0x1514/0x2c60 fs/ntfs3/attrib.c:572
       ntfs_set_size+0x13d/0x220 fs/ntfs3/inode.c:839
       ntfs_extend+0x401/0x570 fs/ntfs3/file.c:335
       ntfs_file_write_iter+0x433/0x2050 fs/ntfs3/file.c:1115
       call_write_iter include/linux/fs.h:2110 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6db/0x1100 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ni->file.run_lock#2){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ntfs_extend_mft+0x138/0x430 fs/ntfs3/fsntfs.c:511
       ntfs_look_free_mft+0x661/0xdd0 fs/ntfs3/fsntfs.c:709
       ntfs_create_inode+0x3a7/0x42c0 fs/ntfs3/inode.c:1329
       ntfs_atomic_open+0x4d6/0x650 fs/ntfs3/namei.c:434
       atomic_open fs/namei.c:3360 [inline]
       lookup_open.isra.0+0xc98/0x13c0 fs/namei.c:3468
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x92f/0x2990 fs/namei.c:3796
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&wnd->rw_lock/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       ntfs_mark_rec_free+0x2f4/0x400 fs/ntfs3/fsntfs.c:742
       ni_delete_all+0x6ad/0x880 fs/ntfs3/frecord.c:1637
       ni_clear+0x519/0x6a0 fs/ntfs3/frecord.c:106
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node mm/vmscan.c:4935 [inline]
       shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &wnd->rw_lock/1 --> &ni->file.run_lock#2 --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ni->file.run_lock#2);
                               lock(fs_reclaim);
  lock(&wnd->rw_lock/1);

 *** DEADLOCK ***

2 locks held by kswapd0/87:
 #0: ffffffff8d9304a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782
 #1: ffff88820b27e0e0 (&type->s_umount_key#89){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88820b27e0e0 (&type->s_umount_key#89){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 0 PID: 87 Comm: kswapd0 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
 ntfs_mark_rec_free+0x2f4/0x400 fs/ntfs3/fsntfs.c:742
 ni_delete_all+0x6ad/0x880 fs/ntfs3/frecord.c:1637
 ni_clear+0x519/0x6a0 fs/ntfs3/frecord.c:106
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

