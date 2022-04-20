Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1439508BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiDTPRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiDTPRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:17:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76253EABE
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 08:14:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c6so2714578edn.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyhnT3S9LREa/PJcUvjDmD1nY9IkR07FNMCsUt52Jy4=;
        b=aT/Gd5rLhE2unVfrl7s+gRgj+bZLy2p7OjaU8CTj8Cj3jWVf9FS4NwaZR0ZFqAbtxT
         w7I/OrbtpbO2KvDDy6YAPogiPtI/IlO6iIU0bdRke4N8oV1+CNaE5Ul9SERzmqSebb69
         RX4hGqkyH3zGxHIUUFFs9sHFFGNV25mJGnwK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyhnT3S9LREa/PJcUvjDmD1nY9IkR07FNMCsUt52Jy4=;
        b=UETIh2WzPCJxWUuyK8Eh3wt5rOAf1v6nBoZOVKyLxvvS/pX175gty49DyI/s04BDRW
         HfF2Kv3ysr7Oij4R3W9k3VqKjBzmUNYtcFa7msHFxVe+14OsNp1LbRZet4BvZFQ/VJqs
         mKkPyfL966Q1EDAGYmzFMF9ZUwEXK42HETkW1qzBpbhQy3bEvSK5zmxFQ/mbjPjQZZv/
         MqY2F6g8h1aWtQ6sE75rrmtxP0Ld4iaAQvAZydgJh0amrqCFluzK/FwKKdqBQiY8bCDZ
         Yy1KehhjJVGwKUZQSLgooBgWnQpsQD5wJDSCNO/Ar1F2l24di096r5+LoiRngoETTMWv
         rAww==
X-Gm-Message-State: AOAM532+2IwnNdD5EieDsEaX7NoyvEaL3g/cpD6a7tJRF8XAQCzBnaoU
        5Hx7KHf25+TrSwIZN+KiNiP9BO3Cz1Db0lg8DFrNFQ==
X-Google-Smtp-Source: ABdhPJwEjwjbxxGf9KaBZVVvXKgqQoE5eGuB6H6+D5Gim9u7yx6WZmM1Knh+yfw2qbYWv5OhyeIOjah61kzGh3pFqbs=
X-Received: by 2002:a05:6402:274b:b0:423:fe73:95a0 with SMTP id
 z11-20020a056402274b00b00423fe7395a0mr9912851edd.224.1650467657421; Wed, 20
 Apr 2022 08:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e88cad05d1525c27@google.com>
In-Reply-To: <000000000000e88cad05d1525c27@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Apr 2022 17:14:06 +0200
Message-ID: <CAJfpegsd-TokH5b8pgLr2mR2QQq7u-_E+8LYMwkT5BCtEyPffA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in fuse_writepage_locked
To:     syzbot <syzbot+d0dd8d6b123d46c4dcf2@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 21 Nov 2021 at 21:29, syzbot
<syzbot+d0dd8d6b123d46c4dcf2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137ec159b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d3b8fd1977c1e73
> dashboard link: https://syzkaller.appspot.com/bug?extid=d0dd8d6b123d46c4dcf2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.

Likely a dup:

#syz dup: WARNING in fuse_write_file_get

>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d0dd8d6b123d46c4dcf2@syzkaller.appspotmail.com
>
> WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_write_file_get fs/fuse/file.c:1833 [inline]
> WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_write_file_get fs/fuse/file.c:1830 [inline]
> WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_writepage_locked+0xa84/0xd40 fs/fuse/file.c:1918
> Modules linked in:
> CPU: 1 PID: 17813 Comm: syz-executor.2 Not tainted 5.16.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:fuse_write_file_get fs/fuse/file.c:1833 [inline]
> RIP: 0010:fuse_write_file_get fs/fuse/file.c:1830 [inline]
> RIP: 0010:fuse_writepage_locked+0xa84/0xd40 fs/fuse/file.c:1918
> Code: 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 bc f4 ff ff ff e9 2d ff ff ff e8 8a dd c6 fe 48 8b 3c 24 e8 b1 fe a3 06 e8 7c dd c6 fe <0f> 0b 49 8d be c8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa
> RSP: 0018:ffffc90018f3f5f0 EFLAGS: 00010212
> RAX: 000000000000a311 RBX: ffff8880834ba688 RCX: ffffc9000d9e9000
> RDX: 0000000000040000 RSI: ffffffff82b10a64 RDI: 0000000000000001
> RBP: ffffea0000263e40 R08: 0000000000000000 R09: ffff8880834ba7a3
> R10: ffffed10106974f4 R11: 000000000000001f R12: ffff8880834ba1c0
> R13: ffffea000258d080 R14: ffff888018b83c00 R15: ffff88814a7ac800
> FS:  00007f75e4cad700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc15c0ef7c CR3: 0000000073f74000 CR4: 0000000000350ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>  <TASK>
>  fuse_writepage+0x104/0x160 fs/fuse/file.c:1976
>  writeout mm/migrate.c:826 [inline]
>  fallback_migrate_page mm/migrate.c:850 [inline]
>  move_to_new_page+0x7ea/0xf00 mm/migrate.c:901
>  __unmap_and_move mm/migrate.c:1063 [inline]
>  unmap_and_move mm/migrate.c:1204 [inline]
>  migrate_pages+0x27f5/0x3810 mm/migrate.c:1481
>  compact_zone+0x1abb/0x3860 mm/compaction.c:2399
>  compact_node+0x129/0x1f0 mm/compaction.c:2683
>  compact_nodes mm/compaction.c:2699 [inline]
>  sysctl_compaction_handler+0x10e/0x160 mm/compaction.c:2741
>  proc_sys_call_handler+0x437/0x620 fs/proc/proc_sysctl.c:586
>  call_write_iter include/linux/fs.h:2162 [inline]
>  new_sync_write+0x429/0x660 fs/read_write.c:503
>  vfs_write+0x7cd/0xae0 fs/read_write.c:590
>  ksys_write+0x12d/0x250 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f75e7737ae9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f75e4cad188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f75e784af60 RCX: 00007f75e7737ae9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f75e7791f6d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffee68ffeff R14: 00007f75e4cad300 R15: 0000000000022000
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
