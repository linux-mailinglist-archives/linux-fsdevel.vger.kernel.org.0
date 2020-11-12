Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB51D2B0D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKLTLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 14:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgKLTLO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:11:14 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED2420B80;
        Thu, 12 Nov 2020 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208274;
        bh=MIxnxk8miGxsOAzLOjR0YQwvefMMlSnyIpNObX3bazE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfgr6SopUO1UFj23PxPDrczZI2Z07mjlkTk9QvecjRTBlADpd716o8if/9yyxRk7g
         xI2oQQDnwoNGiO63mmwDaugb47yuMbunU88tXUJ5BrXohQVKnTRS/4u2b+FX78WjQq
         MhLrmrH3jLOtufoFfcYH7BLcpF2br3ZAL0IVCgfQ=
Date:   Thu, 12 Nov 2020 21:11:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 01/12] mm: Make pagecache tagged lookups return only
 head pages
Message-ID: <20201112191105.GR4758@kernel.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-2-willy@infradead.org>
 <20201028075056.GB1362354@kernel.org>
 <20201112174150.GC17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112174150.GC17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:41:50PM +0000, Matthew Wilcox wrote:
> On Wed, Oct 28, 2020 at 09:50:56AM +0200, Mike Rapoport wrote:
> > > @@ -2074,8 +2074,8 @@ EXPORT_SYMBOL(find_get_pages_contig);
> > >   * @nr_pages:	the maximum number of pages
> > >   * @pages:	where the resulting pages are placed
> > >   *
> > > - * Like find_get_pages, except we only return pages which are tagged with
> > > - * @tag.   We update @index to index the next page for the traversal.
> > > + * Like find_get_pages(), except we only return head pages which are tagged
> > > + * with @tag.   We update @index to index the next page for the traversal.
> > 
> > Nit:                                           ^ next head page
> 
> I don't love the sentence anyway.  How about:
> 
>  * Like find_get_pages(), except we only return head pages which are tagged
>  * with @tag.  @index is updated to the index immediately after the last
>  * page we return, ready for the next iteration.

I like it.

-- 
Sincerely yours,
Mike.
