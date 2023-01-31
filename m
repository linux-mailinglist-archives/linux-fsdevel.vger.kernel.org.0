Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE3683891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAaVZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 16:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAaVZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:25:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080B2A161
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:25:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id v17-20020a92ab11000000b00310c6708243so8470886ilh.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bz/qeOSRBhOsHSdqa1OWiWBUdsNdmoTzukYO2CDzqI=;
        b=QJk+VMnja2J/Sm1+IWSDKQ8sCfuZFK2oq7wgbDAVRxGPGaHS10ao+E/13WE1v39+WH
         QU22woKs35iFfkkY92v7Xk5N71IKkcPlk4Fy8qf7bHl2++OpiA5pDbzqmy+DgSvbF5An
         p0SjCvHtCTc03zhAXoPalVD+NpnlJWpW6uFZOt1v72/oObuUVVHplvo2K00HDZGHwUrP
         6YZVB+SLuSi6VKwJFUNf1bLMMBiOuvW3npMYCRkTgAKWGHIcmtttOG24Bdh1nEkKNHC2
         TAfPuBCIriEVBE33cNS5UulPtTnUPnQXr0NQYTgHlnbY9ox8SHBHlyLpeR1DdYBmebCO
         CIwQ==
X-Gm-Message-State: AO0yUKXYITLu0r8oHfAwODHRFH5YFiP7sI6StO4Z84sIkeWd2BAZJcGH
        DYUOYU3v3nbnhOYuH7pR0KfExvnPGfKoL3n8a8igVymexAo2
X-Google-Smtp-Source: AK7set9s7EsFwmiqYsFE/zmIxaXWzFtfx/XSA4hONDgfkrUxK2ut4/AKYCYgFdcATJp3ahEhKX+mQnENsP6ZmobpHhmbi9y0nn+Z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:217:b0:3a9:6e0c:e144 with SMTP id
 e23-20020a056638021700b003a96e0ce144mr3499093jaq.62.1675200338032; Tue, 31
 Jan 2023 13:25:38 -0800 (PST)
Date:   Tue, 31 Jan 2023 13:25:38 -0800
In-Reply-To: <00000000000057fa4605ef101c4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013805905f395f9a9@google.com>
Subject: Re: [syzbot] [hfsplus?] WARNING in hfsplus_free_extents
From:   syzbot <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    22b8077d0fce Merge tag 'fscache-fixes-20230130' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fc1143480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=515c3f0f31692bf1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0bc9f818702ff75b76
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f700fd480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dcfe59480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e02f2807881e/disk-22b8077d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e28769c4bbea/vmlinux-22b8077d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd96facd9902/bzImage-22b8077d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/47d90a9d05ce/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5302 at fs/hfsplus/extents.c:346 hfsplus_free_extents+0x700/0xad0
Modules linked in:
CPU: 1 PID: 5302 Comm: syz-executor176 Not tainted 6.2.0-rc6-syzkaller-00003-g22b8077d0fce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:hfsplus_free_extents+0x700/0xad0 fs/hfsplus/extents.c:346
Code: 0f cb 44 89 ef 89 de e8 6e 5c 2c ff 41 39 dd 75 20 49 83 c7 28 e8 c0 5a 2c ff 41 bc 05 00 00 00 e9 e3 f9 ff ff e8 b0 5a 2c ff <0f> 0b e9 86 f9 ff ff 44 89 ef 89 de e8 3f 5c 2c ff 41 29 dd 73 0a
RSP: 0018:ffffc900041cf890 EFLAGS: 00010293
RAX: ffffffff825e7170 RBX: ffff8880715f7020 RCX: ffff888075660000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802801c048
RBP: ffff88807a33e000 R08: dffffc0000000000 R09: ffffed100500380a
R10: ffffed100500380a R11: 1ffff11005003809 R12: 0000000000000144
R13: 0000000000000146 R14: 0000000000000146 R15: ffff88802aec2898
FS:  00007f552e806700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020056000 CR3: 0000000022bd1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_file_truncate+0x827/0xbb0 fs/hfsplus/extents.c:591
 hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5536bfb599
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f552e8062f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5536c807b8 RCX: 00007f5536bfb599
RDX: 00000000000ffe00 RSI: 0000000020004200 RDI: 0000000000000004
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5536c807b0
R13: 00007f5536c7e140 R14: 00007f5536c4d904 R15: 0031656c69662f2e
 </TASK>

