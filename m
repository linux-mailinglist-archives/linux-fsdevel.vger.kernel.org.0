Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549FD278592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIYLM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbgIYLM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:12:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9152CC0613CE;
        Fri, 25 Sep 2020 04:12:27 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so1926817otb.2;
        Fri, 25 Sep 2020 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=S9Sl6VItY96kd9/3DY+iJ5f+rTXm9h/Q4R5nq5D4Wnc=;
        b=sCvLWofWJDNrienFM2uR/nqSTwGTi+Wh0YmtODR4NxFYbtwc99bBrrFE4PtlDB7W6M
         pPrIObf/cGi1rhjni6dgSLycVN8jf23hF6kq21ByyIairK1Hfhdc0EuHoT5CiVpKdWYc
         NGRUVuZI4aJ+3+sCL6jEdgs9rkzbZcdTHB4FEX4GXX4oiwLJufNjSYsXJm3GdL8UdXLy
         iGrNBUQE4QFNp6AqQrr4trjbL54L4Bq7fNrr+rA/PxlrNAuaEVXURIVuJIdpOoBkBIIa
         RBXru8845OiAo69Vow6U+tbeG9FDalCv8rh5r2RVaxNrY7jDBok3dAJzNQ60eO1Cod0o
         fabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=S9Sl6VItY96kd9/3DY+iJ5f+rTXm9h/Q4R5nq5D4Wnc=;
        b=orBenlABC1/6mL4MFeaXWNVenwIbI4QQUeO3dAd1p3qFvVK7Z6iG26m6bqkz8uwnVF
         KLkZv7DgIcqUTQycvvDCxregfPlioyCD1bi+7FRsiqKh0mGM+Im/sob/gHEPf2iMa8YZ
         p3Cy0aOw0/2fpXm5/vZSPUqMzKzoOjctHb99ejqCBHzjH16O43s/DYJxH5+mCKJAjUQO
         H/bnPlW6Xdphvi2i42teIv4vZ7qmDHj3VjA4rBxBJ9CeOhJ2ddffUn5S/dwR5C3w5Fme
         5q80CZsro4ZjK4ydNTD7jOwJ1NhqupdAXLAh8Ci4YVMUNsYrGcuQPl0qiL+ADSFDIafj
         GwoQ==
X-Gm-Message-State: AOAM530n/idxgTCiXzut9ERISPc23eOoh8ZcL0JhloNdXa2QlU+kZs5r
        ShYDjydoEVUaL7ifLxpPA+pCmQmqPgi6ppmasls=
X-Google-Smtp-Source: ABdhPJypgtiI4B2wxYncVlJj4+2bl1fNwFv3Z6WKbrj3AtUQTcZqU2sMfbd3+aDvTgp0ZBtTs6qrytsjSrm8PWWG2ak=
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr2321427otq.109.1601032346947;
 Fri, 25 Sep 2020 04:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUXesz8SrB65qsVevEVC1iTV7heTWQyZYOZ21mem4kTZ3g@mail.gmail.com>
In-Reply-To: <CA+icZUXesz8SrB65qsVevEVC1iTV7heTWQyZYOZ21mem4kTZ3g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Sep 2020 13:12:15 +0200
Message-ID: <CA+icZUWxMEfwn_oApGTG2EvXcpya-r7HrDTZSd3vZgOmbp76ew@mail.gmail.com>
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

On Fri, Sep 25, 2020 at 12:44 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Sep 25, 2020 at 1:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 10:04:40PM +0200, Sedat Dilek wrote:
> > > On Thu, Sep 24, 2020 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Thu, Sep 24, 2020 at 09:54:36PM +0200, Sedat Dilek wrote:
> > > > > You are named in "mm: fix misplaced unlock_page in do_wp_page()".
> > > > > Is this here a different issue?
> > > >
> > > > Yes, completely different.  That bug is one Linus introduced in this
> > > > cycle; the bug that this patch fixes was introduced a couple of years
> > > > ago, and we only noticed now because I added an assertion to -next.
> > > > Maybe I should add the assertion for 5.9 too.
> > >
> > > Can you point me to this "assertion"?
> > > Thanks.
> >
> > Here's the version against 5.8
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 810f7dae11d9..b421e4efc4bd 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -70,11 +70,15 @@ static void
> >  iomap_page_release(struct page *page)
> >  {
> >         struct iomap_page *iop = detach_page_private(page);
> > +       unsigned int nr_blocks = PAGE_SIZE / i_blocksize(page->mapping->host);
> >
> >         if (!iop)
> >                 return;
> >         WARN_ON_ONCE(atomic_read(&iop->read_count));
> >         WARN_ON_ONCE(atomic_read(&iop->write_count));
> > +       WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> > +                       PageUptodate(page));
> > +
>
> Are you sure this is "bitmap_full()" or should it be "bitmap_f*i*ll()"?
>
> Both are available in include/linux/bitmap.h.
>

OK, I checked linux-next (next-20200925) and iomap_page_release() (see
[1] and [2]).
Cut-N-Paste is malformatting here in Gmail, so I add the links below.

I also looked into __gfs2_readpage() in fs/gfs2/aops.c:

if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
    !page_has_buffers(page)) {
           error = iomap_readpage(page, &gfs2_iomap_ops);

Thanks.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/iomap/buffered-io.c?h=next-20200925#n67
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/iomap/buffered-io.c?h=next-20200925#n77
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/gfs2/aops.c?h=next-20200925#n471



>
> >         kfree(iop);
> >  }
> >
