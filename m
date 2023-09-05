Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174DD7924EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjIEQAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjIECly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:41:54 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C32CC7
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 19:41:50 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-56f75e70190so1560380a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 19:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693881710; x=1694486510;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rel8C/D7Odl/6HR0dA8yx8orsYr6F/O5Rkd47PoIZI=;
        b=dqWS2CxwIlzWdWKHlFNowuhokCM1j8JxDuoKe+raayzaQ6Wq9sfM2+9MC0siEnWqmQ
         aGFdxPcCobp+7NzlOE9OEXmG1RiRnHdkyoxNN7TcIT5nXa7UghizVDHe/uMj4q+DwN+q
         DvXx6psK4BJInZ+mKyGQ9gnQGCTVVOddf1dvHv97fXKyNdhvZlFSHOkYAoWx32tquqK7
         gKmfcrAQH4xUkRspx6yNG4OzkbEZ/30EnlMuS/omuZcPODl35BDENKwIMotIe4viWe1v
         RS3NV/4Db7SS88VYFuq/DRzLszPymSQz7r2mbDM0K/tAzcAbtjSBYA4E3LalzYpUz/mr
         bhtA==
X-Gm-Message-State: AOJu0YxU50hFI9MKCccJ0M76+azBeRASvX6LvfXrdC1cpHzY3LxXeGUy
        ZA5TkUiypWpBNEUEbmFOJD4KHbuI49M0OOpfLvLCCmXBGi+N
X-Google-Smtp-Source: AGHT+IGW0pF60lKuZHOAJcmKE6HN4PYUeBmo0mzrxsM76DNHFjwYTiAIjApYnrJ1yttLxPBKU5Z3Gjv+vCKsyccE4kcwow3QL93C
MIME-Version: 1.0
X-Received: by 2002:a63:2903:0:b0:564:aeb6:c383 with SMTP id
 bt3-20020a632903000000b00564aeb6c383mr2470013pgb.1.1693881710227; Mon, 04 Sep
 2023 19:41:50 -0700 (PDT)
Date:   Mon, 04 Sep 2023 19:41:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a13b2c06049391bf@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_run_delayed_items
From:   syzbot <syzbot+90ad99829e4f013084b7@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e8d7dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
dashboard link: https://syzkaller.appspot.com/bug?extid=90ad99829e4f013084b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99875b49c50b/disk-b97d64c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bcacc1a3f5b/vmlinux-b97d64c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2fe9c8de38a/bzImage-b97d64c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90ad99829e4f013084b7@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 3647 at fs/btrfs/delayed-inode.c:1158 __btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Modules linked in:
CPU: 0 PID: 3647 Comm: syz-executor.2 Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Code: fe c1 38 c1 0f 8c b5 fc ff ff 48 89 ef e8 f5 e3 42 fe e9 a8 fc ff ff e8 7b 2a e9 fd 48 c7 c7 e0 2a 4c 8b 89 de e8 5d dd af fd <0f> 0b e9 69 ff ff ff f3 0f 1e fa e8 5d 2a e9 fd 48 8b 44 24 10 42
RSP: 0018:ffffc9001403f8f0 EFLAGS: 00010246
RAX: 005f0d5eac152800 RBX: 00000000ffffffef RCX: ffff888026da1dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888031242a00 R08: ffffffff8153f992 R09: 1ffff92002807e94
R10: dffffc0000000000 R11: fffff52002807e95 R12: dffffc0000000000
R13: ffff8880312429d8 R14: 0000000000000000 R15: ffff888031242a00
FS:  00007f5361bdd6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbc30a6b8 CR3: 000000007bf09000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0xf44/0x2ff0 fs/btrfs/transaction.c:2393
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f536a47cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5361bdd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f536a59c050 RCX: 00007f536a47cae9
RDX: 0000000020001200 RSI: 0000000050009401 RDI: 0000000000000007
RBP: 00007f536a4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f536a59c050 R15: 00007fffdca166a8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
