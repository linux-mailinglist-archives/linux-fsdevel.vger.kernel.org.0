Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F643BADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhJZTfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhJZTfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:35:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0ABC061570;
        Tue, 26 Oct 2021 12:33:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d13so763472ljg.0;
        Tue, 26 Oct 2021 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbyPcOn08VL2I8C/2HZAvhs84VOC3xvrXHI1rlDtOFc=;
        b=OAPSZiEELZNVbfPgmPd9N2DnjB64tmaKrzB3mEP02TMKa7Q70rLDtrD6eqqZIJvlTL
         PjTQHz8LS/w1aZ7Yq/VYYdfYmykH5+ml8TCf/8q94NpKvSnnR4Uou70DbDHO46liDZ5x
         BvqaTFFx5iBTn9482Lu/Y5scw/zDkAzdO7phB5RS1ujUDuBY9ptGtO9pOikjkaRQZh92
         OQLPglDb2pj17/ntaQAmk+ilZt+MJCjIgw2D31UpsnRsPLBderuSSC1o6zYwvpdPP0cS
         kBPXfU4Z9rYlKpbjyd957TaUmqSZUFv0fkBIerqHImLhOT5d5MCLIAGInvLfGl+vELXB
         48Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbyPcOn08VL2I8C/2HZAvhs84VOC3xvrXHI1rlDtOFc=;
        b=P8AzNKE7QcCHl8yo2uTvr3hmpAvHbRi8rgzP5+bVtI4cwFmqT/kGqWb7S39FkV22CM
         oiY9B5L3aBmJLVJx+e2Zfhmwy7o72epi6heanNWqRlInTnj6BfzXCWu44z4CJGq/S6N5
         RAGeHUVzLrGFkdmd1MFgYMYC9rFNpJSv1Vcrq3ULMbkS2Q3ojZ8Gc9osSoGMfJt9J5in
         IfuwiYWlX8QJZPgHWRDWkxcFDFQTI/OQJ+H7hpjnsIpPO9P/XERSjrUFE6FoQOCMfc/Y
         IIR326C/IV6l7F67EEXhtgebVBZsqUxJnxbvvaG4JieFdD79SAaslkyfDB05KxKAG3Qj
         xM5w==
X-Gm-Message-State: AOAM530zuSbbsKwGISH+Y+ay6jc0tHd2s0D//O/xDZkHFzrwHltRbZmR
        htp+feiQLn1BaCYmJh0uWPM=
X-Google-Smtp-Source: ABdhPJydkzhlV9E1KalfXwiiHw8d5e2VhZOR+gxOT16ovEHE85ajFZbo9l64fBsGFku0xx5zCd5GLQ==
X-Received: by 2002:a2e:9e93:: with SMTP id f19mr27692303ljk.311.1635276798204;
        Tue, 26 Oct 2021 12:33:18 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a16sm2011793lfu.274.2021.10.26.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:33:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 26 Oct 2021 21:33:15 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211026193315.GA1860@pc638.lan>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:28:52PM +0200, Michal Hocko wrote:
> On Tue 26-10-21 17:48:32, Uladzislau Rezki wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > >
> > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > cannot fail and they do not fit into a single page.
> > >
> > > The larg part of the vmalloc implementation already complies with the
> > > given gfp flags so there is no work for those to be done. The area
> > > and page table allocations are an exception to that. Implement a retry
> > > loop for those.
> > >
> > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > a change to the vmalloc space change if the failure was caused by
> > > the space fragmentation or depletion. But there are multiple different
> > > reasons to retry and this could become much more complex. Keep the retry
> > > simple for now and just sleep to prevent from hogging CPUs.
> > >
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  mm/vmalloc.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index c6cc77d2f366..602649919a9d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> > >                 flags = memalloc_noio_save();
> > >
> > > -       ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > +       do {
> > > +               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > >                         page_shift);
> > > +               if (ret < 0)
> > > +                       schedule_timeout_uninterruptible(1);
> > > +       } while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> > >
> > 
> > 1.
> > After that change a below code:
> > 
> > <snip>
> > if (ret < 0) {
> >     warn_alloc(orig_gfp_mask, NULL,
> >         "vmalloc error: size %lu, failed to map pages",
> >         area->nr_pages * PAGE_SIZE);
> >     goto fail;
> > }
> > <snip>
> > 
> > does not make any sense anymore.
> 
> Why? Allocations without __GFP_NOFAIL can still fail, no?
> 
Right. I meant one thing but wrote slightly differently. In case of
vmap_pages_range() fails(if __GFP_NOFAIL is set) should we emit any
warning message? Because either we can recover on a future iteration
or it stuck there infinitely so a user does not understand what happened.
From the other hand this is how __GFP_NOFAIL works, hm..

Another thing, i see that schedule_timeout_uninterruptible(1) is invoked
for all cases even when __GFP_NOFAIL is not set, in that scenario we do
not want to wait, instead we should return back to a caller asap. Or am
i missing something here?

> > 2.
> > Can we combine two places where we handle __GFP_NOFAIL into one place?
> > That would look like as more sorted out.
> 
> I have to admit I am not really fluent at vmalloc code so I wanted to
> make the code as simple as possible. How would I unwind all the allocated
> memory (already allocated as GFP_NOFAIL) before retrying at
> __vmalloc_node_range (if that is what you suggest). And isn't that a
> bit wasteful?
> 
> Or did you have anything else in mind?
>
It depends on how often all this can fail. But let me double check if
such combining is easy.

--
Vlad Rezki
