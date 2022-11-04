Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D261A031
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiKDSmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiKDSmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:42:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C845EF4
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:42:18 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s206so6079047oie.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFbT8/LGOSkO5UWn6X/i9yU7QOQvwB50sTOfAttdArk=;
        b=StwJsVBO+QYCsFIqrBlboVjJs3jWS2UmISTbIT/aIvDd84ZpUPH6mUnD5ddhkB1UHZ
         2r5ZoCdd29Rk7GOk3lrHquOQ2owToXI7w/68Un4uUCRsu8u/28+VxWwoCrqh3T3TZx07
         Q9/s7PJlZeqBGW2xa9NAFG7pkPr3YxK4ypnq6BHEtsdcvBQt/J81PuHeB6Q3iRVeqUCa
         HLJsnMsR/tWLFF4mDXJpY9oD/Rf5Iy6IHFx/akJJIUnro3ycCteE4W3Hp/Q04jEy+N2N
         WkpCXUrjM5gOVursbQN8VpQ+7J9sgS1Vnix7U6OfVTqs7wQvVTJ9Ya218W/6gRlKiSBw
         b7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFbT8/LGOSkO5UWn6X/i9yU7QOQvwB50sTOfAttdArk=;
        b=b/yucr6ZpANoVwtnYk8gwm7gf8LHAuAdqDerlEfL8FO4gLbChsdOZ4zK6rwqBeVTV6
         V8D43b4VSqKmX4ey3s77C4bC9zdvHB95xbSRdDxQqGS6QSzn+T5En1FbSC1+t8HxiV9S
         kLP9hZ7tRph3tGyMQDWq6u1QRNClYOFLyR49nvc6J3BMo0TlyC3mOySiaIKTnGGpnvKT
         b2kh6BCVyeMD0xIRUmHxCOOviRP3P+stF1TjTGt0TTMg8ArYJ191gfv/yIkIeAKmYafE
         cYqUAfe4/Pn2nCkrY9aBG50A5zObiePIobqXTtWsG2w/A5ke7sCljZjYGqinUF2I0oTJ
         SsKg==
X-Gm-Message-State: ACrzQf3D6QqgR5gJ4t42BrRT8zZmFZOQiQKl6rAwz2Xpv0z+Q8akr1sl
        ZGZwyym3SesaBVQcCBOLpX65JtCECkHpIRlVvkiZDA==
X-Google-Smtp-Source: AMsMyM4/9CEAv6Ur1B05TAGBd0OvGoDIT5OSa5g1h8Gfxd/Ls5Jg4e2xNQbVUSwXYKPxxe9PMpsw8F/+KnKrdDeDjgQ=
X-Received: by 2002:a05:6808:b02:b0:359:cb71:328b with SMTP id
 s2-20020a0568080b0200b00359cb71328bmr276273oij.282.1667587337338; Fri, 04 Nov
 2022 11:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QR0EDvq7p9i1xw@nvidia.com> <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com> <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com> <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
In-Reply-To: <Y2VT6b/AgwddWxYj@nvidia.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 11:42:06 -0700
Message-ID: <CACT4Y+ar_RjXFw1qS7=uLkyTQR1ezvX9X_m4m=BvS2oAKZMx=w@mail.gmail.com>
Subject: Re: xarray, fault injection and syzkaller
To:     Jason Gunthorpe <jgg@nvidia.com>
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
>
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

Filed https://bugzilla.kernel.org/show_bug.cgi?id=216663
We could add GFP_NOFAULT. But now I am thinking if using the existing
GFP_NOFAIL is actually the right thing to do in these cases...
(details are in the bug).
