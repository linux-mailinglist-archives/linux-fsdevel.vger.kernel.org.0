Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF60D64CDB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiLNQHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 11:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiLNQHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:07:47 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4FB248F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 08:07:45 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so4101029iol.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 08:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um3wEGANdEp2NWZvYOJ5VoF+hiKrrgSNQrCCKjoudo0=;
        b=m5L640gyXVqZH1phCYXBLgO4B0ScVMIbDnFyxVFYLVxzHoCjwCzcr7VrwhGknUU3be
         06HMKgezxl0qYXUwbGZa9F7yf5zO+u2jVr9/4e72YQC96vVgIquWV3hZH2i1esY2F+qy
         q1oxpsCw9Xo+PjFTbYqIy9UVpfTODUCfVd+ufncUUSpdxGArQatJJKZGSRAMzr67XKrw
         dMhy7eg5PAY74kTlDg86vDXM5SdaMQF3a+puMXen8dF6qVbJGn8aFZZhS2mYH5VEvNw0
         usahII11vUz4EliaJilJ2Keqp/3k3YHL/sCIflkhGprSi+Tgj9IZIVDLCFpP3AiMQ1qF
         i67Q==
X-Gm-Message-State: ANoB5plrQVhmcnBlJ1oZly30eblrVG9hN4SJm0lVXMV6E1n7KrfHGgvL
        ZmuL5zDkhYAeRtaVAtGvaVmm7h++qn90gsSG0RuWUv5F9Jjr
X-Google-Smtp-Source: AA0mqf59fBM1QA7sX3/AHJpec9zPmTwl4A1541cgnG+4JD+9jgDd6/1KXtkWq7md+mf+4atxKZsKsolyqHtiLjImrx+vQ5/tDPkH
MIME-Version: 1.0
X-Received: by 2002:a02:6a43:0:b0:375:4725:4b4f with SMTP id
 m3-20020a026a43000000b0037547254b4fmr46208214jaf.52.1671034064631; Wed, 14
 Dec 2022 08:07:44 -0800 (PST)
Date:   Wed, 14 Dec 2022 08:07:44 -0800
In-Reply-To: <00000000000057fa4605ef101c4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d47fb105efcbef24@google.com>
Subject: Re: [syzbot] WARNING in hfsplus_free_extents
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

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16de56af880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0bc9f818702ff75b76
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13773757880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aad47431ccd/disk-e2ca6ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/382636835ba9/vmlinux-e2ca6ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac62c9f6a7cf/bzImage-e2ca6ba6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e456a1aeddb8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5902 at fs/hfsplus/extents.c:346 hfsplus_free_extents+0x700/0xad0
Modules linked in:
CPU: 1 PID: 5902 Comm: syz-executor.3 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfsplus_free_extents+0x700/0xad0 fs/hfsplus/extents.c:346
Code: 0f cb 44 89 ef 89 de e8 ae 9f 2c ff 41 39 dd 75 20 49 83 c7 28 e8 00 9e 2c ff 41 bc 05 00 00 00 e9 e3 f9 ff ff e8 f0 9d 2c ff <0f> 0b e9 86 f9 ff ff 44 89 ef 89 de e8 7f 9f 2c ff 41 29 dd 73 0a
RSP: 0018:ffffc9000572f890 EFLAGS: 00010293
RAX: ffffffff825eaf40 RBX: ffff88801dcc1020 RCX: ffff88801ec90000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802a604048
RBP: ffff888028316000 R08: dffffc0000000000 R09: ffffed10054c080a
R10: ffffed10054c080a R11: 1ffff110054c0809 R12: 00000000000000f4
R13: 00000000000000f5 R14: 00000000000000f5 R15: ffff88806d2f06d8
FS:  00007febcaf33700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f632ad26718 CR3: 0000000029d10000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_file_truncate+0x827/0xbb0 fs/hfsplus/extents.c:591
 hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7febca28c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007febcaf33168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007febca3ac050 RCX: 00007febca28c0d9
RDX: 000000006db6e559 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007febca2e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd9093baff R14: 00007febcaf33300 R15: 0000000000022000
 </TASK>

