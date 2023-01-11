Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4666550D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 08:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKHPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 02:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAKHPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:15:43 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54562EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 23:15:42 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id be25-20020a056602379900b006f166af94d6so8429822iob.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 23:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k71p3Hh+VynGVOtf9V5gHEyYU8zX4tMeLYm1AflC7xk=;
        b=1AY88C8nZfqfspVs9P3TquCwAv2oYbQUyUNRKV9rg8tPDO1viDW5Ongr8dzcyrQRJR
         DTUwaYJrDZkEyC1aqlP97cmTUY1ZCOm1LvdghwPmy9YeOsPPJ8PcNSva3ExbHioVDS60
         K7+rek3wXV8yq12gVXuge9yLSTbrQJtgXY4anqZv8PbmvHoc/j62Ee+RWZna5RVHYSOY
         HA/wcpY2bNjOmp8uLXolGEAsEQhTmdmbto1zXLUuX7gXu8koDD0EhaYR3b6k0lSTR15K
         Bgk9SZJCZw4dvKf8na/W8o6QBv36BRIz7fPZhzBDuGaCa1MpCowtf+XjubQZtG1SU3+c
         aurA==
X-Gm-Message-State: AFqh2krsgBBiTtNuvGRQYuncGpbjbuYNTrve0LNvvKW9PEMDNwi3DiGl
        kIw09kTghn8u/M6X6gBi6WLSA124gY5NBh8jE/lCW+SE4m8R
X-Google-Smtp-Source: AMrXdXtV2XxbIvW3wAbBI8rgzNWEv3d9HLnh+Z455xSJTRdsDdjhRUQSkX059Ywzi/cepv7HGE7q22gbXlGFAwUOMyiW/GUCc2Qh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:52d:b0:38a:8db5:664 with SMTP id
 j13-20020a056638052d00b0038a8db50664mr7961852jar.196.1673421341455; Tue, 10
 Jan 2023 23:15:41 -0800 (PST)
Date:   Tue, 10 Jan 2023 23:15:41 -0800
In-Reply-To: <000000000000a0d7f305eecfcbb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dfa9805f1f7c43f@google.com>
Subject: Re: [syzbot] [vfs?] [ntfs3?] WARNING in path_openat
From:   syzbot <syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    40c18f363a08 Merge tag '6.2-rc3-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a30e1c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebc110f9741920ed
dashboard link: https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1505b0ce480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b974f49dd49/disk-40c18f36.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d735ca0c438/vmlinux-40c18f36.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6aeef3d597b4/bzImage-40c18f36.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e9ddd28ad880/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88806a1ef1d0, owner = 0x0, curr 0xffff88802561ba80, list empty
WARNING: CPU: 1 PID: 10307 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 1 PID: 10307 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 1 PID: 10307 Comm: syz-executor.5 Not tainted 6.2.0-rc3-syzkaller-00014-g40c18f363a08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 00 ad ed 8a 48 c7 c6 a0 af ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 9b 59 e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 98 a4 96 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900053ef840 EFLAGS: 00010292
RAX: 7a73507bb1e00700 RBX: ffffffff8aedade0 RCX: ffff88802561ba80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900053ef910 R08: ffffffff816f2c9d R09: fffff52000a7dec1
R10: fffff52000a7dec1 R11: 1ffff92000a7dec0 R12: 0000000000000000
R13: ffff88806a1ef1d0 R14: 1ffff92000a7df10 R15: dffffc0000000000
FS:  00007fd23b092700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555ea4848 CR3: 000000001d10d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:761 [inline]
 open_last_lookups fs/namei.c:3485 [inline]
 path_openat+0x14ff/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd23a28c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd23b092168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd23a3ac050 RCX: 00007fd23a28c0c9
RDX: 0000000000000240 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007fd23a2e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdfbd42a1f R14: 00007fd23b092300 R15: 0000000000022000
 </TASK>

