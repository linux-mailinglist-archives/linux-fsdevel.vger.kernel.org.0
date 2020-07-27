Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B871D22FA36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 22:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG0UkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0UkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:40:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A492C0619D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 13:40:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so16652083qkk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5mkeIUP0mOEiGviUE7WNaFeT77sNuynQLFroF00uM0=;
        b=ndaW31KyuJq5CflqHCgledXt6cwUJPQJEHmUkVLZn5LzMK9Qmep+K2g/zpXAWQMQho
         pEwa9PyhAWywue6kD87lrQWp9cktZBi6ogYvfB5tPT1QwXsdM1S5TdLFXhOQtWkg0nZ/
         85+0VKQvI36D+k7UVliYasEXiaX/wFunjRN3P7ALI05hRyOKSoH5oovDiK+3e5fKUNk7
         j5/PHcj70JYX2+Ard2EYT0IXuR6Yj1IYHsbFAj7CI5t+C0ZSIjkUXwNRUxq+Z21p3dmm
         YbvqHtAl9zFh+2ch1NBB8sQgaeCFujs+677S5bnLzmux6uVkzfPfX2rqMwoOV6yo5EFc
         wSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5mkeIUP0mOEiGviUE7WNaFeT77sNuynQLFroF00uM0=;
        b=S6/xlckubjiZn9l6fxP9B8HYIMDyYlgLtJb8Zz86UHnrx06/IufYAClwvaOpN1NKuY
         nXCSz6MzJPOtSjY2T+iJmU1byH2Sd9SiGUXk/Bxyemwy3lYagwQOj0V1tG4zjRGmuCpm
         oawMR6nyjsiuifQJfpiy9hPM+6froduXzR8R4+qafTVJ0k8GPTIEDWTgp/PdpobHOzlr
         Ng9jkZuiHMsf5GTacOWbwTI55n4X0SOct9DgpgbBr7p0xt4GWdh74YwmzS0+jirnOGgG
         lZbvd9sACzpW7GmoMtvKtIJqDV6XSdLdiRfTP9wJoKk0Mw7M49SnqHwP8wyjMSyP5fyI
         osVw==
X-Gm-Message-State: AOAM530YHuSQIyoNO/8gmVYl+hKeyXM2D5C8ZUBYS7Gv3S7DN03alzj8
        lhr7usmWJevbo1qB/3XWA9XbaVa+rRNJPi7Oh8qbeQ==
X-Google-Smtp-Source: ABdhPJyCDq02r0UswNpJp+FxF2hE3dfe281amCGBoaEXOi/lXtIkBn4jVTKVTXz6GfkFkjZhXH8EL7FDiQijATDf730=
X-Received: by 2002:a05:620a:21d2:: with SMTP id h18mr6352807qka.407.1595882405152;
 Mon, 27 Jul 2020 13:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000862c0305ab6fc661@google.com>
In-Reply-To: <000000000000862c0305ab6fc661@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jul 2020 22:39:53 +0200
Message-ID: <CACT4Y+Z=j1fo-24HtkhJLpq9azXP7bXNMtr9Uz=FCrFx42qnqg@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in delete_node
To:     syzbot <syzbot+062ee7c41cfd844a3a9a@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 7:37 PM syzbot
<syzbot+062ee7c41cfd844a3a9a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e9a523ff Add linux-next specific files for 20200727
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ad9108900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbc23e6202df3d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=062ee7c41cfd844a3a9a
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+062ee7c41cfd844a3a9a@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
> WARNING: CPU: 1 PID: 16220 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 16220 Comm: syz-executor.0 Not tainted 5.8.0-rc7-next-20200727-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:231
>  __warn.cold+0x20/0x45 kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:545
> RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
> Code: dd a0 12 94 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd a0 12 94 88 48 c7 c7 00 08 94 88 e8 e2 87 a6 fd <0f> 0b 83 05 13 a1 1a 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
> RSP: 0018:ffffc900065e7958 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> RDX: ffff8880a1a18280 RSI: ffffffff815d93b7 RDI: fffff52000cbcf1d
> RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae7318a7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89c52a00
> R13: 0000000000000000 R14: 1ffff92000cbcf36 R15: ffffffff89c52a00
>  debug_object_activate+0x2da/0x3e0 lib/debugobjects.c:652
>  debug_object_activate+0x337/0x3e0 lib/debugobjects.c:682
>  debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
>  __call_rcu kernel/rcu/tree.c:2869 [inline]
>  call_rcu+0x2c/0x7e0 kernel/rcu/tree.c:2957
>  radix_tree_node_free lib/radix-tree.c:309 [inline]
>  delete_node+0xe5/0x8a0 lib/radix-tree.c:572

+Matthew, I am not sure if this adds any actionable info, but FWIW
this looks related to the "WARNING in delete_node (2)" issue you
looked at few day ago:
https://lore.kernel.org/lkml/20200726032115.GE23808@casper.infradead.org/

>  __radix_tree_delete+0x190/0x370 lib/radix-tree.c:1378
>  radix_tree_delete_item+0xe7/0x230 lib/radix-tree.c:1429
>  mnt_free_id fs/namespace.c:131 [inline]
>  cleanup_mnt+0x3db/0x500 fs/namespace.c:1140
>  task_work_run+0xdd/0x190 kernel/task_work.c:135
>  exit_task_work include/linux/task_work.h:25 [inline]
>  do_exit+0xb7d/0x29f0 kernel/exit.c:806
>  do_group_exit+0x125/0x310 kernel/exit.c:903
>  __do_sys_exit_group kernel/exit.c:914 [inline]
>  __se_sys_exit_group kernel/exit.c:912 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45c369
> Code: Bad RIP value.
> RSP: 002b:00007fff0e2003e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 000000000045c369
> RDX: 0000000000415e00 RSI: 0000000000ca85f0 RDI: 0000000000000043
> RBP: 00000000004d0de8 R08: 000000000000000c R09: 0000000000000000
> R10: 00000000023fc940 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000744ca0
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000862c0305ab6fc661%40google.com.
