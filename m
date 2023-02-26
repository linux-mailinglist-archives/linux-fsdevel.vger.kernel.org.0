Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09826A3258
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBZPcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 10:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBZPcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:32:02 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F321C674
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 07:29:30 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id m7-20020a924b07000000b003170cef3f12so2550021ilg.22
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 07:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRV0BVLtP52549vMKkrKGdQrZnP3iMyF48xKc9khzkU=;
        b=2ShssRZWtfDiwMafKrlWHgEv8KlEMNVr+m4wZ1Q8D/JWG6hsEIntQrpl7d2NAUD8MZ
         JW4K9F5kigCes2bGODvSa3rziRVwQByOWbJMyNWC3Pbca4m3vPO2l/L79Mvq/d414SHy
         bUizjTP1lBf+XcAFX5ALrAuhu7bjr9QsIqMH1pgLZGJXicCiffyy7BLce1JVu30z37IG
         WwGPKrVw1+vcI7A4U8zeeNxdziTCjW3kemMXyVFmpKBR8naydzwYP3vxtgsXim5wVGbI
         imMhXTSJQVnO0eeXGXsbP4+PZFoPUCcQ6BSER5boCV+fhVayp0yw8uy8Ai5YAo2PS2Y5
         OXPw==
X-Gm-Message-State: AO0yUKUKoF0zxsq95eM9U2EVnofctH95xPH9dgERxnFADvsk8/HmykW7
        lP6VBlkvhsAkrlCMudSdk+1oo4obxtUAgtnU2jFryMGLnEcndAI=
X-Google-Smtp-Source: AK7set+v0Hn3n2ZAEuS+Wqe6EcNo8pDjg3JjlhF/vEFT4/WgAfZQa9gUNQHzdlXwX6c+ZDNBF5593VEE/ylJTF6ntEUPamhKzOdP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1122:b0:3c5:1302:c88c with SMTP id
 f2-20020a056638112200b003c51302c88cmr9012652jar.0.1677425324833; Sun, 26 Feb
 2023 07:28:44 -0800 (PST)
Date:   Sun, 26 Feb 2023 07:28:44 -0800
In-Reply-To: <0000000000001b987605f47b72d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fc0a105f59c0428@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING: locking bug in take_dentry_name_snapshot
From:   syzbot <syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    8232539f864c Add linux-next specific files for 20230225
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f3f254c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fe68735401a6111
dashboard link: https://syzkaller.appspot.com/bug?extid=5a195884ee3ad761db4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11de1350c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e26960c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4259815e0cee/disk-8232539f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ea6ea28200d/vmlinux-8232539f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e461f15ffd6b/bzImage-8232539f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ba8c8f871670/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com

overlayfs: upper fs does not support tmpfile.
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 9271 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 9271 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:221 [inline]
WARNING: CPU: 0 PID: 9271 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4730 [inline]
WARNING: CPU: 0 PID: 9271 at kernel/locking/lockdep.c:232 __lock_acquire+0x1615/0x5d40 kernel/locking/lockdep.c:5006
Modules linked in:
CPU: 0 PID: 9271 Comm: syz-executor233 Not tainted 6.2.0-next-20230225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:221 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4730 [inline]
RIP: 0010:__lock_acquire+0x1615/0x5d40 kernel/locking/lockdep.c:5006
Code: 08 84 d2 0f 85 b4 3d 00 00 8b 15 22 11 13 0d 85 d2 0f 85 31 fb ff ff 48 c7 c6 a0 74 4c 8a 48 c7 c7 e0 68 4c 8a e8 5b 4f e6 ff <0f> 0b 31 ed e9 e9 ed ff ff e8 2d 6f b3 02 85 c0 0f 84 c1 fa ff ff
RSP: 0018:ffffc90003a9f7f8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff9200089f RCX: 0000000000000000
RDX: ffff88807d953a80 RSI: ffffffff814c1907 RDI: 0000000000000001
RBP: 0000000000000e17 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88807d954530
R13: ffff88807d953a80 R14: 0000000000040000 R15: 0000000000040e17
FS:  00007fba7628a700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba6e0b3000 CR3: 0000000021c3d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11a/0x370 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 take_dentry_name_snapshot+0x2b/0x170 fs/dcache.c:315
 ovl_check_rename_whiteout fs/overlayfs/super.c:1207 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1329 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
 ovl_fill_super+0x2090/0x7270 fs/overlayfs/super.c:2000
 mount_nodev+0x64/0x120 fs/super.c:1417
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1501
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fba762deb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba7628a2f8 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fba76364780 RCX: 00007fba762deb29
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007fba763311d0 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0079616c7265766f
R13: d5e172a4510865ec R14: 9837512483e3bdcd R15: 00007fba76364788
 </TASK>

