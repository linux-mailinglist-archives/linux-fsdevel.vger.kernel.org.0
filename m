Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDD26EAB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIRBxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIRBxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:53:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111BFC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 18:53:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so5896865ejb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC2uboF6NMZuC9/ZByaXp1KFBIoZjwLF73X8h59tMWs=;
        b=0n1kgcoBcO/MRG9AAQs28nlby+4uxxdWNINGwW2Okw2teha+5tUcRRM1S51DHvxjbe
         R8Cq+ItKHDbs5yC2r01vwPHgrzycwMkOBbRrsESuJbMdrF8xDKW+v6w7S1lQVw6CX4P9
         M9/7dgueosqWOddYA7f6ndQv2GVxNDfUmiVHE9QYX1uxi2bJty6xyL5m9lsyI5Tr0Ip5
         vxRKjnhcKMG6MwVZlo/19T+6Z8bhvWhZgkjv7bAiYeodgKLsWm9r4VxuokZiIFVcibHq
         AM6HBNJxSr8ACewbKnPZO1qmqRKpaxVJT1GKpdKqb7WgNxAmeZKt4bXcW8QyoirezqiZ
         fWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC2uboF6NMZuC9/ZByaXp1KFBIoZjwLF73X8h59tMWs=;
        b=PP1Q/8VaGHixwVbz0PaJ2fiqGNq3WM/QXkByhrh2DN3f8zd6XW6JLcXAhnMgt8A+HD
         MaOCBdDM8Zt0fT561UI7mRK0vO7q1GNxND8AhxI6RVdSG1hp5hmcKFeA/VSmjC6VI75d
         NI2BsCHVz6yEstAht5TRI6cRZsoYbJcIuMjeuIIip1miwu/2mooDTFz3OAzDxpicVhtT
         Dtxjk85ZVl20d/7xPeuaaBH/PW1AXZ8JyqC+yb0s2H5Q2wNOPPfvyR+YftmAoeJRI8FZ
         mRAw/pvzcEawlZa4M463HnvnMz/3LashqWkWrhS8rTQ++cg44us1litSL6LDy5ZseGaB
         Y7Aw==
X-Gm-Message-State: AOAM531UDJa+5I7DPsANttQkcRobaVdA1JsZF0/Ex/ZMubPoJhMyg72h
        WbAm3V8MSLCD7LQU7RFDk1tCzDiiN5K8/lrfVPYcfA==
X-Google-Smtp-Source: ABdhPJy7DFdMdaS97xMoxRqS6WmXgsRrt5dbwajDW1OzguEa9uaz85Fv52jSvKPNcbb4yTlLVhfIEfhmycxKE179n6U=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr33115785ejw.323.1600394032604;
 Thu, 17 Sep 2020 18:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Sep 2020 18:53:41 -0700
Message-ID: <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
Subject: Re: [PATCH] pmem: fix __copy_user_flushcache
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 16 Sep 2020, Dan Williams wrote:
>
> > On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > >
> > > On Wed, 16 Sep 2020, Dan Williams wrote:
> > >
> > > > On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > I'm submitting this patch that adds the required exports (so that we could
> > > > > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > > > > it for the next merge window.
> > > >
> > > > Why? This should go with the first user, and it's not clear that it
> > > > needs to be relative to the current dax_operations export scheme.
> > >
> > > Before nvfs gets included in the kernel, I need to distribute it as a
> > > module. So, it would make my maintenance easier. But if you don't want to
> > > export it now, no problem, I can just copy __copy_user_flushcache from the
> > > kernel to the module.
> >
> > That sounds a better plan than exporting symbols with no in-kernel consumer.
>
> BTW, this function is buggy. Here I'm submitting the patch.
>
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> If we copy less than 8 bytes and if the destination crosses a cache line,
> __copy_user_flushcache would invalidate only the first cache line. This
> patch makes it invalidate the second cache line as well.

Good catch.

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> ---
>  arch/x86/lib/usercopy_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6/arch/x86/lib/usercopy_64.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/lib/usercopy_64.c   2020-09-05 10:01:27.000000000 +0200
> +++ linux-2.6/arch/x86/lib/usercopy_64.c        2020-09-16 20:48:31.000000000 +0200
> @@ -120,7 +120,7 @@ long __copy_user_flushcache(void *dst, c
>          */
>         if (size < 8) {
>                 if (!IS_ALIGNED(dest, 4) || size != 4)
> -                       clean_cache_range(dst, 1);
> +                       clean_cache_range(dst, size);
>         } else {
>                 if (!IS_ALIGNED(dest, 8)) {
>                         dest = ALIGN(dest, boot_cpu_data.x86_clflush_size);
>

You can add:

Fixes: 0aed55af8834 ("x86, uaccess: introduce
copy_from_iter_flushcache for pmem / cache-bypass operations")
Reviewed-by: Dan Williams <dan.j.wiilliams@intel.com>
