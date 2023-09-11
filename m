Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5624E79B0EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbjIKUyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbjIKNgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:01 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87404125
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:35:55 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68fac73c54aso2510042b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439355; x=1695044155;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jG8GLm4LJITu6qfLgrhEclmMHIdvfy21Md/htW4Vrhk=;
        b=wqUoiyMRAvjeaTvjzz4mTkJ5hmSw3L8qj2AyTSV7HncyQroDTJuBLjjftA2GedO1J+
         xIVKjOkm6wDDNsfzABGpqpWpzknVDoWqZQQBvaU5VK/uM14tUHGTAffzT2jaToP6vRwQ
         N1g+ykCLsbMiA2y/vfSFcCx8i0ubdU7szM7JObGXCF+7JipnqyPaz4Gj40IQbScZSFCL
         pojTuXf+jAaahX2Z4aRdY0j7D94BK6Cj7YpMET6ONpHzqJ3tZdI9j61o9x4ehU9FlSp6
         SKCe06HVf1a3KVs4/I+sebbw5Jo9Q1QpS4f0+crKJcql1atgo9hcX+FG/Y05S1O+mQTK
         jtVA==
X-Gm-Message-State: AOJu0YxLZO1cNsdHfF/0Ybch18wBTgF0QKnAvckky4u7csu+wZ8IGC6o
        sDixlvuz0Ny7KUrIlWcfTOF5JKzwo1rdXruk/x5OErTxHzH1
X-Google-Smtp-Source: AGHT+IHs6ZwBRbUuEEc+sLMqD5UAs/el/JozhWYmP6Ilt6TRADV0OhYbHwX8Ct52NLMFntlyUUmRE62eGklvQhl3vBQc7uupjOCA
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:cd1:b0:68e:3b0b:819e with SMTP id
 b17-20020a056a000cd100b0068e3b0b819emr3924392pfv.5.1694439354986; Mon, 11 Sep
 2023 06:35:54 -0700 (PDT)
Date:   Mon, 11 Sep 2023 06:35:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8f8c20605156732@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_discard_allocated_blocks
From:   syzbot <syzbot+628e71e1cb809306030f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ba2090ca64e Merge tag 'ceph-for-6.6-rc1' of https://githu..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c57f2fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d
dashboard link: https://syzkaller.appspot.com/bug?extid=628e71e1cb809306030f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111acb20680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112d9f34680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7abbf7618c3a/disk-7ba2090c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/694adc723518/vmlinux-7ba2090c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c5d9addc4e4/bzImage-7ba2090c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a4604150b51d/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e3dba8680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1013dba8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e3dba8680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+628e71e1cb809306030f@syzkaller.appspotmail.com

ext4: mb_load_buddy failed (-117)
WARNING: CPU: 0 PID: 5538 at fs/ext4/mballoc.c:4620 ext4_discard_allocated_blocks+0x5d4/0x750 fs/ext4/mballoc.c:4619
Modules linked in:
CPU: 0 PID: 5538 Comm: syz-executor264 Not tainted 6.5.0-syzkaller-12107-g7ba2090ca64e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:ext4_discard_allocated_blocks+0x5d4/0x750 fs/ext4/mballoc.c:4619
Code: 00 0f 85 9a 01 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 eb 99 48 ff 48 c7 c7 00 42 1d 8b 44 89 fe e8 8c 14 0f ff <0f> 0b 49 bf 00 00 00 00 00 fc ff df eb 98 e8 c9 99 48 ff e9 19 fe
RSP: 0018:ffffc90005006cc0 EFLAGS: 00010246
RAX: da27be545f79de00 RBX: 0000000000000001 RCX: ffff888026741dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90005006dd0 R08: ffffffff81541672 R09: 1ffff1101730516a
R10: dffffc0000000000 R11: ffffed101730516b R12: ffff888076b7a124
R13: 1ffff92000a00da0 R14: ffff888076b7a0d8 R15: 00000000ffffff8b
FS:  00007f095582f6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020100000 CR3: 000000001c40b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_new_blocks+0x148f/0x4b30 fs/ext4/mballoc.c:6244
 ext4_ext_map_blocks+0x1e13/0x7150 fs/ext4/extents.c:4285
 ext4_map_blocks+0xa2f/0x1cb0 fs/ext4/inode.c:621
 _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:763
 ext4_block_write_begin+0x53d/0x1550 fs/ext4/inode.c:1043
 ext4_write_begin+0x619/0x10b0
 ext4_da_write_begin+0x300/0xa40 fs/ext4/inode.c:2865
 generic_perform_write+0x31b/0x630 mm/filemap.c:3942
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1d3/0x1ad0 fs/ext4/file.c:717
 call_write_iter include/linux/fs.h:1985 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0955872bd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f095582f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f09558fc6c8 RCX: 00007f0955872bd9
RDX: 000000000000a000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007f09558fc6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09558c8a38
R13: 0000000000000000 R14: 6f6f6c2f7665642f R15: 0032656c69662f2e
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
