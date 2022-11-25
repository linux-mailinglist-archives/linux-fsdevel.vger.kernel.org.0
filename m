Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA6638B5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 14:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKYNhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 08:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKYNhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:37:45 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF489FCF1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 05:37:43 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c23-20020a6b4e17000000b006db1063fc9aso2073451iob.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 05:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MylCb3p+Ls6myJyGJs1nv54tAD4Nw5G5SgxoxqrICpQ=;
        b=VJFu8UX5+WyfcRaN/fMQFC3ME3DFhKDYsqzVcjyT27p8lE59HsuYU5cf/qMEXuVf9g
         IThTKAVeVQ6X5N/qCebcnqphfz094ULfAoqTwbun0D/Y5Yy1j0EGbFk2/t1yV/9UTsl2
         izD/ubQ+xAdmSMExui4pu75wpM1vZoD9ZIQkCeLH8YObo1UgKd3spd1vxIC/fyZyCiLC
         FCzPSfAc321xVDIoyG4IHMIe3aZ496/C2Ndydxucu/N8870JonIP7oF2/P5htrJo13ro
         ZN8zsqIJQirXkuS2Dd6iiN96cmVAXuNmrHl4LwjDduBIWC6hxaZbtdGoqrKkLZdIt0HJ
         5mvA==
X-Gm-Message-State: ANoB5pntmk1wp+tHog9qX2aBDYIV7Ycq44pxv84+a8q3vI100tzGeE7J
        KmM0kdUHkoJJwsRwZN8nAaWTIYtPKeZXs2qYJMaj+sqAZItM
X-Google-Smtp-Source: AA0mqf5sxHXLzFtKueDQg2b5fadddVGPga7WERR+IPad9WPKkIILVUC6WdR5P06FlOc0vfVE+YDnO1HPRp3QWtQFH3dhVORgZcYg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f52:b0:302:b44f:a09 with SMTP id
 y18-20020a056e020f5200b00302b44f0a09mr10193988ilj.227.1669383463212; Fri, 25
 Nov 2022 05:37:43 -0800 (PST)
Date:   Fri, 25 Nov 2022 05:37:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000519d0205ee4ba094@google.com>
Subject: [syzbot] WARNING in iov_iter_revert (3)
From:   syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>
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

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105ff881880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=8c7a4ca1cc31b7ce7070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7897 at lib/iov_iter.c:918 iov_iter_revert+0x394/0x850
Modules linked in:
CPU: 0 PID: 7897 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:iov_iter_revert+0x394/0x850 lib/iov_iter.c:918
Code: 80 3c 01 00 48 8b 5c 24 20 74 08 48 89 df e8 e3 c9 a3 fd 4c 89 2b 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 5c b1 4f fd <0f> 0b eb e8 48 8d 6b 18 48 89 e8 48 c1 e8 03 42 80 3c 28 00 74 08
RSP: 0018:ffffc90015fe7ac8 EFLAGS: 00010287
RAX: ffffffff843ae714 RBX: ffffc90015fe7e40 RCX: 0000000000040000
RDX: ffffc9000c1cc000 RSI: 000000000003ef70 RDI: 000000000003ef71
RBP: fffffffffff80e18 R08: ffffffff843ae3bc R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: fffffffffff80e18
R13: ffffc90015fe7e40 R14: ffffc90015fe7e50 R15: 000000007fefef0c
FS:  00007f212fd7e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00c59ffb8 CR3: 000000007dc32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_file_read_iter+0x3d4/0x540 mm/filemap.c:2804
 do_iter_read+0x6e3/0xc10 fs/read_write.c:796
 vfs_readv fs/read_write.c:916 [inline]
 do_preadv+0x1f4/0x330 fs/read_write.c:1008
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f212f08b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f212fd7e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000147
RAX: ffffffffffffffda RBX: 00007f212f1ac1f0 RCX: 00007f212f08b639
RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f212f0e6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc886837f R14: 00007f212fd7e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
