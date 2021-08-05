Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC13E1E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 00:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhHEWNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 18:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhHEWNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:13:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E65C0613D5
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gdhvdsgSM/8Mwfb1tqmpbDlfUrHJX1cvWgW+pgHKry8=; b=h4Dw4Cc1RkkG2d8JflnhmAQOIR
        991oec0AlgCGJY22m6JYFXpVKQhUopBqQBcSbLJoJ5sk2b5meMixehQk+FesQnsSrG+qtTteNYWuj
        RVKewhUp9G4Fpl20+xqIkT3YjhSQoOpKqd/QUSh7eU07YA2zuoqEesDVpFuDamWWvdb30T7yyn2BH
        6y7Xp/MrCx/2gv2pZc1IO3/i4YFFlkSSYiK2fkPILtBCYGtjZ2b9u4Dbo+++/eKR+TLhP0UeayNY9
        WXMUJ2GNqnOllDsnny/coFRYCAefhZLv97D07GMS7vZ4Uh6PZiLnxD+JEa3m3NU1OOIdSv38N+kHw
        wv8GlRbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBlbU-007ZHk-0E; Thu, 05 Aug 2021 22:12:44 +0000
Date:   Thu, 5 Aug 2021 23:12:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: pass writeback errors to the mapping
Message-ID: <YQxiVxSWWwZwoqbZ@casper.infradead.org>
References: <20210805213154.GZ3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805213154.GZ3601443@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 02:31:54PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Modern-day mapping_set_error has the ability to squash the usual
> negative error code into something appropriate for long-term storage in
> a struct address_space -- ENOSPC becomes AS_ENOSPC, and everything else
> becomes EIO.  iomap squashes /everything/ to EIO, just as XFS did before
> that, but this doesn't make sense.
> 
> Fix this by making it so that we can pass ENOSPC to userspace when
> writeback fails due to space problems.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

I could have sworn I sent this patch in earlier.  Anyway,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
