Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B864B089
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 08:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiLMHqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 02:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMHqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:46:42 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80BAE70
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 23:46:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id o16-20020a056602225000b006e032e361ccso1427316ioo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 23:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sF7s08UHH6oAcOgt+chmOQN+BwW3CcMhQwNJPjVRmuY=;
        b=Z5y6JRWykuYKXVVra4QqRNvxhlErLzMac/kdsQjIdy+PEPCE8FmpXekPjdWThAmSkG
         uO+t9kem34g/HpeF6T6cgJgqd9z7KQNaGsi+mp/nQRdb2y2xiUEBXxWO1FdwTIwaOWm+
         SI0kht75TbOmB0gYAEDjQXcZwsszgk+iYqRu+DrMKIqC/CJERZjwnXsLVqnhIWFtvLIf
         rVTU4U1g4Wb5AIRbmOMxhIfdyk2sYgkMgu+gB3ItNk712kqvU0Qqk0tnN3JfmwTjXOFY
         19RVXfJmkB2d+uSHuyvao23iJrdVxlQfinsIkVOTCTcggc0uiBCphn/mljQN9A7DU1mx
         hDew==
X-Gm-Message-State: ANoB5plJGHxKs3if3ajUXlMIY++DOkey7qUj4dD1KZT+RI5gc16A1Z2T
        07helO99PtsF4MsGeLXV7Fv3pbC3HZ8ffNhWii4fvGUSWunR
X-Google-Smtp-Source: AA0mqf7+KYjZa4VURFejUauaDewv5pmNbGP5zTXtVQrCyzYZDtpe+c2PHgQNi6uLWOOlvfAN8MMKeI5KmMzLIoTeAFpM1Bq6qcwV
MIME-Version: 1.0
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id
 c14-20020a6bfd0e000000b006df5e6cf5c7mr25663576ioi.207.1670917599866; Mon, 12
 Dec 2022 23:46:39 -0800 (PST)
Date:   Mon, 12 Dec 2022 23:46:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd3bbe05efb0d1fd@google.com>
Subject: [syzbot] WARNING in walk_component
From:   syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
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

HEAD commit:    f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b594c7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b83f3e90d74765ea
dashboard link: https://syzkaller.appspot.com/bug?extid=eba014ac93ef29f83dc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117d216b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70829c2e18e5/disk-f3e84166.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f84024c6f5e/vmlinux-f3e84166.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50805dc3b682/bzImage-f3e84166.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a7108de1d0f9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem)): count = 0x0, magic = 0xffff88806aa92b10, owner = 0x0, curr 0xffff88807a496040, list empty
WARNING: CPU: 1 PID: 7332 at kernel/locking/rwsem.c:1336 __up_read+0x5c0/0x720 kernel/locking/rwsem.c:1336
Modules linked in:

CPU: 1 PID: 7332 Comm: syz-executor.2 Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_read+0x5c0/0x720 kernel/locking/rwsem.c:1336
Code: 03 80 3c 02 00 0f 85 35 01 00 00 49 8b 17 4d 89 f1 4c 89 e9 48 c7 c6 80 2b 4c 8a ff 34 24 48 c7 c7 c0 28 4c 8a e8 6d ba 45 08 <0f> 0b 5e e9 38 fb ff ff 48 89 df e8 20 54 6a 00 e9 b2 fa ff ff 48
RSP: 0018:ffffc900067af940 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8e512de8 RCX: 0000000000000000
RDX: ffff88807a496040 RSI: ffffffff81649a0c RDI: fffff52000cf5f1a
RBP: ffff88806aa92b18 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff92000cf5f2c
R13: ffff88806aa92b10 R14: ffff88807a496040 R15: ffff88806aa92b10
FS:  00007f38e75a7700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f46be509000 CR3: 0000000017b11000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock_shared include/linux/fs.h:771 [inline]
 lookup_slow fs/namei.c:1703 [inline]
 walk_component+0x34a/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x74e/0xe20 fs/namei.c:2320
 link_path_walk fs/namei.c:2245 [inline]
 path_parentat+0xa8/0x1b0 fs/namei.c:2521
 filename_parentat+0x1c3/0x5a0 fs/namei.c:2544
 do_renameat2+0x1c3/0xc90 fs/namei.c:4848
 __do_sys_renameat2 fs/namei.c:4963 [inline]
 __se_sys_renameat2 fs/namei.c:4960 [inline]
 __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4960
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f38e688c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38e75a7168 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f38e69ac050 RCX: 00007f38e688c0d9
RDX: 0000000000000004 RSI: 00000000200004c0 RDI: 0000000000000004
RBP: 00007f38e68e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000500 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff1016202f R14: 00007f38e75a7300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
