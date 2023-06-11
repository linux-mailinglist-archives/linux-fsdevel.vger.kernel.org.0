Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19F72B02C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 05:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjFKD4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjFKD4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 23:56:06 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72E13A
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 20:56:01 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7775dd6c7e1so390350439f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 20:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686455761; x=1689047761;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU4x9DhYorffWC0i+QsBM5FEZiBkueCJZ67W6vkSBZs=;
        b=TwtodtWoyCcOTpYeTf877RPDzmNabob8CNUVAjjTIkQ3NdCnZEdu1W078kt1w4R0Pc
         Cu4lkyLHXl2kWjuOHxVN94DvtdxLhNSVOF2xFXWxFVN278SxUS6RmG3wzXrSLj95rkdA
         /Pi+4JuCqq7txWZdhqtckh9x42FddduEzn6k02vTvOX7xVcx4p+jvIza5C4rovZ8hew6
         Nb9+lgEhR9Q9cXT40o1y/zINJTzZ7fFZ06gYgdWs+oP+ogHz73BJYnmTqhY+69TqyUI6
         9n0ncFWZPyiDQh1WEz3XZ5hT1WdLAJRReC6vKxlcS9c0eyV/XDm6ZdwODG+NnTf8MDid
         GOSQ==
X-Gm-Message-State: AC+VfDxZ07rgGzdHZj89RCkCpeTgnvKmN3eVxoM/bOcsoS3Uo+w/FwG/
        wihPhqHqVPzLlHcxtxTw3Yo7HNIE3IByx9ms1EEhqNUKVlwR
X-Google-Smtp-Source: ACHHUZ4sdgHPPL8tjt0y8aQiWptKTX2zdtRXffylGQnJFnmhM9qn0/9pr8EfftbmhVy3zqj8U+UAaGufDqmUOjrzhUHtnRO/Vy+5
MIME-Version: 1.0
X-Received: by 2002:a02:a1db:0:b0:40b:d54d:e5bf with SMTP id
 o27-20020a02a1db000000b0040bd54de5bfmr2178215jah.1.1686455760977; Sat, 10 Jun
 2023 20:56:00 -0700 (PDT)
Date:   Sat, 10 Jun 2023 20:56:00 -0700
In-Reply-To: <000000000000da4f6b05eb9bf593@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009005ad05fdd2948c@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_clear_dirty_page
From:   syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118151dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=53369d11851d8f26735c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e9d48b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7fa63280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb6ca005422c/disk-022ce886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/172bf908a89e/vmlinux-022ce886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a00b7ed8430/bzImage-022ce886.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/edff56b4a75d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5040 Comm: syz-executor116 Not tainted 6.4.0-rc5-syzkaller-00305-g022ce8862dff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:nilfs_clear_dirty_page+0xa9/0x1130 fs/nilfs2/page.c:388
Code: 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 1b 38 97 fe 48 8b 1b 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 f9 37 97 fe 4c 8b 2b 49 8d 5d 28 48
RSP: 0018:ffffc90003d2f2e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0001cb1900
RBP: ffffc90003d2f3b0 R08: ffffffff834bef29 R09: fffff94000396321
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0001cb1900
R13: 0000000000000000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f996874e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fe30356e00 CR3: 000000002995d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_clear_dirty_pages+0x1e0/0x370 fs/nilfs2/page.c:373
 nilfs_writepages+0x11c/0x160 fs/nilfs2/inode.c:165
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 filemap_write_and_wait_range+0x1d4/0x2c0 mm/filemap.c:678
 generic_file_read_iter+0x19e/0x540 mm/filemap.c:2805
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x240/0x640 fs/splice.c:419
 do_splice_to fs/splice.c:902 [inline]
 splice_direct_to_actor+0x40c/0xbd0 fs/splice.c:973
 do_splice_direct+0x283/0x3d0 fs/splice.c:1082
 do_sendfile+0x620/0xff0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9970ac36f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f996874e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9970b497b0 RCX: 00007f9970ac36f9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007f9970b15b1c R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007f9970b150c0
R13: 00000000200026c0 R14: 0032656c69662f2e R15: 00007f9970b497b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_clear_dirty_page+0xa9/0x1130 fs/nilfs2/page.c:388
Code: 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 1b 38 97 fe 48 8b 1b 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 f9 37 97 fe 4c 8b 2b 49 8d 5d 28 48
RSP: 0018:ffffc90003d2f2e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0001cb1900
RBP: ffffc90003d2f3b0 R08: ffffffff834bef29 R09: fffff94000396321
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0001cb1900
R13: 0000000000000000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f996874e700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9970b1500a CR3: 000000002995d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 d8             	mov    %rbx,%rax
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   c:	74 08                	je     0x16
   e:	48 89 df             	mov    %rbx,%rdi
  11:	e8 1b 38 97 fe       	callq  0xfe973831
  16:	48 8b 1b             	mov    (%rbx),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 f9 37 97 fe       	callq  0xfe973831
  38:	4c 8b 2b             	mov    (%rbx),%r13
  3b:	49 8d 5d 28          	lea    0x28(%r13),%rbx
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
