Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1B278553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIYKo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYKo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:44:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429CC0613CE;
        Fri, 25 Sep 2020 03:44:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u126so2273598oif.13;
        Fri, 25 Sep 2020 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=E9cSV5CE+MHJw1tuBMNdGwIhk859xENBsrzkUuMudZg=;
        b=EXuMI9FMTtqmLXffR4V4ar32H3o7ampleIRJ1mnTOa+RvEDZjGUxQ5/nILr/fBZ1mG
         zRqOw45thhUf6h1ixpWOZ3dnV96syaScynoD1Tj4JrH7ZO5f9iV0gfirvKnYsplUi1GG
         B9wF1MLuCLmxFMO6lL/NJfMDFFNYDdFeTnJftxFmu51iA2J6aAA7SrlJDz3ssWGWmUsN
         TdFbaf9exXTjFmcOkIOKOmweovQmYzGcvfYB9zY0sf9rlFL02bnGS7CLgqE6Hcefl6F/
         FzdjYDsBfhDsP/yAOdOdIcJBQ0lQwNb62uqHRzugpmtA8ET8sphcIeCZV6qU8jDmG/MA
         Sz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=E9cSV5CE+MHJw1tuBMNdGwIhk859xENBsrzkUuMudZg=;
        b=VA+goyIeaH2vUzbdnhEnmt4bjUiScq07o28KoZ085Wpmh/zgNdGB2j+0XjSygFmj5X
         4n4fmdfj5gHi5QqkIgY5CC4fygCcvTTK5jh6e/yEOgaBBnPNMxNfieTVw3CfM2/6+hzz
         5ISkbRG5nldmu+Ka7Lpv4kQg2HKJW9wn3Ab6ZWoGl6K3p5rJ3LFDuJP+miWr36jUbpha
         LJrRMDtkdlrSpgBCoNPXMPlLR5KHIeS0Y3+EwwPaS6m9GDd1txgFYAblA4xeSqiRivAe
         PR8Sjeh7M0WvstTwKmrZvdMlcFLeZeZSp4FTAW5UbF++UBs8K8nufL56XcE2yHppXUFC
         0zsA==
X-Gm-Message-State: AOAM532tYwCBiNtt38qksBx7TlWsRC0tuBHHKHwS15RTpKAsaftCmx7o
        uGzGY0YZoSbnkAIaQR84+lzB1W8kkmTwSTriY7i1BroA1D2eig==
X-Google-Smtp-Source: ABdhPJyXmmW5Dk2fR5llT2dunbY3CDhMLvgSKpwBKpJHS23hyTb47Kbk3u8QhUzD1//fzlQ4TJQ5/WRlSBCgEapvuzM=
X-Received: by 2002:aca:4754:: with SMTP id u81mr1186591oia.72.1601030695513;
 Fri, 25 Sep 2020 03:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org>
In-Reply-To: <20200924235756.GD32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Sep 2020 12:44:44 +0200
Message-ID: <CA+icZUXesz8SrB65qsVevEVC1iTV7heTWQyZYOZ21mem4kTZ3g@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 24, 2020 at 10:04:40PM +0200, Sedat Dilek wrote:
> > On Thu, Sep 24, 2020 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 09:54:36PM +0200, Sedat Dilek wrote:
> > > > You are named in "mm: fix misplaced unlock_page in do_wp_page()".
> > > > Is this here a different issue?
> > >
> > > Yes, completely different.  That bug is one Linus introduced in this
> > > cycle; the bug that this patch fixes was introduced a couple of years
> > > ago, and we only noticed now because I added an assertion to -next.
> > > Maybe I should add the assertion for 5.9 too.
> >
> > Can you point me to this "assertion"?
> > Thanks.
>
> Here's the version against 5.8
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 810f7dae11d9..b421e4efc4bd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -70,11 +70,15 @@ static void
>  iomap_page_release(struct page *page)
>  {
>         struct iomap_page *iop = detach_page_private(page);
> +       unsigned int nr_blocks = PAGE_SIZE / i_blocksize(page->mapping->host);
>
>         if (!iop)
>                 return;
>         WARN_ON_ONCE(atomic_read(&iop->read_count));
>         WARN_ON_ONCE(atomic_read(&iop->write_count));
> +       WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> +                       PageUptodate(page));
> +

Are you sure this is "bitmap_full()" or should it be "bitmap_f*i*ll()"?

Both are available in include/linux/bitmap.h.

- Sedat -

>         kfree(iop);
>  }
>
