Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59E63F2C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiLAOZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 09:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLAOZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:25:38 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCFA8FC0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 06:25:36 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so2081114ila.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 06:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2miDlS0xQ1Yf7wqvRTqBCgWxay5ISRT2GvN76D7MvCM=;
        b=MSU4HBXMz/TtbXIxpBQnKKb8nfNc3+klaerjtlxwcM755BK+U14T8u6gwSqd1k3lHU
         T6Lo+ayObSdgWLx2u/PXzPIX8zvD4t8Yko8dag4PexwDrb9FHcn9d3CSdq2ZQ6InrH3U
         wM9NEeG2IT3uneZyHumOlsRZrwi1Y5LazTbgpDVRuTAWwhP+L2S1ZRLNTBCWxQejMt7z
         SxuNcoXvSOMLJ+ihvIuvU6THuoNWhmDftN2szy4PTcM+3kqxmcCDeMyJcClp9eqe+xj5
         FCvYTEEBIdlZXRh0nyBB/yXufVOsUxw4v7JZcg7YvToHKSWyrWQjC+HK/PtGnCIhJlU5
         kg5g==
X-Gm-Message-State: ANoB5plvLKRmbBYVWSXfwS7JybwG4q/WYzJTXd/+9YgPAEjv1K1TZCsi
        +MXCwfLqiBSy0yPm6Rekiw4EwR7OXUekoo3mm9fRwngRLl5N
X-Google-Smtp-Source: AA0mqf4qXpZW+6CJl/ZO83Z+Hr1LStFdXCgVyj6NCx8/Rgn/tP6yFXT1qzIyXPZvDky4zBfKNR1f6ISiHQlmy8hC9Lz8aPfywiQw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d:b0:38a:4e1:7b52 with SMTP id
 z13-20020a056638000d00b0038a04e17b52mr3413887jao.3.1669904735959; Thu, 01 Dec
 2022 06:25:35 -0800 (PST)
Date:   Thu, 01 Dec 2022 06:25:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098830505eec4fe41@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in path_openat
From:   syzbot <syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com>
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

HEAD commit:    cf562a45a0d5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147339bb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=59a66cac604a6b49ecce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a92dc058341/disk-cf562a45.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c320c2307225/vmlinux-cf562a45.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00049e41b3c5/bzImage-cf562a45.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59a66cac604a6b49ecce@syzkaller.appspotmail.com

REISERFS (device loop4): Using r5 hash to sort names
REISERFS (device loop4): Created .reiserfs_priv - reserved for xattr storage.
BUG: unable to handle page fault for address: fffffbfff8000014
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 13823 Comm: syz-executor.4 Not tainted 6.1.0-rc6-syzkaller-00375-gcf562a45a0d5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__d_entry_type include/linux/dcache.h:385 [inline]
RIP: 0010:d_can_lookup include/linux/dcache.h:400 [inline]
RIP: 0010:d_is_dir include/linux/dcache.h:410 [inline]
RIP: 0010:do_open fs/namei.c:3533 [inline]
RIP: 0010:path_openat+0x213e/0x2df0 fs/namei.c:3714
Code: ff ff e8 05 d2 99 ff 4c 8b 74 24 18 48 8b 44 24 70 42 80 3c 20 00 74 08 4c 89 f7 e8 ac eb ed ff 4d 8b 36 4c 89 f0 48 c1 e8 03 <42> 8a 04 20 84 c0 0f 85 9e 09 00 00 bb 00 00 60 00 41 23 1e bf 00
RSP: 0018:ffffc9000328f920 EFLAGS: 00010a06
RAX: 1ffffffff8000014 RBX: 0000000000000042 RCX: 0000000000040000
RDX: ffffc90003fb2000 RSI: 000000000000500f RDI: 0000000000005010
RBP: ffffc9000328fb50 R08: ffffffff81f0c583 R09: fffffbfff1cebdfe
R10: fffffbfff1cebdfe R11: 1ffffffff1cebdfd R12: dffffc0000000000
R13: ffffc9000328fba0 R14: ffffffffc00000a3 R15: ffffc9000328fda0
FS:  00007f4c5c8c5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff8000014 CR3: 000000001e588000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4c5ba8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c5c8c5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4c5bbabf80 RCX: 00007f4c5ba8c0d9
RDX: 000000000000275a RSI: 0000000020000140 RDI: ffffffffffffff9c
RBP: 00007f4c5bae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd5f5636f R14: 00007f4c5c8c5300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: fffffbfff8000014
---[ end trace 0000000000000000 ]---
RIP: 0010:__d_entry_type include/linux/dcache.h:385 [inline]
RIP: 0010:d_can_lookup include/linux/dcache.h:400 [inline]
RIP: 0010:d_is_dir include/linux/dcache.h:410 [inline]
RIP: 0010:do_open fs/namei.c:3533 [inline]
RIP: 0010:path_openat+0x213e/0x2df0 fs/namei.c:3714
Code: ff ff e8 05 d2 99 ff 4c 8b 74 24 18 48 8b 44 24 70 42 80 3c 20 00 74 08 4c 89 f7 e8 ac eb ed ff 4d 8b 36 4c 89 f0 48 c1 e8 03 <42> 8a 04 20 84 c0 0f 85 9e 09 00 00 bb 00 00 60 00 41 23 1e bf 00
RSP: 0018:ffffc9000328f920 EFLAGS: 00010a06
RAX: 1ffffffff8000014 RBX: 0000000000000042 RCX: 0000000000040000
RDX: ffffc90003fb2000 RSI: 000000000000500f RDI: 0000000000005010
RBP: ffffc9000328fb50 R08: ffffffff81f0c583 R09: fffffbfff1cebdfe
R10: fffffbfff1cebdfe R11: 1ffffffff1cebdfd R12: dffffc0000000000
R13: ffffc9000328fba0 R14: ffffffffc00000a3 R15: ffffc9000328fda0
FS:  00007f4c5c8c5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff8000014 CR3: 000000001e588000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	e8 05 d2 99 ff       	callq  0xff99d20a
   5:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
   a:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
   f:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  14:	74 08                	je     0x1e
  16:	4c 89 f7             	mov    %r14,%rdi
  19:	e8 ac eb ed ff       	callq  0xffedebca
  1e:	4d 8b 36             	mov    (%r14),%r14
  21:	4c 89 f0             	mov    %r14,%rax
  24:	48 c1 e8 03          	shr    $0x3,%rax
* 28:	42 8a 04 20          	mov    (%rax,%r12,1),%al <-- trapping instruction
  2c:	84 c0                	test   %al,%al
  2e:	0f 85 9e 09 00 00    	jne    0x9d2
  34:	bb 00 00 60 00       	mov    $0x600000,%ebx
  39:	41 23 1e             	and    (%r14),%ebx
  3c:	bf                   	.byte 0xbf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
