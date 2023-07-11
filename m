Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC60474E92F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGKIfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 04:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGKIfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:35:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FD98;
        Tue, 11 Jul 2023 01:35:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7673180224bso392688985a.0;
        Tue, 11 Jul 2023 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689064508; x=1691656508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKtJPZezCvQKiwKt/aqGjtS1NBKlCyU9BlTL0Nsk5EE=;
        b=UL5rr+iPmC3Z4GxzAAFm24OsFsIH64CO8q/+z3c1aBNBSoUIXvJvYcoiAWvh/kyk/l
         IqHHfDl7Ff2MBPuNoKAxvArhNnTPvo+6rLoNeSOp9TsAO9/+1Dx6laJjUjy0TKypE0OG
         Tp7mz5MrnSQGBaTpJIA0JD4v6ROUlIl/eYhfzEoPi2lEPd0mvJ+BrTKncBJXnVhOgKUo
         2kHlaIsAN3hrbbCGfrCG+lqE9ufx1bRAQQt8DCXd/+Fo8zkwkv6TsGzAUaxIcDQAv7XW
         Pn8yvvuMWkGv/6WWnWX5UXhB0jwvGqsOeb3mJuU27Nbm6yab6nGTeENE/9H0pSSzTk8z
         F+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689064508; x=1691656508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKtJPZezCvQKiwKt/aqGjtS1NBKlCyU9BlTL0Nsk5EE=;
        b=UHDHaJlpWmZpXfnJFhO5SQwi39WF4fl7y7ooYgC2l5/cOJ/pxUpGKymLF+APGrf9IV
         hBSTRVfrWJ7vV35TLFkeuC4GrAwUsKH+J8mf1pms0ppKMd6BuNkfDfklU/ThyWX45ond
         TfkURkvwlwAvpYt/r5Cad1VyklYDda4VfWsuxORgPYbn39TLPVtZ8K0+/XcXvRUUQKtp
         np0FvZaQ2ELHRD6nbK7zHNrL/CoupRMnhIXFt2GFw/gxOlZA43r5m1latDMJHcKPGe0Y
         IsqMo2bdl88dWQylEKJHC6Eq4DVjWLIFmXhwnfxo2Bs0YQ6gQxueEfnM5XTHPxJJep8W
         WH3Q==
X-Gm-Message-State: ABy/qLayHaPDo0It3k8y63VVlVfXlL6rFC0K7bGgkxH4x6uNS2pnsNrb
        yHiaJQs0EzMBM9DMXzsXrzilcE4UHoWIJTudl03LJvBGpWA=
X-Google-Smtp-Source: APBJJlH2uWFjyPzSHQnB4iICXoPTIIk5ZWS3/Pmqf5ZY+NVutX5eeS/srtPSqSg4alzRHk1+W0G3ttj+m28BJwuCUFc=
X-Received: by 2002:a05:620a:4490:b0:767:27e1:fcc4 with SMTP id
 x16-20020a05620a449000b0076727e1fcc4mr15642017qkp.22.1689064508136; Tue, 11
 Jul 2023 01:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000914c1206002dc099@google.com>
In-Reply-To: <000000000000914c1206002dc099@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Jul 2023 11:34:57 +0300
Message-ID: <CAOQ4uxgQodMoCLvO6TGPiR3dKOhbtYKrDHzmu-gkaRAO8iSLTQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_init_uuid_xattr
To:     syzbot <syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 6:32=E2=80=AFAM syzbot
<syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12353b44a8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D15ec80b62f588=
543
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db592c1f562f0da8=
0ce2c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15741e22a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1105b4e2a8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/dis=
k-123212f5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinu=
x-123212f5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/b=
zImage-123212f5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc0000=
00001c: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
> CPU: 1 PID: 5024 Comm: syz-executor280 Not tainted 6.4.0-next-20230707-sy=
zkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/27/2023
> RIP: 0010:ovl_do_getxattr fs/overlayfs/overlayfs.h:263 [inline]
> RIP: 0010:ovl_path_getxattr fs/overlayfs/overlayfs.h:292 [inline]
> RIP: 0010:ovl_init_uuid_xattr+0x1f6/0xa90 fs/overlayfs/util.c:695
> Code: c1 ea 03 80 3c 02 00 0f 85 54 08 00 00 48 b8 00 00 00 00 00 fc ff d=
f 49 8b 74 24 08 48 8d be e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 f2 07 00 00 4c 89 e1 48 8b 86 e0 00 00 00 48 ba
> RSP: 0018:ffffc90003aafab8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888014e67c00 RCX: 0000000000000005
> RDX: 000000000000001c RSI: 0000000000000000 RDI: 00000000000000e0
> RBP: ffff888029c04678 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801927c480
> R13: ffff888014e67c79 R14: ffff888014e67c60 R15: 0000000000000000
> FS:  0000555556b13300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001000 CR3: 0000000022580000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ovl_fill_super+0x1f94/0x5d70 fs/overlayfs/super.c:1437
>  vfs_get_super+0xea/0x280 fs/super.c:1152
>  vfs_get_tree+0x8d/0x350 fs/super.c:1519
>  do_new_mount fs/namespace.c:3335 [inline]
>  path_mount+0x136e/0x1e70 fs/namespace.c:3662
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount fs/namespace.c:3861 [inline]
>  __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f60c9bc0b09
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc22c0ccf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f60c9bc0b09
> RDX: 00000000200000c0 RSI: 0000000020000200 RDI: 0000000000000000
> RBP: 00007f60c9b84cb0 R08: 0000000020000480 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f60c9b84d40
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ovl_do_getxattr fs/overlayfs/overlayfs.h:263 [inline]
> RIP: 0010:ovl_path_getxattr fs/overlayfs/overlayfs.h:292 [inline]
> RIP: 0010:ovl_init_uuid_xattr+0x1f6/0xa90 fs/overlayfs/util.c:695
> Code: c1 ea 03 80 3c 02 00 0f 85 54 08 00 00 48 b8 00 00 00 00 00 fc ff d=
f 49 8b 74 24 08 48 8d be e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 f2 07 00 00 4c 89 e1 48 8b 86 e0 00 00 00 48 ba
> RSP: 0018:ffffc90003aafab8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888014e67c00 RCX: 0000000000000005
> RDX: 000000000000001c RSI: 0000000000000000 RDI: 00000000000000e0
> RBP: ffff888029c04678 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801927c480
> R13: ffff888014e67c79 R14: ffff888014e67c60 R15: 0000000000000000
> FS:  0000555556b13300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001000 CR3: 0000000022580000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   c1 ea 03                shr    $0x3,%edx
>    3:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    7:   0f 85 54 08 00 00       jne    0x861
>    d:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   14:   fc ff df
>   17:   49 8b 74 24 08          mov    0x8(%r12),%rsi
>   1c:   48 8d be e0 00 00 00    lea    0xe0(%rsi),%rdi
>   23:   48 89 fa                mov    %rdi,%rdx
>   26:   48 c1 ea 03             shr    $0x3,%rdx
> * 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping in=
struction
>   2e:   0f 85 f2 07 00 00       jne    0x826
>   34:   4c 89 e1                mov    %r12,%rcx
>   37:   48 8b 86 e0 00 00 00    mov    0xe0(%rsi),%rax
>   3e:   48                      rex.W
>   3f:   ba                      .byte 0xba
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
overlayfs-next
