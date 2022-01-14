Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05148E250
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 02:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiANBzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 20:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiANBzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:55:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BEC061574;
        Thu, 13 Jan 2022 17:55:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x4so13225757wru.7;
        Thu, 13 Jan 2022 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8UEJ1iSqGqlRBlA4uU7XNpXzcTOzdSsV6ukeP+prMiA=;
        b=oMEUQoPypi4cjpgOLTyUukEeuQfrSUYvVgOay3geHrVSGom9mxnIl4yQG2e0U0gzaR
         AXQ1BaLzpMfLGYvi6I8/SuySsRNcANhUsEzaOtdfEII4leWITHjiu+yFhP31JM9iutLm
         Ycdk0u26z3SMiLprGk0Yv1xh7FM0WD87xEtuydhbs2yebkWbAGQXNfM6Q5qIsBrvu+y9
         uVwmiN4ZLbBeEgkbY1Pjq8NrEaVeGLt3U0cAGOCTrJzvKXn4SZ1S7QdWWuXw/wpwQGle
         SAzbu+gX0cLrgfQFQuyJqmqdXmJJ2jksh0JUENWT/q8bbELdAnXsUlXMdDK4mePuK3ld
         SDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8UEJ1iSqGqlRBlA4uU7XNpXzcTOzdSsV6ukeP+prMiA=;
        b=LRlNWGZb8qdQ8jEj6ksiJSPLLUzI3BwicMsLB1PxFIyy6nI2QWQusN1wfU0AomNUvA
         Q2hrERwY2gBdyAejPU4CqGLBqEjJ1PWB9Bu4pqLt+HLLnG+qFMUY4SetfIPXCAyw21a1
         cqsjSAlPMPf69C9v+FKxmssfdlfSIlLPIqc2MS3DLalXVe/Xgz1yHsxrw1X0oOOoRceP
         jXsV80uF8uL9mj/6aICA+049/VKAMmjIIE0U8iIi0KSLrQQJI2shigpt91N/+4RmUPre
         TThiFHj2XVWOI4SGiMPGFea1nAAA7jRK3pvm6UIedvkKXBYnPq5I7AEhkVbZzN7gGgJS
         H2MQ==
X-Gm-Message-State: AOAM530pCSsCnmWnyJnqEcEnBf4+31wcybOh+L7yfRehJYYS5wrgqWIx
        W3phTobeY6CV9+0MBqSJcwpP26Cafgw=
X-Google-Smtp-Source: ABdhPJw7B+IVIdcD+vcY/JmFqYX3JZ7DqyPdtzIjQKKmQoIIHNfF+w2UJEErXXKEZkVVmZBq4hU2tg==
X-Received: by 2002:a5d:6dc6:: with SMTP id d6mr5891194wrz.458.1642125343915;
        Thu, 13 Jan 2022 17:55:43 -0800 (PST)
Received: from [192.168.8.198] ([85.255.234.103])
        by smtp.gmail.com with ESMTPSA id m7sm3658437wmi.13.2022.01.13.17.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 17:55:43 -0800 (PST)
Message-ID: <998e645c-b300-9e58-eb02-3005667dcfe2@gmail.com>
Date:   Fri, 14 Jan 2022 01:55:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] WARNING in signalfd_cleanup
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+5426c7ed6868c705ca14@syzkaller.appspotmail.com>,
        changbin.du@intel.com, Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yajun Deng <yajun.deng@linux.dev>
References: <000000000000c9a3fb05d4d787a3@google.com>
 <CANn89iK3tP3rANSWM7_=imMeMcUknT0U2GyfA9W4v12ad6_PkQ@mail.gmail.com>
 <YdW+trV0x25fhTqV@sol.localdomain>
 <6a692d3e-2b8d-bef6-d54d-9880980b245c@gmail.com>
In-Reply-To: <6a692d3e-2b8d-bef6-d54d-9880980b245c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/5/22 17:37, Pavel Begunkov wrote:
> On 1/5/22 15:52, Eric Biggers wrote:
>> [+io_uring list and maintainers]
>>
>> This appears to be the known bug in io_uring where it doesn't POLLFREE
>> notifications.  See previous discussion:
>> https://lore.kernel.org/all/4a472e72-d527-db79-d46e-efa9d4cad5bb@kernel.dk/
> 
> We've got some fixing and groundwork done, but not POLLFREE yet.
> Great to have a repro, thanks

#syz test: https://github.com/isilence/linux.git pollfree_test1

Almost identical to how Eric did it for aio, let's try it out


>> On Wed, Jan 05, 2022 at 07:42:10AM -0800, 'Eric Dumazet' via syzkaller-bugs wrote:
>>> On Wed, Jan 5, 2022 at 7:37 AM syzbot
>>> <syzbot+5426c7ed6868c705ca14@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    6b8d4927540e Add linux-next specific files for 20220104
>>>> git tree:       linux-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=159d88e3b00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=45c9bbbf2ae8e3d3
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=5426c7ed6868c705ca14
>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117be65db00000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a75c8db00000
>>>>
>>>
>>> C repro looks legit, point to an io_uring issue.
>>>
>>>> The issue was bisected to:
>>>
>>> Please ignore the bisection.
>>>
>>>>
>>>> commit e4b8954074f6d0db01c8c97d338a67f9389c042f
>>>> Author: Eric Dumazet <edumazet@google.com>
>>>> Date:   Tue Dec 7 01:30:37 2021 +0000
>>>>
>>>>      netlink: add net device refcount tracker to struct ethnl_req_info
>>>>
>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bca4e3b00000
>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11bca4e3b00000
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=16bca4e3b00000
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+5426c7ed6868c705ca14@syzkaller.appspotmail.com
>>>> Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")
>>>>
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 0 PID: 3604 at kernel/sched/wait.c:245 __wake_up_pollfree+0x40/0x50 kernel/sched/wait.c:246
>>>> Modules linked in:
>>>> CPU: 0 PID: 3604 Comm: syz-executor714 Not tainted 5.16.0-rc8-next-20220104-syzkaller #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>> RIP: 0010:__wake_up_pollfree+0x40/0x50 kernel/sched/wait.c:245
>>>> Code: f3 ff ff 48 8d 6b 40 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 75 11 48 8b 43 40 48 39 c5 75 03 5b 5d c3 <0f> 0b 5b 5d c3 48 89 ef e8 13 d8 69 00 eb e5 cc 48 c1 e7 06 48 63
>>>> RSP: 0018:ffffc90001aaf9f8 EFLAGS: 00010083
>>>> RAX: ffff88801cd623f0 RBX: ffff88801bec8048 RCX: 0000000000000000
>>>> RDX: 1ffff110037d9011 RSI: 0000000000000004 RDI: 0000000000000001
>>>> RBP: ffff88801bec8088 R08: 0000000000000000 R09: ffff88801bec804b
>>>> R10: ffffed10037d9009 R11: 0000000000000000 R12: ffff88801bec8040
>>>> R13: ffff88801e029d40 R14: dffffc0000000000 R15: ffff88807eb50000
>>>> FS:  00005555573ad300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 00000000200000c0 CR3: 000000001e5e4000 CR4: 00000000003506f0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>   <TASK>
>>>>   wake_up_pollfree include/linux/wait.h:271 [inline]
>>>>   signalfd_cleanup+0x42/0x60 fs/signalfd.c:38
>>>>   __cleanup_sighand kernel/fork.c:1596 [inline]
>>>>   __cleanup_sighand+0x72/0xb0 kernel/fork.c:1593
>>>>   __exit_signal kernel/exit.c:159 [inline]
>>>>   release_task+0xc02/0x17e0 kernel/exit.c:200
>>>>   wait_task_zombie kernel/exit.c:1117 [inline]
>>>>   wait_consider_task+0x2fa6/0x3b80 kernel/exit.c:1344
>>>>   do_wait_thread kernel/exit.c:1407 [inline]
>>>>   do_wait+0x6ca/0xce0 kernel/exit.c:1524
>>>>   kernel_wait4+0x14c/0x260 kernel/exit.c:1687
>>>>   __do_sys_wait4+0x13f/0x150 kernel/exit.c:1715
>>>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> RIP: 0033:0x7facd6682386
>>>> Code: 0f 1f 40 00 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
>>>> RSP: 002b:00007ffdb91adef8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
>>>> RAX: ffffffffffffffda RBX: 000000000000c646 RCX: 00007facd6682386
>>>> RDX: 0000000040000001 RSI: 00007ffdb91adf14 RDI: 00000000ffffffff
>>>> RBP: 0000000000000f17 R08: 0000000000000032 R09: 00007ffdb91ec080
>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 431bde82d7b634db
>>>> R13: 00007ffdb91adf14 R14: 0000000000000000 R15: 0000000000000000
>>>>   </TASK>
>>>>
>>>>
>>>> ---
>>>> This report is generated by a bot. It may contain errors.
>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>>
>>>> syzbot will keep track of this issue. See:
>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>>> syzbot can test patches for this issue, for details see:
>>>> https://goo.gl/tpsmEJ#testing-patches
>>>
>>> -- 
>>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CANn89iK3tP3rANSWM7_%3DimMeMcUknT0U2GyfA9W4v12ad6_PkQ%40mail.gmail.com.
> 

-- 
Pavel Begunkov
