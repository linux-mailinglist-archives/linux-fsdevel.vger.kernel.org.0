Return-Path: <linux-fsdevel+bounces-18770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8C8BC308
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DB5B210CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94D6D1A8;
	Sun,  5 May 2024 18:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BD6BFA1
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714933591; cv=none; b=sV2il2KuqnH6yvUzgl4Gd8ugEXs/kNviXeaNY4eWLhpa1vMdH8iQTk5HfkC/faGjEMPWbLPZoOPrA6dm9Ph5b5NJyfIIqdaEiZIzUTIyksvepMJGjHSeop6PB/0kpvpmrzm1LHdC0oQsb+DtNeoLG3dSbHsS6w3O04xKu6Z5CBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714933591; c=relaxed/simple;
	bh=67CQkFU/JyWNsH/gRbYISWCNgDNk1dIC19djJtO92gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ss5fH+4N3dZ3+4mbs1ltltv8q5hAlKj3n3X0wVNjMlP6BL7y6ooEdmptDUVne4Lj7sOJLqfMO70sEvUFQqQzAigTGwhG8VvKmmns5/R4s8EzqpMNxp3SIxljZjZ5mQB7W850BwJzdXV+mE0gY7CgFjyKNOVc3HhHGvgGT6wHxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7de9cd658acso171314739f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714933588; x=1715538388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPmsENZX/D4o264mPcbSQSF+NkWk3WeQwVQA3g6gKwM=;
        b=mcJwFwp6gUrGRk5bXZf+5eeACH/rq0m8SSN37If4eNYDQHk79YK68R95Wwj1nXZ2T5
         +OsgcxIYJTNzB7xnVQK57EsiOLE4jeIJ1HQIV/36H9/bRK0DvcxcVLpf5cgq+P6A7E+t
         bnuBKDz2KdQnPWTiBMJ6iA3HB9xbrqioWFz13pXbCnnEELwX1HMz6e6t8dYRNbEcmY9Y
         9RKmP9jPFHVaGwkpvcbs94d3BEkpketUcpoMPXOdHm4q/jz1YFeR8oRKC+SVgJEAyxT3
         zH1dRu9UCwi6qflU/ZwYaJtQFNt9pM5kpBGMc5+ZYgvI5t4kGQnMP4jaq1CaOE1KOC66
         qGpg==
X-Forwarded-Encrypted: i=1; AJvYcCWhkRZZtn9pQltZM366mr3KVJVKRIVK9qfPPpf+kDSs7DGazyuBkmNajOi1WugZAvboLGg6Vt1VOIklaboB2GnwV5r5iQCXxIByfMgJUw==
X-Gm-Message-State: AOJu0Yzr3c8+KMXvF0++3thU6DoKayg4DdaaBg/SfgH7CvK7zhXb426M
	LBstlDkNj16A2wUJrhAIWwDLSjjJxFdbCib3dKXaW1kQMW83Y0K1OTz7cbP8hr83+fY4bs+EO1s
	ojgLysZyVV+dmLloqw09m53CxeVpPp/UnOZeszI+4DoNtpTV3sNOtGbQ=
X-Google-Smtp-Source: AGHT+IE9mXMO/mn3BtonTNi2PeiSJcQRE4OoZydRYsyfQhKgihEd18c0ezX5OqtAkqABvq7+G7DWmdbwRCtH+bvfob72nrlSSrDr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871a:b0:488:7bb2:c9f6 with SMTP id
 iw26-20020a056638871a00b004887bb2c9f6mr167853jab.3.1714933588571; Sun, 05 May
 2024 11:26:28 -0700 (PDT)
Date: Sun, 05 May 2024 11:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c46090617b917e7@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __bch2_bkey_invalid
From: syzbot <syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78186bd77b47 Merge branch 'for-next/mm-ryan-staging' into ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1258e8a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ee4da92608aba71
dashboard link: https://syzkaller.appspot.com/bug?extid=ae4dc916da3ce51f284f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1074b908980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156cad60980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6645ec7d501b/disk-78186bd7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d272001bc0f/vmlinux-78186bd7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/95e2c70cba6e/Image-78186bd7.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/56d58dd39151/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/bkey_methods.c:174:2
shift exponent 255 is too large for 64-bit type 'unsigned long long'
CPU: 1 PID: 6237 Comm: syz-executor106 Not tainted 6.9.0-rc6-syzkaller-g78186bd77b47 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:468
 __bch2_bkey_invalid+0x630/0x64c fs/bcachefs/bkey_methods.c:174
 bch2_bkey_invalid+0x58/0x1d8 fs/bcachefs/bkey_methods.c:230
 journal_validate_key+0x5ec/0xc08 fs/bcachefs/journal_io.c:344
 journal_entry_btree_root_validate+0x130/0x3c8 fs/bcachefs/journal_io.c:440
 bch2_journal_entry_validate+0xb8/0xec fs/bcachefs/journal_io.c:823
 bch2_sb_clean_validate_late fs/bcachefs/sb-clean.c:40 [inline]
 bch2_read_superblock_clean+0x188/0x414 fs/bcachefs/sb-clean.c:168
 bch2_fs_recovery+0x1b0/0x4854 fs/bcachefs/recovery.c:573
 bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1043
 bch2_fs_open+0x8b4/0xb64 fs/bcachefs/super.c:2102
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
---[ end trace ]---
invalid journal entry, version=1.7: mi_btree_bitmap type=btree_root in superblock: 
  u64s 11 type 255 SPOS_MAX len 0 ver 0: 
  invalid key type for btree internal btree node ((unknown)), shutting down
bcachefs (loop0): inconsistency detected - emergency read only at journal seq 0
------------[ cut here ]------------
virt_to_phys used for non-linear address: fffffffffffff75e (0xfffffffffffff75e)
WARNING: CPU: 1 PID: 6237 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
Modules linked in:
CPU: 1 PID: 6237 Comm: syz-executor106 Not tainted 6.9.0-rc6-syzkaller-g78186bd77b47 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
lr : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
sp : ffff80009ad06e00
x29: ffff80009ad06e00 x28: 1ffff000135a0e02 x27: fffffffffffff75e
x26: ffff80009ad07010 x25: ffff7000135a0df4 x24: dfff800000000000
x23: ffff0000df080000 x22: 000f600000000000 x21: 000000000000002d
x20: fffffffffffff75e x19: 000ffffffffff75e x18: 0000000000000008
x17: 6666783028206535 x16: ffff80008ae8863c x15: 0000000000000001
x14: 1fffe000367bd602 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 6f3d61fbe7072c00
x8 : 6f3d61fbe7072c00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009ad06578 x4 : ffff80008ef850a0 x3 : ffff8000805e8270
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
 virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
 virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
 virt_to_folio include/linux/mm.h:1306 [inline]
 kfree+0xa4/0x3e8 mm/slub.c:4382
 bch2_fs_recovery+0x32c/0x4854 fs/bcachefs/recovery.c:905
 bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1043
 bch2_fs_open+0x8b4/0xb64 fs/bcachefs/super.c:2102
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 76314
hardirqs last  enabled at (76313): [<ffff800080375438>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (76313): [<ffff800080375438>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (76313): [<ffff800080375438>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (76314): [<ffff80008ae83a88>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (76276): [<ffff8000800218e4>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (76276): [<ffff8000800218e4>] __do_softirq+0xb10/0xd2c kernel/softirq.c:583
softirqs last disabled at (76247): [<ffff80008002ad34>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffffffffc37affc8
KASAN: maybe wild-memory-access in range [0x0003fffe1bd7fe40-0x0003fffe1bd7fe47]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001ad5df000
[ffffffffc37affc8] pgd=0000000000000000, p4d=00000001b0db9003, pud=00000001b0dba003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6237 Comm: syz-executor106 Tainted: G        W          6.9.0-rc6-syzkaller-g78186bd77b47 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:246 [inline]
pc : virt_to_folio include/linux/mm.h:1308 [inline]
pc : kfree+0xbc/0x3e8 mm/slub.c:4382
lr : virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
lr : virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
lr : virt_to_folio include/linux/mm.h:1306 [inline]
lr : kfree+0xa4/0x3e8 mm/slub.c:4382
sp : ffff80009ad06e30
x29: ffff80009ad06e40 x28: 1ffff000135a0e02 x27: fffffffffffff75e
x26: ffff80009ad07010 x25: ffff7000135a0df4 x24: dfff800000000000
x23: ffff0000df080000 x22: 0000000000000001 x21: ffffffffc37affc0
x20: ffff80008294a5bc x19: fffffffffffff75e x18: 0000000000000008
x17: 6666783028206535 x16: ffff80008ae8863c x15: 0000000000000001
x14: 1fffe000367bd602 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 00003e00037affc0
x8 : ffffc1ffc0000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009ad06578 x4 : ffff80008ef850a0 x3 : ffff8000805e8270
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000080011ebff75e
Call trace:
 virt_to_folio include/linux/mm.h:1306 [inline]
 kfree+0xbc/0x3e8 mm/slub.c:4382
 bch2_fs_recovery+0x32c/0x4854 fs/bcachefs/recovery.c:905
 bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1043
 bch2_fs_open+0x8b4/0xb64 fs/bcachefs/super.c:2102
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 927acd29 f2d83fe8 cb151929 8b080135 (f94006a8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	927acd29 	and	x9, x9, #0x3ffffffffffffc0
   4:	f2d83fe8 	movk	x8, #0xc1ff, lsl #32
   8:	cb151929 	sub	x9, x9, x21, lsl #6
   c:	8b080135 	add	x21, x9, x8
* 10:	f94006a8 	ldr	x8, [x21, #8] <-- trapping instruction


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

