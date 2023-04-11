Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56446DD378
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDKGyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDKGyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:54:05 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E141BCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:47 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id w14-20020a056e0213ee00b0032827955ae6so8448700ilj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196026; x=1683788026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGVH0WnSXrVNezxRIYrXgrKByqgiTSx6uDX6MYjCj6s=;
        b=pDry32a1SG4VwoHU6ruTpoUX9+7QUiHoEyDnpZOOA2+QK0Ln5VW4bczontm4YVdqGj
         RnB1EMcjWl4jeKXbXPHYSy2JG2CfiEZ4NQD9bps+4GpXfyH9HrRGBQkC9FbzxMSeR3x1
         0RV/0Jl2JQNuijEbglwA7GHCE4eaxdwqFgWLV8ohFmqC+kB22RC2g0h2H28gUwkZz/Gz
         FN/3+EnRGGyzLRnr3bw+ZCokeUtGXCZl6kgFQ23uCE6GmVxq8hGTy4dSmR6u2RooV6mK
         uU+GaPDoAyPqhrvvR9Ctyes1tabPork18PByZhM4KM2TK0SQNXnuZ60FQXbMz9vVs+gJ
         0jIQ==
X-Gm-Message-State: AAQBX9e50Oz3OXMneqNVAmspYMb8dZ/CMo1zSJvJHH8tmUMlE6Now3cU
        HrjS+9HBU/mo2mJmOvMcPfyCqZJEG+fA//P1HCai25GYDQv6
X-Google-Smtp-Source: AKy350Ybvq13Jj9CD7o5yV7zJ0tsyR7cl/QgQ5hkiVaSJ9UiBO8pKc2KDAB7FBx12cxcSKcLaMFRetmcfDdu4yqBHZoOpdEJRmwQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:216f:b0:3fc:e1f5:961a with SMTP id
 p15-20020a056638216f00b003fce1f5961amr5148091jak.2.1681196026533; Mon, 10 Apr
 2023 23:53:46 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:53:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f59d0a05f909f300@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in __kmem_cache_alloc_node
From:   syzbot <syzbot+4c1f1aff5637977d5ba9@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6ab608fe852b Merge tag 'for-6.3-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102ad495c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e626f76ad59b1c14
dashboard link: https://syzkaller.appspot.com/bug?extid=4c1f1aff5637977d5ba9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c1f1aff5637977d5ba9@syzkaller.appspotmail.com

ntfs3: loop3: Different NTFS' sector size (1024) and media sector size (512)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __kmem_cache_alloc_node+0x3a7/0x3f0 mm/slab.c:3543
CPU: 1 PID: 5830 Comm: syz-executor.3 Not tainted 6.3.0-rc4-syzkaller-00243-g6ab608fe852b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 panic+0x688/0x730 kernel/panic.c:340
 __stack_chk_fail+0x19/0x20 kernel/panic.c:759
 __kmem_cache_alloc_node+0x3a7/0x3f0 mm/slab.c:3543
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 mi_init+0x90/0x100 fs/ntfs3/record.c:105
 ntfs_read_mft fs/ntfs3/inode.c:53 [inline]
 ntfs_iget5+0x3ff/0x3310 fs/ntfs3/inode.c:518
 ntfs_fill_super+0x3138/0x3ab0 fs/ntfs3/super.c:1244
 get_tree_bdev+0x444/0x760 fs/super.c:1303
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f92a728d62a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92a8085f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f762 RCX: 00007f92a728d62a
RDX: 0000000020000000 RSI: 000000002001f740 RDI: 00007f92a8085fe0
RBP: 00007f92a8086020 R08: 00007f92a8086020 R09: 0000000001000000
R10: 0000000001000000 R11: 0000000000000202 R12: 0000000020000000
R13: 000000002001f740 R14: 00007f92a8085fe0 R15: 0000000020000040
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
