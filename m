Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA85F9A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiJJHkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiJJHkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:12 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D35F225
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l18-20020a056e02067200b002f6af976994so8251176ilt.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3PuK6BkkpDeeSeKboKKuamEJPG6dqd6D3eivM/BEN8=;
        b=N/nVqyaENIgP4ooEGcOVnTeJk2ez5IYwvYIz4tHsflTdU+SZOpmrErsAEm/7yQOxS5
         b5+8tqEGIeJ1kBKIOMGQrnOnoAaNAq/ybyaADDBRSdIsrH7GTdBeFSPs//3zhI1I8kto
         Nt+zbv+tzUKqEglHcmMCaSD5uS+FJ/veXlXTipRseoG15NFOGTyNu96f246hApRG72uk
         ng60iR+FOPROklxZAd44Q4WoT7zbGChSu0v/jqbJyIkebaknmhAnyX5VrSIEURrc4WXR
         uYM0jtBvWmDZRcOnEYePPBDfb6ti+21MMMBRaCz1YrLmgsiX9OPMf5PBe7WgZy3Ob/Cv
         jo5A==
X-Gm-Message-State: ACrzQf1Ei8LXpu0IVl/kdEdejp4kK0HSl44PlRX7TNYabWco2OFjtA/q
        HbN/A92fF/NBGGKqhLd/bb407J/HOksC+Yo+I1fy8mEXpSGW
X-Google-Smtp-Source: AMsMyM4lQhWf7VIxsfea2/gNVGnioYJiG5PEBVy+2SHEyZRVewARjbmNNF+CrR9TdC58JEJqCh+Qf73qMPw0qDqdc2PAOvTf3cHg
MIME-Version: 1.0
X-Received: by 2002:a92:c514:0:b0:2f9:2b06:6283 with SMTP id
 r20-20020a92c514000000b002f92b066283mr8254283ilg.287.1665387338571; Mon, 10
 Oct 2022 00:35:38 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:35:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baa88c05eaa934bb@google.com>
Subject: [syzbot] stack segment fault in truncate_inode_pages_final
From:   syzbot <syzbot+0f7dd5852be940800ca4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cae158880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=676645938ad4c02f
dashboard link: https://syzkaller.appspot.com/bug?extid=0f7dd5852be940800ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f66757bbae28/disk-833477fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50ec5a2788dd/vmlinux-833477fc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f7dd5852be940800ca4@syzkaller.appspotmail.com

stack segment: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 22407 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-05118-g833477fce7a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0x55f/0x780 kernel/locking/lockdep.c:5677
Code: 48 c7 c0 40 e8 ca 8d 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e0 01 00 00 48 8b 05 65 42 6d 0c e8 80 2e 06 <00> 85 c0 74 17 65 ff 0d 55 c9 a4 7e 0f 85 3e fb ff ff e8 ec ce a2
RSP: 0018:ffffc90005367a10 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff92000a6cf44 R08: 0000000000000000 R09: ffffffff8ddf9957
R10: fffffbfff1bbf32a R11: 0000000000000000 R12: ffff888093973498
R13: ffff888093973278 R14: ffffffff8a22b140 R15: ffff8880478d8a00
FS:  00007f9ae3bb2700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e927000 CR3: 000000003f6b9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
 _raw_spin_unlock_irq+0x12/0x40 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:399 [inline]
 truncate_inode_pages_final+0x5f/0x80 mm/truncate.c:484
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9ae2a8bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9ae3bb1f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f9ae2a8bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f9ae3bb1fe0
RBP: 00007f9ae3bb2020 R08: 00007f9ae3bb2020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f9ae3bb1fe0 R15: 0000000020000140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0x55f/0x780 kernel/locking/lockdep.c:5677
Code: 48 c7 c0 40 e8 ca 8d 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e0 01 00 00 48 8b 05 65 42 6d 0c e8 80 2e 06 <00> 85 c0 74 17 65 ff 0d 55 c9 a4 7e 0f 85 3e fb ff ff e8 ec ce a2
RSP: 0018:ffffc90005367a10 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff92000a6cf44 R08: 0000000000000000 R09: ffffffff8ddf9957
R10: fffffbfff1bbf32a R11: 0000000000000000 R12: ffff888093973498
R13: ffff888093973278 R14: ffffffff8a22b140 R15: ffff8880478d8a00
FS:  00007f9ae3bb2700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e927000 CR3: 000000003f6b9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
