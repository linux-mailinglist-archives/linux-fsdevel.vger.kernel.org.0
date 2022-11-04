Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D4619FB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiKDSWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKDSWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:22:08 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543A69DE8
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:21:33 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so737394oor.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr/Ioq7PJoDIpzitmEodH6JFX0LnKBRFzuiNkGXBhwg=;
        b=b0zMo53WYuWZNy/T+j1svo96H/Z5Ss0/YIngZFZmZfCXVjmJEmbRmnwQj7pD/Ou3Pw
         5lK2u3n70u0MQUCLiBpX6fZqIgH/h9Nl8klgtDMSnTRfWPMHVAcBqgVAKeHtdkhenD/F
         Nm02APn7GbMgBbXQ/j5aAFdNQdtIIO8PumSmlCl7AHxecBQv/Ts4GyLlCW5WpYpNfB1K
         Pvm6WGyP+s64NQEsjjW5+xxQ/R0u+1HqERntIlS+A6MheT7+DEVjRLwwG+Dpe1Ok3LfG
         +7mHyhMTpzn/tu8NemAo+fNeXKcng+cJESi2/lkz/UqqasqWh8fPiZ7x8L4VjVckd2cO
         RmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr/Ioq7PJoDIpzitmEodH6JFX0LnKBRFzuiNkGXBhwg=;
        b=bbVLLQK2q4TmyZN1gGPEQvstAElHehhvtOX170oGxMgkRE/XDm2ovgQXhhmIIgbdjt
         guW+pFGwt8RbKgSAd1G1YUUB8EF6qB93M2LliufBIol4LWhcmZiFsjWTl0yI07XiNfCC
         HQHbKGnu26TsIgylcPjaf/kWyY8z8MFi1snjK0tuxK1Y0D2hlYTWSjEHMw56SKqAp2I/
         1CKnqEPNoKx6L268hTs6rQH3zJYhAmZ8XriPuIv9x8GHPD2lEy5v9KslRvXxs2t3WIXY
         7PDsrqpAXR1Slc8c6uF0k3ckP/dcvQT1lOFBeWjh0xHL2nu9umWsFmdZ3ktnkUyrmmky
         0kJA==
X-Gm-Message-State: ACrzQf0KG3Miv10Be8/Yi2YHAUViH9welHA/grj/Jv0TIxtTHhwqMXXg
        omAZcLdgiDd17ju9l2Wb8/5jsYt3yj210SQ0TtDT1Q==
X-Google-Smtp-Source: AMsMyM7lZOPHrz0G3fSzbLmGxpAhP9qMdYYW+tsz+t6UbdyLjVlpuP7v4atlOuZ//8+rz3sqkLFwsu14MfzjcjXwPvg=
X-Received: by 2002:a4a:9586:0:b0:448:5e55:a122 with SMTP id
 o6-20020a4a9586000000b004485e55a122mr15691028ooi.61.1667586092193; Fri, 04
 Nov 2022 11:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QR0EDvq7p9i1xw@nvidia.com> <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com> <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com> <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
In-Reply-To: <Y2VT6b/AgwddWxYj@nvidia.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 11:21:21 -0700
Message-ID: <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
Subject: Re: xarray, fault injection and syzkaller
To:     Jason Gunthorpe <jgg@nvidia.com>, zhengqi.arch@bytedance.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Nov 2022 at 11:03, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Nov 04, 2022 at 10:47:17AM -0700, Dmitry Vyukov wrote:
> > > > Do we know how common/useful such an allocation pattern is?
> > >
> > > I have coded something like this a few times, in my cases it is
> > > usually something like: try to allocate a big chunk of memory hoping
> > > for a huge page, then fall back to a smaller allocation
> > >
> > > Most likely the key consideration is that the callsites are using
> > > GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
> > > NOWARN case assuming that another allocation attempt will closely
> > > follow?
> >
> > GFP_NOWARN is also extensively used for allocations with
> > user-controlled size, e.g.:
> > https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451
> >
> > That's different and these allocations are usually not repeated.
> > So looking at GFP_NOWARN does not look like the right thing to do.
>
> This may be the best option then, arguably perhaps even more
> "realistic" than normal fail_nth as in a real system if this stuff
> starts failing there is a good chance things from then on will fail
> too during the error cleanup.
>
> > > However, this would also have to fix the obnoxious behavior of fail
> > > nth where it fails its own copy_from_user on its write system call -
> > > meaning there would be no way to turn it off.
> >
> > Oh, interesting. We added failing of copy_from/to_user later and did
> > not consider such interaction.
> > Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.
>
> Oh, I will tell you the other two bugish things I noticed
>
> __should_failslab() has this:
>
>         if (gfpflags & __GFP_NOWARN)
>                 failslab.attr.no_warn = true;
>
>         return should_fail(&failslab.attr, s->object_size);
>
> Which always permanently turns off no_warn for slab during early
> boot. This is why syzkaller reports are so confusing. They trigger a
> slab fault injection, which in all other cases gives a notification
> backtrace, but in slab cases there is no hint about the fault
> injection in the log.

Ouch, this looks like a bug in:

commit 3f913fc5f9745613088d3c569778c9813ab9c129
Author: Qi Zheng <zhengqi.arch@bytedance.com>
Date:   Thu May 19 14:08:55 2022 -0700
     mm: fix missing handler for __GFP_NOWARN

+Qi could you please fix it?

At the very least the local gfpflags should not alter the global
failslab.attr that is persistent and shared by all tasks.

But I am not sure if we really don't want to issue the fault injection
stack in this case. It's not a WARNING, it's merely an information
message. It looks useful in all cases, even with GFP_NOWARN. Why
should it be suppressed?


> Once that is fixed we can quickly explain why the socketpair() example
> in the docs shows success ret codes in the middle of the sweep when
> run on syzkaller kernels
>
> fail_nth interacts badly with other kernel features typically enabled
> in syzkaller kernels. Eg it fails in hidden kmemleak instrumentation:
>
> [   18.499559] FAULT_INJECTION: forcing a failure.
> [   18.499559] name failslab, interval 1, probability 0, space 0, times 0
> [   18.499720] CPU: 10 PID: 386 Comm: iommufd_fail_nt Not tainted 6.1.0-rc3+ #34
> [   18.499826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [   18.499971] Call Trace:
> [   18.500010]  <TASK>
> [   18.500048]  show_stack+0x3d/0x3f
> [   18.500114]  dump_stack_lvl+0x92/0xbd
> [   18.500171]  dump_stack+0x15/0x17
> [   18.500232]  should_fail.cold+0x5/0xa
> [   18.500291]  __should_failslab+0xb6/0x100
> [   18.500349]  should_failslab+0x9/0x20
> [   18.500416]  kmem_cache_alloc+0x64/0x4e0
> [   18.500477]  ? __create_object+0x40/0xc50
> [   18.500539]  __create_object+0x40/0xc50
> [   18.500620]  ? kasan_poison+0x3a/0x50
> [   18.500690]  ? kasan_unpoison+0x28/0x50
> [***18.500753]  kmemleak_alloc+0x24/0x30
> [   18.500816]  __kmem_cache_alloc_node+0x1de/0x400
> [   18.500900]  ? iopt_alloc_area_pages+0x95/0x560 [iommufd]
> [   18.500993]  kmalloc_trace+0x26/0x110
> [   18.501059]  iopt_alloc_area_pages+0x95/0x560 [iommufd]
>
> Which has the consequence of syzkaller wasting half its fail_nth
> effort because it is triggering failures in hidden instrumentation
> that has no impact on the main code path.
>
> Maybe a kmem_cache_alloc_no_fault_inject() would be helpful for a few
> cases.
>
> Jason
