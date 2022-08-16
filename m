Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87F595728
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiHPJyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 05:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiHPJx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64AD9E92
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:37:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso5606855ioe.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=tboL+2t//XefaCLnDTGrPfl5RupstyNFWcrS7xB6m6M=;
        b=aCYPPM3onYqiIMunN3AWNXLdM5haXOFWKRCsicpJliZMlezJ3xnRiEr7jzp3c1Ah2I
         TCoDN0glslnQbBXew9HhuTR058xsXnrPad4uJa1PNjvHnIJUlRqBAPxb1V1tKTb3mM1w
         yS4oRJVflXSn/Kfqw8C8SLJ6C81iW0nZ5H/kTY1AxTxryeDKrKqBRkGK+MWZP0YgfM6W
         0+/qZNXnZAOztE1paGJG2RgWVktOH1YnhWj6V5x6AM4TQoRf9Cvn2CVdri1eklUSIauA
         /DEwmF3HrWBQJp1U/9YKCWjVWFdVf4dVwKuI7A38Buhh7c/0/lDAiJWKLkI27fswhvG9
         iwZQ==
X-Gm-Message-State: ACgBeo1z9iS4FWOVFxCP2gbJtj6YbZpaAS4uzOR8CRraOv57LEjdXVKn
        SkAK8pE19SUZ7C94K0do4T5oobCjHSGrDVZTf8rJ6CDE1X/E
X-Google-Smtp-Source: AA6agR6ZKNJFQX5tQWG1kAZNBBCRHLeIaljZ1MoFMwN6D+pe7+ukZAfhecPoUbOlta0Q3Ne1cPTDg8+nzd/eIyCp7cUGF3JT2c+6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c8:b0:343:34af:32ff with SMTP id
 j8-20020a05663822c800b0034334af32ffmr9225175jat.238.1660639042238; Tue, 16
 Aug 2022 01:37:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367cfb05e657a8ac@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in kernel_execve
From:   syzbot <syzbot+c50cf81fb2c17ffb6e6b@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1131e5e3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=c50cf81fb2c17ffb6e6b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c50cf81fb2c17ffb6e6b@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1105 Comm: kworker/u4:4 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0018:ffffc90004cc7e10 EFLAGS: 00010246
RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
R13: ffff88801f859c00 R14: ffff000000000000 R15: ffff88801f859c00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 strnlen include/linux/fortify-string.h:119 [inline]
 copy_string_kernel+0x26/0x250 fs/exec.c:616
 copy_strings_kernel+0xb3/0x190 fs/exec.c:655
 kernel_execve+0x377/0x500 fs/exec.c:2001
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0018:ffffc90004cc7e10 EFLAGS: 00010246
RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
R13: ffff88801f859c00 R14: ffff000000000000 R15: ffff88801f859c00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	74 3c                	je     0x3e
   2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
   9:	fc ff df
   c:	49 89 fc             	mov    %rdi,%r12
   f:	48 89 f8             	mov    %rdi,%rax
  12:	eb 09                	jmp    0x1d
  14:	48 83 c0 01          	add    $0x1,%rax
  18:	48 39 e8             	cmp    %rbp,%rax
  1b:	74 1e                	je     0x3b
  1d:	48 89 c2             	mov    %rax,%rdx
  20:	48 89 c1             	mov    %rax,%rcx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
  27:	83 e1 07             	and    $0x7,%ecx
* 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
  2e:	38 ca                	cmp    %cl,%dl
  30:	7f 04                	jg     0x36
  32:	84 d2                	test   %dl,%dl
  34:	75 11                	jne    0x47
  36:	80 38 00             	cmpb   $0x0,(%rax)
  39:	75 d9                	jne    0x14
  3b:	4c 29 e0             	sub    %r12,%rax
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
