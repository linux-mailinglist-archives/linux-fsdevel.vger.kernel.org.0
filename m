Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA7646A79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 09:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLHI0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLHI0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:26:48 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440E5D6BD
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Dec 2022 00:26:47 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so640143ilj.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Dec 2022 00:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D29xb/Z+5WTN+XE9gVFvEvb1Rr+QEuNqVEJlqmRpp0M=;
        b=PB8wgq1rw0zmxQWywAwd4Oq1V9PWJXkGHTsMQw6Nkxd1/aDIz31tHXadcBmQh7MBho
         MNMCUMPtHwcx9Szu0xIfettjLZGK1GthEOdP6cUb4mI/A68ZJWEdJ7mrEnyT3gYVDJLJ
         uNg5JHdmtudl/FDpEYV4JQvnXNyMGG2iyc1qolJSfWsGSYKSyP5w5QIQONAP9Qsw/AtX
         B6e/3wkoDz3wCGZBJbJmI4r0rz1Uscbd70g/Em5mCTWvNoLGtnqnN8SosZz4ti8hyf9p
         cb7rTPmnKYTUkclvdJKnpkeOO7jIFtS5zbhWyb1FMIli6FutNU+U84SZGfwTBUP7fxzs
         p/DQ==
X-Gm-Message-State: ANoB5pmSPAD3zq89VTkWm0UfToEFtHPakePDJJ7uKbkibqQdbukfZ9RG
        W3GXyBwTjvknzvag9AKcAYgLaf3WurTdrx4waiBCDsJbZ1iK
X-Google-Smtp-Source: AA0mqf6OZIlrIcwPi4EKxoCOPTvFm9R7wZj5Ia0OcP59nLg1Sq5aDU6vAnNembaWj2uhSp7qiYgPPAaAJU1x8lWYUH0wU38l4tS5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3822:b0:38a:486d:4f71 with SMTP id
 i34-20020a056638382200b0038a486d4f71mr7464024jav.102.1670488007099; Thu, 08
 Dec 2022 00:26:47 -0800 (PST)
Date:   Thu, 08 Dec 2022 00:26:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043c9a105ef4cccf7@google.com>
Subject: [syzbot] KMSAN: uninit-value in hfs_brec_find
From:   syzbot <syzbot+5ce571007a695806e949@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    30d2727189c5 kmsan: fix memcpy tests
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15931383880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2144983ada8b4f3
dashboard link: https://syzkaller.appspot.com/bug?extid=5ce571007a695806e949
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e8c2d419c2e/disk-30d27271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e8a728a72a9/vmlinux-30d27271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89f71c80c707/bzImage-30d27271.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ce571007a695806e949@syzkaller.appspotmail.com

hfs: keylen 9474 too large
=====================================================
BUG: KMSAN: uninit-value in hfs_brec_find+0x671/0x9b0 fs/hfs/bfind.c:141
 hfs_brec_find+0x671/0x9b0 fs/hfs/bfind.c:141
 hfs_brec_read+0x3b/0x190 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0xfb/0x450 fs/hfs/catalog.c:194
 hfs_fill_super+0x1f49/0x2400 fs/hfs/super.c:419
 mount_bdev+0x508/0x840 fs/super.c:1401
 hfs_mount+0x49/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
 vfs_get_tree+0xa1/0x500 fs/super.c:1531
 do_new_mount+0x694/0x1580 fs/namespace.c:3040
 path_mount+0x71a/0x1eb0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3568
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable fd created at:
 hfs_fill_super+0x5e/0x2400 fs/hfs/super.c:381
 mount_bdev+0x508/0x840 fs/super.c:1401

CPU: 0 PID: 5557 Comm: syz-executor.2 Not tainted 6.1.0-rc8-syzkaller-64144-g30d2727189c5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
