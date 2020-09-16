Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1E926C999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgIPTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgIPRk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE209C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 10:40:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g4so7188588edk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uV0tE7wFf4iDXsIGWtEvvLMw+8GMDfCmV/fmV+L5rtE=;
        b=VUL59OIjIyapTdJmj8801q2Y3Mpvx7u/EUu0OW6UkOjIUtwW/SNHGKoOeax/rYuwFm
         BV+zC1jvzAnrHZ1+lB6gnvz/k34BGHKFYWsvs4xz5diwhGTkav8A0fXp1OSF1SVXrMNA
         GLgLeBWbfYQFhlJWYDSqhAvOOynHfdz3tdzgBr7WR0swtYyTgVYf3vz1RVxlC/uoAIWp
         pG98RBSBX5qWKRT1T68utMs4dX5/GL6lROu88danJYsXhPfOOipKUgyN/i0KEo2LcHRN
         nUr+R+oaGvfLrK5T8EnNypzlI70SgVNfFRidyM8avNMPlJwthJJAKYpib0C16t3rg8t/
         7lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uV0tE7wFf4iDXsIGWtEvvLMw+8GMDfCmV/fmV+L5rtE=;
        b=iK3jdJYC2Bz0rcsgzENsbKIRjZEdsbZTK7pGypqr4Sje8KaRmaVjTyNFZ5Y4eOJUhE
         cr/Lwadj816WXdUXbMthIgoBLsglSkUnIvHmUNyYUvJ6vuO8+4VkKFh1pp+E+m0O9ImQ
         FvFf5/f73DYRIidG+kMMV5MRelRZn2JIVwwTP3l3qS1yXIrGudxVRmvhBI6pngPYFQxV
         WqWTibwprcBwVipm0CclJC4OrRup9ws6pvce3JXOre5haA4bCpkQiSPUb38qdJOH83fS
         jEyT31uRLi3aYRW7CGk552IOSCburJQb+H/XTTgq22ws1QW//HLvAT3ClBZiGQW0Twl5
         Fz0Q==
X-Gm-Message-State: AOAM530b5t26lx2ckPSDXLHnVz9giYoIsF1vRzVsDU+RMa3UCKZQe5Ft
        FS+B8ArYLT4qzrzdFX+Ikep88WpQpY7Flm+FBjgbeQ==
X-Google-Smtp-Source: ABdhPJzpHn0y6abLjMHwzZfMOYlSY1x/tDmVXtLr70lERpOAZ6Mr1OrxP6/6W1RpzzyfKPPPiW/omY0hhpf2kB2k3ag=
X-Received: by 2002:aa7:c148:: with SMTP id r8mr29631134edp.210.1600278024225;
 Wed, 16 Sep 2020 10:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Sep 2020 10:40:13 -0700
Message-ID: <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
Subject: Re: [PATCH] pmem: export the symbols __copy_user_flushcache and __copy_from_user_flushcache
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 16 Sep 2020, Dan Williams wrote:
>
> > On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > >
> > > I'm submitting this patch that adds the required exports (so that we could
> > > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > > it for the next merge window.
> >
> > Why? This should go with the first user, and it's not clear that it
> > needs to be relative to the current dax_operations export scheme.
>
> Before nvfs gets included in the kernel, I need to distribute it as a
> module. So, it would make my maintenance easier. But if you don't want to
> export it now, no problem, I can just copy __copy_user_flushcache from the
> kernel to the module.

That sounds a better plan than exporting symbols with no in-kernel consumer.

> > My first question about nvfs is how it compares to a daxfs with
> > executables and other binaries configured to use page cache with the
> > new per-file dax facility?
>
> nvfs is faster than dax-based filesystems on metadata-heavy operations
> because it doesn't have the overhead of the buffer cache and bios. See
> this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS

...and that metadata problem is intractable upstream? Christoph poked
at bypassing the block layer for xfs metadata operations [1], I just
have not had time to carry that further.

[1]: "xfs: use dax_direct_access for log writes", although it seems
he's dropped that branch from his xfs.git
