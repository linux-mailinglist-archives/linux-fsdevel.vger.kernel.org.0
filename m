Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34A663B512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiK1W6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 17:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiK1W5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:57:52 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC61DA51
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:50 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso7059553iob.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9Zslu+374mV4v3rdyS4dptOs0an64BkcbviyYygMKY=;
        b=RFDElwrTKJmzSoztdk26ZJZgC3GkeG5FEmeaDEaQQog124ALONjK13jOcMp4jxRkvl
         fDCsSV4kFz458dMDuIxYn81p0UOmh/EltAbCEsHxeXnH44TDVnOsVxGdR9oP3U5eZmAr
         cEkIfEBjBnettw9slrrptsNc6l9MeK7LyxmWABgGaRaTOM/Lduj7NUJXlzrslUYMRCEi
         0WKax7RRJAWeB+X8ewy8ci++67tBZZTNdyjC0SzPdscwQeBRIrlhGUkGRXpS2VeFjRs5
         GAi6Ofnb3rKH8UBuKSOdf0xOL7r/eyOA028GMHjWqtW67oYGrrwWmSY0nuu1CzNDAg+n
         S8xg==
X-Gm-Message-State: ANoB5pmkLuqkPz5KMQsjLWciBefAmKawkdUyDLftMbjlMCM6tq/Ejck8
        9zohveYypEpD92Gk13k6SBo6+sx5QEyNEYjz2EZDnC64Mpg+
X-Google-Smtp-Source: AA0mqf6JnUKEsSgMERO94OvBnY5xscDjj25wJZrd/XQtzyIQupgQkMmtbfbcO5kgcJnBZllXZqOhIr7J2UZ948QggFbNBciuEWHw
MIME-Version: 1.0
X-Received: by 2002:a5d:980d:0:b0:6a0:ee21:53fb with SMTP id
 a13-20020a5d980d000000b006a0ee2153fbmr16057838iol.190.1669676269954; Mon, 28
 Nov 2022 14:57:49 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:57:49 -0800
In-Reply-To: <000000000000519d0205ee4ba094@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5ecad05ee8fccf0@google.com>
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
From:   syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1498138d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c7a4ca1cc31b7ce7070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17219fbb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172d94d5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b1f44a556b42/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3655 at lib/iov_iter.c:918 iov_iter_revert+0x394/0x850
Modules linked in:
CPU: 0 PID: 3655 Comm: syz-executor207 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:iov_iter_revert+0x394/0x850 lib/iov_iter.c:918
Code: 80 3c 01 00 48 8b 5c 24 20 74 08 48 89 df e8 33 c0 a7 fd 4c 89 2b 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 dc a5 53 fd <0f> 0b eb e8 48 8d 6b 18 48 89 e8 48 c1 e8 03 42 80 3c 28 00 74 08
RSP: 0018:ffffc90003c0fac8 EFLAGS: 00010293
RAX: ffffffff8436f214 RBX: ffffc90003c0fe40 RCX: ffff888026a39d40
RDX: 0000000000000000 RSI: fffffffffffa6000 RDI: 000000007ffff000
RBP: fffffffffffa6000 R08: ffffffff8436eebc R09: fffffbfff1cebe0e
R10: fffffbfff1cebe0e R11: 1ffffffff1cebe0d R12: fffffffffffa6000
R13: ffffc90003c0fe40 R14: ffffc90003c0fe50 R15: 000000007ffa4000
FS:  00007fc698110700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000000235e6000 CR4: 00000000003506e0
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
RIP: 0033:0x7fc698185789
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6981102e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000147
RAX: ffffffffffffffda RBX: 00007fc6982297b8 RCX: 00007fc698185789
RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc6982297b0
R13: 00007fc6981f67e4 R14: 6573726168636f69 R15: 0030656c69662f2e
 </TASK>

