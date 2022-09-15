Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41E5B94B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOGwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIOGwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:52:40 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79A51A3D
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 23:52:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k12-20020a92c24c000000b002f18edda397so11927449ilo.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 23:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YRzv5Gcy4/mzJnqE/Oh11tN56w+9we0Bw9AMA0F1Rl0=;
        b=B2qHQVUXC5VgxWp3HvX/X9uGqKLhSRQc/HXoL/4S7V9ivvinkBR1eX/9NojavNK9Ld
         WWsQXRsGkZQKpS/fS0niKc01a1PB0Kv7V/PgkoztJU2a4BYyWaGhWsqrHxQJrP2XhLrS
         pVw1LVv3eXk5ET2v7G9U7mzNuP5m87Wyx2eD24eoU2Qjm2smAxzlMbTqSTW/9PFZxq11
         3L9u5rsWUHisVQN8oRw1Ok5zI14uPD4FyYzGpWsLs1B4Wnki1Bv9AWPv3bDJeUocAjOV
         qU2WRgemlplDcEt5gAj9PsWZnTwp2jeGHAyx+U5a18U9T2ummGZpChCPqvnZDUPdazfa
         rBlA==
X-Gm-Message-State: ACgBeo3OzfEUeWVsS3zqHdBzX5/UbzSunWyflIhaQB8tLOgmSg+wjMwn
        yOuaJNIS8N0IQ3NeOftHKLySNktuBuXhX+TjsaB+MG8ePRno
X-Google-Smtp-Source: AA6agR4klKViFdcSJ9+NXNOBbBuyzX7yUk0SrgOGpmIdFyJVVaRF+X0EIlsUkqGnFPXDy9+P/xG1jkF8wOyaLpyLdSzANczjrZgn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:2f1:dc7a:c514 with SMTP id
 k15-20020a056e021a8f00b002f1dc7ac514mr16487981ilv.242.1663224757752; Wed, 14
 Sep 2022 23:52:37 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:52:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de1bc505e8b1b012@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in
 writeback_single_inode (2)
From:   syzbot <syzbot+cbe497b6194ae8171bf8@syzkaller.appspotmail.com>
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

HEAD commit:    b96fbd602d35 Merge tag 's390-6.0-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1078acbb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79df237bd9a0448
dashboard link: https://syzkaller.appspot.com/bug?extid=cbe497b6194ae8171bf8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d9969364c8a/disk-b96fbd60.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00883756a3a3/vmlinux-b96fbd60.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbe497b6194ae8171bf8@syzkaller.appspotmail.com

ntfs3: loop4: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop4: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
BUG: unable to handle page fault for address: ffffffff81e3b77b
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD bc8f067 P4D bc8f067 PUD bc90063 PMD 1e001e1 
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8235 Comm: syz-executor.4 Not tainted 6.0.0-rc4-syzkaller-00302-gb96fbd602d35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:writeback_single_inode+0x1f7/0x4c0 fs/fs-writeback.c:1701
Code: ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 7b 02 00 00 45 8b 7c 24 20 bf 01 00 00 00 44 89 fe e8 e8 4d 98 <ff> 41 83 ff 01 0f 85 26 ff ff ff e8 19 51 98 ff 48 8d 7d 30 48 b8
RSP: 0018:ffffc90013287a10 EFLAGS: 00010297

RAX: 0000000000000002 RBX: 0000000000000010 RCX: ffffffff81e3b7f8
RDX: ffff888023c21d80 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff888049b59870 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90013287a88
R13: ffff888049b59948 R14: ffff888049b598f8 R15: 0000000000000001
FS:  00007f31be027700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff81e3b77b CR3: 0000000067d28000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 write_inode_now+0x16a/0x1e0 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x45b/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f31bce8a8fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f31be026f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f31bce8a8fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f31be026fe0
RBP: 00007f31be027020 R08: 00007f31be027020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f31be026fe0 R15: 000000002007aa80
 </TASK>
Modules linked in:
CR2: ffffffff81e3b77b
---[ end trace 0000000000000000 ]---
RIP: 0010:writeback_single_inode+0x1f7/0x4c0 fs/fs-writeback.c:1701
Code: ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 7b 02 00 00 45 8b 7c 24 20 bf 01 00 00 00 44 89 fe e8 e8 4d 98 <ff> 41 83 ff 01 0f 85 26 ff ff ff e8 19 51 98 ff 48 8d 7d 30 48 b8
RSP: 0018:ffffc90013287a10 EFLAGS: 00010297
RAX: 0000000000000002 RBX: 0000000000000010 RCX: ffffffff81e3b7f8
RDX: ffff888023c21d80 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff888049b59870 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90013287a88
R13: ffff888049b59948 R14: ffff888049b598f8 R15: 0000000000000001
FS:  00007f31be027700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff81e3b77b CR3: 0000000067d28000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
