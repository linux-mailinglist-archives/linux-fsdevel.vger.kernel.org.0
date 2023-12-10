Return-Path: <linux-fsdevel+bounces-5424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780980B95D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DD41C2090F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC23522B;
	Sun, 10 Dec 2023 06:40:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C811D
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Dec 2023 22:40:21 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb2b95e667so6415428fac.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Dec 2023 22:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702190421; x=1702795221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFFwRy2N/0G7JtfDFizFJ6sDME0Agg87dHPC6Ukv4hA=;
        b=sIZaCEsDFklCY0gQg82PHk9pLkg8fBZbVAviXCKtYkqyhD4GPXA12K0ai13Q3u02VV
         Ye+9DL4lcl0jI5uRzUSyU6UI6W08xAYS/7ySX1x1mlQAde7B47WdxlUhIk8RV4EIx3k6
         TrqDR/HYwlOj90/97e8rSNMCZ3lnanjrgfHJ/TW43amQYnANBTOUWpWnDmuJ0Vj+INye
         yCxRKuDCwqJWhbIzLNg8rQSRCvBp1cD22gYqBAifVHX811vr6KydLJxqKWB0bQG5b5yD
         9KAFPArPIrZp213E1TBxLu+eLpIutVJEe2ysPdVmdxseS0JB2Vwiryt2Z/tVbRgjVYy5
         gdSQ==
X-Gm-Message-State: AOJu0Yxb82NDUOAGcbYxt1JWdVlPz8BMtftbmIuZAHR1fREyn0xDFKSj
	9OkLI7OVHHTCjEenkGieVEmSTvwNCFuavCZH7+srUJUUKZ2W
X-Google-Smtp-Source: AGHT+IGCIyoxMIK1pCg+Sf7WO5ZlCiJNt87mIJLCEcZMeArss0IgicVboiTl5pslJEOrUZg0to1SjbN+qQuRVEqyia8ytryejc1/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5214:b0:1fa:f432:231 with SMTP id
 ht20-20020a056871521400b001faf4320231mr3318822oac.3.1702190421024; Sat, 09
 Dec 2023 22:40:21 -0800 (PST)
Date: Sat, 09 Dec 2023 22:40:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062a4cc060c2217de@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diNewExt
From: syzbot <syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1088351ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=553d90297e6d2f50dbc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122acc3ce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110a49b4e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af357ba4767f/disk-bee0e776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae4d50206171/vmlinux-bee0e776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e12203376a9f/bzImage-bee0e776.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d8974c833f6f/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133caf54e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bcaf54e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=173caf54e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:2360:2
index -878706688 is out of range for type 'struct iagctl[128]'
CPU: 1 PID: 5065 Comm: syz-executor282 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 diNewExt+0x3cf3/0x4000 fs/jfs/jfs_imap.c:2360
 diAllocExt fs/jfs/jfs_imap.c:1949 [inline]
 diAllocAG+0xbe8/0x1e50 fs/jfs/jfs_imap.c:1666
 diAlloc+0x1d3/0x1760 fs/jfs/jfs_imap.c:1587
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xb90 fs/jfs/namei.c:225
 vfs_mkdir+0x2f1/0x4b0 fs/namei.c:4106
 do_mkdirat+0x264/0x3a0 fs/namei.c:4129
 __do_sys_mkdir fs/namei.c:4149 [inline]
 __se_sys_mkdir fs/namei.c:4147 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4147
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fcb7e6a0b57
Code: ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd83023038 EFLAGS: 00000286 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fcb7e6a0b57
RDX: 00000000000a1020 RSI: 00000000000001ff RDI: 0000000020000140
RBP: 0000000020000140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00007ffd830230d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

