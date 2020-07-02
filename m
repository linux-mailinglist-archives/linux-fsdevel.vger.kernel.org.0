Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576FA212792
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgGBPQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 11:16:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729404AbgGBPQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593703017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaHGVjmAmXhp9lutE/R+X9XTXlXuXnf2H5y3xxwJ93o=;
        b=eeEdBqeDpzUZ2QharGAkPeijprs4unJMHJtTeIShJYlbJ2watqnC5ZPQcUG5odFffKTvyR
        HQ2ZG0v9YH9i04NT/lhDv69Vn7yfeqz5s6OW2y35A50/DMYC+0HUdhbB5z518CHELrtGvD
        0QT2ZFPtyRJZScvEuPky5cYQXE3JOTI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-2paQBcrROniM5hYkEQwIuw-1; Thu, 02 Jul 2020 11:16:55 -0400
X-MC-Unique: 2paQBcrROniM5hYkEQwIuw-1
Received: by mail-oo1-f72.google.com with SMTP id b20so4859694ooq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaHGVjmAmXhp9lutE/R+X9XTXlXuXnf2H5y3xxwJ93o=;
        b=cJp7eyAnMwoWQRfplsIBA2SN/QZ0+Wc/yqeeXh+Ig45MY28kqQNtSPfkShsBaiJxl0
         XVfcdTebd1uA/1q40jlj6j0iWBNEfnM45epQXBCqK5JRYuYwRMBwkEJrkwvlmAlh+p3Z
         4xoPFwKmn7UolpyqLctIWUs15ZIlxldNfAMP7A53KrB5K5XCzkWDwzgBNN3XalZY6Lg/
         qdikTMd4Tq1CyQ86wLfE0tg3CZx/y+wN8LRxn0QMBYcT/vQ8Sb45uFZeLtGxQkmvC+vc
         GtmfEVJ60+/QYz9osMomouvZKYc6UT/iPQ8nFMUcIEjMbGtSePilUV83Zg9MOWJRYQWt
         i4nA==
X-Gm-Message-State: AOAM5331zgQXm2GOpj7KJRT915VlLMsxS3v+bxU0Tf106+4I6IpBpVmx
        C3cgIE2xBnk/xXpwdavPNYaEFHkVDqTHKrkDkDGeMB6dRxrT3eq9l9o59XC1O3W0sUZiL1sv29A
        zr20QOmTqNFVFZezetcNLmo76RxT3fkbLNgbim1atSQ==
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr22045246otg.58.1593703014901;
        Thu, 02 Jul 2020 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI3bsBzuJ3Kf//oLr+uyYhe2RcCJSWhVflkhZK7zJVGNOpQZUZYdLgArfJLRyL4CcHxYQZONIFKjbIDY2zBQc=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr22045226otg.58.1593703014619;
 Thu, 02 Jul 2020 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
 <20200622181338.GA21350@casper.infradead.org> <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
In-Reply-To: <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 17:16:43 +0200
Message-ID: <CAHc6FU5jZfz3Kv-Aa6MWbELhTscSp5eEAXTWBoVysrQg6f1moA@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 2:35 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Mon, Jun 22, 2020 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> > > I'm fine with not moving that functionality into the VFS. The problem
> > > I have in gfs2 is that taking glocks is really expensive. Part of that
> > > overhead is accidental, but we definitely won't be able to fix it in
> > > the short term. So something like the IOCB_CACHED flag that prevents
> > > generic_file_read_iter from issuing readahead I/O would save the day
> > > for us. Does that idea stand a chance?
> >
> > For the short-term fix, is switching to a trylock in gfs2_readahead()
> > acceptable?
>
> Well, it's the only thing we can do for now, right?

It turns out that gfs2 can still deadlock with a trylock in
gfs2_readahead, just differently: in this instance, gfs2_glock_nq will
call inode_dio_wait. When there is pending direct I/O, we'll end up
waiting for iomap_dio_complete, which will call
invalidate_inode_pages2_range, which will try to lock the pages
already locked for gfs2_readahead.

This late in the 5.8 release cycle, I'd like to propose converting
gfs2 back to use mpage_readpages. This requires reinstating
mpage_readpages, but it's otherwise relatively trivial.
We can then introduce an IOCB_CACHED or equivalent flag, fix the
locking order in gfs2, convert gfs2 to mpage_readahead, and finally
remove mage_readpages in 5.9.

I'll post a patch queue that does this for comment.

Thanks,
Andreas

