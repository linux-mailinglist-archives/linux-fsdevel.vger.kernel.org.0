Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB296C93CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCZKov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCZKot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 06:44:49 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8D8A6E
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 03:44:46 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so4006179ils.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 03:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679827486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjsmqCVV/m3aVO6Qcl6MbDGG1a+UzUUaaNCJyfsGu68=;
        b=8D+76mrjRSDPBZENjAN55jjYupfO9YroI+M36eWqIw6ZhlFM9KnUX9J6Y2HQvdNtLz
         bFoQT8NwokddLFx39BWYAzXIuYIZXd8n0trbM6LsQFfSuAzCCDnwv6tQQIyZ4UCcUK6P
         o4tZZxJ4RhR6TIWEd+myxR2qlQ/I+k3B8KpihJUlzqBoNJEbUZ3cRUUNGoJU8gg/J/6L
         5DA1WksUxCEjse+n4lSVBhI2JCNc/tLfHAOjDpHTpxH7j3PVMLasvhgAJ2An55f3Iuit
         sICrUAGHYQ+s1efSZxwuUyk23sKy+v/866i82nKyTSXnwp5n5lvXQBzPIxybbgsShWAu
         JFsw==
X-Gm-Message-State: AO0yUKUlAABkixwpFPROAKlo0AfnL8/fw0Bl36k7XP+k00/VEUgTlWN0
        VHc9TFc0Wvg1204ca2uekxo+ZN4dsJLYg2drjRwHgQNdfKIj
X-Google-Smtp-Source: AK7set/PPtTKbYJMtM7hC4jEsdjJUSWvGIxgXvd3pdlTVFKEU5WOPTZsyaLuaeIEy31uW12UXn7p7Kx4Z71ayNhYMDe2KavY8cOF
MIME-Version: 1.0
X-Received: by 2002:a6b:4f04:0:b0:745:5dec:be5b with SMTP id
 d4-20020a6b4f04000000b007455decbe5bmr3109088iob.0.1679827486129; Sun, 26 Mar
 2023 03:44:46 -0700 (PDT)
Date:   Sun, 26 Mar 2023 03:44:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009842c105f7cb50b8@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_da_update_reserve_space (2)
From:   syzbot <syzbot+a1232eabd7a3d43d4fb5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fff5a5e7f528 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106ebc66c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=a1232eabd7a3d43d4fb5
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd867ac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15094596c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f6445f85469/disk-fff5a5e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a04a9ef0da2b/vmlinux-fff5a5e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/414b78e64804/bzImage-fff5a5e7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0563d853a594/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1232eabd7a3d43d4fb5@syzkaller.appspotmail.com

EXT4-fs warning (device loop1): ext4_da_update_reserve_space:372: ext4_da_update_reserve_space: ino 18, used 1 with only 0 reserved data blocks
------------[ cut here ]------------
WARNING: CPU: 1 PID: 41 at fs/ext4/inode.c:373 ext4_da_update_reserve_space+0x419/0x730 fs/ext4/inode.c:369
Modules linked in:
CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: writeback wb_workfn (flush-7:1)
RIP: 0010:ext4_da_update_reserve_space+0x419/0x730 fs/ext4/inode.c:373
Code: 4c 89 ff 48 c7 c6 69 9e 82 8c ba 74 01 00 00 48 c7 c1 c0 3c fc 8a 49 c7 c0 69 9e 82 8c 41 55 41 54 e8 9b bb 0e 00 48 83 c4 10 <0f> 0b 48 bd 00 00 00 00 00 fc ff df 0f b6 04 2b 84 c0 0f 85 8f 01
RSP: 0018:ffffc90000b26cd0 EFLAGS: 00010282
RAX: cf4d35dbf73d9100 RBX: 1ffff1100e9b024d RCX: cf4d35dbf73d9100
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888074d80cf8 R08: ffffffff816dfe9c R09: fffffbfff205be51
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888074d80cb8 R15: ffff88807db7e000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7e69ab88 CR3: 00000000764a4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_map_blocks+0xb64/0x1cf0 fs/ext4/inode.c:672
 mpage_map_one_extent fs/ext4/inode.c:2421 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2474 [inline]
 ext4_do_writepages+0x189f/0x3d20 fs/ext4/inode.c:2876
 ext4_writepages+0x1e5/0x290 fs/ext4/inode.c:2964
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 __writeback_single_inode+0x155/0xfb0 fs/fs-writeback.c:1600
 writeback_sb_inodes+0x8ef/0x11d0 fs/fs-writeback.c:1891
 wb_writeback+0x458/0xc70 fs/fs-writeback.c:2065
 wb_do_writeback fs/fs-writeback.c:2208 [inline]
 wb_workfn+0x400/0xff0 fs/fs-writeback.c:2248
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
