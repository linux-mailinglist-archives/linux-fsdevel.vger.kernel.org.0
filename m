Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EEC639455
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKZIGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZIGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:06:49 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5927FCD
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:47 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k3-20020a92c243000000b0030201475a6bso4337728ilo.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK0l+Lf+tCezD+tESCSp6qOqBtJJPkKIibcdWDf4hKY=;
        b=N9tJ1/8qqxAikI146LNdUSN4j+eRRoCchOYdPimMVCx5bI07J/vWwQ1PM4RTk6OZR9
         ZIzGnxzLwpYiwkh7hkZPAYGVlDOMY7W/AjQNNiuLf2oryFUOlSK2HwH50nnIaPZiKj9F
         56Cdu4m4nT1jtZGNy8BJcbZ3DvxYJyNPLbEntNPbwwAugHSS7BdlqCWB29cwbhfJjao9
         f2nq4eejPw4p3XXhZLUeeHvAyt7uoOblAKTKdbLTEkZBmN5C1c1MheQoRlxiwqUWE/Rm
         2NY79Ugo9fAt3656Lw2uEoZbaIZ30DlFW1/kbSBUs/E/xc/4LUjsiOf82SFdrwpfXwLA
         /+VA==
X-Gm-Message-State: ANoB5plFWfr/Bc0SkJQczyCum0TjiMKRFHSGiS3uNhoEzPxOv+MFxUt4
        hipiOMkV3rPxO2wDlJRWu9511Uw1/FniiYIK0UnaUYy5ES1b
X-Google-Smtp-Source: AA0mqf56aCnoMyzSl3lzPjXeedmg6gvT1+nsuZbZ0tr3O/LdxsnEj4Jh9KoCUxCW9Uw/moewDn/b+bk7wqbXDDNHE+B+H33FIkyi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b7:b0:389:c2fd:bc13 with SMTP id
 d23-20020a05663802b700b00389c2fdbc13mr2189118jaq.12.1669450007061; Sat, 26
 Nov 2022 00:06:47 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:06:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a42d2c05ee5b1e18@google.com>
Subject: [syzbot] kernel BUG in hfsplus_create_attributes_file
From:   syzbot <syzbot+a313c6d1d9ef87de2a66@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17a49603880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=a313c6d1d9ef87de2a66
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14382015880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f791c3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/23c8423bc069/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a313c6d1d9ef87de2a66@syzkaller.appspotmail.com

         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
------------[ cut here ]------------
kernel BUG at fs/hfsplus/xattr.c:175!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor864 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hfsplus_create_attributes_file+0x6d4/0x6fc fs/hfsplus/xattr.c:175
lr : hfsplus_create_attributes_file+0x6d4/0x6fc fs/hfsplus/xattr.c:175
sp : ffff80000fbab650
x29: ffff80000fbab670 x28: 0000000000000000 x27: ffff0000c6616000
x26: ffff0000c94e6000 x25: 000000000000002e x24: 0000000000000080
x23: 0000000000000000 x22: 0000000000010000 x21: 0000000000000001
x20: ffff0000cb7fa8b0 x19: ffff0000c6616038 x18: 00000000000000c0
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c7df0000
x14: 00000000000000b8 x13: 00000000ffffffff x12: ffff0000c7df0000
x11: ff808000088f78f0 x10: 0000000000000000 x9 : ffff8000088f78f0
x8 : ffff0000c7df0000 x7 : ffff8000085f9554 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000010000 x0 : 0000000000000000
Call trace:
 hfsplus_create_attributes_file+0x6d4/0x6fc fs/hfsplus/xattr.c:175
 __hfsplus_setxattr+0x180/0x4e8 fs/hfsplus/xattr.c:331
 hfsplus_initxattrs+0xac/0x130 fs/hfsplus/xattr_security.c:59
 security_inode_init_security+0x208/0x278 security/security.c:1119
 hfsplus_init_security+0x40/0x54 fs/hfsplus/xattr_security.c:71
 hfsplus_mknod+0x128/0x1bc fs/hfsplus/dir.c:498
 hfsplus_create+0x40/0x54 fs/hfsplus/dir.c:523
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3710
 do_filp_open+0xdc/0x1b8 fs/namei.c:3740
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d4210000 97e6b81d d4210000 97e6b81b (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
