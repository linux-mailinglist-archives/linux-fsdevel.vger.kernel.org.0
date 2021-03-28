Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7715034BA85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhC1DF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 23:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1DFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 23:05:12 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED77C0613B1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 20:05:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z15so9841323oic.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APX4LnXlg+3kr85w1PEHFEdO/A+eUu4WKT9NHCRE6qg=;
        b=kGTx6ODuNVmBr7JV4L17yfvin2SbzEGB6u0QxbVSAKmK3dUilMeeMF+DMZ4Sd/yOn4
         YDHqVNtdAqD9a4yDfe1Vqv2x/nrma30YYvHZVckSIsUjOEKT8Xsp3cKM2if2vc4+uXHD
         xVg8hOWJ1pFGjEVzNor6Y9coE4YC9oPlVuFb6+uxEfyZq7Fakp94w+/9IpIZIYjLn5GQ
         OOaghyxC+xWzj8eEfg/CxG8LaSnEiMpXOpX5VtsHdvVy5kOQQvcSLP5dVaMWrBf+wahh
         yTOO4Ov+OwipVPT0nNV/im1o8q9kTsctssAHpOFfOZUpg8Xq0ul/+trhbEAwCxdj6cAE
         JCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APX4LnXlg+3kr85w1PEHFEdO/A+eUu4WKT9NHCRE6qg=;
        b=U0YOTCpITQkd8kONIlma83AxyJldDhYRTX80FGY+LfU81wlYK3Kdp6MP1krQLkldVh
         Trl7nv3I5xmejZuaoJ3b3ItfNwnCqxdw8yeayNQkYxNjgRPRQSzkWgvXEYgG8FoOJSJB
         7B8CtgKnlfH1Dzq3tesFc6e3rE6z8Sn04H9GTDabQ1fNba+NZMvYgdY/DQYFHfz3AqTd
         gTWTj0ylmoiQPq/kLCcohVi5QnbeIVE0hW4qnkYw97fJEBC8efY9l1HQtAXXB8h06pX9
         /f2p4yADNuxSJ5F+7V+ioK1FfAqjzGXtJYesfNI7AIrxaGdT3YC0WDvzv+nvEe1XQW5w
         mhrQ==
X-Gm-Message-State: AOAM531kBmUKKpXwX5vzrb2XYWQBQFj4rq+6QbTxWnPdyoTcBrbo03B7
        4wBcs5+6d/5Dsq/p/XRsyu0hFWY100Ugd5pTo2eKSH4HZ+nqkwdT
X-Google-Smtp-Source: ABdhPJx/qNSOBQSYsp9hF12yNdrNZRg5E+A/4mGx2r2CTFsAlVhotAQQUkz86yndMjiTdFYfZFhK/gpTZHWZ4ss7rK0=
X-Received: by 2002:a54:4e08:: with SMTP id a8mr14971167oiy.135.1616900710908;
 Sat, 27 Mar 2021 20:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org>
In-Reply-To: <20210327155630.GJ1719932@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 27 Mar 2021 23:04:59 -0400
Message-ID: <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This seems OK... ?

static void orangefs_readahead(struct readahead_control *rac)
{
loff_t offset;
struct iov_iter iter;
struct file *file = rac->file;
struct inode *inode = file->f_mapping->host;
struct xarray *i_pages;
struct page *page;
loff_t new_start = readahead_pos(rac);
int ret;
size_t new_len = 0;

loff_t bytes_remaining = inode->i_size - readahead_pos(rac);
loff_t pages_remaining = bytes_remaining / PAGE_SIZE;

if (pages_remaining >= 1024)
new_len = 4194304;
else if (pages_remaining > readahead_count(rac))
new_len = bytes_remaining;

if (new_len)
readahead_expand(rac, new_start, new_len);

offset = readahead_pos(rac);
i_pages = &file->f_mapping->i_pages;

iov_iter_xarray(&iter, READ, i_pages, offset, readahead_length(rac));

/* read in the pages. */
if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
&offset, &iter, readahead_length(rac),
inode->i_size, NULL, NULL, file)) < 0)
gossip_debug(GOSSIP_FILE_DEBUG,
"%s: wait_for_direct_io failed. \n", __func__);
else
ret = 0;

/* clean up. */
while ((page = readahead_page(rac))) {
page_endio(page, false, ret);
put_page(page);
}
}

I need to go remember how to git send-email through the
kernel.org email server, I apologize for the way gmail
unformats my code, even in plain text mode...

-Mike

On Sat, Mar 27, 2021 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Mar 27, 2021 at 11:40:08AM -0400, Mike Marshall wrote:
> > int ret;
> >
> > loff_t new_start = readahead_index(rac) * PAGE_SIZE;
>
> That looks like readahead_pos() to me.
>
> > size_t new_len = 524288;
> > readahead_expand(rac, new_start, new_len);
> >
> > npages = readahead_count(rac);
> > offset = readahead_pos(rac);
> > i_pages = &file->f_mapping->i_pages;
> >
> > iov_iter_xarray(&iter, READ, i_pages, offset, npages * PAGE_SIZE);
>
> readahead_length()?
>
> > /* read in the pages. */
> > ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> > npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
> >
> > /* clean up. */
> > while ((page = readahead_page(rac))) {
> > page_endio(page, false, 0);
> > put_page(page);
> > }
> > }
>
> What if wait_for_direct_io() returns an error?  Shouldn't you be calling
>
> page_endio(page, false, ret)
>
> ?
>
> > On Sat, Mar 27, 2021 at 9:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Mar 27, 2021 at 08:31:38AM +0000, David Howells wrote:
> > > > However, in Mike's orangefs_readahead_cleanup(), he could replace:
> > > >
> > > >       rcu_read_lock();
> > > >       xas_for_each(&xas, page, last) {
> > > >               page_endio(page, false, 0);
> > > >               put_page(page);
> > > >       }
> > > >       rcu_read_unlock();
> > > >
> > > > with:
> > > >
> > > >       while ((page = readahead_page(ractl))) {
> > > >               page_endio(page, false, 0);
> > > >               put_page(page);
> > > >       }
> > > >
> > > > maybe?
> > >
> > > I'd rather see that than open-coded use of the XArray.  It's mildly
> > > slower, but given that we're talking about doing I/O, probably not enough
> > > to care about.
