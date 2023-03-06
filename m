Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8196ACBBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCFR7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCFR6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:58:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C9460B6
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 09:58:11 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id k13-20020a5d9d4d000000b0074caed3a2d2so5836772iok.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 09:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK9ZXC6YfZH4j9qfqbaIVRSqmEgs/PeD52exQAy10PA=;
        b=eZjz/AfZn9xjXfVjOxaIWuGfYej2F4OD2/XkQ/+I5WjGyKL+//5LWzPLTjnKh62kPj
         6HVEkGCkiPjU/5HUQ7jgLDB0iNLYPRRrr3Wo1a9pcpffQOdFAtrXOnS9ACvZAEENJlLL
         TlzWq5HUHQBJLh8PP6KP843ZUAvZ3Qn00Yw7lgS+dCLtysUbTfqaf4Wd7/hR+4YgUtfD
         UXKcsOrPZ+2gJ8PcXF52SlCRl2SRr8Wce274W+lsm9RCikS0MxBg2z+ZgJ7SDzq51PTk
         Cm3NbNOqOk+8uyQC6Nf9O4UtiSvY/rW+9vLNkxLcr1/UrbNzWa84a3NtMaMk3/6B1XWI
         HP/g==
X-Gm-Message-State: AO0yUKV8Sau7akZqGFHEt2kupvzCEH6po3iJ/3YXPuefcZgr4nsmvlso
        tLy/g0S/8795KX3p2thcnw452TUCXVFX9vBwr0LB6rOBZrxF
X-Google-Smtp-Source: AK7set/nYocyn99uYw4qf7ESqyd6k8CfSeNtM+qG6Atp4m9fkBoQ/6k7ClZzYpGooR74eEgHPOMJedA2zaz9yZF3AYQVHTUO7q3J
MIME-Version: 1.0
X-Received: by 2002:a5e:d60c:0:b0:74d:13bc:e9e6 with SMTP id
 w12-20020a5ed60c000000b0074d13bce9e6mr5672924iom.3.1678125404894; Mon, 06 Mar
 2023 09:56:44 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:56:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5bd2d05f63f04ae@google.com>
Subject: [syzbot] [nilfs?] KMSAN: kernel-infoleak in nilfs_ioctl_wrap_copy
From:   syzbot <syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com>
To:     glider@google.com, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    97e36f4aa06f Revert "sched/core: kmsan: do not instrument ..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=106829a8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=132fdd2f1e1805fdc591
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9931a9627dc6/disk-97e36f4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aafdb2fd6dc/vmlinux-97e36f4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90df5872c7ff/bzImage-97e36f4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xc0/0x100 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0xc0/0x100 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 nilfs_ioctl_wrap_copy+0x6fa/0xc10 fs/nilfs2/ioctl.c:99
 nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
 nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
 nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f6/0xe90 mm/page_alloc.c:5572
 alloc_pages+0xab0/0xd80 mm/mempolicy.c:2287
 __get_free_pages+0x34/0xc0 mm/page_alloc.c:5599
 nilfs_ioctl_wrap_copy+0x223/0xc10 fs/nilfs2/ioctl.c:74
 nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
 nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
 nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Bytes 16-127 of 3968 are uninitialized
Memory access of size 3968 starts at ffff888014534000
Data copied to user address 000000002000002f

CPU: 0 PID: 18968 Comm: syz-executor.0 Not tainted 6.2.0-syzkaller-81152-g97e36f4aa06f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
