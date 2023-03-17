Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D548F6BDF7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 04:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCQDTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 23:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCQDSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:18:54 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF287BA0D
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 20:17:35 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so1797692ils.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 20:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679023006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+999wz0aGUL3hWoz/oWV9qhCocdvku7jaLZrjOKtgI0=;
        b=ZXhh0X05dstM4fCGdCkaEW9evL2EqCzLdHXmTwmMwlxWTd1dWq/01wlXEBkv1Ibp/m
         zqnHma0/DJdKfdhIo32Qwa1jHG9FMuiWqTbpm5zBBGnRVQWJjRzwSmIBrmSiaNhcEe40
         XWWpia4YQzON3TZabUaHFEHlDir9UGnaTYfi4jGXQX/7RsX8T93osiVTXNz3h2ANJhsd
         FPc3UZpkLjLzovf1aByCnmpDsYaG39K0grJixZRBJyA7RoXmypV39h2b98pnQDhvxbHs
         WC9uyaowngFx8PZDZVefB93RI5bL7lK0WC8XDAQcq6HaHQYRuCI07WJNoLPY5mmFHxvJ
         vYFQ==
X-Gm-Message-State: AO0yUKVQO6XTf+CDrkj71YRnL355Uqji2T71Y2nU0wOFGzejfhY3P/cn
        pPkXXzZMzzwuyyDSPyESl1O+XbgHpi5wmHYrLjeO9IBiyyHk
X-Google-Smtp-Source: AK7set+HkO1TlWh+5TQE/cKbokMqaUb3Ni1nWuUGnedz5v6eZ94gtjB16Np038Pv6zX+W0L7fkEUkF0sNtpaJssJl2scVSpqxu1y
MIME-Version: 1.0
X-Received: by 2002:a02:7315:0:b0:3c5:15d2:9a1c with SMTP id
 y21-20020a027315000000b003c515d29a1cmr580951jab.2.1679023006535; Thu, 16 Mar
 2023 20:16:46 -0700 (PDT)
Date:   Thu, 16 Mar 2023 20:16:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfd6a105f71001d7@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    134231664868 Merge tag 'staging-6.3-rc2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ec9f7ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aef547e348b1ab8
dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:225!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 24186 Comm: syz-executor.2 Not tainted 6.3.0-rc1-syzkaller-00274-g134231664868 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:225
Code: 5f e9 b0 16 5b ff e8 ab 16 5b ff 45 8d 64 2c c4 41 bd 3c 00 00 00 41 29 ed e9 e8 fe ff ff e8 93 16 5b ff 0f 0b e8 8c 16 5b ff <0f> 0b e8 a5 5c ac ff e9 fe fd ff ff 4c 89 ff e8 98 5c ac ff e9 99
RSP: 0018:ffffc900035673c0 EFLAGS: 00010216
RAX: 000000000001158c RBX: ffff88801cbb02b0 RCX: ffffc900031ea000
RDX: 0000000000040000 RSI: ffffffff8228bf04 RDI: 0000000000000006
RBP: 0000000000000048 R08: 0000000000000006 R09: 0000000000000051
R10: 0000000000000048 R11: 0000000000000000 R12: 0000000000000009
R13: 0000000000000051 R14: ffffc90003567460 R15: ffff88801cbb0872
FS:  0000000000000000(0000) GS:ffff88802cb00000(0063) knlGS:00000000f7f53b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020030018 CR3: 00000000487e6000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2a3/0x12f0 fs/ext4/inline.c:766
 ext4_da_write_end+0x396/0x9c0 fs/ext4/inode.c:3149
 generic_perform_write+0x316/0x570 mm/filemap.c:3937
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 call_write_iter include/linux/fs.h:1851 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x743/0xc80 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:1022
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:977
 do_splice_direct+0x1ab/0x280 fs/splice.c:1065
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_compat_sys_sendfile fs/read_write.c:1344 [inline]
 __se_compat_sys_sendfile fs/read_write.c:1327 [inline]
 __ia32_compat_sys_sendfile+0x1e1/0x220 fs/read_write.c:1327
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f58579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f535cc EFLAGS: 00000296 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 0000000080000041 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:225
Code: 5f e9 b0 16 5b ff e8 ab 16 5b ff 45 8d 64 2c c4 41 bd 3c 00 00 00 41 29 ed e9 e8 fe ff ff e8 93 16 5b ff 0f 0b e8 8c 16 5b ff <0f> 0b e8 a5 5c ac ff e9 fe fd ff ff 4c 89 ff e8 98 5c ac ff e9 99
RSP: 0018:ffffc900035673c0 EFLAGS: 00010216
RAX: 000000000001158c RBX: ffff88801cbb02b0 RCX: ffffc900031ea000
RDX: 0000000000040000 RSI: ffffffff8228bf04 RDI: 0000000000000006
RBP: 0000000000000048 R08: 0000000000000006 R09: 0000000000000051
R10: 0000000000000048 R11: 0000000000000000 R12: 0000000000000009
R13: 0000000000000051 R14: ffffc90003567460 R15: ffff88801cbb0872
FS:  0000000000000000(0000) GS:ffff88802cb00000(0063) knlGS:00000000f7f53b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020030018 CR3: 00000000487e6000 CR4: 0000000000150ee0
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
  2b:	c3                   	retq
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
