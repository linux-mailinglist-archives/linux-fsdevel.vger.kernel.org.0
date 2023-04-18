Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA236E5F48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 13:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDRLEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRLEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:04:48 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA044B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 04:04:46 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7606d455e4cso476118239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 04:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681815886; x=1684407886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlJ5emJe9Z4EQ3vuIj9HxGmuBXyF49i+IhR55CYXeMo=;
        b=BrQr/TjpqzimgRs/qeITrWoVw1FoKTMSj7h6bXwdVL+3e9o3QgS6i0nbolWRTmtPFQ
         VhwiWifok7MASLBCU8uVEPfdboFMXyj2XbEHhQzZ1l0FR3bzgiEMqnadZEm2cC2E5vCp
         578OmQsucx14eV5KoTjuQ/PF7Ni110WFi3UiPwqhzmG5+jDqD0+deg1sihBcS8lcOvxo
         Xh1+UdBRkcKbg2p8/x7Urnv26V8qaUTDaFQ/LRVO9XpbbfNsgxmjl8jgE2pioioCpaiA
         3EBmtGdEhfWVjZX0x2CiHk6sUQLciYGP13vkZ86sMXdjEhd7Lfp83yYOgtottwWPMTtv
         gbkg==
X-Gm-Message-State: AAQBX9c1jXatxQMyqKj9bTZaZLRMEEMWJwYxbPBAFxQyYv3OtSnnQHFB
        bY8+wzWWM0Y/L1uw/23V2ClCJOBQ7k0ynDh+199XLUl3qC8D
X-Google-Smtp-Source: AKy350axwh0zVYk7nmeGYiiC2CPgUtunmZSEmOCvPG9Fl0AHbaGF1T8isxd5gJhb/6LdkbbEIvSxf+ol62mRyEfgK9VeploLFYFj
MIME-Version: 1.0
X-Received: by 2002:a02:7a50:0:b0:40b:d54d:e5bf with SMTP id
 z16-20020a027a50000000b0040bd54de5bfmr1147402jad.1.1681815885805; Tue, 18 Apr
 2023 04:04:45 -0700 (PDT)
Date:   Tue, 18 Apr 2023 04:04:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000739c9f05f99a46d7@google.com>
Subject: [syzbot] [fs?] [mm?] general protection fault in folio_wait_stable
From:   syzbot <syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

Hello,

syzbot found the following issue on:

HEAD commit:    4aa1da8d9972 Add linux-next specific files for 20230417
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b08dc0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e1a2e42c883f5b6
dashboard link: https://syzkaller.appspot.com/bug?extid=d1ae544e6e9dc29bcba5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0beda3b66b40/disk-4aa1da8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a7cd9f14ca57/vmlinux-4aa1da8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48453a9c6a60/bzImage-4aa1da8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com

RSP: 002b:00007f963cd4d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f963c1abf80 RCX: 00007f963c08c169
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007f963cd4d1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000001dd03 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd7ae18d4f R14: 00007f963cd4d300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 18742 Comm: syz-executor.5 Not tainted 6.3.0-rc7-next-20230417-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:folio_inode include/linux/pagemap.h:400 [inline]
RIP: 0010:folio_wait_stable+0x23/0xe0 mm/page-writeback.c:3132
Code: 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 48 89 fd 53 e8 a2 92 d1 ff 48 8d 7d 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a4 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc9000316f488 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88803e265cb0 RCX: ffffc9000c002000
RDX: 0000000000000001 RSI: ffffffff81b1f0ee RDI: 000000000000000c
RBP: fffffffffffffff4 R08: 0000000000000001 R09: ffffffff8c8eef13
R10: fffffbfff191dde2 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88803e265ed8 R14: 0000000000002000 R15: ffff88803e265a50
FS:  00007f963cd4d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f668b534110 CR3: 000000006ca4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_da_write_begin+0x47f/0x8b0 fs/ext4/inode.c:2939
 generic_perform_write+0x256/0x570 mm/filemap.c:3927
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 call_write_iter include/linux/fs.h:1854 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x185/0x7e0 fs/read_write.c:860
 vfs_iter_write+0x74/0xa0 fs/read_write.c:901
 iter_file_splice_write+0x745/0xc80 fs/splice.c:761
 do_splice_from fs/splice.c:839 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:1018
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:973
 do_splice_direct+0x1ab/0x280 fs/splice.c:1061
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f963c08c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f963cd4d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f963c1abf80 RCX: 00007f963c08c169
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007f963cd4d1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000001dd03 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd7ae18d4f R14: 00007f963cd4d300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_inode include/linux/pagemap.h:400 [inline]
RIP: 0010:folio_wait_stable+0x23/0xe0 mm/page-writeback.c:3132
Code: 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 48 89 fd 53 e8 a2 92 d1 ff 48 8d 7d 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a4 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc9000316f488 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88803e265cb0 RCX: ffffc9000c002000
RDX: 0000000000000001 RSI: ffffffff81b1f0ee RDI: 000000000000000c
RBP: fffffffffffffff4 R08: 0000000000000001 R09: ffffffff8c8eef13
R10: fffffbfff191dde2 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88803e265ed8 R14: 0000000000002000 R15: ffff88803e265a50
FS:  00007f963cd4d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32724000 CR3: 000000006ca4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 40 00          	nopl   0x0(%rax)
   6:	f3 0f 1e fa          	endbr64
   a:	55                   	push   %rbp
   b:	48 89 fd             	mov    %rdi,%rbp
   e:	53                   	push   %rbx
   f:	e8 a2 92 d1 ff       	callq  0xffd192b6
  14:	48 8d 7d 18          	lea    0x18(%rbp),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 a4 00 00 00    	jne    0xd7
  33:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3a:	fc ff df
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
