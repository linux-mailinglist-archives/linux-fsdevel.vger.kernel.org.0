Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B35F1C89
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 15:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJANuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJANum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:50:42 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00862917
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Oct 2022 06:50:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id w2-20020a056e021c8200b002f5c95226e0so5423627ill.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Oct 2022 06:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CmWVkptbWxqSVuBTRjD4ZZJJO96WLGFnefimyWCUh4k=;
        b=aPdaBtYk2f51Osy2a1RiH5LuLrqMM620enqMfIdT8XOgHivPQ07jK4eP3T9CAVW62y
         8KH2EuUvVvpglqeDZuYwg4kKFMHXTPj6mDkNIGAlnqaoZplLsLgEGBpXDOxCemnjFLf+
         Tf+nE1EWpfZ7fZ0JQAPKa4hLlzBegBBV4Di5gvLRChacuHVPyqEnoayGbBZFvo2P2Sa5
         LpRq6YrkWfiQz+aC5i2ACxoL6GBSuwSx0mbHLUT6RCcsQaTOqmd6Z4DXnN6/4nd1UUV5
         zNyXhxKuyABK8UOaFYSaqG0UpnyHpWJoQQNYRAK5kObyeZBPJ8/Df+cLj9ueKHTOPZnt
         Qrvw==
X-Gm-Message-State: ACrzQf0CchfUnzKKqP7ouLXFfIG/IvrWCKrZwtC6qJEum2X8wT3TvyGT
        5VMw1YFA/ZfDsUQV/ImnCTvOzE36/9GVayaT2kRx66NhSz6A
X-Google-Smtp-Source: AMsMyM4lEBaMgdJs7sKnei/5LTeWt5kmQxxO2E2fA0vkampdzRxybZhVmcrEQFPA0EVG2l+7rtYzk/SjgFjpgzEvS8UaF/DrNc8k
MIME-Version: 1.0
X-Received: by 2002:a05:6638:471b:b0:35a:9a34:40b9 with SMTP id
 cs27-20020a056638471b00b0035a9a3440b9mr7047583jab.307.1664632238630; Sat, 01
 Oct 2022 06:50:38 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:50:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043f31305e9f965f6@google.com>
Subject: [syzbot] WARNING in __find_get_block
From:   syzbot <syzbot+250b054f84ffcf12d7f1@syzkaller.appspotmail.com>
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

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bbbb9c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=250b054f84ffcf12d7f1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+250b054f84ffcf12d7f1@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 brelse include/linux/buffer_head.h:327 [inline]
WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 bh_lru_install fs/buffer.c:1259 [inline]
WARNING: CPU: 1 PID: 6477 at fs/buffer.c:1145 __find_get_block+0xfe9/0x1110 fs/buffer.c:1309
Modules linked in:
CPU: 0 PID: 6477 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__brelse fs/buffer.c:1145 [inline]
RIP: 0010:brelse include/linux/buffer_head.h:327 [inline]
RIP: 0010:bh_lru_install fs/buffer.c:1259 [inline]
RIP: 0010:__find_get_block+0xfe9/0x1110 fs/buffer.c:1309
Code: 8e ff e8 5a f5 94 ff fb e9 02 f3 ff ff e8 5f 48 8e ff e9 f8 f2 ff ff e8 55 48 8e ff 48 c7 c7 a0 9a 9d 8a 31 c0 e8 27 d5 56 ff <0f> 0b e9 de f2 ff ff 44 89 f9 80 e1 07 38 c1 0f 8c a1 f3 ff ff 4c
RSP: 0018:ffffc90004a9f880 EFLAGS: 00010246
RAX: 533f0fab2aa63200 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900054e9000 RSI: 000000000000bd65 RDI: 000000000000bd66
RBP: ffffc90004a9f9e0 R08: ffffffff816bd38d R09: ffffed1017364f14
R10: ffffed1017364f14 R11: 1ffff11017364f13 R12: 1ffff11017366bae
R13: ffff8880292d6828 R14: ffff88802901ee80 R15: ffff8880290195d0
FS:  00007fc26c747700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110f33724b CR3: 000000007c6dd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __getblk_gfp+0x2d/0x290 fs/buffer.c:1329
 sb_getblk include/linux/buffer_head.h:363 [inline]
 fat_zeroed_cluster+0x18b/0x8c0 fs/fat/dir.c:1092
 fat_alloc_new_dir+0x7c6/0xc90 fs/fat/dir.c:1185
 vfat_mkdir+0x15a/0x410 fs/fat/namei_vfat.c:859
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc26b68a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc26c747168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fc26b7abf80 RCX: 00007fc26b68a5a9
RDX: 0000000000000004 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007fc26b6e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd6d66b0f R14: 00007fc26c747300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
