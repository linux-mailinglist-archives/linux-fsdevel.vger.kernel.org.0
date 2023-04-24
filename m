Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCC6EC7A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjDXIJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjDXIJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:09:49 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469831B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:09:48 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-329326caa4aso29415535ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323787; x=1684915787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+vFd/eLWYExPHxI2C++WyFDM8khhvHXL59PpUUA+H4=;
        b=kj6ADiA5YRcYfLjkzG+Wt/RG/6pJua1jJvzyLfSyEwYPCa9TkQhW4xtEWN/QoDj41h
         yQGbw5ucdjBHddftdAhtwA2CsKWN+Mf2m1abqWxPfTybYxNebJgGef3bt/KcotrCL8YP
         +QmSR2kYVa0tNZwwr4WOSd1QCi1V6j0qNMMnGaKRZuNFcWF96up1SCBFiOEO1dD83jH9
         re4pSwJjPDycQ6GaypXbTKgErU3UNGQCmjrZB7qvqRYkeclwXJh+MNCeCv1XK4hkIf4D
         hMfCmCzkrIEmhUirIiBEr+tOjog20YmMgrVYGDK6k3h4ZsjKOX6D/t1o2+PjJ1L8xXLW
         eZWw==
X-Gm-Message-State: AAQBX9dvOZYB/+sI6ARjbFWXaBpA3tYyiupb7PkNKDmlM9xG5e9hqmO2
        ZedwPXAz0F+OmUFuWeieZHd6WUWDfCyz2uZMzZrx82tR+b0O
X-Google-Smtp-Source: AKy350bAGAijF3vZM4Q9OsJla+4tX4FPUeUk9NZCVk5nE7l3Qy+1s8OX3odpZg+Qj746GJ1RADjP7Xx43ORMebtrTOJK/g879KPU
MIME-Version: 1.0
X-Received: by 2002:a02:95c2:0:b0:40f:ae6d:c2c0 with SMTP id
 b60-20020a0295c2000000b0040fae6dc2c0mr3855191jai.3.1682323787669; Mon, 24 Apr
 2023 01:09:47 -0700 (PDT)
Date:   Mon, 24 Apr 2023 01:09:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2e89505fa108749@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in inotify_handle_inode_event / inotify_remove_from_idr
From:   syzbot <syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1482ffafc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=4a06d4373fd52f0b2f9c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b5f31d96315/disk-622322f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adca7dc8daae/vmlinux-622322f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed78ddc31ccb/bzImage-622322f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in inotify_handle_inode_event / inotify_remove_from_idr

write to 0xffff888104e31368 of 4 bytes by task 3229 on cpu 1:
 inotify_remove_from_idr+0x106/0x310 fs/notify/inotify/inotify_user.c:511
 inotify_ignored_and_remove_idr+0x34/0x60 fs/notify/inotify/inotify_user.c:532
 inotify_freeing_mark+0x1d/0x30 fs/notify/inotify/inotify_fsnotify.c:133
 fsnotify_free_mark fs/notify/mark.c:490 [inline]
 fsnotify_destroy_mark+0x17a/0x190 fs/notify/mark.c:499
 __do_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:817 [inline]
 __se_sys_inotify_rm_watch+0xf7/0x170 fs/notify/inotify/inotify_user.c:794
 __x64_sys_inotify_rm_watch+0x31/0x40 fs/notify/inotify/inotify_user.c:794
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888104e31368 of 4 bytes by task 3638 on cpu 0:
 inotify_handle_inode_event+0x17e/0x2c0 fs/notify/inotify/inotify_fsnotify.c:113
 fsnotify_handle_inode_event+0x19b/0x1f0 fs/notify/fsnotify.c:264
 fsnotify_handle_event fs/notify/fsnotify.c:316 [inline]
 send_to_group fs/notify/fsnotify.c:364 [inline]
 fsnotify+0x101c/0x1150 fs/notify/fsnotify.c:570
 __fsnotify_parent+0x307/0x480 fs/notify/fsnotify.c:230
 fsnotify_parent include/linux/fsnotify.h:77 [inline]
 fsnotify_file include/linux/fsnotify.h:99 [inline]
 fsnotify_close include/linux/fsnotify.h:341 [inline]
 __fput+0x4b0/0x570 fs/file_table.c:307
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x123/0x160 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd1/0xe0 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000060 -> 0xffffffff

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 3638 Comm: syz-executor.0 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
