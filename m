Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F43737892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 03:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFUBGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 21:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUBGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:06:49 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42D139
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 18:06:48 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77e28bc1714so387810839f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 18:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687309608; x=1689901608;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHnNpvfxFKxMWOxMfewfAGJjYEY4G+Sn1HjByxNCDgU=;
        b=f7svtpXzyMDx50glpS00TjxQc4Covu7vg+ekFu+p6Hlcof9FjodvAkOy3TtPsS3wVx
         +sm1jJdMimAY/WDEXEYR2bWqC/CbaNej7vVwPvVPJIw0anAuXFHY4FuKNyAlDQJxe+ny
         pjHMQ11zjrZunR1wgUeJEpGl3onl3IlzBfzmKj0oMCsOF6o1cbGljk95Tzu8Vgqc0SNS
         1h1XqPixjnOfdQI3DOU1UsK+x7X0MMkzP3IWKjkiY+rLUzud1kvJ+quszmfZ14KLFZ0G
         5sBq+Wn+Tkvc0Caf6+DERmyFPJ56dwxtGj3/qEQ1ZgFZqCFXb63bCmy5OcaCUvWLebKY
         8tpw==
X-Gm-Message-State: AC+VfDwy1ntju0rmB2NMrYr5qxZJn0JMA7EFyE82clrkLzkrYDHpqMHL
        auIOB/FQalMxDmb1qHI5j0YOgk0cDtKUGYp2pnsqL37me2B7
X-Google-Smtp-Source: ACHHUZ62fGel3JvV3b97VGEvnz510J6QrFhycnKM9NFpgsHelTmVfJV6MAZ0tCVCh69RnLHSGfyHchRSOMxgBlVJBMqU8Vv/GYkY
MIME-Version: 1.0
X-Received: by 2002:a92:c110:0:b0:335:146f:9012 with SMTP id
 p16-20020a92c110000000b00335146f9012mr5239488ile.4.1687309607880; Tue, 20 Jun
 2023 18:06:47 -0700 (PDT)
Date:   Tue, 20 Jun 2023 18:06:47 -0700
In-Reply-To: <00000000000073c14105fdf2c0f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdd20305fe996118@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_setsize (2)
From:   syzbot <syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    99ec1ed7c2ed Merge tag '6.4-rc6-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d849b7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1662e03f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141c5260a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f16a44eaf8dd/disk-99ec1ed7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9e8611423fa/vmlinux-99ec1ed7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6127eeba514b/bzImage-99ec1ed7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a39116bf6f18/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5066 at fs/udf/inode.c:673 udf_setsize+0x1092/0x1480 fs/udf/inode.c:1275
Modules linked in:
CPU: 0 PID: 5066 Comm: syz-executor615 Not tainted 6.4.0-rc7-syzkaller-00019-g99ec1ed7c2ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:udf_extend_file fs/udf/inode.c:672 [inline]
RIP: 0010:udf_setsize+0x1092/0x1480 fs/udf/inode.c:1275
Code: 00 00 00 00 fc ff df 74 0a e8 9a ed 8c fe e9 18 ff ff ff 4c 89 64 24 20 e8 8b ed 8c fe 4c 89 fb e9 a7 fd ff ff e8 7e ed 8c fe <0f> 0b e9 1b f6 ff ff 44 89 f9 80 e1 07 38 c1 0f 8c 2b f0 ff ff 4c
RSP: 0018:ffffc90003b5fae0 EFLAGS: 00010293
RAX: ffffffff82fe9222 RBX: 0000000000000200 RCX: ffff8880163c1dc0
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000200
RBP: ffffc90003b5fcd0 R08: ffffffff82fe8820 R09: ffffed100ea634f2
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff9200076bf70
R13: 0000000000000002 R14: 0000000000000009 R15: 0000000000000400
FS:  00007ff22b5e5700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff2232c4718 CR3: 000000002afd3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_setattr+0x370/0x540 fs/udf/file.c:239
 notify_change+0xc8b/0xf40 fs/attr.c:483
 do_truncate+0x220/0x300 fs/open.c:66
 do_sys_ftruncate+0x2e4/0x380 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff22b6395f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff22b5e52f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007ff22b6bf7a0 RCX: 00007ff22b6395f9
RDX: 00007ff22b6395f9 RSI: 0000000000000002 RDI: 0000000000000004
RBP: 00007ff22b68be00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff22b68b208
R13: 00007ff22b68b0c0 R14: 0030656c69662f2e R15: 00007ff22b6bf7a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
