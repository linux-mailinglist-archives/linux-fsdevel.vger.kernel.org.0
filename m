Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05430267B4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILPxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgILPxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 11:53:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DDC061573;
        Sat, 12 Sep 2020 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qc5yghyJGBgDTTfHSsXLoAfmeYI1Ary/kXXv/3UfwB8=; b=FjhCwl87ORYo39n9Un3auXdBhI
        wu0axmdEZoPb8Uve5mievG0RLvAFghLys8WQSUAXqMzmzGOOmWnP4rrx+JIK3duQSf3f9mhwhMqe4
        mtVp5FJV3qRcjAYl5eTRVrwShqp6/g4DQB3N03KdsMBZFoUt0HSyGVcig/YY+80LB+l0nqYgV9EJo
        5uLd6kllCTqSnculuq/FIGavc/FuANsUxLDoZpPJ3yidQckO5aEwDcedMneIb8gVzZ5tipp7SOTVJ
        zdI4BWgWUm+rHCptwwPYbAApJBu31f1+M5o7FOd+gWG7RAjcv4LB9H3JcFYHpkrowBEbgbM+KWHu1
        ah8RGPEw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kH7qE-0002Ct-Je; Sat, 12 Sep 2020 15:53:30 +0000
Date:   Sat, 12 Sep 2020 16:53:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200912155330.GC6583@casper.infradead.org>
References: <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
 <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 10:28:29AM +0300, Amir Goldstein wrote:
> On Sat, Sep 12, 2020 at 1:40 AM Michael Larabel
> <Michael@michaellarabel.com> wrote:
> >
> > On 9/11/20 5:07 PM, Linus Torvalds wrote:
> > > On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > >> Ok, it's probably simply that fairness is really bad for performance
> > >> here in general, and that special case is just that - a special case,
> > >> not the main issue.
> > > Ahh. It turns out that I should have looked more at the fault path
> > > after all. It was higher up in the profile, but I ignored it because I
> > > found that lock-unlock-lock pattern lower down.
> > >
> > > The main contention point is actually filemap_fault(). Your apache
> > > test accesses the 'test.html' file that is mmap'ed into memory, and
> > > all the threads hammer on that one single file concurrently and that
> > > seems to be the main page lock contention.
> > >
> > > Which is really sad - the page lock there isn't really all that
> > > interesting, and the normal "read()" path doesn't even take it. But
> > > faulting the page in does so because the page will have a long-term
> > > existence in the page tables, and so there's a worry about racing with
> > > truncate.

Here's an idea (sorry, no patch, about to go out for the day)

What if we cleared PageUptodate in the truncate path?  And then
filemap_fault() looks a lot more like generic_file_buffered_read() where
we check PageUptodate, and only if it's clear do we take the page lock
and call ->readpage.

We'd need to recheck PageUptodate after installing the PTE and zap
it ourselves, and we wouldn't be able to check page_mapped() in the
truncate path any more, which would make me sad.  But there's something
to be said for making faults cheaper.

Even the XFS model where we take the MMAPLOCK_SHARED isn't free -- it's
just write-vs-write on a cacheline instead of a visible contention on
the page lock.

