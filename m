Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510C3D07C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 06:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhGUDsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 23:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhGUDsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:48:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64032C061574;
        Tue, 20 Jul 2021 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FlnqjlJh3+nTNFv7MwYaGgv+ViirQs+pMyz9SMZzsIE=; b=qxcLQv8KimgPKjPFbsjxDLl7q7
        QHrRNJEkWYryI5cfKkbsuB7ubxhq37SxS1xMNKH2z758mnkb8yEtcnmw35Q5i4B6OnUs1Ohkgcixv
        BOXme6/Zh0eSW04VraCEWzOuy0f5TcDh49jHqcIcya96Ldg/EYfRgi9idToPoV5zv4bTTHePTQvLM
        dvYxuIxTcZ42wp5wDfFGFAyB0hu/RKkK6ucs9rNjEtljPT3fWQ5PcnU0U0JX3hT9ojoAMcWINNbVz
        ISq07OZr/6thtu5WZMpofNG4Jds+G+uFbf6CWBjzBhDNTgDdsVL8yWjw+Jji6EWA/CSrCsCbrM/Ix
        dKfVfnYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m63pl-008mos-PD; Wed, 21 Jul 2021 04:28:01 +0000
Date:   Wed, 21 Jul 2021 05:27:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <YPeiRb8o+zh29Pag@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
 <20210721001219.GR22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721001219.GR22357@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 05:12:19PM -0700, Darrick J. Wong wrote:
> I /am/ beginning to wonder, though -- seeing as Christoph and Matthew
> both have very large patchsets changing things in fs/iomap/, how would
> you like those landed?  Christoph's iterator refactoring looks like it
> could be ready to go for 5.15.  Matthew's folio series looks like a
> mostly straightforward conversion for iomap, except that it has 91
> patches as a hard dependency.
> 
> Since most of the iomap changes for 5.15 aren't directly related to
> folios, I think I prefer iomap-for-next to be based directly off -rcX
> like usual, though I don't know where that leaves the iomap folio
> conversion.  I suppose one could add them to a branch that itself is a
> result of the folio and iomap branches, or leave them off for 5.16?

Maybe willy has a different opinion, but I thought the plan was to have
the based folio enablement in 5.15, and then do things like the iomap
conversion in the the next merge window.  If we have everything ready
this window we could still add a branch that builds on top of both
the iomap and folio trees, though.
