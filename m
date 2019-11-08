Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F49F5327
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfKHSCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 13:02:35 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34344 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfKHSCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:02:35 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so5916992ilp.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZP+RMk2vz1gKDsd6v9NElMa7DaL1My+IavDdTycnaU=;
        b=PspogXYG5IFzNmDoM304jLRv9oiEYPJW3bos3m3npWKNOWJ+WJy/L711oF5jL43niv
         /sEkT3jaShr5SeU5cJX/y2iEyvfzchDHp9ADUqQ5FRY5K94X+ZnJXpDt8bCyFpE17kwL
         I388NhjzTwL/YyFfltRWV4fYIw6PU1dw8vsh+sUUwnMY/HgVMKbtSWddVssE4UMO5Ar2
         wMd8V/6uz3ps0Y5dtmZZGVytP1GbxlyDlBQ/FGpBtSWQCruRFOyeIpPPEt/zfRlr8eiT
         88ZxmY5kiIvYfg+++F7rWZc8OhZcuBnUNAOn2JfHwxelUC06aPIo5oddkNfPM3lzRZYp
         h1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZP+RMk2vz1gKDsd6v9NElMa7DaL1My+IavDdTycnaU=;
        b=Bzi8SB93AhTN0Q3QEqd682NeSHORmjRX8ZqahIDf9xtAgHI468/MVuJj4wg3wL6k8K
         APWm2ypUni4Cgd4p21W4bz+B7l+cpPnMJsj8Ks1MiHwaIEwRwbTyQx0ZRwq9a08z2Jr4
         zxDjwSYMfBr25QQnlZFvnJh6EO4FGpzS1kmBnAMxvq2lLy/tOnOGwCHPvlp5wz5LVHuL
         qN+hSvAw0Prr7P3TAyXdb4nzrkc/tfKyJuUv22zXpmrF2upa5YCASZgndSr0wGWAKNfg
         CCmSXP+Byok25fZCp5j3+q/dca+q7qtIY6Do9EG3dBXqVJYDLwSlSjMH07VvSD2mjY1y
         0Eeg==
X-Gm-Message-State: APjAAAUXbi2xmY466/qm7mM+xH6zSHXrajHWzAP+iU/ogqwuvLrIijFe
        nyMxmVahepnCEqDHeEUCy1bYzi4531F/UlrRtOOqgA==
X-Google-Smtp-Source: APXvYqyKLcrxSty18grHnGyAishpVkPO6NCgznfHmCdtd0hAPmmccjQUAfGcCtpIntCEX1a7+oH/8dVj8TE5XL16Sr4=
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr14480264ili.269.1573236153666;
 Fri, 08 Nov 2019 10:02:33 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com> <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
In-Reply-To: <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 10:02:22 -0800
Message-ID: <CANn89iLN758CpQPKcd++NLdj62LS-ekiEUV91VREzMsamLn9bw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:55 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Nov 8, 2019 at 9:39 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >
> > > I'd hope that there is some way to mark the cases we know about where
> > > we just have a flag. I'm not sure what KCSAN uses right now - is it
> > > just the "volatile" that makes KCSAN ignore it, or are there other
> > > ways to do it?
> >
> > I dunno, Marco will comment on this.
> >
> > I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> > and is the facto accessor we used for many years (before KCSAN was conceived)
> >
>
> BTW, I would love an efficient ADD_ONCE(variable, value)
>
> Using WRITE_ONCE(variable, variable + value) is not good, since it can
> not use the
> optimized instructions operating directly on memory.

Another interesting KCSAN report :

static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
{
        s64 ret = fbc->count;   // data-race ....

        barrier();              /* Prevent reloads of fbc->count */
        if (ret >= 0)
                return ret;
        return 0;
}

How was this code supposed to work at all on 32bit arches ???

Using READ_ONCE(fbc->count) alone will not help.


BUG: KCSAN: data-race in ip6_dst_gc / ip6_dst_gc

read to 0xffff88811dd6298c of 4 bytes by task 10060 on cpu 1:
 dst_entries_get_fast include/net/dst_ops.h:47 [inline]
 ip6_dst_gc+0xf6/0x220 net/ipv6/route.c:3167
 dst_alloc+0x104/0x149 net/core/dst.c:85
 ip6_dst_alloc+0x3d/0x80 net/ipv6/route.c:353
 ip6_rt_cache_alloc+0x8d/0x340 net/ipv6/route.c:1338
 ip6_pol_route+0x4ec/0x5c0 net/ipv6/route.c:2217
 ip6_pol_route_output+0x48/0x60 net/ipv6/route.c:2452
 fib6_rule_lookup+0x95/0x470 net/ipv6/fib6_rules.c:113
 ip6_route_output_flags_noref+0x16b/0x230 net/ipv6/route.c:2484
 ip6_route_output_flags+0x50/0x1a0 net/ipv6/route.c:2497
 ip6_dst_lookup_tail+0x25d/0xc30 net/ipv6/ip6_output.c:1052
 ip6_dst_lookup_flow+0x68/0x120 net/ipv6/ip6_output.c:1153
 rawv6_sendmsg+0x82c/0x21e0 net/ipv6/raw.c:928
 inet_sendmsg+0x6d/0x90 net/ipv4/af_inet.c:807
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0x9f/0xc0 net/socket.c:657
 kernel_sendmsg+0x4d/0x70 net/socket.c:677
 sock_no_sendpage+0xda/0x110 net/core/sock.c:2742
 kernel_sendpage+0x7b/0xc0 net/socket.c:3682
 sock_sendpage+0x6c/0x90 net/socket.c:935
 pipe_to_sendpage+0x102/0x180 fs/splice.c:449
 splice_from_pipe_feed fs/splice.c:500 [inline]
 __splice_from_pipe+0x248/0x480 fs/splice.c:624
 splice_from_pipe+0xbb/0x100 fs/splice.c:659
 generic_splice_sendpage+0x45/0x60 fs/splice.c:829
 do_splice_from fs/splice.c:848 [inline]
 direct_splice_actor+0xa0/0xc0 fs/splice.c:1020
 splice_direct_to_actor+0x215/0x510 fs/splice.c:975
 do_splice_direct+0x161/0x1e0 fs/splice.c:1063
 do_sendfile+0x384/0x7f0 fs/read_write.c:1464
 __do_sys_sendfile64 fs/read_write.c:1525 [inline]
 __se_sys_sendfile64 fs/read_write.c:1511 [inline]
 __x64_sys_sendfile64+0x12a/0x140 fs/read_write.c:1511
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
