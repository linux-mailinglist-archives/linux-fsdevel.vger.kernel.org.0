Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE5737B30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFUGWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFUGWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:22:02 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6C10DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 23:21:57 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-342345934a8so28736175ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 23:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328517; x=1689920517;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiMal5spkWzxQuFQIfK2vMHUo4FNmdwa/V87z8doXGc=;
        b=dQb68kc6ArbEF9Tar+uGLpIsPk7Qtzh2AoYioN25BV8ludYA6bUKbVga+4lIuSWjdE
         0YRRUZO/JiTN0dtrLxNbr/AT4ZriykvLy4x+MrRNoD4CGE2Pc7rYHLL49Duu/B/sjKK6
         dKG6016wQTPq6ApiwMilSUuX/XQZ9rRJMjdVnFs7HR8sZs8+Z9UGGYbAfeg3shnJEN4V
         Q2/1u7RvRxpsEL4XBYIUWJ7sYiO281RsULxoveQVneqc01OQuv9RTQHlcab9bUu8oqiS
         RCINwRlAd3pFMSOhdRFs5yc9fW8dWmGd2hoeet7FMr+n5lHzwhe/H8Yjsm8Rcht+y4Ad
         VCXA==
X-Gm-Message-State: AC+VfDwB84L89xAY5r54CywrEW/HNffVdNSSFSjcsPCX+IMwrVb+PbIS
        HjsZzJEtKjaWhwDwTb05jl8zL4NUtDe+bpR+vfXgSXj6SJWw
X-Google-Smtp-Source: ACHHUZ5SNaRAP4AlQomcHJ+cQkJ/JYbpSfleiz9DmSgIpbdo3Y+yEDxUPEAfrkmmJuOytq7wEY72T5Y752YY3GgvaS+gYL8anMNM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:541:b0:341:d190:ca88 with SMTP id
 i1-20020a056e02054100b00341d190ca88mr5412963ils.6.1687328517151; Tue, 20 Jun
 2023 23:21:57 -0700 (PDT)
Date:   Tue, 20 Jun 2023 23:21:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2638a05fe9dc8f9@google.com>
Subject: [syzbot] [udf?] KMSAN: uninit-value in udf_name_from_CS0
From:   syzbot <syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com>
To:     glider@google.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e6bc8833d80f string: use __builtin_memcpy() in strlcpy/str..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16c43f97280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a7e173060c804ee
dashboard link: https://syzkaller.appspot.com/bug?extid=cd311b1e43cc25f90d18
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df1e5cb3acfa/disk-e6bc8833.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55bdfe53ed68/vmlinux-e6bc8833.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e2a33babf5f/bzImage-e6bc8833.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
=====================================================
BUG: KMSAN: uninit-value in udf_name_from_CS0+0x1581/0x1a40 fs/udf/unicode.c:250
 udf_name_from_CS0+0x1581/0x1a40 fs/udf/unicode.c:250
 udf_get_filename+0xa4/0x150 fs/udf/unicode.c:390
 udf_fiiter_find_entry+0x77b/0xa60 fs/udf/namei.c:90
 udf_unlink+0x80/0x920 fs/udf/namei.c:547
 vfs_unlink+0x66f/0xa20 fs/namei.c:4327
 do_unlinkat+0x3fa/0xed0 fs/namei.c:4393
 __do_sys_unlink fs/namei.c:4441 [inline]
 __se_sys_unlink fs/namei.c:4439 [inline]
 __ia32_sys_unlink+0x77/0xa0 fs/namei.c:4439
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
 kmalloc_trace+0x51/0x200 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 udf_fiiter_find_entry+0x213/0xa60 fs/udf/namei.c:66
 udf_unlink+0x80/0x920 fs/udf/namei.c:547
 vfs_unlink+0x66f/0xa20 fs/namei.c:4327
 do_unlinkat+0x3fa/0xed0 fs/namei.c:4393
 __do_sys_unlink fs/namei.c:4441 [inline]
 __se_sys_unlink fs/namei.c:4439 [inline]
 __ia32_sys_unlink+0x77/0xa0 fs/namei.c:4439
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 5699 Comm: syz-executor.2 Not tainted 6.4.0-rc7-syzkaller-ge6bc8833d80f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
