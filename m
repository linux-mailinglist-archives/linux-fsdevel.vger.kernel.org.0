Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7463F0D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLAMtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLAMtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:49:42 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFB91C3A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 04:49:41 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w9-20020a056e021c8900b0030247910269so1838196ill.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 04:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IHSWu8cpROGIek2vroiLGwTRbK0xKUT/twwPlglJnA=;
        b=02SWKPpqFzv20qQvWNOmtax7RMRnufQxpLFsMO598caakHT5EizV4wTfHEXVcctL1m
         5EPYGW74l6/6wfnYBXpIG3F4Pd0kCx+IxZGul7sFt18imXB7H2ILsFHL6n6kTTIazZLN
         aSWQWEKq8RkDMTU+TE/Xpbleoj1ulXqTYNzev3HdyIwrPwcGL3tKjDLKJGIGBkAkceAa
         tJ6RcSQJ/gqXFVNjUQAW+l/ZMYa56a1Lw8gXQ/i+AkfgFzoR8QBoLzEiyyi3bqYnL1qH
         gCsLT1UDAZP9pHCgVBF+B+AxrOZp0ij/7hKYS2DR+FmF15lECsHGuPN26UnEpoi6pr6X
         Fdfg==
X-Gm-Message-State: ANoB5pkHdiWNJgL5IxL/+VCVKoO2lh54Gt+HCIZEH9J96YrgBiDqBMkN
        FhkLvTsw4A/pWrrqWCWCZtaeL1sJNj3QXHEm638liFPBZjtK
X-Google-Smtp-Source: AA0mqf6JbipCj5IoGcHzLZjfU923ilDwvC/rACUt+vw2J+y1KJ4Qt1F874qk1U3uBoLQWzZJVSQxa8hkRFn26Ld1oDoahWmOIOSG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:346:b0:388:9146:8361 with SMTP id
 x6-20020a056638034600b0038891468361mr17144222jap.19.1669898980456; Thu, 01
 Dec 2022 04:49:40 -0800 (PST)
Date:   Thu, 01 Dec 2022 04:49:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a836b05eec3a7e9@google.com>
Subject: [syzbot] WARNING in hfsplus_cat_read_inode
From:   syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    cdb931b58ff5 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1672f7fd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=e2787430e752a92b8750
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120b96a7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116da6bd880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07e4eae17e60/disk-cdb931b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc4815dd00c0/vmlinux-cdb931b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f46b40f30e1/Image-cdb931b5.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3082309c63cc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3073 at fs/hfsplus/inode.c:534 hfsplus_cat_read_inode+0x32c/0x338 fs/hfsplus/inode.c:534
Modules linked in:
CPU: 0 PID: 3073 Comm: syz-executor278 Not tainted 6.1.0-rc7-syzkaller-33054-gcdb931b58ff5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hfsplus_cat_read_inode+0x32c/0x338 fs/hfsplus/inode.c:534
lr : hfsplus_cat_read_inode+0x32c/0x338 fs/hfsplus/inode.c:534
sp : ffff80000ff23640
x29: ffff80000ff23850 x28: ffff0000c23a0000 x27: 000000000000000b
x26: ffff0000c9e92000 x25: 00000000000000ff x24: ffff0000cbd81530
x23: ffff0000c7bffdf0 x22: ffff0000c7bffd30 x21: 0000000000000058
x20: ffff80000ff23880 x19: ffff0000cbd81bb0 x18: 00000000000000c0
x17: ffff80000dda8198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: ffff80000d514f80
x11: ff808000088e828c x10: 0000000000000000 x9 : ffff8000088e828c
x8 : ffff0000c23a0000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80000ff235f6 x4 : ffff0001803f7028 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 0000000000000058 x0 : 00000000000000f8
Call trace:
 hfsplus_cat_read_inode+0x32c/0x338 fs/hfsplus/inode.c:534
 hfsplus_iget+0x244/0x2ac fs/hfsplus/super.c:84
 hfsplus_fill_super+0x480/0x864 fs/hfsplus/super.c:503
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 15818
hardirqs last  enabled at (15817): [<ffff80000c0963d4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (15817): [<ffff80000c0963d4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (15818): [<ffff80000c083704>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (15354): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (15241): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
