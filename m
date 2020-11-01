Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC492A1D7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgKALEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgKALEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:04:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884EC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6C2hTaQSGmv10YNbIHkE/EE0lKL7K5w8Au0qd2PPPQk=; b=KeP9tipCGPHH3YhPRnKk8ZWuE6
        5X1H9N+Ha1sw9pikrarTs9Zxx4eurpa12Eku96lyfuXLkYEChZ/M6irGgCFtlFPIfxioYB4UybZB3
        zOt5+nlRC7C36txQotWUlaygGlNeyA88rULKImdjykaldwB9enYQwwQQSIHVeMsuIXjyU/eVN0yto
        0wa7Zbsts29UgNQplP1WoZi3QFgArS6J+fdnVaA1bK4Tr9sd99XOQ/WT8NYyREn+EhBEuMyVVdDMq
        SkoBqippx8ieNxVIrmlJrfw6/lLYtqFLSzSJCDGHF8OyA3KcZVd2mAmwNmhlWJcgQco5gEU1FdXKw
        bGkaKdgw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZB9a-00032W-M1; Sun, 01 Nov 2020 11:04:07 +0000
Date:   Sun, 1 Nov 2020 11:04:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101110406.GV27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-5-hch@lst.de>
 <20201031170646.GT27442@casper.infradead.org>
 <20201101103144.GC26447@lst.de>
 <20201101104958.GU27442@casper.infradead.org>
 <20201101105112.GA26860@lst.de>
 <20201101105158.GA26874@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101105158.GA26874@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 11:51:58AM +0100, Christoph Hellwig wrote:
> On Sun, Nov 01, 2020 at 11:51:12AM +0100, Christoph Hellwig wrote:
> > On Sun, Nov 01, 2020 at 10:49:58AM +0000, Matthew Wilcox wrote:
> > > On Sun, Nov 01, 2020 at 11:31:44AM +0100, Christoph Hellwig wrote:
> > > > This looks sensible, but goes beyond the simple refactoring I had
> > > > intended.  Let me take a more detailed look at your series (I had just
> > > > updated my existing series to to the latest linux-next) and see how
> > > > it can nicely fit in.
> > > 
> > > I'm also working on merging our two series.  I'm just about there ...
> > 
> > Heh, same here.
> 
> I'll stop for now.

http://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/next

is what i currently have.  Haven't pulled in everything from you; certainly not renaming generic_file_buffered_read to filemap_read(), which is awesome.
i'm about 500 seconds into an xfstests run.
