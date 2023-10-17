Return-Path: <linux-fsdevel+bounces-538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3947CC81E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E81C20C3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0E450FD;
	Tue, 17 Oct 2023 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C23EBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 15:53:51 +0000 (UTC)
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC5E103
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:46 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c6373a4aa7so8257969a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558025; x=1698162825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUZ0de+MvZvkBI+v56kYAAGsEXZomKaCXv/rWu5w7Kg=;
        b=Rij4BeVzmd8ZrJzLJTwWAfCDLq7VgVeuFgmiy7KegIoL4aXVshMOlfNuTPaZoroph3
         IXDngS4wXa4SuZdPYkeFWOfeJe5Vg1ML+YS4zCvy/3DiY3JV0XLqp3aLk06E0DSGugam
         JM0IdPLTYnPCkssp9AgqAtBO76FSAn5o8s3woy9ibF2M4EWcIEHLCWedk3kyii1RGmuD
         mvO1V9+7ERE4PO+ORP4A2MagGaO3oUGoM3aFaoXpLFvmpBMzHN9Q+IXRXRI5qDR9ygVh
         Vb5Q2CG0DEWu0D69WytDBUxjx5CekXVSqfOQmJ9DoT+Ht6qFOQLUvAtWMZtd9MTcdRYW
         4+vQ==
X-Gm-Message-State: AOJu0YytJov7vHYOy/hoZYP5fsdvfPppnf0dFfS12QNEBEN6IxxEzcX5
	JEuupdNxFBulC2gX6Ure+FzxMBacdgdRALZ+yPOs9802WJU7
X-Google-Smtp-Source: AGHT+IGDyNvYe1mxxsf+pTLt5whcHcfl6lOC9wzaf4wyVb/FuHFawAeA79RfYrArTvY/jzrZ/w/COCrkx1E15meSmYGttPuplKMX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7082:0:b0:6ba:8e4a:8e62 with SMTP id
 l2-20020a9d7082000000b006ba8e4a8e62mr744031otj.7.1697558025539; Tue, 17 Oct
 2023 08:53:45 -0700 (PDT)
Date: Tue, 17 Oct 2023 08:53:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019171d0607eb8786@google.com>
Subject: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (3)
From: syzbot <syzbot+6aa88a2d31fbec170f8b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    c295ba49917a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=135804fe680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
dashboard link: https://syzkaller.appspot.com/bug?extid=6aa88a2d31fbec170f8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d48d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13498275680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/045554f2bee6/disk-c295ba49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba2705f8a872/vmlinux-c295ba49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e36242e95b79/Image-c295ba49.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/39a4eecc45c3/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/3a9106a526c9/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6aa88a2d31fbec170f8b@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 PID: 11455 Comm: kworker/u4:4 Not tainted 6.6.0-rc6-syzkaller-gc295ba49917a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 lookup_chain_cache_add kernel/locking/lockdep.c:3815 [inline]
 validate_chain kernel/locking/lockdep.c:3836 [inline]
 __lock_acquire+0x1c60/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 btrfs_reduce_alloc_profile fs/btrfs/block-group.c:83 [inline]
 btrfs_get_alloc_profile+0x2b8/0xad4 fs/btrfs/block-group.c:138
 get_alloc_profile_by_root fs/btrfs/extent-tree.c:2508 [inline]
 btrfs_reserve_extent+0x1b8/0x674 fs/btrfs/extent-tree.c:4502
 btrfs_alloc_tree_block+0x1b0/0x1444 fs/btrfs/extent-tree.c:4931
 __btrfs_cow_block+0x3f4/0x1924 fs/btrfs/ctree.c:546
 btrfs_cow_block+0x314/0xa0c fs/btrfs/ctree.c:724
 btrfs_search_slot+0xb8c/0x29d8
 btrfs_update_root+0xe4/0xa88 fs/btrfs/root-tree.c:137
 commit_fs_roots+0x428/0x69c fs/btrfs/transaction.c:1473
 btrfs_commit_transaction+0x10ec/0x2dd4 fs/btrfs/transaction.c:2418
 btrfs_qgroup_rescan_worker+0x15fc/0x1674 fs/btrfs/qgroup.c:3417
 btrfs_work_helper+0x340/0x1504 fs/btrfs/async-thread.c:314
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
BTRFS info (device loop3): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop1): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop2): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop4): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop2): qgroup scan completed (inconsistency flag cleared)
BTRFS info (device loop3): qgroup scan completed (inconsistency flag cleared)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

