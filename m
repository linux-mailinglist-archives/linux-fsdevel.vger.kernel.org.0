Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0044297DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 21:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhJKUAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJKUAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:00:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E5C061570;
        Mon, 11 Oct 2021 12:58:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so72056419edt.7;
        Mon, 11 Oct 2021 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKh3z8/eFx39DZqeLn4BLSOUQsWLVYgA6sDrH+x4Ulk=;
        b=mbTZFkNUWLVTd4DmzdjidHDoed1HvzabyqoqjfbSfDSfnZRHFe4aWbFxP2vttXkLYG
         fgY+vmdfVg8Mb4knc/uzjZjfn95JQUhUJc5HJhCh9fN/PBs8dpnFew/8uq99xByifowb
         zBoI1HjWz9lcOv+6aEy9mW2W1p2/VB7839rIxbIRaOXmHbm1i2/FZ2WkzUvWFgD76T78
         vWYhEa2D/8Mzg57eBzfslfMifTlrCf/5JZr9d7Fgj+UFyhA3ujRICitMDtAQmdSFaVMD
         DAjQ7PSre+Q5+1Lizyafz9GbRf7aeSI9wN0kfkztsb23UEChT6x/uZTDYIyay0WtQ7DR
         fBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKh3z8/eFx39DZqeLn4BLSOUQsWLVYgA6sDrH+x4Ulk=;
        b=oKATgOAcA0HYmOdQYC+3hsWhPneEOTDRZJMB6Isb42kZpvRoz3wjKlYuvzx7s3tOJE
         l3A3sbmkUFwMU7ypz54j+BqoQyVYrhYMVQ6aMyRJtPRQophYqaY6gSYCpx4iK4uFrOmF
         L+2DtT5+rEGO/ukRo24eNHHK58unu8cpsYAZ1+38aQWN/4fONq1KYoWwmchXZcxHYiCc
         jqZKDXpCxi6GHCZ2roW8GTTIOJiZEnS3QBqyHcQzYLOGx3KpjOhYdvN6dsRa8SYwuHaf
         AWfrCmVbmJdWe29YI0PK3u/L77wjdmgRg3akHztHfAaARMhwftr0mAbg//gdBTIoejrj
         c5Uw==
X-Gm-Message-State: AOAM533jPKP7l3KTiFoQxiHVus7XvKhriXOqAQWGD4fSgbgyjKqJmQUU
        VzeHiMG/yv+b1gd7XM/5X3DIRUWxzMifwC4W1xpXkiGBBh0=
X-Google-Smtp-Source: ABdhPJyvPma2sUPqNK2WXoa3c5nzFwAzXULxWPsz1UOgT2ZXXI0SzXbS+dZePUX9ENuRUxmAFHX8Z0px4jAlKssBXrA=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr28983343ejc.62.1633982282937;
 Mon, 11 Oct 2021 12:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com> <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org> <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org> <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
In-Reply-To: <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Oct 2021 12:57:51 -0700
Message-ID: <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 3:35 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Sep 20, 2021 at 2:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Sep 20, 2021 at 02:23:41PM -0700, Yang Shi wrote:
> > > On Sun, Sep 19, 2021 at 7:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > > > > > The debugging showed the page passed to invalidatepage is a huge page
> > > > > > and the length is the size of huge page instead of single page due to
> > > > > > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > > > > > the size is greater than single page.
> > > >
> > > > Things have already gone wrong before we get to this point.  See
> > > > do_dentry_open().  You aren't supposed to be able to get a writable file
> > > > descriptor on a file which has had huge pages added to the page cache
> > > > without the filesystem's knowledge.  That's the problem that needs to
> > > > be fixed.
> > >
> > > I don't quite understand your point here. Do you mean do_dentry_open()
> > > should fail for such cases instead of truncating the page cache?
> >
> > No, do_dentry_open() should have truncated the page cache when it was
> > called and found that there were THPs in the cache.  Then khugepaged
> > should see that someone has the file open for write and decline to create
> > new THPs.  So it shouldn't be possible to get here with THPs in the cache.
>

I think Hugh's skipping special file patch
(https://lore.kernel.org/linux-mm/a07564a3-b2fc-9ffe-3ace-3f276075ea5c@google.com/)
could fix this specific BUG report and seems like a more proper fix to
this.

However, it still doesn't make too much sense to have thp_size passed
to do_invalidatepage(), then have PAGE_SIZE hardcoded in a BUG
assertion IMHO. So it seems this patch is still useful because
block_invalidatepage() is called by a few filesystems as well, for
example, ext4. Or I'm wondering whether we should call
do_invalidatepage() for each subpage of THP in truncate_cleanup_page()
since private is for each subpage IIUC.

> AFAICT, it does so.
>
> In do_dentry_open():
> /*
>          * XXX: Huge page cache doesn't support writing yet. Drop all page
>          * cache for this file before processing writes.
>          */
>         if (f->f_mode & FMODE_WRITE) {
>                 /*
>                  * Paired with smp_mb() in collapse_file() to ensure nr_thps
>                  * is up to date and the update to i_writecount by
>                  * get_write_access() is visible. Ensures subsequent insertion
>                  * of THPs into the page cache will fail.
>                  */
>                 smp_mb();
>                 if (filemap_nr_thps(inode->i_mapping))
>                         truncate_pagecache(inode, 0);
>         }
>
>
> In khugepaged:
> filemap_nr_thps_inc(mapping);
>                 /*
>                  * Paired with smp_mb() in do_dentry_open() to ensure
>                  * i_writecount is up to date and the update to nr_thps is
>                  * visible. Ensures the page cache will be truncated if the
>                  * file is opened writable.
>                  */
>                 smp_mb();
>                 if (inode_is_open_for_write(mapping->host)) {
>                         result = SCAN_FAIL;
>                         __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
>                         filemap_nr_thps_dec(mapping);
>                         goto xa_locked;
>                 }
>
> But I'm not quite sure if there is any race condition.
