Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7212842F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 22:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTV6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 16:58:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42943 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfLTV6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:58:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so4672687plk.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g5MGlH4MrfWXy08LWY50RJrMpvbtbh0z6ynjczk7/5I=;
        b=Xc9qL6HkGFZexF59sCQw89J20dMimzIzLbmpeJWN3r0Q25+zgzt56c0c09o9eKt7uW
         lio+cdf2F+o5YH7BRsphLspf/f1j9noOB7+TBupkqVVcJS1XOMG4ySD8pA5JWj+TgPch
         r8dTH6mzVSaqJn2JSAMeufuVRKVbnlBofN1FOH13/c1ghwBVLxzGWIqhqJnM5MjkMCZp
         Vd7rQFTcWFIZli/Rub0g8Y9dLaNx+UbP8epyExLvZHiL5osrQfkrxWSJFzhK6DD9/O/H
         XNpwvBKPTUdkLGUB6u83xq4ZtcaebRdpbY+yvOCoHfuxYUGu0C2LuVl97hR2m4XEb9eU
         7GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5MGlH4MrfWXy08LWY50RJrMpvbtbh0z6ynjczk7/5I=;
        b=MLtfw+Rl+EbAlw/205YzGSvfV/Ck5Bk1TMrIAFsghDLMQ816zzKqanvoZWbd6QRgou
         85ainw1uJZcG4fMqlFY9hqxmm7aJcwMAuTuPnMeAIrmsu/hg/kESxMTuObJEucnKmQGO
         hk+N2X+f/fJySie8Ut2wdcT3n5LylejJVZJK8mnhGK74BJMyDBa6f+x9KIU7Bd6JMObT
         AlsicOMgIoZb4ilFsh0N77wp7mhQFVQ10G7KgB/bGzAfz1pyqFMw10JXebvkSGakwVV/
         HincCCdoSPxeSooaw9Npp9OkZENHPAwG6xRcBh/qj6XqglnA0WgaDvBdIWPOFmpQytAE
         ghzA==
X-Gm-Message-State: APjAAAVlwdZK0RVB1wbBGIqZnJQpwnnI+6mwhm3V6vr1TR8LHuPARvnE
        1kzi3c1M+GrzO7xOrcCZ1MSWiA==
X-Google-Smtp-Source: APXvYqyKiEDmCfSdGE+SpIFVMson8HGrxY4vLf3JLz3G3sZkOscNozTMIi20a1fQKgqSwmzMiWp4ZA==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr17678806pjk.26.1576879117152;
        Fri, 20 Dec 2019 13:58:37 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1349? ([2620:10d:c090:180::4be8])
        by smtp.gmail.com with ESMTPSA id p28sm12593518pgb.93.2019.12.20.13.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 13:58:36 -0800 (PST)
Subject: Re: WARNING in percpu_ref_exit
To:     syzbot <syzbot+2eea1ab51194c814cb70@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000ee01f5059a294f5c@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd8bec81-c9a0-3584-366f-b38167c5d081@kernel.dk>
Date:   Fri, 20 Dec 2019 14:58:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <000000000000ee01f5059a294f5c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/20/19 2:25 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7ddd09fc Add linux-next specific files for 20191220
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1457dcb9e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
> dashboard link: https://syzkaller.appspot.com/bug?extid=2eea1ab51194c814cb70
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116182c1e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d3c925e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2eea1ab51194c814cb70@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 9727 at lib/percpu-refcount.c:111  
> percpu_ref_exit+0xab/0xd0 lib/percpu-refcount.c:111
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 9727 Comm: syz-executor571 Not tainted  
> 5.5.0-rc2-next-20191220-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   panic+0x2e3/0x75c kernel/panic.c:221
>   __warn.cold+0x2f/0x3e kernel/panic.c:582
>   report_bug+0x289/0x300 lib/bug.c:195
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   fixup_bug arch/x86/kernel/traps.c:169 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:percpu_ref_exit+0xab/0xd0 lib/percpu-refcount.c:111
> Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 1d 48 c7 43 08 03 00  
> 00 00 e8 01 41 e5 fd 5b 41 5c 41 5d 5d c3 e8 f5 40 e5 fd <0f> 0b eb bf 4c  
> 89 ef e8 29 2c 23 fe eb d9 e8 82 2b 23 fe eb a7 4c
> RSP: 0018:ffffc90003bf7968 EFLAGS: 00010293
> RAX: ffff8880a700e500 RBX: ffff8880990cde10 RCX: ffffffff83901432
> RDX: 0000000000000000 RSI: ffffffff8390149b RDI: ffff8880990cde28
> RBP: ffffc90003bf7980 R08: ffff8880a700e500 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000607f514357c0
> R13: ffff8880990cde18 R14: ffff8880973e3000 R15: ffff8880973e3228
>   io_sqe_files_unregister+0x7d/0x2f0 fs/io_uring.c:4623
>   io_ring_ctx_free fs/io_uring.c:5575 [inline]
>   io_ring_ctx_wait_and_kill+0x430/0x9a0 fs/io_uring.c:5644
>   io_uring_release+0x42/0x50 fs/io_uring.c:5652
>   __fput+0x2ff/0x890 fs/file_table.c:280
>   ____fput+0x16/0x20 fs/file_table.c:313
>   task_work_run+0x145/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x909/0x2f20 kernel/exit.c:797
>   do_group_exit+0x135/0x360 kernel/exit.c:895
>   get_signal+0x47c/0x24f0 kernel/signal.c:2734
>   do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
>   exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:160
>   prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
>   do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4468f9
> Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb197749db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000006dbc48 RCX: 00000000004468f9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc48
> RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
> R13: 00007ffc42ed8b0f R14: 00007fb19774a9c0 R15: 0000000000000001
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

#syz invalid

This is fixed in the current tree, pushing out a new linux-next
branch.

-- 
Jens Axboe

