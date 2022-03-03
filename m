Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E34CB72F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 07:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiCCGv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 01:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCGvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:51:55 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79B1693B2;
        Wed,  2 Mar 2022 22:51:10 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id i14so3308592ilv.4;
        Wed, 02 Mar 2022 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9tum+mvr4r/WQl+w9fpdy1xDFA2vaS1Lr9K70S1GO0=;
        b=JLzjn/yVFIuobabw72Ns8KSDhUmcLdI3HnTJb8Q0FislWK/Tph7rGclk8pCwSS1Aot
         KMlitYQYCY5bY5GzON8KLFVgUAL8qSAbTFH7ovtgtA8ZID+JITwGYIyvM27/yeQladCx
         zIqyQyFGVwjw9zOdg4m/Ahd+KTfTZTFX8pOvmz2J+xAksBRiMU6kB0HRUUi4YMdnENY0
         VaRF550DRxJmJyGVzJ3EfClCsl7nV3fjgoVHOR1RRuWNsjBBjuE+j+Znk6smJvfEqrVg
         pNiwPF3IVCsj0neb+C75W+XblKcwHX53X8tTZzMQ5YX4ne9Iduq2rqprZeUxccAfXBU0
         VcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9tum+mvr4r/WQl+w9fpdy1xDFA2vaS1Lr9K70S1GO0=;
        b=FpvGvdxQWUti965/SfNo+cIeb3ePcN4ejHXnmF2yLNexYlCaM3sSRRGVQlFIB8NK8Z
         aD3hn0Cr35+zBNvkdDHoRyznW/977PgM9ITVH87fsTOqjE60kjjThyPcOM0jsn17q1Au
         An4OV2qqYOldBDG/tDagWo78jQDy7pQKNCpfDBLZIrESmncnxZJ6I12RZQ6tyCb7sKnH
         75gh03gF5sSyuCOHEaakGVhLBrEob6gLGeleRDUeEcCuYYvqw2amnp6apgs+qtslVJlg
         SVvOzPkqpAMn2RbrFXvS1vUwAOY704ChJKzadsfsJwAmeHBM/HVnwq0+YR8OziDOIS38
         qquA==
X-Gm-Message-State: AOAM533BDBOT7QBisw+EU+YilJ3KMQo0EK8JHliL9+pf2e7nOLpQD748
        VaHZgTC2fhMm4VQbuQqVgWLoU54dYa7U2a7bXCO0nqGCYrc=
X-Google-Smtp-Source: ABdhPJxKy0R/Yh5ganr1VmaK08okUWjWic+bOwe2Vc9kCJ4PMCFYeVcvbkrblvCKe1kUfICoVLoF4PdLlqD4LsuGpdI=
X-Received: by 2002:a05:6e02:1aa2:b0:2c2:2fc1:face with SMTP id
 l2-20020a056e021aa200b002c22fc1facemr32431214ilv.198.1646290269553; Wed, 02
 Mar 2022 22:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20220301184221.371853-1-amir73il@gmail.com> <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area> <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
In-Reply-To: <20220302211226.GG3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Mar 2022 08:50:58 +0200
Message-ID: <CAOQ4uxhv=g6hDS6LbNRY48Jmprhn7zWS8cedFQqMChKoGEs5FA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Not that simple.
> > First of all alloc_super() is used for all sorts of internal kernel sb
> > (e.g. pipes) that really don't need those stats.
>
> Doesn't change anything - it still should be entirely set up and
> managed by alloc_super/deactivate_locked_super.
>
> If it really has to be selected by filesystem, alloc_super() has
> a fstype passes to it and you can put a falg in the fstype to say
> this is supported. Then filesystems only need to set a feature flag
> to enable it, not have to manage allocation/freeing of something
> that only the core VFS code uses.
>

That sounds good to me.

It will still leave the decision per fs maintainer whether to support
sb iostats or not, but at least it won't cluttle mountstats with less
interesting stats from the many pseudo filesystem mounts.

I wish I had a good heuristic for which filesystems iostats should
be enabled. I was thinking for blockdev fs and for fs with private BDI
the iostats make more sense, because those fs are more likely to be
io intensive. Then I would not initialize iostats in alloc_super() but in
vfs_get_tree() as my test patch does.

Overlayfs does not have a private BDI yet [1], but overlayfs can use
an fstype flag to opt-in for iostats as you suggested.

[1] https://lore.kernel.org/linux-unionfs/20210923130814.140814-2-cgxu519@mykernel.net/

> > Second, counters can have performance impact.
>
> So does adding branches for feature checks that nobody except some
> special case uses.
>
> But if the counters have perf overhead, then fix the counter
> implementation to have less overhead.
>
> > Depending on the fs, overhead may or may not be significant.
> > I used the attached patch for testing and ran some micro benchmarks
> > on tmpfs (10M small read/writes).
> > The patch hacks -omand for enabling iostats [*]
> >
> > The results were not great. up to 20% slower when io size > default
> > batch size (32).
> > Increasing the counter batch size for rchar/wchar to 1K fixed this
> > micro benchmark,
>
> Why do you think that is? Think about it: what size IO did you test?
> I bet it was larger than 32 bytes and so it was forcing the
> default generic percpu counter implementation to take a spin lock on
> every syscall.  Yes?

Yes. I know why that is.

>
> Which means this addition will need to use a custom batch size for
> *all* filesystems, and it will have to be substantially larger than
> PAGE_SIZE because we need to amortise the cost of the global percpu
> counter update across multiple IOs, not just one. IOWs, the counter
> batch size likely needs to be set to several megabytes so that we
> don't need to take the per-cpu spinlock in every decent sized IO
> that applications issue.
>
> So this isn't a negative against enabling the feature for all
> superblocks - you just discovered a general problem because you
> hadn't considered the impact of the counter implementation on
> high performance, high concurrency IO. overlay does get used in such
> environments hence if the implementation isn't up to spec for
> filesystems like XFS, tmpfs, etc that overlay might sit on top of
> then it's not good enough for overlay, either.
>

I very much agree with you here. The batch size should be increased
to several MB, but that brings me back to your comment in the beginning
of this thread that I should use percpu_counter_read_positive() instead of
percpu_counter_sum_positive().

It's true that stats don't need to be accurate, but those stats are pretty
useful for sanity tests and testing some simple operations without ever
seeing the counters increase can be very confusing to users, especially
if megabytes are missing.

My instinct here is that I should use percpu_counter_sum_positive()
for mountstats and if someone reads this file too often, they should
pay the price for it. It is also not hard at all to spot the process and
function to blame for the extra CPU cycles, so unless this change is
going to regress a very common use case, I don't think this is going
to be a real life problem.

> > but it may not be a one size fits all situation.
> > So I'd rather be cautious and not enable the feature unconditionally.
>
> But now that you've realised that the counter configs need to be
> specifically tuned for the use case and the perf overhead is pretty
> much a non-issue, what's the argument against enabling it for
> all superblocks?
>

One argument still is the bloat of the mountstats file.
If people do not want iostats for pseudo fs I do not want to force
feed it to them.

I think the blockdev+private BDI+explicit opt-in by fstype flag
is a good balance.

Thanks,
Amir.
