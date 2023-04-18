Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE696E59A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDRGrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 02:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjDRGq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:46:58 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ACE6186
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 23:46:53 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-32addcf3a73so65352585ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 23:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681800413; x=1684392413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3ZIjq1GXCHPUU25jt9OZIQwK8cnqKRQjDCwiags6N4=;
        b=jpM5DmjiwIghRXToE/62z8otJSsq6gdfpxaboGmpWHi9o7Hy9VfXBkJvyPrsbeve8E
         FqCUXeugbMusf2vv7Ny/chVpaZiYNh/bj1TNuZm9Nkp8KrZwWE34wuHmMIhyZ+wfwDtJ
         OvTpu1Yke5Ag/6fa41Ld9gtgNxeIoswMr5mTAnTVpULg/rnXVZHpWq7V48N45XsiPgjO
         D0ZQzrLnTL7pZnfH4ZjLdj1mG3XuwEO27bnvFAC8c6u95QtL5q7KgvF3mdo2neX1ZfIv
         6NmvoO4b1Je44kVHkCseroqSrrZ6uPrU0ZTVnCdSoZXfOXNTZ0v0mzbmOESyuEBunIb7
         ZEYg==
X-Gm-Message-State: AAQBX9eAu1o/Fih/Hce/o9nBaWSh3cDH2Pw8/NcY2HOptv172vqBrkXZ
        HRTBuShly6LHGq3R/9weZrWW3hvAvEbd7/CIOznAzEEhznz36n9ILg==
X-Google-Smtp-Source: AKy350bvmMTUr78A64+oGWakzqlEsTx/s4LP+kSj+j5eFI1oms2ySMku4TIk66fvBE+Y6yQoG4XtMHtSZdaKclZvnETpzOpDy+Mg
MIME-Version: 1.0
X-Received: by 2002:a02:a1c1:0:b0:40f:9ab9:c43e with SMTP id
 o1-20020a02a1c1000000b0040f9ab9c43emr858257jah.3.1681800413263; Mon, 17 Apr
 2023 23:46:53 -0700 (PDT)
Date:   Mon, 17 Apr 2023 23:46:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000373fe705f996ac92@google.com>
Subject: [syzbot] [squashfs?] general protection fault in squashfs_page_actor_init_special
From:   syzbot <syzbot+8b3f7f31f049832f24f8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de4664485abb Merge tag 'for-linus-2023041201' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bc4a33c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=8b3f7f31f049832f24f8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44a61f522288/disk-de466448.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d98783cb3e58/vmlinux-de466448.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72cf36ebe961/bzImage-de466448.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b3f7f31f049832f24f8@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 8
SQUASHFS error: Failed to read block 0x4ba: -5
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 16271 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00046-gde4664485abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 23 16 8e ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc90005e865d8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000001000 RCX: 0000000000040000
RDX: ffff88802a419d40 RSI: 0000000000001000 RDI: ffff88802f3596c0
RBP: ffff88802f3596c8 R08: ffffffff825212b3 R09: fffffbfff205b664
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802f359680
R13: 0000000000001000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007fbcca418700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29ab2d7000 CR3: 0000000023f35000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 squashfs_readpage_block+0x634/0xf80 fs/squashfs/file_direct.c:70
 squashfs_read_folio+0x569/0xee0 fs/squashfs/file.c:479
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2424
 filemap_update_page mm/filemap.c:2508 [inline]
 filemap_get_pages+0x15a5/0x20c0 mm/filemap.c:2622
 filemap_read+0x45a/0x1170 mm/filemap.c:2693
 __kernel_read+0x422/0x8a0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xa5b/0x1c00 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x3a7/0x880 security/integrity/ima/ima_api.c:293
 process_measurement+0xfdb/0x1ce0 security/integrity/ima/ima_main.c:341
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:539
 do_open fs/namei.c:3562 [inline]
 path_openat+0x280a/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbcc968c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbcca418168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fbcc97abf80 RCX: 00007fbcc968c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020002a00
RBP: 00007fbcc96e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd54b3d52f R14: 00007fbcca418300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:squashfs_page_actor_init_special+0x20e/0x4c0 fs/squashfs/page_actor.c:128
Code: 00 00 00 49 8d 6c 24 48 48 89 e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 32 02 00 00 c7 45 00 00 00 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 23 16 8e ff 49 8b 2f 48 83 c5 20
RSP: 0018:ffffc90005e865d8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000001000 RCX: 0000000000040000
RDX: ffff88802a419d40 RSI: 0000000000001000 RDI: ffff88802f3596c0
RBP: ffff88802f3596c8 R08: ffffffff825212b3 R09: fffffbfff205b664
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802f359680
R13: 0000000000001000 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007fbcca418700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f822f208fc0 CR3: 0000000023f35000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 49 8d             	add    %cl,-0x73(%rcx)
   5:	6c                   	insb   (%dx),%es:(%rdi)
   6:	24 48                	and    $0x48,%al
   8:	48 89 e8             	mov    %rbp,%rax
   b:	48 c1 e8 03          	shr    $0x3,%rax
   f:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  14:	84 c0                	test   %al,%al
  16:	0f 85 32 02 00 00    	jne    0x24e
  1c:	c7 45 00 00 00 00 00 	movl   $0x0,0x0(%rbp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 23 16 8e ff       	callq  0xff8e165c
  39:	49 8b 2f             	mov    (%r15),%rbp
  3c:	48 83 c5 20          	add    $0x20,%rbp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
