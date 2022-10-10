Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24A35F9A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiJJHkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiJJHkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:12 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C404913D12
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:39 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id e15-20020a5d8acf000000b006a3ed059e49so6857508iot.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o39KLSThBBbmlQ5+WSluDQ+kcELYKm+g5hCqRRwqeLo=;
        b=K1wzqEgQpyAzOiBGk97ouafWb7g0hGxz2jRC2r2ExjNNFEaX0qFOGYi964jSGSNd08
         Padln5yxJepXYQFGXtkWXmfNbqYPSgT2DLeBa6bp4IB6X2nW0WozIzJc0FLqzVQCRE4X
         wU0/pfM8juXocKWD1EEzPP/atOya/lLMDzSHgVMb+flxfHeugxyH7Ir1ItiirstsWKzO
         aFua0bSE89c8YYCI4DPFSeCxagkvUV5BdMfVyMM/jbfoLGJemNOhMW5GoF+lxQdn3orh
         5mF2XzYK6p+7knBstX+t/oi57CamidfKoSRICuGBfl2V/5SPfxgqQ1hBcvNJWaKTXt0c
         AlBA==
X-Gm-Message-State: ACrzQf37s3gjjwRi4xj9FAEzYILZVpkT6aOeUas/6XUCvkGkFauZU/nV
        t3JVXaP+ulKR+Sp8q1oQC/ACwUO3+kD+hgpOQOnfYFdN1dXf
X-Google-Smtp-Source: AMsMyM4fD4hugt6s2Z6FVogp+vD1Gcy+Q7JqMnvi1uk1DT1NEwRKRRXLX6Vnan+ABO3ch+OSW5upoJfcVOM9eJumyAtx00a4W7TI
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d15:b0:6a4:e07e:6c54 with SMTP id
 c21-20020a0566022d1500b006a4e07e6c54mr7903800iow.26.1665387339097; Mon, 10
 Oct 2022 00:35:39 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:35:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2ac0405eaa934f3@google.com>
Subject: [syzbot] general protection fault in __d_add
From:   syzbot <syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com>
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

HEAD commit:    62e6e5940c0c Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14595c78880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c13637ccca17699
dashboard link: https://syzkaller.appspot.com/bug?extid=a8f26a403c169b7593fe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4f4f04cf38f/disk-62e6e594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb013b64867/vmlinux-62e6e594.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 13342 Comm: syz-executor.4 Not tainted 6.0.0-syzkaller-07362-g62e6e5940c0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 ea c0 ea ff 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c4 c0 ea ff 48 83 3b 00 0f 85 b7 01
RSP: 0018:ffffc90008b97870 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: ffff88807e593b00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888030aa6232 R08: ffffffff81ef71d9 R09: ffff888075fb02a0
R10: ffffed100ebf6056 R11: 1ffff1100ebf6054 R12: 0000000000000008
R13: 1ffff11006154c46 R14: ffff888075fb0178 R15: 0000000000008000
FS:  00007f9fb9bfe700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9fbadad0b0 CR3: 00000000753d7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 d_splice_alias+0x122/0x3b0 fs/dcache.c:3191
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9fbac8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9fb9bfe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f9fbadabf80 RCX: 00007f9fbac8a5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007f9fbace5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd04dd2b0f R14: 00007f9fb9bfe300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 ea c0 ea ff 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c4 c0 ea ff 48 83 3b 00 0f 85 b7 01
RSP: 0018:ffffc90008b97870 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: ffff88807e593b00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888030aa6232 R08: ffffffff81ef71d9 R09: ffff888075fb02a0
R10: ffffed100ebf6056 R11: 1ffff1100ebf6054 R12: 0000000000000008
R13: 1ffff11006154c46 R14: ffff888075fb0178 R15: 0000000000008000
FS:  00007f9fb9bfe700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9fbadad0b0 CR3: 00000000753d7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 ea c0 ea ff       	callq  0xffeac0f8
   e:	48 8b 1b             	mov    (%rbx),%rbx
  11:	48 83 c3 08          	add    $0x8,%rbx
  15:	48 89 d8             	mov    %rbx,%rax
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  23:	fc ff df
* 26:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2a:	74 08                	je     0x34
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 c4 c0 ea ff       	callq  0xffeac0f8
  34:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  38:	0f                   	.byte 0xf
  39:	85                   	.byte 0x85
  3a:	b7 01                	mov    $0x1,%bh


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
