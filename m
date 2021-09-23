Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995A4167C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbhIWV4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbhIWV4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:56:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006DC061574;
        Thu, 23 Sep 2021 14:55:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c21so27906951edj.0;
        Thu, 23 Sep 2021 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyaukEdoY1z1aKx24A8HjbLfYl3/26h3pGEVti21r2o=;
        b=bKLgDd3gQ2vsGxxodi83AcpnShI19aXFzITFGpUC2/B67N5nRW6MaS08TQdLmLVo83
         dBB+XTXDeuHIPIanceHrTOUj5vutRzEaQj6omoDdSuzoeGwovop/2B/HZv4KRuqefaVx
         Im1U8ox47krXE91N/YcU8kq8tMQ7jR2nmyMzlEDeZfz/StqAQ+zIGR1rN+Oq5bT4JOAD
         vMm5vJbHE+eH0J0TCeMGFJrWnOSQj7kz17jq11hPCWN/14eHVWmcwMxr25E8JTHnZOrj
         fspqS8rznTsBkITGFIt53bpkM/AWUcbZVHXi0e7yHvpPr5krdJwzNklaP/1oanvW27Hu
         k2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyaukEdoY1z1aKx24A8HjbLfYl3/26h3pGEVti21r2o=;
        b=QYJsAbIzAAPdq9hTiMx+U//pa7NF9/4xEb5DktVTCXXlaEZpkRKVi7d6Rl9afBkPWg
         vqg5ouWFByK4APlVJoqKIdDbKmntDlYMitylhXUeUcfXebW8QGZDdF6KKjID5LOHkwIi
         rj2WDhtyxQlw53PYmAHmYct13uM3JkO1wHo44AYM6asJCI+W7Br+aOClaMMgqgKCEP+H
         FTs6bfqA0yk3kVzJP5ObFrSWHb6mtDFGHEB0J+FKd7m88Has4XH2TypEIcrbF3QIPRcD
         fgI492rH7j6NePGOaP4MjkKfuhCgOw8q7OSsv5JerJLvcfENsEv8M6UFUYEby77cSL0Y
         N+gw==
X-Gm-Message-State: AOAM5305xCRR6hpT+UPpVKKs3YtGrbbuOsvCeW4Nzs2OHUxpEAs4bK2v
        BSaRZvrYke2ATb/Kxp7G+8NcqHuIu9yXZXDK+Xc=
X-Google-Smtp-Source: ABdhPJzvRBl4386O9mXbGkypIExS2NjtQkuuCYFediqBv/zuOYi/yQPY0oXVlOJmvbveYcJbHdVj85A5jW+HBRJMugw=
X-Received: by 2002:a05:6402:14c3:: with SMTP id f3mr1389088edx.312.1632434103740;
 Thu, 23 Sep 2021 14:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name> <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
In-Reply-To: <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 14:54:51 -0700
Message-ID: <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
Subject: Re: Mapcount of subpages
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 23 Sep 2021, Kirill A. Shutemov wrote:
> > On Thu, Sep 23, 2021 at 12:40:14PM +0100, Matthew Wilcox wrote:
> > > On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
> > > > On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
> > > > > (compiling that list reminds me that we'll need to sort out mapcount
> > > > > on subpages when it comes time to do this.  ask me if you don't know
> > > > > what i'm talking about here.)
> > > >
> > > > I am curious why we would ever need a mapcount for just part of a page, tell me
> > > > more.
> > >
> > > I would say Kirill is the expert here.  My understanding:
> > >
> > > We have three different approaches to allocating 2MB pages today;
> > > anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
> > > 2MB boundary, so it has no special handling of mapcount [1].  Anon THP
> > > always starts out as being mapped exclusively on a 2MB boundary, but
> > > then it can be split by, eg, munmap().  If it is, then the mapcount in
> > > the head page is distributed to the subpages.
> >
> > One more complication for anon THP is that it can be shared across fork()
> > and one process may split it while other have it mapped with PMD.
> >
> > > Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
> > > but then have processes which only ever map part of it.  Or you might
> > > have some processes mapping it with a 2MB entry and others mapping part
> > > or all of it with 4kB entries.  And then someone truncates the file to
> > > midway through this page; we split it, and now we need to figure out what
> > > the mapcount should be on each of the subpages.  We handle this by using
> > > ->mapcount on each subpage to record how many non-2MB mappings there are
> > > of that specific page and using ->compound_mapcount to record how many 2MB
> > > mappings there are of the entire 2MB page.  Then, when we split, we just
> > > need to distribute the compound_mapcount to each page to make it correct.
> > > We also have the PageDoubleMap flag to tell us whether anybody has this
> > > 2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
> > > mapcounts if nobody has done that.
> >
> > Possible future complication comes from 1G THP effort. With 1G THP we
> > would have whole hierarchy of mapcounts: 1 PUD mapcount, 512 PMD
> > mapcounts and 262144 PTE mapcounts. (That's one of the reasons I don't
> > think 1G THP is viable.)
> >
> > Note that there are places where exact mapcount accounting is critical:
> > try_to_unmap() may finish prematurely if we underestimate mapcount and
> > overestimating mapcount may lead to superfluous CoW that breaks GUP.
>
> It is critical to know for sure when a page has been completely unmapped:
> but that does not need ptes of subpages to be accounted in the _mapcount
> field of subpages - they just need to be counted in the compound page's
> total_mapcount.
>
> I may be wrong, I never had time to prove it one way or the other: but
> I have a growing suspicion that the *only* reason for maintaining tail
> _mapcounts separately, is to maintain the NR_FILE_MAPPED count exactly
> (in the face of pmd mappings overlapping pte mappings).
>
> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
>
> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
> each pte as if it mapped the whole THP, or don't count a THP's ptes
> at all - you opted for the latter in the "Mlocked:" accounting),
> and I suspect subpage _mapcount could be abandoned.

AFAIK, partial THP unmap may need the _mapcount information of every
subpage otherwise the deferred split can't know what subpages could be
freed.

>
> But you have a different point in mind when you refer to superfluous
> CoW and GUP: I don't know the score there (and I think we are still in
> that halfway zone, since pte CoW was changed to depend on page_count,
> but THP CoW still depending on mapcount).
>
> Hugh
>
