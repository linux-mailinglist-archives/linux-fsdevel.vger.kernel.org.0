Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88EA26C8BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgIPS4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgIPRyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE1C02C28B
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 09:21:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c8so6891503edv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFYB36o5sQGOopQLIZ3LmVh5DVkQCsLHuBBKUkF022U=;
        b=gfng9FWV0J0yb5BbFoXNVi6dZSBG/a54FXDC6xO+b/rTexcJnOWoPzO2/a311RfdwU
         DndBlAsVoWq4m+KQxFxruPUXfOu/H/4aLqR+oqmcepZCVdQTeqAY9wXyPg1oxjdISGWz
         gxKXAXmkYpxOqulD0ZtwHmI63UlmamOH+5KeY8Ewl5owECC7J4+/0xTe9BKFYWPLvR/G
         Gh4/swNnN+GowPmGP9+0t9WAvKqz9INT9J7grCQpb5LVfUk+xEjovR4QWxt/hEKBc/Ne
         MM/a/bzu/8Q2+EooAIv4i8PFQEts7EHmlv/ZDeS4LScQoEdZ9rnfCtw53Dx3UPFL411n
         3B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFYB36o5sQGOopQLIZ3LmVh5DVkQCsLHuBBKUkF022U=;
        b=EZw4+U8MjjDIyM0ptA0GkuJ/Oy1UCylNPFDTgbm47Gjxq5A6XErGcsRlBJIaenNXaz
         cKHeP2/RlmPId6975SIVr+NWDiTbsiMejJsze5y+s2gBdtZidWIV2B/90IVZtYVUA5vN
         7bJeRThq3MZdQiUYjPDOIuEd41qAyQWr+iUQu2Q8BdGfSk6Bv+eGE6V+hjb8Zoi8+MKy
         jhQUr/QacQWQiBT9x23Aky7vP2GbndENECEhrmKO4DjAcwuEa79nm1tOqmIu2dxt+mcV
         pTqPKyBjWbVAH2JeHV5A7MeOORVp+g5GPQh+TQgK/uxYfgW9qY3qKd2h2TUp008vQBQL
         Utfw==
X-Gm-Message-State: AOAM532dVT9KJNg1dO6DTcrrkyBUGt62PwExGLiwZ6Epn4mghDbr7O+M
        hefadih3EJnLw1ISauIj+l6CjUDlNYwHJAAL3hmYKw==
X-Google-Smtp-Source: ABdhPJwI88G6wJzJR/w0a81ppKmua0R7ZF2T841uxc4i05zvl4D9vTqu2QlDOKyf+whND4urfI7hRks/8DB+WSLHUoA=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr29447035edo.354.1600273273498;
 Wed, 16 Sep 2020 09:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Sep 2020 09:21:02 -0700
Message-ID: <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
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

On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 15 Sep 2020, Mikulas Patocka wrote:
>
> >
> >
> > On Tue, 15 Sep 2020, Mikulas Patocka wrote:
> >
> > > > > - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> > > > > trailing bytes.
> > > >
> > > > You want copy_user_flushcache(). See how fs/dax.c arranges for
> > > > dax_copy_from_iter() to route to pmem_copy_from_iter().
> > >
> > > Is it something new for the kernel 5.10? I see only __copy_user_flushcache
> > > that is implemented just for x86 and arm64.
> > >
> > > There is __copy_from_user_flushcache implemented for x86, arm64 and power.
> > > It is used in lib/iov_iter.c under
> > > #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE - so should I use this?

Yes, but maybe not directly.

> > >
> > > Mikulas
> >
> > ... and __copy_user_flushcache is not exported for modules. So, I am stuck
> > with __copy_from_user_inatomic_nocache.
> >
> > Mikulas
>
> I'm submitting this patch that adds the required exports (so that we could
> use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> it for the next merge window.

Why? This should go with the first user, and it's not clear that it
needs to be relative to the current dax_operations export scheme.

My first question about nvfs is how it compares to a daxfs with
executables and other binaries configured to use page cache with the
new per-file dax facility?
