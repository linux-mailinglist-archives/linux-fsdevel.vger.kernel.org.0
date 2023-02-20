Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159EB69C624
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 08:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBTHyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 02:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBTHyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:54:47 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD9BDFD
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Feb 2023 23:54:46 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id v3-20020a92c6c3000000b003159a0109ceso746857ilm.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Feb 2023 23:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96yj1aHD38hIt7rAdjlqjX1GsnoopRCQUkxRVi9L4P0=;
        b=dDV2N7nqo1iWgihp68l8nXCh0j6ebNqMhL4Zpo9VoUw5BEl4zfJXBx/n9/Zsu4I8Ki
         zCPCJZI80BobrGcPyc73VYBMgAzIcoCBPDkX8iSeHi+rwSJWGzFToCG1KyHXaKOzrBXH
         HMVprQX5J4r9Mo3eVfeGKRtETpZ++FdAWDmGGJPmkG3MWqLR5kvqeJ8zQOIjrVBfAHdB
         +soMf6CkGSVgrlIfDKXZRycOa9k3qi/tqhacBpXyE2GUtA6QCsjDQPPE+tfX4MaOytVD
         uhoz8Po6PyejdTWgNnxMjKssTgtyNeQYn0S1ERcoluR0up08aeXE+YR4+lFAP8Vhbzxs
         Unzg==
X-Gm-Message-State: AO0yUKXpvqmDzwrmM8mUkTWjHH/wkkqo/K/VSkoFE+te4IjGK42RUBZ9
        xdxMCUnX2cKqBTTcBa7K7d3TEiXGLovFabEv8psDJL7ShCjR
X-Google-Smtp-Source: AK7set+S+y1GWOWBgC3KownZ7sPSvSzsW/4WNlYyMDg0EhpWi0MaSNWu1NYiugx7lWDMZvJXAA/TgJFFFx1wlsJfD6KAkprE7VwH
MIME-Version: 1.0
X-Received: by 2002:a02:8503:0:b0:3b1:7d3:88b2 with SMTP id
 g3-20020a028503000000b003b107d388b2mr634528jai.6.1676879685936; Sun, 19 Feb
 2023 23:54:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 23:54:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002eb8105f51cfa96@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_ioctl_add_dev
From:   syzbot <syzbot+afdee14f9fd3d20448e7@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    c9c3395d5e3d Linux 6.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216e630c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4a1b2323673cc82
dashboard link: https://syzkaller.appspot.com/bug?extid=afdee14f9fd3d20448e7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c9a378c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e5c044c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26e9c877102c/disk-c9c3395d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e3e3feba050/vmlinux-c9c3395d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21beac50cf7f/bzImage-c9c3395d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9f00aa255474/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afdee14f9fd3d20448e7@syzkaller.appspotmail.com

assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE || fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD, in fs/btrfs/ioctl.c:457
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6416 Comm: syz-executor132 Not tainted 6.2.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 0c 2d 3c f7 e9 50 fb ff ff e8 e2 7e 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 20 16 2c 8b e8 38 62 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 03 f4 e6 f6 48
RSP: 0018:ffffc9000ca0fea0 EFLAGS: 00010246
RAX: 0000000000000097 RBX: 00000000fffffff2 RCX: eb26e11d15dcfa00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816efb3c R09: fffff52001941f8d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000003 R14: ffff888029d64680 R15: 1ffff110053acc1a
FS:  00007f9e79ad6700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000077d02000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_exclop_balance fs/btrfs/ioctl.c:456 [inline]
 btrfs_ioctl_add_dev+0x347/0x480 fs/btrfs/ioctl.c:2660
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9e80f4b589
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e79ad62f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9e80fd57b0 RCX: 00007f9e80f4b589
RDX: 0000000000000000 RSI: 000000005000940a RDI: 0000000000000004
RBP: 00007f9e80fd57bc R08: 00007f9e79ad6700 R09: 0000000000000000
R10: 00007f9e79ad6700 R11: 0000000000000246 R12: 00007f9e80fa2660
R13: 01c8dfb098cf77b9 R14: 0030656c69662f2e R15: 00007f9e80fd57b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 0c 2d 3c f7 e9 50 fb ff ff e8 e2 7e 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 20 16 2c 8b e8 38 62 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 03 f4 e6 f6 48
RSP: 0018:ffffc9000ca0fea0 EFLAGS: 00010246
RAX: 0000000000000097 RBX: 00000000fffffff2 RCX: eb26e11d15dcfa00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816efb3c R09: fffff52001941f8d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000003 R14: ffff888029d64680 R15: 1ffff110053acc1a
FS:  00007f9e79ad6700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000077d02000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
