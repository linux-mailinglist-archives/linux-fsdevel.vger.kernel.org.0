Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB96D4534
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjDCNED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjDCND5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:03:57 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0495260
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:03:47 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id a9-20020a921a09000000b003264524481cso6806814ila.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 06:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527026; x=1683119026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeW8ljnyP6swcMnfaUC9awkjoZoVFaQ6LdG1DUitAXs=;
        b=qssY1acTSrjL5/zb3l+YYr9acc0clD2kRscnsliB0YXs8o67TORafE3lQMWXTY8Y0h
         Llm7Wq2pOLZiAn9XuV/2IJvEVp4+IlVFQBAZUDNILIYXmv8kcZBwmPrM+RgUfo08zZXk
         ThCgTdtulfkw6Vu4lDAA97Web4EF4yMez3Wk+5eW56tNiEby8osqSgJll3nEVW11e06p
         YBcV2V1w2aVNg3mmCw2TBQYmrscq5tScwL9GV3q5OS1Hm5ewny9SvUnroruQ5PyjFZXl
         WvaDKlF62Gx5DX7CGvF6YJthuSiCczXUuI4jHBzYBxYBEfhyjSy1sq/FX/cNuserqUgz
         zu0g==
X-Gm-Message-State: AAQBX9cF5LuIr/DRRzy6Unt1CjU0ZLNBOz6OZllb50rgjlKBnixuiI0r
        welPmG+pw2eq29AeY+3yFhHe97YefS/caN9dpdUTdEqcBYi/
X-Google-Smtp-Source: AKy350ZwMHK9GlM9NB+l45StTEeFEY2I9o7NtOhRqFo/jS2Mo2/nF7emiLmnqIYqLlap8/XeB+AaSP8IC5hwqZ064lvA1k92ZIWw
MIME-Version: 1.0
X-Received: by 2002:a92:7b06:0:b0:326:61cb:5f3b with SMTP id
 w6-20020a927b06000000b0032661cb5f3bmr3181458ilc.3.1680527026483; Mon, 03 Apr
 2023 06:03:46 -0700 (PDT)
Date:   Mon, 03 Apr 2023 06:03:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007301c505f86e3072@google.com>
Subject: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in attr_set_size
From:   syzbot <syzbot+14a2433710a3affee84e@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7e364e56293b Linux 6.3-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a94395c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9a438ce47536f0c
dashboard link: https://syzkaller.appspot.com/bug?extid=14a2433710a3affee84e
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54c56bddacf4/disk-7e364e56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/447e5d1af596/vmlinux-7e364e56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e2d1545e7be/bzImage-7e364e56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14a2433710a3affee84e@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs3/attrib.c:450:9
shift exponent 64 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 1 PID: 1832 Comm: syz-executor.1 Not tainted 6.3.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c3/0x420 lib/ubsan.c:387
 attr_set_size+0x32c2/0x4290 fs/ntfs3/attrib.c:450
 ntfs_extend_mft+0x188/0x4b0 fs/ntfs3/fsntfs.c:511
 ntfs_look_free_mft+0x43d/0x10b0 fs/ntfs3/fsntfs.c:589
 ntfs_create_inode+0x4d7/0x3830 fs/ntfs3/inode.c:1296
 ntfs_atomic_open+0x3db/0x530 fs/ntfs3/namei.c:424
 atomic_open fs/namei.c:3279 [inline]
 lookup_open fs/namei.c:3387 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x103c/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f99f548c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f99f622e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f99f55abf80 RCX: 00007f99f548c0f9
RDX: 0000000000000000 RSI: 0000000000060142 RDI: 0000000020000000
RBP: 00007f99f54e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd74d2bccf R14: 00007f99f622e300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
