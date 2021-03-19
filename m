Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B404E3413F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 05:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhCSECQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 00:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhCSECM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:02:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C005BC06174A;
        Thu, 18 Mar 2021 21:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3U1SiosJPv5inO8Mg1xTTyoOO2EveSxOVFyiCAwBa/Y=; b=Zi+23hPtHBaycX7b5e4lFzn/gG
        yUROkuxZhdLj766nJ5AOAu8tXjqbJmntnI7qTeaI/s4xgXuCo+p0A6KGQ08u3BiRMiQViRsYmMN03
        OXxoIvBXytT9ussar2z4bSdeIX0Tj/3Sa8uZrce6Pv/ZHKZqTiK9T26s8Z19+gNFcuPvrzXiATYBq
        4anvx9pfJOl71BZm7ggnHJOHD6mRtdYiwrDKpRkfY1PHhSfaszHIGHZnvTqMq0lGV+awvjs+gT8z9
        Tge+qeYzFchjPzlHl6t9cOywZ9mPAS+1YkRiJ8VfLF1pAvjNvKYc2kxBqNmenVdIv/X0xxcFKdpI2
        feeYTlzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lN6KY-003tvb-FV; Fri, 19 Mar 2021 04:01:49 +0000
Date:   Fri, 19 Mar 2021 04:01:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210319040146.GY3420@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:18:36AM +0000, Matthew Wilcox (Oracle) wrote:
> Our type system does not currently distinguish between tail pages and
> head or single pages.  This is a problem because we call compound_head()
> multiple times (and the compiler cannot optimise it out), bloating the
> kernel.  It also makes programming hard as it is often unclear whether
> a function operates on an individual page, or an entire compound page.

I've pushed a new version out here:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

I think it takes into account everyone's comments so far.  It even compiles.
