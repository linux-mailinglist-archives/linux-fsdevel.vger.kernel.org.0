Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547FD33E76A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 04:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQDEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCQDEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:04:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2541CC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 20:04:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u6so33042230oic.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 20:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKJVDGq2fD/K8JDHgdceX4ZU6BQj507CK8v7EKjVYFU=;
        b=fE1P5fiE4yp7C9fG/rJdKNBQynGyQfJdb36Od9usmkBMAdAubIkTGG9hWXO0/2KOjn
         VzYa+76HCb9l0yG+p7X675qqfoDludKiClRHh7jUuKLqOP0s7DfXMhtCV2qf24jlg3BM
         ofkHQUK2QbhbS/VvvvguAHA7Pr8tgxNKtJ7p9KuUE1X+PhPTfR+MFzKD7a+1Bo/ujYVj
         uWpe3iQe0O07xg5r1okog40zamw4cwOOWk19OLGlolFxNZaUmBpp1zO7J712gW4ghWsA
         R6SuhlOzDyKjfeYHxFHG7/qEcvOzS2HinM/j3coM8mOVmR5513IOYC4ChNgaiWnOxLa5
         aMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKJVDGq2fD/K8JDHgdceX4ZU6BQj507CK8v7EKjVYFU=;
        b=m7ARF/GhBqWKoY3BXuGUNZkuiiAujfGacOwc8p7MxL+Doch69Pf4Mi+n65gnI0d06O
         h8dLauf3odB6CXpmz+9bHtNxYO4Jp+Y/MWc3JBiHgS7iwS+cWIG245v0i6PjrtUYKXOm
         yH6i/lzzxHMBqIwS94LmhBKXKuI4mnvxmkhV1Md420GGlRMx0o8CPunMJTx7iDuHf+JN
         /njDkxWrl4LmuSj+qeqlNnS1Z6kxufbIWnTfKFrM8kWMpKRSPSFA12jTg2nQ/cL2piU/
         STGgTEyrBhjHAMNvxmOB15TziWxURHej7NWNdmn2OTYxQ7F8zccA4nPdx3qDlVGQNxQa
         ZFbA==
X-Gm-Message-State: AOAM5306MdSpfAgWv6o1v1iMu8+qjgECihftefAI8NbeSv5M+rG/Mcwp
        S9U6OKgvlr2MZpsCPCvbQtyidV2yZoPFxumIryiubQ==
X-Google-Smtp-Source: ABdhPJx9MvoNOrBNPbnCCBnJJ5/viAPiTOEuFqbFngZIsW27w22YA8/3lAfkGBk4Np6w9nV/GaqHrhIOwXD6W+8eIiw=
X-Received: by 2002:aca:538c:: with SMTP id h134mr1265814oib.174.1615950273440;
 Tue, 16 Mar 2021 20:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
In-Reply-To: <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 16 Mar 2021 23:04:22 -0400
Message-ID: <CAOg9mSSW_fs73jmB1jmArJZ-bGSeVagp+R93W6k5sQ74xUyqcw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I took my orangefs_readahead patch and
David Howells' patches from his fscache-iter
branch and put them on top of Linux 5.12-rc3
so as to get rid of all that
 RIP: 0010:ttm_bo_release+0x2ea/0x340 [ttm]
stuff that was happening to VMs with
5.12-rc2.  Then I added a readahead_expand
call at the start of orangefs_readahead. I
played with various expansion values, but
the bottom line is: it works GREAT in my
simple tests, speeds reads WAY up.

-Mike

On Sat, Mar 13, 2021 at 10:31 AM Mike Marshall <hubcap@omnibond.com> wrote:
>
> Greetings everyone.
>
> I have made another version of orangefs_readahead, without any
> of my hand rolled page cache manipulations. I read a bunch of
> the source in other filesystems and mm and fs and pagemap.h to
> try and get an idea of how to implement readahead so that my
> implementation is "with the program".
>
> I have described the flawed code I have upstream now in an
> earlier message. My flawed code has no readahead implementation, but
> it is much faster than with this readahead implementation.
>
> If this readahead implementation is "the right idea", I can
> use it as a framework to implement an async orangefs read function
> and start the read at the beginning of my readahead function
> and collect the results at the end after the readahead pages
> have been marshaled. Also, once some mechanism like David Howells'
> code to control the readahead window goes upstream, I should be
> able take big enough gulps of readahead to make Orangefs do right.
> The heuristically chosen 64 page max that I can get now isn't enough.
>
> I hope some of y'all have the time to review this implementation of
> readahead...
>
> Thanks!
>
> -Mike
>
> static void orangefs_readahead(struct readahead_control *rac)
> {
> struct page **pages;
> unsigned int npages = readahead_count(rac);
> loff_t offset = readahead_pos(rac);
> struct bio_vec *bvs;
> int i;
> struct iov_iter iter;
> struct file *file = rac->file;
> struct inode *inode = file->f_mapping->host;
> int ret;
>
> /* allocate an array of page pointers. */
> pages = kzalloc(npages * (sizeof(struct page *)), GFP_KERNEL);
>
> /* Get a batch of pages to read. */
> npages = __readahead_batch(rac, pages, npages);
>
> /* allocate an array of bio_vecs. */
> bvs = kzalloc(npages * (sizeof(struct bio_vec)), GFP_KERNEL);
>
> /* hook the bio_vecs to the pages. */
> for (i = 0; i < npages; i++) {
> bvs[i].bv_page = pages[i];
> bvs[i].bv_len = PAGE_SIZE;
> bvs[i].bv_offset = 0;
> }
>
> iov_iter_bvec(&iter, READ, bvs, npages, npages * PAGE_SIZE);
>
> /* read in the pages. */
> ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
>
> /* clean up. */
> for (i = 0; i < npages; i++) {
> SetPageUptodate(bvs[i].bv_page);
> unlock_page(bvs[i].bv_page);
> put_page(bvs[i].bv_page);
> }
> kfree(pages);
> kfree(bvs);
> }
>
> On Mon, Feb 1, 2021 at 10:32 PM Mike Marshall <hubcap@omnibond.com> wrote:
> >
> > >> This is not the way to do it. You need to actually kick
> > >> off readahead in this routine so that you get pipelining
> > >> (ie the app is working on pages 0-15 at the same time
> > >> the server is getting you pages 16-31).
> >
> > Orangefs isn't very good at reading or writing a few
> > pages at a time. Its optimal block size is four megabytes.
> > I'm trying to do IOs big enough to make Orangefs
> > start flowing like it needs to and then have pages
> > on hand to fill with the data. Perhaps I can figure
> > how to use Dave Howell's code to control the
> > readahead window and make adjustments to
> > how many pages Orangefs reads per IO and
> > end up with something that is closer to how
> > readahead is intended to be used.
> >
> > This patch is a big performance improvement over
> > the code that's upstream even though I'm
> > not using readahead as intended.
> >
> > >> I don't see much support in orangefs for doing async
> > >> operations; everything seems to be modelled on
> > >> "submit an I/O and wait for it to complete".
> >
> > Yep... when we were polishing up the kernel module to
> > attempt to go upstream, the code in there for async was
> > left behind... I might be able to make sense of it now,
> > Ida know... You've helped me to see this place where
> > it is needed.
> >
> > >> adding async
> > >> support to orangefs is a little bigger task than I'm willing to put
> > >> significant effort into right now.
> >
> > The effort and help that you're providing is much
> > appreciated and just what I need, thanks!
> >
> > -Mike
> >
> > On Mon, Feb 1, 2021 at 8:08 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Jan 31, 2021 at 05:25:02PM -0500, Mike Marshall wrote:
> > > > I wish I knew how to specify _nr_pages in the readahead_control
> > > > structure so that all the extra pages I need could be obtained
> > > > in readahead_page instead of part there and the rest in my
> > > > open-coded stuff in orangefs_readpage. But it looks to me as
> > > > if values in the readahead_control structure are set heuristically
> > > > outside of my control over in ondemand_readahead?
> > >
> > > That's right (for now).  I pointed you at some code from Dave Howells
> > > that will allow orangefs to enlarge the readahead window beyond that
> > > determined by the core code's algorithms.
> > >
> > > > [root@vm3 linux]# git diff master..readahead
> > > > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > > > index 48f0547d4850..682a968cb82a 100644
> > > > --- a/fs/orangefs/inode.c
> > > > +++ b/fs/orangefs/inode.c
> > > > @@ -244,6 +244,25 @@ static int orangefs_writepages(struct
> > > > address_space *mapping,
> > > >
> > > >  static int orangefs_launder_page(struct page *);
> > > >
> > > > +/*
> > > > + * Prefill the page cache with some pages that we're probably
> > > > + * about to need...
> > > > + */
> > > > +static void orangefs_readahead(struct readahead_control *rac)
> > > > +{
> > > > +       pgoff_t index = readahead_index(rac);
> > > > +       struct page *page;
> > > > +
> > > > +       while ((page = readahead_page(rac))) {
> > > > +               prefetchw(&page->flags);
> > > > +               put_page(page);
> > > > +               unlock_page(page);
> > > > +               index++;
> > > > +       }
> > > > +
> > > > +       return;
> > > > +}
> > >
> > > This is not the way to do it.  You need to actually kick off readahead in
> > > this routine so that you get pipelining (ie the app is working on pages
> > > 0-15 at the same time the server is getting you pages 16-31).  I don't
> > > see much support in orangefs for doing async operations; everything
> > > seems to be modelled on "submit an I/O and wait for it to complete".
> > >
> > > I'm happy to help out with pagecache interactions, but adding async
> > > support to orangefs is a little bigger task than I'm willing to put
> > > significant effort into right now.
