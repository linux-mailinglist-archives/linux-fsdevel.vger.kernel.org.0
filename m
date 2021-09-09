Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAF405CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 20:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbhIISP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhIISP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:15:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0EC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 11:14:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 22so2815936qkg.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DblO9ClH443238qZj20JkQQSAd0noLNjchR3cpshmnA=;
        b=Q86+9sX7t6cI3lgecF19O/4RxatjCaFYj4PdR8hhhd4DcI/gyHIeAO/qFH/KY5VJMC
         31EhG1siSdE3ltgNctvI/T+/l5GYT657t4obERgmN+Evu3C+lzhD7Zm0DDWHv8JsIbrR
         qkCDYW+qUkonLI8X4RJZf/6RgcuFMl4CHdC9WTSk0B2SiRun8eQqYwi2sogffpL01N2z
         CEAFT2AwGIA5d8LLwfZmJmEARdfBoJT9wQOMuoTNfAajynu1B/cHOjAkdeAa6fBYJLfs
         us6D9BVtgOrcSaJIbBzWBLtDbmVA44tT2Hwh3FJJ3YgOHVdGAaRobufS/CsuXBwavQFd
         Lkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DblO9ClH443238qZj20JkQQSAd0noLNjchR3cpshmnA=;
        b=JxHQrahlQfmSoAYBVV18iTVZiQyaqMtSpm5IFbslxpDG8ChKGsu+qVupUqqnRWemIy
         WWZfgE9DMDPXyuaONRsv3zHeUVOtTnP+FWCBYu0Lgilz7yc6goeTJ6yUZCBj/EmdI7AU
         jyZvYJwmkUlp4h2WltuCkQKRjPu00mUDEGwZ46qguYeEAGer7QMNdjp3UakttqPALWgE
         WN3LdEGWUtMoU1hs3z326sT/6bS6FKnCi2nzda94xo7HG3iuEmugdmXT7IQQstnayivL
         Hjs6KW4tqUuvVOwbjcL7HD+WNJgR2eRpgC9vzZkMaxWrIJ7qSu19f43SkARGbGsFv5eP
         iLsA==
X-Gm-Message-State: AOAM531JHXNhR9jO6UVSEn9keNkGWwDEHiv8nEzCAGSkCJ4qttU85QT+
        Mqntiq+2pWd17Nj/QdWmTEzASw==
X-Google-Smtp-Source: ABdhPJxZrSplUulNFGu6SlBUF9t6hILViTDkMRHvSu9j9tUAIEzSWig8TRANAwaksO+9ULJ2LUcvnQ==
X-Received: by 2002:a37:a147:: with SMTP id k68mr4008554qke.416.1631211288054;
        Thu, 09 Sep 2021 11:14:48 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id x125sm1867923qkd.8.2021.09.09.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:14:47 -0700 (PDT)
Date:   Thu, 9 Sep 2021 14:16:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YTpPh2aaQMyHAi8m@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:56:54PM +0200, Vlastimil Babka wrote:
> On 9/9/21 14:43, Christoph Hellwig wrote:
> > So what is the result here?  Not having folios (with that or another
> > name) is really going to set back making progress on sane support for
> > huge pages.  Both in the pagecache but also for other places like direct
> > I/O.

From my end, I have no objections to using the current shape of
Willy's data structure as a cache descriptor for the filesystem API:

struct foo {
        /* private: don't document the anon union */
        union {
                struct {
        /* public: */
                        unsigned long flags;
                        struct list_head lru;
                        struct address_space *mapping;
                        pgoff_t index;
                        void *private;
                        atomic_t _mapcount;
                        atomic_t _refcount;
#ifdef CONFIG_MEMCG
                        unsigned long memcg_data;
#endif
        /* private: the union with struct page is transitional */
                };
                struct page page;
        };
};

I also have no general objection to a *separate* folio or pageset or
whatever data structure to address the compound page mess inside VM
code. With its own cost/benefit analysis. For whatever is left after
the filesystems have been sorted out.

My objection is simply to one shared abstraction for both. There is
ample evidence from years of hands-on production experience that
compound pages aren't the way toward scalable and maintainable larger
page sizes from the MM side. And it's anything but obvious or
self-evident that just because struct page worked for both roles that
the same is true for compound pages.

Willy says it'll work out, I say it won't. We don't have code to prove
this either way right now.

Why expose the filesystems to this gamble?

Nothing prevents us from putting a 'struct pageset pageset' or 'struct
folio folio' into a cache descriptor like above later on, right?

[ And IMO, the fact that filesystem people are currently exposed to,
  and blocked on, mindnumbing internal MM discussions just further
  strengthens the argument to disconnect the page cache frontend from
  the memory allocation backend. The fs folks don't care - and really
  shouldn't care - about any of this. I understand the frustration. ]

Can we go ahead with the cache descriptor for now, and keep the door
open on how they are backed from the MM side? We should be able to
answer this without going too deep into MM internals.

In the short term, this would unblock the fs people.

In the longer term this would allow the fs people to focus on fs
problems, and MM people to solve MM problems.

> Yeah, the silence doesn't seem actionable. If naming is the issue, I believe
> Matthew had also a branch where it was renamed to pageset. If it's the
> unclear future evolution wrt supporting subpages of large pages, should we
> just do nothing until somebody turns that hypothetical future into code and
> we see whether it works or not?

Folio or pageset works for compound pages, but implies unnecessary
implementation details for a variable-sized cache descriptor, IMO.

I don't love the name folio for compound pages, but I think it's
actually hazardous for the filesystem API.

To move forward with the filesystem bits, can we:

1. call it something - anything - that isn't tied to the page, or the
   nature of multiple pages? fsmem, fsblock, cachemem, cachent, I
   don't care too deeply and would rather have a less snappy name than
   a clever misleading one,

2. make things like folio_order(), folio_nr_pages(), folio_page()
   page_folio() private API in mm/internal.h, to acknowledge that
   these are current implementation details, not promises on how the
   cache entry will forever be backed in the future?

3. remove references to physical contiguity, PAGE_SIZE, anonymous
   pages - and really anything else that nobody has explicitly asked
   for yet - from the kerneldoc; generally keep things specced to what
   we need now, and not create dependencies against speculative future
   ambitions that may or may not pan out,

4. separate and/or table the bits that are purely about compound pages
   inside MM code and not relevant for the fs interface - things like
   the workingset.c and swap.c conversions (page_folio() usage seems
   like a good indicator for where it permeated too deeply into MM
   core code which then needs to translate back up again)?
