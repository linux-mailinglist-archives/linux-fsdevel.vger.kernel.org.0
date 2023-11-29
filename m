Return-Path: <linux-fsdevel+bounces-4221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1037FDD58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ADA1C20995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDE3B788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBEABF
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:28:23 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cba754b041so8034423b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275303; x=1701880103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsXGXgaZSNXxAkrghgvic5qFLjCKx/nr13WFl9UgcEE=;
        b=qDix9vffogKDuPtJcullv1f08kpd0E2zdHx7yrVu00VaarpBzckJilHci5yNgG0Vo7
         cfR/ZwD+3KT4WGspn4HR49FqSxSdBhg5JAXN3qxurcONL8LKNljC/aEdw5pCdsDv3XWP
         imWVfFS0mSZxeT2rRPbiGYW8o9hEQRV6NiIbO0OzCsB1aynJJIwEulX+PM61XYFsr22m
         PY/C9zQ8sIPW1eJbzenxiXjc/JzV7dc8HyKaT8d813HLxdrvNBlyCzpRecs0KWMDzPzN
         wFnvhxbrbOzfcvY9OqmN7ChOw7rVt6N/dRSKrtovk9DZG5wLmfZ+OQKcqaFUCg4m4cfW
         9dQA==
X-Gm-Message-State: AOJu0YwIO/zT0Hya71cEyDLQotzx9CsdubkMaw7lkH3e+QG1GE7ToJ9p
	4q4V+cvGQ0Enc4Wtxu5DHij16Q+H2EtaJn7u2V9kM7wid0zI
X-Google-Smtp-Source: AGHT+IGE03yNZju61/42IbmlFpq1TvMMX2G1dPos+w6BW70zkA5PmJurtsjQpMDQuBK41XWhlMaAmp27PBBg1QLclAndv61EQ4h7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1785:b0:6cd:e206:e0bd with SMTP id
 s5-20020a056a00178500b006cde206e0bdmr32459pfg.2.1701275303122; Wed, 29 Nov
 2023 08:28:23 -0800 (PST)
Date: Wed, 29 Nov 2023 08:28:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9dbd060b4d06a8@google.com>
Subject: [syzbot] [exfat?] KMSAN: uninit-value in exfat_set_entry_time
From: syzbot <syzbot+d41ef22a1e1ce5b449b2@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155bcf18e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=d41ef22a1e1ce5b449b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16a813d08871/disk-30523014.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/226b88790aa7/vmlinux-30523014.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1b45d0d85fa/bzImage-30523014.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d41ef22a1e1ce5b449b2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in exfat_set_entry_time+0x2dc/0x320 fs/exfat/misc.c:99
 exfat_set_entry_time+0x2dc/0x320 fs/exfat/misc.c:99
 __exfat_write_inode+0x7ca/0xdd0 fs/exfat/inode.c:59
 exfat_write_inode+0xd9/0x180 fs/exfat/inode.c:97
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0x843/0x12b0 fs/fs-writeback.c:1690
 writeback_sb_inodes+0xb73/0x1c00 fs/fs-writeback.c:1916
 wb_writeback+0x4a1/0xdf0 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x3a4/0x1710 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Local variable ts created at:
 __exfat_write_inode+0x105/0xdd0 fs/exfat/inode.c:29
 exfat_write_inode+0xd9/0x180 fs/exfat/inode.c:97

CPU: 1 PID: 8475 Comm: kworker/u4:5 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: writeback wb_workfn (flush-7:4)
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

