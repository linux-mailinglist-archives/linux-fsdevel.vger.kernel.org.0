Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D70571960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiGLMDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiGLMD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:03:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDDF1DA53
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x4-20020a6bd004000000b00675354ad495so4177576ioa.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+F3CLkcWxHEXZdXQEcfO2GuvqxGPDoVXGJ9ah/g01A8=;
        b=yGvl/bOcv0l/Hqfss692T6wrVSUhPMZ9nNiH0tPI1Teko7YWkg/6rxFkIeGAhjP/zQ
         Bxx4Crud+e5BWLRv+748cctiPWiayOt6Y0ns9emJt6zCFDQpDJbhYPkJturFVDhsirnF
         WnmiBftO/xlo8PDzD3aEnOjw6ucdy6IG6PMzSPIkcX/9MnAUd2s6GxAuFAA1jD2yZipR
         EgBjCCnj5mdKPgSODGiTZFxhJLjFxPQ9DmLXFFJ5UzVBKx/Uu7nmMuEfPBsDHhKqQw7N
         FjKfdVJFtzUj5DdFFUFr+QYXePUZW5Pz5977+onvJn1zm/c410eypSj9+8+Nkr0k8z6b
         cfQQ==
X-Gm-Message-State: AJIora88qJarecWL1RgFYrYQ5uEp4QQzug+oZyVM4MImAtjNyhvM1RV2
        WT5OoONP8WuQlgLUTEzqaHoXzuheYWWmIcq8+wNVVioaUrAS
X-Google-Smtp-Source: AGRyM1tc18D3QDk9ZXZzVbihko7yyFDJmdvq1GZlYDVcn5AE8VZ2E0IcLcXq4Mgg3Lj/SgWXR7sV6vRAsQBLvhRqtmoPLyK+m/vf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:2dc:3511:d313 with SMTP id
 p6-20020a056e02144600b002dc3511d313mr11867190ilo.157.1657627405055; Tue, 12
 Jul 2022 05:03:25 -0700 (PDT)
Date:   Tue, 12 Jul 2022 05:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5fe4305e39a746c@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __xas_nomem
From:   syzbot <syzbot+b355e80670ac28f5263c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8e59a6a7a4fa Merge tag 'mm-hotfixes-stable-2022-07-11' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a10ac8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f58350a1f5f99e22
dashboard link: https://syzkaller.appspot.com/bug?extid=b355e80670ac28f5263c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b355e80670ac28f5263c@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10059, name: syz-executor.3
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor.3/10059:
 #0: ffff888014c5e0e0 (&type->s_umount_key#70/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xa80 fs/super.c:228
 #1: ffff8880259280c0 (&fs_info->fs_roots_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff8880259280c0 (&fs_info->fs_roots_lock){+.+.}-{2:2}, at: btrfs_insert_fs_root+0x78/0x2e0 fs/btrfs/disk-io.c:1708
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 10059 Comm: syz-executor.3 Not tainted 5.19.0-rc6-syzkaller-00019-g8e59a6a7a4fa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9821
 might_alloc include/linux/sched/mm.h:274 [inline]
 slab_pre_alloc_hook mm/slab.h:723 [inline]
 slab_alloc mm/slab.c:3285 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3479 [inline]
 kmem_cache_alloc_lru+0x41b/0x8c0 mm/slab.c:3506
 __xas_nomem+0x263/0x670 lib/xarray.c:340
 __xa_insert+0x122/0x250 lib/xarray.c:1662
 xa_insert include/linux/xarray.h:774 [inline]
 btrfs_insert_fs_root+0xf7/0x2e0 fs/btrfs/disk-io.c:1709
 btrfs_get_root_ref.part.0+0x820/0xb80 fs/btrfs/disk-io.c:1855
 btrfs_get_root_ref fs/btrfs/disk-io.c:1809 [inline]
 btrfs_get_fs_root fs/btrfs/disk-io.c:1887 [inline]
 btrfs_read_roots fs/btrfs/disk-io.c:2725 [inline]
 init_tree_roots fs/btrfs/disk-io.c:3111 [inline]
 open_ctree+0x2d88/0x49d3 fs/btrfs/disk-io.c:3736
 btrfs_fill_super fs/btrfs/super.c:1455 [inline]
 btrfs_mount_root.cold+0x15/0x162 fs/btrfs/super.c:1821
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:1043 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1073
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1060
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1881
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f14e7c8a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14e6bfdf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f14e7c8a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f14e6bfdfe0
RBP: 00007f14e6bfe020 R08: 00007f14e6bfe020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f14e6bfdfe0 R15: 0000000020016800
 </TASK>
BTRFS info (device loop3): enabling ssd optimizations


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
