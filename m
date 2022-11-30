Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED11463E397
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 23:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiK3Wnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 17:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK3Wnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:43:52 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971A8DBCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 14:43:51 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso14402ilg.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 14:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP1zmj2nFxLam6JR0lY72TFGiyD5flrr88q+91cw0Rs=;
        b=lTtEdXxpfGHLWX42Dfzrgc5nEg7k6tJEi4xogWmVHvxoKaf6cHY4CuBAzpyp49Tw7U
         Dlz99OIk0yM7PN1ot7GgcfHOdC3CAAUOPN6HTQpdQIVIXpXHTQcmaav3LJ1bBtykj0CR
         oQ6xdGL7d3JwSLwX89yoGuHEx5aNg6LSWwDwRMufSz+GNdS7p8v/I5YoQzOfeW0BXRpA
         dRS8BIt49Ef7zMU3exsehFG7bGLf//5v8TzkYeiMyjqHYn0mMddz3BEiU+lVimfyOTdb
         d2zW2PHDboTrs0Mp17jJjWDIT/JwT5xtpIa5wez0Zm1ZwidaV8em8onVmVTUpn4Fg9Uj
         vvTA==
X-Gm-Message-State: ANoB5pmmW+gWgFu2LYLL7NcjdTEOPzSsGFDaCDkTbRmVuSG9blFB62+n
        J6afq+n6Av6uHbenWkmFvHl3AZFwzX7WeHk0IBOruNOepeUP
X-Google-Smtp-Source: AA0mqf4wrRBvmA7GzSQa1vfo7iimqTLJT3hMzwIdRI60mS0gZ6M9LDioqOvr4Fo+aQPiuwSbYF7IO3qVj02AcuXYdHFykXh5veeJ
MIME-Version: 1.0
X-Received: by 2002:a02:c905:0:b0:374:e77e:d3d8 with SMTP id
 t5-20020a02c905000000b00374e77ed3d8mr29730572jao.103.1669848230710; Wed, 30
 Nov 2022 14:43:50 -0800 (PST)
Date:   Wed, 30 Nov 2022 14:43:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ed53d05eeb7d6e8@google.com>
Subject: [syzbot] WARNING in ep_poll (2)
From:   syzbot <syzbot+040b317810fd3e21b55d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10905dbb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=040b317810fd3e21b55d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110f4605880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ba453d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ba54b6200826/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+040b317810fd3e21b55d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 3083 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 1 PID: 3083 Comm: udevd Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff80000ffabb30
x29: ffff80000ffabba0 x28: ffff80000eec8000 x27: ffff0000c9ac9b40

x26: 0000000000000000
 x25: ffff0000c9289a40
 x24: 0000000000000002

x23: ffff80000866ba78
 x22: 0000000000000000
 x21: 0000000000000000

x20: 0000000000000000
 x19: ffff0000c9ac9a00
 x18: 000000000000031c

x17: ffff80000c0cd83c
 x16: 0000000000000000
 x15: 0000000000000000

x14: 0000000000000000
 x13: 0000000000000012 x12: ffff80000d93b3d0

x11: ff808000081c4d40
 x10: 0000000000000000
 x9 : c0fb5fb0435d7400

x8 : c0fb5fb0435d7400
 x7 : 4e5241575f534b43
 x6 : ffff80000c08e4f4

x5 : 0000000000000000
 x4 : 0000000000000001
 x3 : 0000000000000000

x2 : 0000000000000000
 x1 : 0000000100000000
 x0 : 0000000000000028

Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 ep_send_events fs/eventpoll.c:1655 [inline]
 ep_poll+0x320/0xc70 fs/eventpoll.c:1821
 do_epoll_wait+0x144/0x18c fs/eventpoll.c:2256
 do_epoll_pwait fs/eventpoll.c:2290 [inline]
 __do_sys_epoll_pwait+0x110/0x214 fs/eventpoll.c:2303
 __se_sys_epoll_pwait fs/eventpoll.c:2297 [inline]
 __arm64_sys_epoll_pwait+0x30/0x40 fs/eventpoll.c:2297
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 121585
hardirqs last  enabled at (121585): [<ffff8000080387b0>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (121585): [<ffff8000080387b0>] el0_svc_common+0x40/0x220 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (121584): [<ffff80000c080d24>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
softirqs last  enabled at (121232): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (121230): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
