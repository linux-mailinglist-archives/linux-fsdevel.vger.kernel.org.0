Return-Path: <linux-fsdevel+bounces-3816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A363C7F8B9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554B028150F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E065156C6;
	Sat, 25 Nov 2023 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858A3BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 06:24:25 -0800 (PST)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5bd26ef66d1so3361207a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 06:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700922265; x=1701527065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXCbPAf7T2ScsNNwSDLwLbG1GUeM6C+sPVZgAsEMbGI=;
        b=FUUlLHbCk5rKIFbf9GHPbTbtlEvhRtFMGlGdEGBvkbxAo6EMl7C950Wkg/LyjVUCQd
         z5zHseFk0UBuqqxoCglWTnFi8FE06PoKl6jdxm2fIcockuQ+op4GSRZBfJMpiMDHtZoI
         vYJLkw50zFt+GfYlWWMyl68hTMHI7TzlMrqoNuATJ73oqNi3ZG0AaY4N3B4t6zjiV0qN
         fLbfDpZWXfbe6cgMGyZK3UjsfStWMa5GrgmcRMwLiA0J7e9DLSaovFrTRI0ulxBOvjWa
         M3nNdJ2xPTbyvDy0BB/T7bK/76Zxza9ZdO+W358/DZgYlzZ633POaHl5vman8cv6Tjn9
         KluQ==
X-Gm-Message-State: AOJu0YwVhYKMf1F7EElWVxQrQHjwLVScWXpMY2swRMxffS+BR+aZVo+s
	irPZlBdWD3eUCuSsR+8AdaI4Fth6uWheXNT7nVwNJO3+IOzY
X-Google-Smtp-Source: AGHT+IEZ+gCU8CHWIqxJwVd+KAlJMLfLiCcqYB9PMZ/WDmwSS8UQARU7tiRQawIOmWUTmsuSTKUgQVJze1bjLg1aAgyZbb1VoY1E
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:1220:0:b0:5c2:2f9:c374 with SMTP id
 h32-20020a631220000000b005c202f9c374mr972750pgl.9.1700922264990; Sat, 25 Nov
 2023 06:24:24 -0800 (PST)
Date: Sat, 25 Nov 2023 06:24:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000653bb6060afad327@google.com>
Subject: [syzbot] [bfs?] general protection fault in bfs_get_block (2)
From: syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1427ba00e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6ed11a88fb40d6e184
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16783b84e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165172a0e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b60687e82ad4/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29477f0b04df/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aab12888a60/bzImage-98b1cc82.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/58e57ae1d84f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com

Code: Unable to access opcode bytes at 0xffffffffffffffd6.
general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 PID: 5059 Comm: syz-executor306 Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:bfs_move_block fs/bfs/file.c:42 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:56 [inline]
RIP: 0010:bfs_get_block+0x3b2/0xeb0 fs/bfs/file.c:125
Code: a8 ff 48 8d 7d 20 48 89 c3 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 5b 08 00 00 48 8d 7b 28 48 8b 55 20 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 dd 08 00 00 48 8d 7d 28 48 8b 43 28 48 89 f9
RSP: 0018:ffffc900033fef30 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffffff81fd2b77
RDX: 0000000000000200 RSI: ffffffff81fd2e15 RDI: 0000000000000028
RBP: ffff888074ee20e8 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffa R11: 0000000000000003 R12: 0000000000000019
R13: dffffc0000000000 R14: ffff88807fb36000 R15: ffffed100ff66c2c
FS:  0000555556c24380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6250121b3b CR3: 000000001f25d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __block_write_begin_int+0x3c0/0x1560 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2227
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:177
 generic_perform_write+0x278/0x600 mm/filemap.c:3918
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4013
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4039
 __kernel_write_iter+0x261/0x7b0 fs/read_write.c:517
 __kernel_write+0xf6/0x140 fs/read_write.c:537
 __dump_emit fs/coredump.c:813 [inline]
 dump_emit+0x21d/0x330 fs/coredump.c:850
 writenote+0x215/0x2b0 fs/binfmt_elf.c:1422
 write_note_info fs/binfmt_elf.c:1897 [inline]
 elf_core_dump+0x250c/0x3900 fs/binfmt_elf.c:2064
 do_coredump+0x2c97/0x3fd0 fs/coredump.c:764
 get_signal+0x2438/0x2790 kernel/signal.c:2890
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xa/0x40 kernel/entry/common.c:309
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000000020000008 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 0000000000000020 RCX: 00007f3fa02f7db9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffdb733b1e8 R14: 0000000000000001 R15: 00007ffdb733afb0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bfs_move_block fs/bfs/file.c:42 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:56 [inline]
RIP: 0010:bfs_get_block+0x3b2/0xeb0 fs/bfs/file.c:125
Code: a8 ff 48 8d 7d 20 48 89 c3 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 5b 08 00 00 48 8d 7b 28 48 8b 55 20 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 dd 08 00 00 48 8d 7d 28 48 8b 43 28 48 89 f9
RSP: 0018:ffffc900033fef30 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffffff81fd2b77
RDX: 0000000000000200 RSI: ffffffff81fd2e15 RDI: 0000000000000028
RBP: ffff888074ee20e8 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffa R11: 0000000000000003 R12: 0000000000000019
R13: dffffc0000000000 R14: ffff88807fb36000 R15: ffffed100ff66c2c
FS:  0000555556c24380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001f25d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a8 ff                	test   $0xff,%al
   2:	48 8d 7d 20          	lea    0x20(%rbp),%rdi
   6:	48 89 c3             	mov    %rax,%rbx
   9:	48 89 f8             	mov    %rdi,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  15:	0f 85 5b 08 00 00    	jne    0x876
  1b:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
  1f:	48 8b 55 20          	mov    0x20(%rbp),%rdx
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 dd 08 00 00    	jne    0x912
  35:	48 8d 7d 28          	lea    0x28(%rbp),%rdi
  39:	48 8b 43 28          	mov    0x28(%rbx),%rax
  3d:	48 89 f9             	mov    %rdi,%rcx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

