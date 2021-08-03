Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040FE3DE4AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHCDWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 23:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCDWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 23:22:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D97C06175F;
        Mon,  2 Aug 2021 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ttKeZ0AwoZ2xt7fmwfbVjwk8DclE1a0iPb+yr/d+Jg8=; b=tdz3wpHKqHIgGhHcb0WEMA090j
        qPv9b3z9r3jWc38djh0cSG4mEaoSvc6DYGuMC5+ikxJdE+XM7ESi5MgWQvth3w34qvoo78MPDvgpz
        /Pex+2sUOcRNhQnD/y8Cc0jhPnKTfnjYu14g4xI9gZPDQinf5IaCNJL9B6M6672EnnwyAJLHm13Bj
        YR5bHCQ7jltNEvcppjfvsTMTnvhdEf2lIR8A+AYHoQaub60MtuhFQa423VtoJdV/46YjAp5y/0+xv
        RPSjLwsutvnpJLGuF23C3/71HXDgYdac9mczLrt1GrQvtTurIXFBB7TxoC+hEzq5FU9HKeXd2AgmX
        F9+a1YVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAkzb-004Avv-1z; Tue, 03 Aug 2021 03:21:30 +0000
Date:   Tue, 3 Aug 2021 04:21:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <YQi2M8BXVLaBgrn6@casper.infradead.org>
References: <20210802221114.GG3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221114.GG3601466@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:11:14PM -0700, Darrick J. Wong wrote:
> Hi everyone!
> 
> iomap has become very popular for this cycle, with seemingly a lot of
> overlapping patches and whatnot.  Does this accurately reflect all the
> stuff that people are trying to send for 5.15?
> 
> 1. So far, I think these v2 patches from Christoph are ready to go:
> 
> 	iomap: simplify iomap_readpage_actor
> 	iomap: simplify iomap_add_to_ioend
> 
> 2. This is the v9 "iomap: Support file tail packing" patch from Gao,
> with a rather heavily edited commit:
> 
> 	iomap: support reading inline data from non-zero pos
> 
> Should I wait for a v10 patch with spelling fixes as requested by
> Andreas?  And if there is a v10 submission, please update the commit
> message.
> 
> 3. Matthew also threw in a patch:
> 
> 	iomap: Support inline data with block size < page size
> 
> for which Andreas also sent some suggestions, so I guess I'm waiting for
> a v2 of that patch?  It looks to me like the last time he sent that
> series (on 24 July) he incorporated Gao's patch as patch 1 of the
> series?

These four patches are at the base of my 'devel' branch of folios, ie
they're basically the next in the series after for-next.  So I've built
the rest of the iomap-folios patches on top of them.  I'll pull in Gao's
v10 tomorrow, retest and send you a git pull for those four?

> So, I /think/ that's all I've received for this next cycle.  Did I miss
> anything?  Matthew said he might roll some of these up and send me a
> pull request, which would be nice... :)

I ran out of time on Friday, and I took today (+ the weekend) off.
I'll catch up tomorrow.
