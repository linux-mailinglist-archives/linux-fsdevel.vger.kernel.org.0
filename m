Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1A3EC9FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhHOPga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 11:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHOPga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 11:36:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132CC061764;
        Sun, 15 Aug 2021 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eYSk1CsSbdU6TZDzwzr/5Rga7dzOhjq06uCI72Yt8v8=; b=B6xaQgGxdCdoXNp3KRyPOxnERh
        C/7Lg4rqNcC1kw99i4ixF4K5FBcTzxKmL64L9VVAbhDlrclSCeml39NQUuzmTYLqOBycvaEhvuj3f
        Lpe3EZD/E27F623ENZ9pQe5q3qaRDcgPVN+g/QE61zunyNWJjEz4r5BHLfkHZObtsSm45Frf65NJs
        TQcdUo8QCldl6iyH4L9+OCavA7eAR8jmH1pofQlxHYMxI1Fv0Dp8tsKoGm2fQw1QDFSAEvIgRu41H
        703a0TmBGOqbvT6oz3RKQ50/X81kDalORq05dqUwZheQsNKZEP9gXnbMCWmcHIRUXrxOhII9Z7x3f
        W33x5Arg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFIAr-000OO9-Kb; Sun, 15 Aug 2021 15:35:49 +0000
Date:   Sun, 15 Aug 2021 16:35:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 076/138] mm/writeback: Add
 folio_redirty_for_writepage()
Message-ID: <YRk0UazqhEi4xczM@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-77-willy@infradead.org>
 <249863ea-8b4b-df38-545a-5f083502270d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249863ea-8b4b-df38-545a-5f083502270d@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 06:30:51PM +0200, Vlastimil Babka wrote:
> > +/**
> > + * folio_redirty_for_writepage - Decline to write a dirty folio.
> > + * @wbc: The writeback control.
> > + * @folio: The folio.
> > + *
> > + * When a writepage implementation decides that it doesn't want to write
> > + * @folio for some reason, it should call this function, unlock @folio and
> > + * return 0.
> 
> s/0/false

... no?  This sentence describes what a writepage implementation should
do, and writepage returns an int, not bool.

