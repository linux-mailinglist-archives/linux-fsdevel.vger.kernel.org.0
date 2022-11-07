Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548DF620152
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKGViv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKGVgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:36:49 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC61A383
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 13:36:43 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso8067470iob.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Nov 2022 13:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XavOv7O7sN5y/ANw4GZ5+1GS3zpa5e7jeG3PXprMkRE=;
        b=3XJZRAf84mtHDm/JA/pkbE7/+lVpJ5ng9gkG7yfwXouNpxCw1H4yrdVACa8ICAQBWs
         S9kEOjOecJCN6E1l7yqTR+69ligsS5mVC/LqjvtY2KuZlounEmuupSRhnCIxkqCWMX2a
         8lcwEq/Sv//X/ma4WbKsVFGanQ+ZP8RTkze6Rp5XUYW2tiZ4nYpRcg1lT3ScG+gOmoGZ
         OakvLUEiFQxykbBCM8SY2ebW5lxIN9sesZ+c5ctGH5s1Ko9+7ap0ppfwSnD2/V2ucR0i
         KniK/pdXbdtn6enN+s9hFl3nYop2nrd48962N0ktJechI1r8fIVomuy7LWj2sXVdq8ts
         CawA==
X-Gm-Message-State: ACrzQf0WZ9wz1qUXQHBoDC7LM9PkvtvwVfMMFSaTBjVie93aG73MEdyl
        i4tYleJ8QTKcm0wSkR++973nI4PrrZL8ffvTts/SmQlIWze/
X-Google-Smtp-Source: AMsMyM6HWug/J3hoxbaHsJPmONtnc0ytWo4foqdx9hoV7qB8KsaRd34//0HcI6EmQ8M0JQh3RNimzOXtin5ODcCZlFQTMKeqvq3z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d11:b0:375:1ba7:bb11 with SMTP id
 q17-20020a0566380d1100b003751ba7bb11mr31497583jaj.28.1667857002479; Mon, 07
 Nov 2022 13:36:42 -0800 (PST)
Date:   Mon, 07 Nov 2022 13:36:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b449505ece8385e@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in sb_end_write
From:   syzbot <syzbot+baa30b3f0af34d3b3832@syzkaller.appspotmail.com>
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

HEAD commit:    f0c4d9fc9cc9 Linux 6.1-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1325f951880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff27f0c8b406726e
dashboard link: https://syzkaller.appspot.com/bug?extid=baa30b3f0af34d3b3832
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c3890e880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d5fede880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92c7e839ac32/disk-f0c4d9fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7bedbc08fb4/vmlinux-f0c4d9fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fe25e2dfdb7/Image-f0c4d9fc.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e08ff430eaf4/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baa30b3f0af34d3b3832@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 79
Unable to handle kernel paging request at virtual address ffff8001f1dad000
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c5630000
[ffff8001f1dad000] pgd=100000023ffff003, p4d=100000023ffff003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3024 Comm: syz-executor176 Not tainted 6.1.0-rc4-syzkaller-31833-gf0c4d9fc9cc9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __percpu_add_case_32 arch/arm64/include/asm/percpu.h:127 [inline]
pc : percpu_up_read include/linux/percpu-rwsem.h:106 [inline]
pc : __sb_end_write include/linux/fs.h:1821 [inline]
pc : sb_end_write+0xac/0x22c include/linux/fs.h:1853
lr : rcu_sync_is_idle include/linux/rcu_sync.h:36 [inline]
lr : percpu_up_read include/linux/percpu-rwsem.h:105 [inline]
lr : __sb_end_write include/linux/fs.h:1821 [inline]
lr : sb_end_write+0x84/0x22c include/linux/fs.h:1853
sp : ffff800012b9bc00
x29: ffff800012b9bc00 x28: ffff0000cb107888 x27: ffff80000d3182f0
x26: 00000000fffffffb x25: 0000000000000021 x24: 0000000000000001
x23: 0000000020000080 x22: 0000000020000180 x21: ffff0000c6540000
x20: 0000000000000000 x19: ffff0000c97e7000 x18: 00000000000000c0
x17: ffff80000dcec198 x16: ffff80000db2a158 x15: ffff0000c6540000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6540000
x11: ff808000085ff1b0 x10: 0000000000000000 x9 : 00000000ffffffff
x8 : ffff8001f1dad000 x7 : ffff8000095f3074 x6 : 0000000000000000
x5 : 0000000000000080 x4 : ffff0001feff2950 x3 : 0000000000002bb9
x2 : ffff0000c9558000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __sb_end_write include/linux/fs.h:1821 [inline]
 sb_end_write+0xac/0x22c include/linux/fs.h:1853
 mnt_drop_write+0x28/0x38 fs/namespace.c:471
 path_setxattr+0x36c/0x414 fs/xattr.c:638
 __do_sys_setxattr fs/xattr.c:652 [inline]
 __se_sys_setxattr fs/xattr.c:648 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:648
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: f941fe68 d538d089 8b080128 12800009 (b829011f) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f941fe68 	ldr	x8, [x19, #1016]
   4:	d538d089 	mrs	x9, tpidr_el1
   8:	8b080128 	add	x8, x9, x8
   c:	12800009 	mov	w9, #0xffffffff            	// #-1
* 10:	b829011f 	stadd	w9, [x8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
