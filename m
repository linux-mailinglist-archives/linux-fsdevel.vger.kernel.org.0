Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED87E2825F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgJCSxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJCSxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 14:53:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D93C0613D0;
        Sat,  3 Oct 2020 11:53:07 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e5so4273028ils.10;
        Sat, 03 Oct 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=q1mMXEHnEE0w2MvuZ3k8r6mLC/axsWVlKrfeY6R5BHk=;
        b=B9qe28J6HN56F4P7EIv18rQdvhstpSLQTBPkCDuX5hjlh9s/WRpNqAto5OXu0TCyRL
         IDgpM8Fk2v1UmPR571E8zrxK96qaenIKYPkg8tHsdkc273yscUNXP6+olkokxRdBdYib
         /wr80iXl75sT8GKPB5sjhWQ9BByqgWg95TNVqcLCp9CBmHqikprAX26f740nWn+toWaJ
         DqvRu8pg7E/1ZO7y8G49AZh7NDYC50IxE+ZrcHJbwW95QKVzOJCkDi4xxThMyWwL06r/
         a6/NxrFW3fgVuebdMRBfPm3PZMo2FJHdTt2SYY4nP1LjYxPtnepSUSYh/VyPo8NJ1aVX
         piUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=q1mMXEHnEE0w2MvuZ3k8r6mLC/axsWVlKrfeY6R5BHk=;
        b=JpaTyTnbtrGwfppWmBvZ69c9/pPWDvwgb3LWNKDMFHuiMrWnrMiFX2/L8MQlZ+3W3I
         rcOWWuaQyWQhid1gNQmyy3+pz3KMHYfHmme4zFqpzfF/A4LHulYklZliiqMTLNscc36M
         G8eHspUubM+wB4MD6okxZGll4lbMs12gYnl4xy0NMvUKfJWdjpuiO/YOk8WskJ/JY2Pp
         YeERV4uX4w0o36CZqayzMrX0jtke+lGRww8vIeD+O+2Q72xo49IkF/XJp7IC6an0gGNN
         jReh7gek1FUBoGY3E1M/+SfKjinWEiqbd0pFKTeCP/2L6qK137OpYipkdo0xcmPExPip
         rZ4w==
X-Gm-Message-State: AOAM53027S7AfAFgRJRaxaKrZVg9QnSY7KVdycU17IPc6oVO//yQ86qj
        6bosTi6UGK3w8RG3NHcWXYOnd29zSkqQ3vZO/igATIscilQ=
X-Google-Smtp-Source: ABdhPJw1fBp2k3zfC+JQip5elR7eC1F7w0MKQOXi8FdVWPeVo5guiIEJYbgmvVMkRenKsjplhPzzmzwsfwc/QoL2d8k=
X-Received: by 2002:a92:c80a:: with SMTP id v10mr6121699iln.10.1601751186641;
 Sat, 03 Oct 2020 11:53:06 -0700 (PDT)
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
Date:   Sat, 3 Oct 2020 20:52:55 +0200
Message-ID: <CA+icZUULTKouG4L-dFYbGUi=aLXTZ083tZ=kzw6P+pKcSj-6hQ@mail.gmail.com>
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
>         kfree(iop);
>  }
>

Will you send this as a separate patch or fold into the original?

I have tested the original patch plus this (debug) assertion diff on
top of Linux v5.9-rc7.

- Sedat -
