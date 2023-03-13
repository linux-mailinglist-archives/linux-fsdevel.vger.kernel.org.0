Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F86B7CDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCMPzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCMPzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:55:05 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C5311E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 08:54:23 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id c13-20020a0566022d0d00b0074cc4ed52d9so6549010iow.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722835;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vaShXChXf9BcORoi0tFSiNxi7xLZqWmExJATcqzfoI=;
        b=YRfSHVNPzguMdYb4szn0AZz+PDGR5A5hgojdTKMaxbhqFRmw9RJPeckIrBJBZpcWWE
         bbX7iR1NJJJaQ48rY8gCq4cCCnMPse8s5xskNIxXspTUHuuZQByroLDl9yJzydNdHjAb
         cO/cqwjzrf128Avw9bYAHimY8QjmPobmBoonMe4nRKja8BmE0clg1wAUAQCC3cXmt7rZ
         SKI+V0oWgQ483eV/6dxojLJgRMtbzD7szkq3G0riB2RidkRa8/U/O79spL/P6xT0m4ZA
         CWWRz8XY6Lk+j8lRTQqrOsvo2qa1iZl8GfFEVyu4KcmAbD2GlXxDDWbGPsuA06m8oqa5
         T4LA==
X-Gm-Message-State: AO0yUKW8K8sbDlwFG6RXugBWVwsVb7+7XprpxheGOk159DSxA+rZpvPO
        pIn4UhnrI/RvQ0O5eb0XSF2di1DlTutagrS4bYFGG5EzL76p
X-Google-Smtp-Source: AK7set8fg58FsPagCxOjtwijK6qtBHk6VlgfsLkPWW8QDoP8Vno1VuivzIIWVzxQW+qxVh2CL7lBB6MakUwjRteKO03lyV+leLgg
MIME-Version: 1.0
X-Received: by 2002:a92:da8a:0:b0:313:cc98:7eee with SMTP id
 u10-20020a92da8a000000b00313cc987eeemr110294iln.1.1678722835176; Mon, 13 Mar
 2023 08:53:55 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:53:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044651705f6ca1e30@google.com>
Subject: [syzbot] [fscrypt?] WARNING in fscrypt_destroy_keyring
From:   syzbot <syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com>
To:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fe15c26ee26e Linux 6.3-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2d88ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=93e495f6a4f748827c88
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16171188c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ac08dac80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bf3b409baf10/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 without journal. Quota mode: writeback.
fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-ce"
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5945 at fs/crypto/keyring.c:237 fscrypt_destroy_keyring+0x164/0x240 fs/crypto/keyring.c:237
Modules linked in:
CPU: 1 PID: 5945 Comm: syz-executor265 Not tainted 6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fscrypt_destroy_keyring+0x164/0x240 fs/crypto/keyring.c:237
lr : fscrypt_destroy_keyring+0x164/0x240 fs/crypto/keyring.c:237
sp : ffff80001e4c7960
x29: ffff80001e4c7960 x28: 1fffe0001aaec0fa x27: 0000000000000000
x26: 0000000000000073 x25: 1fffe00019138025 x24: dfff800000000000
x23: 0000000000000002 x22: ffff0000cbffa000 x21: ffff0000c738e000
x20: ffff0000c89c0000 x19: ffff0000c89c0128 x18: ffff80001e4c7320
x17: ffff800015cdd000 x16: ffff800008313a3c x15: ffff8000081cd8e0
x14: 1ffff00002b9c0b2 x13: dfff800000000000 x12: 0000000000000001
x11: ff80800008bcd61c x10: 0000000000000000 x9 : ffff800008bcd61c
x8 : ffff0000cc0b3680 x7 : ffff800008b76ab4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800008bcd558
x2 : 0000000000000000 x1 : 0000000000000002 x0 : 0000000000000001
Call trace:
 fscrypt_destroy_keyring+0x164/0x240 fs/crypto/keyring.c:237
 generic_shutdown_super+0xac/0x328 fs/super.c:482
 kill_block_super+0x70/0xdc fs/super.c:1398
 deactivate_locked_super+0xac/0x124 fs/super.c:331
 deactivate_super+0xf0/0x110 fs/super.c:362
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1177
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1184
 task_work_run+0x240/0x2f0 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x4fc/0x1a30 kernel/exit.c:869
 do_group_exit+0x194/0x22c kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __wake_up_parent+0x0/0x60 kernel/exit.c:1028
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 16114
hardirqs last  enabled at (16113): [<ffff8000083af01c>] __call_rcu_common kernel/rcu/tree.c:2658 [inline]
hardirqs last  enabled at (16113): [<ffff8000083af01c>] call_rcu+0x65c/0xb38 kernel/rcu/tree.c:2736
hardirqs last disabled at (16114): [<ffff80001245e098>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (15276): [<ffff800008020ec0>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (15276): [<ffff800008020ec0>] __do_softirq+0xd64/0xfbc kernel/softirq.c:600
softirqs last disabled at (15265): [<ffff80000802b524>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000003
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[dfff800000000003] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5945 Comm: syz-executor265 Tainted: G        W          6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x104/0x764c kernel/locking/lockdep.c:4926
lr : lock_acquire+0x2f0/0x8c8 kernel/locking/lockdep.c:5669
sp : ffff80001e4c7040
x29: ffff80001e4c72e0 x28: 1ffff00002b9c0b1 x27: ffff800008bcd13c
x26: 0000000000000001 x25: ffff700003c98e2c x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000018 x18: ffff80001e4c7398
x17: ffff800015cdd000 x16: ffff80001246263c x15: ffff8000081cd8e0
x14: 1ffff00002b9c0b2 x13: ffff80001e4c7160 x12: dfff800000000000
x11: ffff800008318d80 x10: ffff800015ce058c x9 : 00000000000000f3
x8 : 0000000000000003 x7 : ffff800008bcd13c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000018
Call trace:
 __lock_acquire+0x104/0x764c kernel/locking/lockdep.c:4926
 lock_acquire+0x2f0/0x8c8 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 fscrypt_put_master_key_activeref+0x8c/0x408 fs/crypto/keyring.c:95
 put_crypt_info+0x218/0x2d0 fs/crypto/keysetup.c:546
 fscrypt_put_encryption_info+0x44/0x6c fs/crypto/keysetup.c:743
 ext4_clear_inode+0x154/0x1a0 fs/ext4/super.c:1445
 ext4_evict_inode+0x6ec/0x148c fs/ext4/inode.c:346
 evict+0x260/0x68c fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x988/0xa6c fs/inode.c:1774
 hook_sb_delete+0x688/0xa10 security/landlock/fs.c:1025
 security_sb_delete+0x50/0x94 security/security.c:950
 generic_shutdown_super+0xb4/0x328 fs/super.c:483
 kill_block_super+0x70/0xdc fs/super.c:1398
 deactivate_locked_super+0xac/0x124 fs/super.c:331
 deactivate_super+0xf0/0x110 fs/super.c:362
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1177
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1184
 task_work_run+0x240/0x2f0 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x4fc/0x1a30 kernel/exit.c:869
 do_group_exit+0x194/0x22c kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __wake_up_parent+0x0/0x60 kernel/exit.c:1028
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: d006d368 b9482108 34000208 d343fe68 (386c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d006d368 	adrp	x8, 0xda6e000
   4:	b9482108 	ldr	w8, [x8, #2080]
   8:	34000208 	cbz	w8, 0x48
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	386c6908 	ldrb	w8, [x8, x12] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
