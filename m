Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9E34B3DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 03:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhC0C41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0Cz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:55:56 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4DC0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 19:55:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z15so7649370oic.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 19:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llA7GqFEHJF1e+jvpYg3uLWI3+4tBu1h68vwQ2H7rpY=;
        b=eSdhOSxLnqpaOGN2HogBSXG/Rq+Pv0iVK0LBC0ZThOe3Xe1AnJiS757YuWlSKWkYBH
         IAERcsR73LCxIbG72dEgnbeTZEGusgbKDOTdcS9HJePbJSVzWePNqKLQw/aB0ZNqSfGi
         /ltH5+AvVSDXNRxWN5p/0MQZErhNCKv5QtJoBRo0jHLQ/mYN2Rs1tnv+rC+YPHdmVeNO
         gTqyc5lCcwpaHA2dKizOT/gtv5W4U8Smoy672fRv5ky0LLlGPWMUsdccSQ+UEG+bPYFP
         QGlLMYyQ/U+R7LLYi4ZQi2glLPs3YXugUXqT5SRoTcxRFG18LjrZxw3zoPUjMzC9mwHD
         /tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llA7GqFEHJF1e+jvpYg3uLWI3+4tBu1h68vwQ2H7rpY=;
        b=bxvx0XMXyddv4jcpSov6mWwmvWdGxGIyXVSksMdIxoQuk6bMdRevG/s8y6NjPZLXa9
         OfBIU+jq5ogUSDjHRxOfhoq2NnXY5MtIIOMbjXsJMReET0VV05ytHdQ7yNbFy2mlskdE
         ZgBP9qCjLndrqmfsVwEflEoBVWv/dktS2rlcC5ThVRCeWc/1Tt4TSuRU2a5T4ChaqMBP
         MmfESPzfj10vzYl5ivxeBgdDOBgOaTuoiAfKmaoJtgUP0Bo22ESdNyrYOY7QGrVbOCcO
         14hJGePZDK5NWUOLcJFgOGUngPifUcAHGwJiCvZ7EQcPXAGJjl2DIvMsmMbdX4+eEg2L
         N+FQ==
X-Gm-Message-State: AOAM530jM8FnvR4QW+RSXqVdwEv8IRlXN0m51Ger8YlJDml7GaTImPlv
        5vdVo3DIqTTkKi+iF0WkN4AyqMC/ICiVCB0d0Pul2Q==
X-Google-Smtp-Source: ABdhPJyMY+chWpyz9lwXLTnH6VSC1U5wkD2yQ1RCJBAgmLTU8ojaSKvZ5vEBni0ZOuo1INjqhYQ16l6wcS2DU8O/AsQ=
X-Received: by 2002:aca:478d:: with SMTP id u135mr11659357oia.174.1616813755110;
 Fri, 26 Mar 2021 19:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk>
In-Reply-To: <2884397.1616584210@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 26 Mar 2021 22:55:44 -0400
Message-ID: <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David.

I implemented a version with iov_iter_xarray (below).
It appears to be doing "the right thing" when it
gets called, but then I get a backtrace in the kernel
ring buffer "RIP: 0010:read_pages+0x1a1/0x2c0" which is
page dumped because: VM_BUG_ON_PAGE(!PageLocked(page))
------------[ cut here ]------------
kernel BUG at include/linux/pagemap.h:892!

So it seems that in mm/readahead.c/read_pages I end up
entering the "Clean up the remaining pages" part, and
never make it through even one iteration... it happens
whether I use readahead_expand or not.

I've been looking at it a long time :-), I'll look more
tomorrow... do you see anything obvious?




static void orangefs_readahead_cleanup(struct xarray *i_pages,
pgoff_t index,
unsigned int npages,
struct iov_iter *iter)
{
pgoff_t last;
struct page *page;
XA_STATE(xas, i_pages, index);

last = npages - 1;

if (iov_iter_count(iter) > 0)
iov_iter_zero(iov_iter_count(iter), iter);

rcu_read_lock();
xas_for_each(&xas, page, last) {
page_endio(page, false, 0);
put_page(page);
}
rcu_read_unlock();
}

static void orangefs_readahead(struct readahead_control *rac)
{
unsigned int npages;
loff_t offset;
struct iov_iter iter;
struct file *file = rac->file;
struct inode *inode = file->f_mapping->host;

struct xarray *i_pages;
pgoff_t index;

int ret;

loff_t new_start = readahead_index(rac) * PAGE_SIZE;
size_t new_len = 524288;

readahead_expand(rac, new_start, new_len);

npages = readahead_count(rac);
offset = readahead_pos(rac);
i_pages = &file->f_mapping->i_pages;


iov_iter_xarray(&iter, READ, i_pages, offset, npages * PAGE_SIZE);

/* read in the pages. */
ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);

/* clean up. */
index = offset >> PAGE_SHIFT;
orangefs_readahead_cleanup(i_pages, index, npages, &iter);
}

On Wed, Mar 24, 2021 at 7:10 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > /* allocate an array of bio_vecs. */
> > bvs = kzalloc(npages * (sizeof(struct bio_vec)), GFP_KERNEL);
> >
>
> Better to use kcalloc() here as it has overflow checking.
>
> > /* hook the bio_vecs to the pages. */
> > for (i = 0; i < npages; i++) {
> > bvs[i].bv_page = pages[i];
> > bvs[i].bv_len = PAGE_SIZE;
> > bvs[i].bv_offset = 0;
> > }
> >
> > iov_iter_bvec(&iter, READ, bvs, npages, npages * PAGE_SIZE);
> >
> > /* read in the pages. */
> > ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> > npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
> >
> > /* clean up. */
> > for (i = 0; i < npages; i++) {
> > SetPageUptodate(bvs[i].bv_page);
> > unlock_page(bvs[i].bv_page);
> > put_page(bvs[i].bv_page);
> > }
> > kfree(pages);
> > kfree(bvs);
> > }
>
> Could you try ITER_XARRAY instead of ITER_BVEC:
>
>         https://lore.kernel.org/linux-fsdevel/161653786033.2770958.14154191921867463240.stgit@warthog.procyon.org.uk/T/#u
>
> Setting the iterator looks like:
>
>         iov_iter_xarray(&iter, READ, &mapping->i_pages,
>                         offset, npages * PAGE_SIZE);
>
> The xarray iterator will handle THPs, but I'm not sure if bvecs will.
>
> Cleanup afterwards would look something like:
>
>         static void afs_file_read_done(struct afs_read *req)
>         {
>                 struct afs_vnode *vnode = req->vnode;
>                 struct page *page;
>                 pgoff_t index = req->pos >> PAGE_SHIFT;
>                 pgoff_t last = index + req->nr_pages - 1;
>
>                 XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
>
>                 if (iov_iter_count(req->iter) > 0) {
>                         /* The read was short - clear the excess buffer. */
>                         _debug("afterclear %zx %zx %llx/%llx",
>                                req->iter->iov_offset,
>                                iov_iter_count(req->iter),
>                                req->actual_len, req->len);
>                         iov_iter_zero(iov_iter_count(req->iter), req->iter);
>                 }
>
>                 rcu_read_lock();
>                 xas_for_each(&xas, page, last) {
>                         page_endio(page, false, 0);
>                         put_page(page);
>                 }
>                 rcu_read_unlock();
>
>                 task_io_account_read(req->len);
>                 req->cleanup = NULL;
>         }
>
> David
>
