Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8523E277DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 04:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIYCNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 22:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIYCNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:13:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3716C0613CE;
        Thu, 24 Sep 2020 19:13:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m12so915656otr.0;
        Thu, 24 Sep 2020 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fXz74Mau6+KuvvTKWE0vkW9nC6evQbwsekCfblHroN0=;
        b=HYuYIT60YzlqDFTZWa3k+7jb6ulZ+XLGFU+E6AWf/m66bkNKT+Aap7lsIOZsuVwmOF
         XyduNh1qm+SnNE61wVHhcWkPySDfsgpUfkGHPJk3q8l3P90kvuVkAikkSNfUKHNnT+a6
         L/obpPfURnxJ72amJZv15zp1ASqCqD+8LPGEiAJSl3bImTGWTMMuNCfIkzpBIcPLxcR5
         jyqCqgQ0WDnglI1I1e4riG8f59LBvErznrpUOvO88cszmT/DkU33itbjT9K1ngURU1vi
         C6ynlb+18JXc0WcMQ9TZdkMbd3Y1qllHaRiqdO5XrTjmZY0m76sfZxa62WV17D6uSq1J
         gQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fXz74Mau6+KuvvTKWE0vkW9nC6evQbwsekCfblHroN0=;
        b=m1UtBmAr9rf6jb3C6pCADdPYdi9JaqFgXdFtT7/UlubGkIKhUjEtJDb6yro5FcZiVS
         ZS+Gr5prgLbeJ54jmYiwGs0Vn967AeCtl6dFjf1/qfbShZavEmpNw7ucHvQPYhraHlIW
         FOoq+bbyx+MVSlkQxomxDqsqoVIFKMr9tBnai3X5iLBJ6yVx8cZt5SQK6A1MZLK1AkGx
         jeXRvnJJQiq3Gbt5cq0SP/kvdM0RI2OkCNZydlIRRh/9faOmchd1J5VkIBhZIY5kyJvu
         mQeDZVmjvAM3ogVmiHbj0Tnbhrj1PDCu7XNHPb2aikNmryVirctxjqR3E2OITJG8oCOw
         EdcQ==
X-Gm-Message-State: AOAM532idXOmxxuw2BOzUjE9L3+6UMljiE4H7V9MG4GeEK67UOZ4MkfS
        gX9ax4e5IMRHGkNyiPoKb390OFPIKpyuEAwfOh4=
X-Google-Smtp-Source: ABdhPJyokqsw/NObjWiHgqegLZAB6a6883WfP3iqFCj+k3B/5iIjG/fcqIl87XOKSldFWWXjDRHqymK1pmC+j8wplw4=
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr1486453otn.9.1601000032038;
 Thu, 24 Sep 2020 19:13:52 -0700 (PDT)
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
Date:   Fri, 25 Sep 2020 04:13:40 +0200
Message-ID: <CA+icZUUZvjfSqY_F=pdwDVK2jBF_vZ+pw-PtiAuRKfRppOiF+w@mail.gmail.com>
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

5.8? I am here on 5.9.

- Sedat -

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
