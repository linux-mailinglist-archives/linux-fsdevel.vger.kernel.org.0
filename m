Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AE799CFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjIJHyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjIJHyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:54:10 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A8184
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 00:54:06 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-573d44762e4so3883485a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 00:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694332446; x=1694937246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUcPFhyaiBWRlhiel+UlSDKyPCTkxLTqqHPSvju7blg=;
        b=RUfGuSAbfIB8Y40Unw89TBGA2JBdIOn7KF9uTjvv+xqQ3+zZ4wgHB5sKSba0ml3SPq
         pMT5XOcfYG/NNnV6wYnBqEE5EjlKREeO6jCA8jNr4Tr2SqTgSf6TGjZ1taspDaKjrmEv
         aYi+EKDF9ZL3XZF+LeSvKX9uXtLIzrBF5zS/c/rbJUFqLgOHFDW24lJrt4LFxPhJgEDA
         7y7Tf69JzEixyk/FvhSQPVgm92e5mdFHQ2Htvt+7xO9B8GjuttmjvnGCaP6egNm4wnRP
         m72nwEDtNfLuEX+3Dzfy8XguICv2drnukZrMmYaEecs6YiLEcpYoWAF9twREOUKNz6iB
         +UNA==
X-Gm-Message-State: AOJu0YzUv30nCmPTxGHRJLSqnpsw2ycKGf4u+Lkgkk4X0x8NO6yQxcFq
        asoTXmnJCAFO0sSBtGCPsmhsp8LlDLP8hvFYBJExnd0bd150
X-Google-Smtp-Source: AGHT+IF02V/0dFKoCfCyKLAu+9E/7gMaCF0H5i/F48+I3vumijIcxHLWxE9kSQASj2wzfQT4HyK+XHJMhJudolxatVXFs8dihgq/
MIME-Version: 1.0
X-Received: by 2002:a63:3542:0:b0:564:aeb6:c383 with SMTP id
 c63-20020a633542000000b00564aeb6c383mr1431423pga.1.1694332446146; Sun, 10 Sep
 2023 00:54:06 -0700 (PDT)
Date:   Sun, 10 Sep 2023 00:54:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095887a0604fc8301@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in qd_put
From:   syzbot <syzbot+ac749796740f1d4348bc@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1294ea14680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=ac749796740f1d4348bc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-65d6e954.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cdf5375ab649/vmlinux-65d6e954.xz
kernel image: https://storage.googleapis.com/syzbot-assets/302d058f1d48/bzImage-65d6e954.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac749796740f1d4348bc@syzkaller.appspotmail.com

kernel BUG at fs/gfs2/quota.c:323!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5188 Comm: syz-executor.2 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:qd_put+0x132/0x190 fs/gfs2/quota.c:323
Code: c7 43 70 00 00 00 00 48 8d 73 78 e8 48 7e 1e fe 4c 89 e7 e8 f0 24 9a 06 5b 5d 41 5c 41 5d 41 5e e9 c3 ef e0 fd e8 be ef e0 fd <0f> 0b e8 b7 ef e0 fd 4c 89 e7 e8 cf 07 7a 00 4c 89 e7 e8 c7 24 9a
RSP: 0018:ffffc90004017c30 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff8880269c23f0 RCX: 0000000000000000
RDX: ffff8880164fc800 RSI: ffffffff83a6b442 RDI: 0000000000000005
RBP: 00000000ffffff80 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff80 R11: 0000000000000000 R12: ffff8880269c2420
R13: ffff8880269c2460 R14: ffff8880276aca68 R15: ffff88802441f008
FS:  0000000000000000(0000) GS:ffff88802c600000(0063) knlGS:000000005771d400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7268bb0 CR3: 0000000076871000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_quota_sync+0x44b/0x630 fs/gfs2/quota.c:1350
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:667
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0x109/0x280 fs/sync.c:30
 generic_shutdown_super+0x7e/0x3c0 fs/super.c:666
 kill_block_super+0x3b/0x70 fs/super.c:1646
 gfs2_kill_sb+0x361/0x410 fs/gfs2/ops_fstype.c:1811
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 __do_fast_syscall_32+0x6d/0xe0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fe8579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffd6aa88 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffd6ab30 RCX: 000000000000000a
RDX: 00000000f7353ff4 RSI: 00000000f72a53bd RDI: 00000000ffd6bbd4
RBP: 00000000ffd6ab30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qd_put+0x132/0x190 fs/gfs2/quota.c:323
Code: c7 43 70 00 00 00 00 48 8d 73 78 e8 48 7e 1e fe 4c 89 e7 e8 f0 24 9a 06 5b 5d 41 5c 41 5d 41 5e e9 c3 ef e0 fd e8 be ef e0 fd <0f> 0b e8 b7 ef e0 fd 4c 89 e7 e8 cf 07 7a 00 4c 89 e7 e8 c7 24 9a
RSP: 0018:ffffc90004017c30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880269c23f0 RCX: 0000000000000000
RDX: ffff8880164fc800 RSI: ffffffff83a6b442 RDI: 0000000000000005
RBP: 00000000ffffff80 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff80 R11: 0000000000000000 R12: ffff8880269c2420
R13: ffff8880269c2460 R14: ffff8880276aca68 R15: ffff88802441f008
FS:  0000000000000000(0000) GS:ffff88802c600000(0063) knlGS:000000005771d400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7268bb0 CR3: 0000000076871000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
