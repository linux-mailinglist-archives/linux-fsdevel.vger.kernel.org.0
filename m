Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065786C219D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 20:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCTTea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCTTd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:33:58 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFC28EBE
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 12:28:49 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so6639553ila.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 12:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340529;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twO0cBgqHVuadLiEtqwEUyKk2bd1+BbcRIByatF2Y98=;
        b=FmwGzpyhV3Bq/uOGKVIOAf5/VoJxiNwa1gHOdiegOHqCuKlFaO3py3FJvpco4RzEjo
         6uZCi0lCQyxkTLaMXGAVyrssBvvpRlXq30QUtvYmkJp94GCzcxI0msBJ0rSNKcvJHDc4
         1hwFmo+5Cv+TgFqVSkdORk/L7I1eTRY+74YwoBxUspjjR57w93CuezgN4KEe/0cPIgVn
         moJLKqIU2Fs5a0NBJys2K0N5T8k3BbISekSH/vNfCGz6tuFI+8pkSpvjXJdMsIrOBKZP
         64hbny0E3K2lxX7sTdcpiCchMgdrkBQ4SXUQPxL0sAk8H6Kznrm4UNC0QbTd6hJOhqV9
         W4OQ==
X-Gm-Message-State: AO0yUKVeEChgbsZ1hEKkswmu0+22lT/AYG9sxIm3whDFPfettJNsjxLt
        ZT6GBIvUl+eo/OQ0jQcGvVO1gOuxYn2f4AsCnB4uNB9K+msy
X-Google-Smtp-Source: AK7set+iH8yfyr5kAlbGh7l8msoSzx8Xt30vZFsOBN5uDeZYu2R+lEcdKLa+MW5d2J+F/gkxELLSa/C7VX9aoMMfCqDkgXX2cSTF
MIME-Version: 1.0
X-Received: by 2002:a02:2a04:0:b0:3c4:88e7:14cf with SMTP id
 w4-20020a022a04000000b003c488e714cfmr442022jaw.1.1679340528905; Mon, 20 Mar
 2023 12:28:48 -0700 (PDT)
Date:   Mon, 20 Mar 2023 12:28:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec88d05f759ef57@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFree
From:   syzbot <syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0ddc84d2dd43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f30826c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbab9019ad6fc418
dashboard link: https://syzkaller.appspot.com/bug?extid=d2cd27dcf8e04b232eb2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1211504ac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1447df1ac80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1aef650a28e/disk-0ddc84d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab9d7540bffe/vmlinux-0ddc84d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf0758e28298/bzImage-0ddc84d2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bd86262b7da2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
find_entry called with index = 0
read_mapping_page failed!
ERROR: (device loop0): txCommit: 
ERROR: (device loop0): remounting filesystem as read-only
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:381:12
shift exponent 134217736 is too large for 64-bit type 'long long'
CPU: 1 PID: 5068 Comm: syz-executor350 Not tainted 6.3.0-rc2-syzkaller-00069-g0ddc84d2dd43 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c3/0x420 lib/ubsan.c:387
 dbFree+0x46e/0x650 fs/jfs/jfs_dmap.c:381
 txFreeMap+0x96a/0xd50 fs/jfs/jfs_txnmgr.c:2510
 xtTruncate+0xe5c/0x3260 fs/jfs/jfs_xtree.c:2467
 jfs_free_zero_link+0x46e/0x6e0 fs/jfs/namei.c:758
 jfs_evict_inode+0x35f/0x440 fs/jfs/inode.c:153
 evict+0x2a4/0x620 fs/inode.c:665
 __dentry_kill+0x436/0x650 fs/dcache.c:607
 shrink_dentry_list+0x39c/0x6a0 fs/dcache.c:1201
 shrink_dcache_parent+0xcd/0x480
 do_one_tree+0x23/0xe0 fs/dcache.c:1682
 shrink_dcache_for_umount+0x7d/0x120 fs/dcache.c:1699
 generic_shutdown_super+0x67/0x340 fs/super.c:472
 kill_block_super+0x7e/0xe0 fs/super.c:1398
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:869
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa87e2289b9
Code: Unable to access opcode bytes at 0x7fa87e22898f.
RSP: 002b:00007fff4bfe3938 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa87e2a3330 RCX: 00007fa87e2289b9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007fa87e29de40
R10: 00007fff4bfe3850 R11: 0000000000000246 R12: 00007fa87e2a3330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
