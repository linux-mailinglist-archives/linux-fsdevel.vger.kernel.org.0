Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C150E3793CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhEJQbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEJQbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:31:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C7C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2uXGZMgNjoMdSplWtfJsG5vUGfYvRDuyRM1M9SbfwSQ=; b=KVL0hDRqSBHkJt1lxABY9cgPS/
        xLpKjKfy5RCDAF4tgf31yw+hM0q8/bMefasxsDTN5NhFQtgcYwMyH7EIIBpLoz2ku/Ks1SudeKQrQ
        1nZRGo0KuHjLYlX/e1WyPkc02OhKIAXLIOznk5QTbyqty2vUqcvcsK+vOjNjsvm6Gea4a2RVK2lxX
        DPSSzE/BOk5gstMuehmWxVlpKSdnwvX3CEgwXwHAJWOrSodu1ebp3jFDqxPrFdivj0xDkiu4vvDWy
        hd/n1ROE/PY8bEi7QU1J5JKmueiRKRldl2qx/DHw6REI+OnL7756HGc7oSb1OWiiyCOq3S1j20/Fx
        H2ulUXNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lg8mS-006MME-Vz; Mon, 10 May 2021 16:29:33 +0000
Date:   Mon, 10 May 2021 17:29:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/8] Folio Prequel patches
Message-ID: <YJlfXAMN7Es3/Sgu@casper.infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
 <20210510181245.15b4701e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510181245.15b4701e@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 06:12:45PM +0200, Matteo Croce wrote:
> On Fri, 30 Apr 2021 15:55:41 +0100
> "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > These patches have all been posted before and not picked up yet.  I've
> > built the folio patches on top of them; while they are not necessarily
> > prerequisites in the conceptual sense, I'm not convinced that the
> > folio patches will build without them.  The nth_page patch is purely
> > an efficiency question, while patch 5 ("Make compound_head
> > const-preserving") is required for the current implementation of
> > page_folio().  Patch 8 ("Fix struct page layout on 32-bit systems")
> > is required for the struct folio layout to match struct page layout
> > on said 32-bit systems (arm, mips, ppc).
> > 
> > They are on top of next-20210430
> > 
> 
> I'm running them since a couple days on an arm64 machine which uses the
> page_pool API. No issues so far.

Thanks!  Andrew picked up the first seven of these patches last night,
and I resent the eighth one today:

https://lore.kernel.org/linux-mm/20210510153211.1504886-1-willy@infradead.org/

