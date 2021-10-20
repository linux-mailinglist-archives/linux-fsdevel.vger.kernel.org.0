Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A6435689
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 01:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJTXlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 19:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:41:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAFBC06161C;
        Wed, 20 Oct 2021 16:39:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so1179338edj.1;
        Wed, 20 Oct 2021 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m++dlrHIml0Wqg63117GS9AXAYHvTxZYinRAd885b3w=;
        b=ZWK4LF2ala6mstOiD6RlG3TD4qZEDkA2Msb/OjkpXmlOInfQPxJ7XBZ75Bt0zUII5b
         rjaKl5Iym86LwOdDw0fsbFCYaaDKVoRR1lnePJIBEbJmI9Lo8j1k5uHKIgiXAiKxswtJ
         ywnN8XEABOt9AlzFbONgvMyyYM3YMWs0gUctv0hSIVWzgfL9p1x1jsvdTTr5w6A6koTT
         qMCH0f3rOyqvVOXVl4YT681I0kn1cfAoinup44MF34mAvzOX75Z2yPzuw9/465I3BFGT
         KQI5hgSd+cixKfzylsckip37zcGsL9XLoM46lGuSymBSY5Gkbq9xwizPNVi9xsUcNWvr
         UxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m++dlrHIml0Wqg63117GS9AXAYHvTxZYinRAd885b3w=;
        b=fflWgOD/WGCHJ33wmeWDcdnfB+P0GQAbnLxmvCSrMR7W0ZUj5oGVH6Vsh3C6nrGh4F
         8tenFyx7JsEEKtEbs7NeqqhtND+FlQseJLeOnjX1OVl/UhhacEm9tbeTO6OakUk/9Mby
         E0rDasZJVwJaqnb+fmZKWMW4KeSxXq9kT5mNrX8eBLXeU8cMTkmfrhdjlDorH+YYK+pE
         skahn/4bHD6VV9Bd10tdRvJ8HbTVjwFd9UzAdLdBnYdTUl9nULFPTuwISFt6vLk2Useb
         FOMAS+MW0RlhuNUmDRN5zKwoULk+CmoFQ83xzQMQHeknKBmx8yP6dRVhvFsrDtdvvlyC
         bcgA==
X-Gm-Message-State: AOAM532TYXatdDgp+/EZd9Eb+YQCwbN50nQJtrrBSr7zZzuChSOVH85W
        oaQ0uzVmBLTGKpEmwxco3XVkS8XirPma02oJ3YHFpS/QWDM=
X-Google-Smtp-Source: ABdhPJzjnzn+utT/TRyXjvVFzmfumtSjzkS0NZwcdCpDbCIuNTc9fq8vmpA5Vw4/ZlT3F4I/aUv/gYjj1utvNPJ0Vpc=
X-Received: by 2002:a05:6402:16d2:: with SMTP id r18mr2703521edx.363.1634773140864;
 Wed, 20 Oct 2021 16:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com> <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org> <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org> <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
 <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
In-Reply-To: <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Oct 2021 16:38:49 -0700
Message-ID: <CAHbLzkq2v+xpBweO-XG+uZiF3kvOFodKi4ioX=dzXpBYLtoZcw@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 12:57 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Sep 20, 2021 at 3:35 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Mon, Sep 20, 2021 at 2:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Sep 20, 2021 at 02:23:41PM -0700, Yang Shi wrote:
> > > > On Sun, Sep 19, 2021 at 7:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > > > > > > The debugging showed the page passed to invalidatepage is a huge page
> > > > > > > and the length is the size of huge page instead of single page due to
> > > > > > > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > > > > > > the size is greater than single page.
> > > > >
> > > > > Things have already gone wrong before we get to this point.  See
> > > > > do_dentry_open().  You aren't supposed to be able to get a writable file
> > > > > descriptor on a file which has had huge pages added to the page cache
> > > > > without the filesystem's knowledge.  That's the problem that needs to
> > > > > be fixed.
> > > >
> > > > I don't quite understand your point here. Do you mean do_dentry_open()
> > > > should fail for such cases instead of truncating the page cache?
> > >
> > > No, do_dentry_open() should have truncated the page cache when it was
> > > called and found that there were THPs in the cache.  Then khugepaged
> > > should see that someone has the file open for write and decline to create
> > > new THPs.  So it shouldn't be possible to get here with THPs in the cache.
> >
>
> I think Hugh's skipping special file patch
> (https://lore.kernel.org/linux-mm/a07564a3-b2fc-9ffe-3ace-3f276075ea5c@google.com/)
> could fix this specific BUG report and seems like a more proper fix to
> this.
>
> However, it still doesn't make too much sense to have thp_size passed
> to do_invalidatepage(), then have PAGE_SIZE hardcoded in a BUG
> assertion IMHO. So it seems this patch is still useful because
> block_invalidatepage() is called by a few filesystems as well, for
> example, ext4. Or I'm wondering whether we should call
> do_invalidatepage() for each subpage of THP in truncate_cleanup_page()
> since private is for each subpage IIUC.

Seems no interest?

Anyway the more I was staring at the code the more I thought calling
do_invalidatepage() for each subpage made more sense. So, something
like the below makes sense?

diff --git a/mm/truncate.c b/mm/truncate.c
index 714eaf19821d..9048f498cd02 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -169,11 +169,16 @@ void do_invalidatepage(struct page *page,
unsigned int offset,
  */
 static void truncate_cleanup_page(struct page *page)
 {
+       int nr = thp_nr_pages(page);
+       int i;
+
        if (page_mapped(page))
                unmap_mapping_page(page);

-       if (page_has_private(page))
-               do_invalidatepage(page, 0, thp_size(page));
+       for (i = 0; i < nr; i++) {
+               if (page_has_private(page + i))
+                       do_invalidatepage(page + i, 0, PAGE_SIZE);
+       }

        /*
         * Some filesystems seem to re-dirty the page even after

>
> > AFAICT, it does so.
> >
> > In do_dentry_open():
> > /*
> >          * XXX: Huge page cache doesn't support writing yet. Drop all page
> >          * cache for this file before processing writes.
> >          */
> >         if (f->f_mode & FMODE_WRITE) {
> >                 /*
> >                  * Paired with smp_mb() in collapse_file() to ensure nr_thps
> >                  * is up to date and the update to i_writecount by
> >                  * get_write_access() is visible. Ensures subsequent insertion
> >                  * of THPs into the page cache will fail.
> >                  */
> >                 smp_mb();
> >                 if (filemap_nr_thps(inode->i_mapping))
> >                         truncate_pagecache(inode, 0);
> >         }
> >
> >
> > In khugepaged:
> > filemap_nr_thps_inc(mapping);
> >                 /*
> >                  * Paired with smp_mb() in do_dentry_open() to ensure
> >                  * i_writecount is up to date and the update to nr_thps is
> >                  * visible. Ensures the page cache will be truncated if the
> >                  * file is opened writable.
> >                  */
> >                 smp_mb();
> >                 if (inode_is_open_for_write(mapping->host)) {
> >                         result = SCAN_FAIL;
> >                         __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> >                         filemap_nr_thps_dec(mapping);
> >                         goto xa_locked;
> >                 }
> >
> > But I'm not quite sure if there is any race condition.
