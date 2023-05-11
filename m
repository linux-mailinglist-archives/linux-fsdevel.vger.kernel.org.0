Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EA6FF320
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjEKNhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjEKNgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 09:36:14 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6A106C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 06:35:00 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3358657b57aso53757135ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 06:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812100; x=1686404100;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEtKPqXPc8KwjQyplWNpVUtXydk8COJxQKJbi5Nsyvo=;
        b=guspJRXj1S4E8oOEdt5n8uduzj8gTSrDxuAiEf5kNvuDMddgvIAPxG6IG1HtDOSuwm
         EfuKKn09oyu4OQ0GH8y6elJ9+jxac92pKl2xOmudsbl0tFE/CrtkUIZOBzdfSioU5Up8
         EqiI5aflCZfWfYUsEyG9flmzo2tEg9fyN7vNOuuxnV+UsZ5M5TSx5tcMCS1REiueklzK
         r+af8N17ydFNjTDEIG1KL1kdjw1Hz3yXM5pfPsaO5ALM5xufgyxY81ObIPA4a6wuAwc6
         PMsVi/7QIvQ4s7/qwixElWuJQrbQ8cSd6cRnAzd6cDKuhzXDIOSqNR3jiLf1fIE7AwfW
         kskg==
X-Gm-Message-State: AC+VfDy89ABGqX9NEVoT5jSZg45fU05wkZ/QEIG+6ASuDVjCYk7PZ42o
        /vB8FqTYlcZNNhOQAeuu60qMc/eUKjNG+rVWtxUk4cj48qHW
X-Google-Smtp-Source: ACHHUZ6qcDTWku63SrxWIveG39qSJbRmc55sb0oQ/h2PLZ3REUH9VGDGcu3/x5ZFjx4lgB+7xhDtRaP1O9WIbEodeikrbJCfID09
MIME-Version: 1.0
X-Received: by 2002:a92:c686:0:b0:317:9096:e80f with SMTP id
 o6-20020a92c686000000b003179096e80fmr11324593ilg.4.1683812100231; Thu, 11 May
 2023 06:35:00 -0700 (PDT)
Date:   Thu, 11 May 2023 06:35:00 -0700
In-Reply-To: <000000000000602c0e05f55d793c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a583a05fb6b0e76@google.com>
Subject: Re: [syzbot] [ntfs?] kernel BUG in ntfs_iget
From:   syzbot <syzbot+d62e6bd2a2d05103d105@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    d295b66a7b66 Merge tag 'fsnotify_for_v6.4-rc2' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1438109e280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba9dec280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef95fa280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95f1878df2f4/disk-d295b66a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d18d65ddcb5/vmlinux-d295b66a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a59b1fdff8e/bzImage-d295b66a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eee641006b52/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d62e6bd2a2d05103d105@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 190
ntfs: (device loop0): is_boot_sector_ntfs(): Invalid boot sector checksum.
ntfs: (device loop0): map_mft_record_page(): Mft record 0x1 is corrupt.  Run chkdsk.
ntfs: (device loop0): map_mft_record(): Failed with error code 5.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0x1 as bad.  Run chkdsk.
ntfs: (device loop0): load_system_files(): Failed to load $MFTMirr.  Mounting read-only.  Run ntfsfix and/or chkdsk.
------------[ cut here ]------------
kernel BUG at fs/ntfs/malloc.h:31!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4993 Comm: syz-executor320 Not tainted 6.4.0-rc1-syzkaller-00025-gd295b66a7b66 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:__ntfs_malloc fs/ntfs/malloc.h:31 [inline]
RIP: 0010:ntfs_malloc_nofs+0xfd/0x100 fs/ntfs/malloc.h:52
Code: 17 e8 d7 1e c7 fe 48 89 df be 42 0c 00 00 5b 41 5e 41 5f e9 a5 f2 10 ff e8 c0 1e c7 fe 31 c0 5b 41 5e 41 5f c3 e8 b3 1e c7 fe <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 49 89 fe 49 bc
RSP: 0018:ffffc90003a3f818 EFLAGS: 00010293
RAX: ffffffff82c4488d RBX: 0000000000000000 RCX: ffff88802476bb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888073a05118 R08: ffffffff82c447bd R09: ffffed100e9c5323
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff888074e29be0 R14: ffff888073a05147 R15: dffffc0000000000
FS:  000055555752e300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f02336e6000 CR3: 000000007a170000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_read_locked_inode+0x1fd5/0x49c0 fs/ntfs/inode.c:703
 ntfs_iget+0x113/0x190 fs/ntfs/inode.c:177
 load_and_init_upcase fs/ntfs/super.c:1663 [inline]
 load_system_files+0x151c/0x4840 fs/ntfs/super.c:1818
 ntfs_fill_super+0x19b3/0x2bd0 fs/ntfs/super.c:2900
 mount_bdev+0x274/0x3a0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f023bb1cafa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffebbdb6c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f023bb1cafa
RDX: 000000002001f1c0 RSI: 000000002001f200 RDI: 00007fffebbdb6e0
RBP: 00007fffebbdb6e0 R08: 00007fffebbdb720 R09: 0000000000000987
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 000055555752e2c0 R14: 0000000000000000 R15: 00007fffebbdb720
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__ntfs_malloc fs/ntfs/malloc.h:31 [inline]
RIP: 0010:ntfs_malloc_nofs+0xfd/0x100 fs/ntfs/malloc.h:52
Code: 17 e8 d7 1e c7 fe 48 89 df be 42 0c 00 00 5b 41 5e 41 5f e9 a5 f2 10 ff e8 c0 1e c7 fe 31 c0 5b 41 5e 41 5f c3 e8 b3 1e c7 fe <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 49 89 fe 49 bc
RSP: 0018:ffffc90003a3f818 EFLAGS: 00010293
RAX: ffffffff82c4488d RBX: 0000000000000000 RCX: ffff88802476bb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888073a05118 R08: ffffffff82c447bd R09: ffffed100e9c5323
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff888074e29be0 R14: ffff888073a05147 R15: dffffc0000000000
FS:  000055555752e300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f02336e6000 CR3: 000000007a170000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
