Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9B34C14B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhC2BwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2Bvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:51:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37681C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Mar 2021 18:51:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so10844240otr.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Mar 2021 18:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW2BqiAhijOdIATx0Mdvl2mxq7iOTJupj8It01JaPbo=;
        b=PmFf+in024hTU+OBBNNMZ6/+fMt8ed//NiL4RG54oHprUnyURODJ4pRvu2L32DMDd5
         rJMKNADXogEkqJk+KXwjM5VfjaLVp8rAIU6OILPdK+98LMaJhVprXXy3aRfaoFAQKbxN
         8QLqrkPjW68V2ejAi6UhALfkdhpB4C7Rv9quqS6UKYyLnYhqsHcgBCYP7kCi0lJ8SVq6
         JSP9Y1DrETKg01YYh2wKUVguj8N+2u0y7lKIioC2HNyzw+SjMcqD5XdmaguDkeV8JFWS
         08lsxpfMRidXLpYgEEYxengxlsTUwN6e1P37StOnaWcoImbpEcepng7JKG8PEk+Z44mO
         Efbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW2BqiAhijOdIATx0Mdvl2mxq7iOTJupj8It01JaPbo=;
        b=kIsalHRtM8g4qyj4UwCN3bVf1B9PYw9F0OyiPRWjbSmVlxh0kBI18U5fN266Ev7Mgu
         qMcI+Wdk+A+kkV6OMIlTK4D+zgQ2iEujXANRjrVXfAOOorYHtndkrVx1vGlwnAzRw7fi
         VUZ++2v8P4BFWcc9uagSZ0feVLM/zcYF0KFhTRetSJLc3GDAMN9A8USpLcsnasXX52Aj
         KYvGiUu6wOMxcCrZKKyCkfr21ieZoqrnszFZ+yX0MXOYzyX7Eo98rd6FOcVRdm9zriM6
         8OsrHSe+9lMj64iB3ysiGVEPjHPh7wjUkekQYsUoiFYfApmJLWKGXR/zvGLheIQ7XCcV
         ZqKg==
X-Gm-Message-State: AOAM532VcvTjsrEV8ljq2xzHT+83nPtlnZzzxvMupab4Gp2ybrNkKNrD
        upUA5lYPwRNmCp+YRrOKIIvSjrzjhyL3ncjMlLN4xA==
X-Google-Smtp-Source: ABdhPJwRQQ5MHsLqU/NnSPqZj8QTWBIYCaZontT/3bP/tIj75aaCLdz0hKPlr5C7hkUq3nSG2Rua6eJu2W3/J72kDs4=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr20847573ote.53.1616982697629;
 Sun, 28 Mar 2021 18:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
In-Reply-To: <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sun, 28 Mar 2021 21:51:26 -0400
Message-ID: <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have Linux 5.12-rc4.

On top of that I have "David's patches", an 85 patch
series I peeled off of David Howell's fscache-iter
branch on git.kernel.org a few days ago. These
patches include what I need to use
readahead_expand.

On top of that is my orangefs_readahead patch.

I have run through the xfstests I run, and am
failing generic 75 112 127 & 263, which I
normally pass.

So I got rid of my orangefs_readahead patch.
Still failing 75 112 127 & 263.

Then I got rid of David's patches, I'm at
generic Linux 5.12-rc4, and am no longer
failing those tests.

Just thought I should mention it... other
than that, I'm real happy with the
orangefs_readahead patch, it is a
giant improvement. Y'all's help
made all the difference...

-Mike

On Sat, Mar 27, 2021 at 11:04 PM Mike Marshall <hubcap@omnibond.com> wrote:
>
> This seems OK... ?
>
> static void orangefs_readahead(struct readahead_control *rac)
> {
> loff_t offset;
> struct iov_iter iter;
> struct file *file = rac->file;
> struct inode *inode = file->f_mapping->host;
> struct xarray *i_pages;
> struct page *page;
> loff_t new_start = readahead_pos(rac);
> int ret;
> size_t new_len = 0;
>
> loff_t bytes_remaining = inode->i_size - readahead_pos(rac);
> loff_t pages_remaining = bytes_remaining / PAGE_SIZE;
>
> if (pages_remaining >= 1024)
> new_len = 4194304;
> else if (pages_remaining > readahead_count(rac))
> new_len = bytes_remaining;
>
> if (new_len)
> readahead_expand(rac, new_start, new_len);
>
> offset = readahead_pos(rac);
> i_pages = &file->f_mapping->i_pages;
>
> iov_iter_xarray(&iter, READ, i_pages, offset, readahead_length(rac));
>
> /* read in the pages. */
> if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
> &offset, &iter, readahead_length(rac),
> inode->i_size, NULL, NULL, file)) < 0)
> gossip_debug(GOSSIP_FILE_DEBUG,
> "%s: wait_for_direct_io failed. \n", __func__);
> else
> ret = 0;
>
> /* clean up. */
> while ((page = readahead_page(rac))) {
> page_endio(page, false, ret);
> put_page(page);
> }
> }
>
> I need to go remember how to git send-email through the
> kernel.org email server, I apologize for the way gmail
> unformats my code, even in plain text mode...
>
> -Mike
>
> On Sat, Mar 27, 2021 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Mar 27, 2021 at 11:40:08AM -0400, Mike Marshall wrote:
> > > int ret;
> > >
> > > loff_t new_start = readahead_index(rac) * PAGE_SIZE;
> >
> > That looks like readahead_pos() to me.
> >
> > > size_t new_len = 524288;
> > > readahead_expand(rac, new_start, new_len);
> > >
> > > npages = readahead_count(rac);
> > > offset = readahead_pos(rac);
> > > i_pages = &file->f_mapping->i_pages;
> > >
> > > iov_iter_xarray(&iter, READ, i_pages, offset, npages * PAGE_SIZE);
> >
> > readahead_length()?
> >
> > > /* read in the pages. */
> > > ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> > > npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
> > >
> > > /* clean up. */
> > > while ((page = readahead_page(rac))) {
> > > page_endio(page, false, 0);
> > > put_page(page);
> > > }
> > > }
> >
> > What if wait_for_direct_io() returns an error?  Shouldn't you be calling
> >
> > page_endio(page, false, ret)
> >
> > ?
> >
> > > On Sat, Mar 27, 2021 at 9:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sat, Mar 27, 2021 at 08:31:38AM +0000, David Howells wrote:
> > > > > However, in Mike's orangefs_readahead_cleanup(), he could replace:
> > > > >
> > > > >       rcu_read_lock();
> > > > >       xas_for_each(&xas, page, last) {
> > > > >               page_endio(page, false, 0);
> > > > >               put_page(page);
> > > > >       }
> > > > >       rcu_read_unlock();
> > > > >
> > > > > with:
> > > > >
> > > > >       while ((page = readahead_page(ractl))) {
> > > > >               page_endio(page, false, 0);
> > > > >               put_page(page);
> > > > >       }
> > > > >
> > > > > maybe?
> > > >
> > > > I'd rather see that than open-coded use of the XArray.  It's mildly
> > > > slower, but given that we're talking about doing I/O, probably not enough
> > > > to care about.
