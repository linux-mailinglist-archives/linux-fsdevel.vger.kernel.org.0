Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EDD405CF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhIISqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhIISqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:46:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17323C061574;
        Thu,  9 Sep 2021 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cIe376GgS7Aa1qahSeo56O31ILie9slE4Ah8Ipra0Y=; b=isb8aKhsQKU9aodtEFHcPo7q+Z
        1Nz6ODr+wnNeD8tqFqpeXKTvLRgFv+5BQgvx9iSfVaTGxb9av/YCRKFbBmX9n2NZU2cwtag7ol6Lw
        SgXaHyt/SGoDFon3xW2co6a60bgibv0hfVX5O8nmJokeW3SdWM83X9LZSERTPciu1OL5hEzh9HPlK
        F8RPUS99ce8oAHkeEkjKwN7yIdoosW0p3Xb3LsfSJiw1P9M9is4mkz/Wk1xmzT4G4gj7CfbhE0Rjh
        Qa6kQ6E0tTaIpPMpKbvYjlQzX8XMRONPmrOXUMN4OPbsOodB0lv3y2jWn/c6L/ZzbeFnWyFEtCN87
        K5TrPHxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOP26-00AHI7-QI; Thu, 09 Sep 2021 18:44:33 +0000
Date:   Thu, 9 Sep 2021 19:44:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YTpWBif8DCV5ovON@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
 <YTpPh2aaQMyHAi8m@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTpPh2aaQMyHAi8m@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:16:39PM -0400, Johannes Weiner wrote:
> My objection is simply to one shared abstraction for both. There is
> ample evidence from years of hands-on production experience that
> compound pages aren't the way toward scalable and maintainable larger
> page sizes from the MM side. And it's anything but obvious or
> self-evident that just because struct page worked for both roles that
> the same is true for compound pages.

I object to this requirement.  The folio work has been going on for almost
a year now, and you come in AT THE END OF THE MERGE WINDOW to ask for it
to do something entirely different from what it's supposed to be doing.
If you'd asked for this six months ago -- maybe.  But now is completely
unreasonable.

I don't think it's a good thing to try to do.  I think that your "let's
use slab for this" idea is bonkers and doesn't work.  And I really object
to you getting in the way of my patchset which has actual real-world
performance advantages in order to whine about how bad the type system
is in Linux without doing anything to help with it.

Do something.  Or stop standing in the way.  Either works for me.
