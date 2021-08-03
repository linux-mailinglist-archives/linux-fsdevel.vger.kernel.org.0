Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EF3DE82A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhHCITZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhHCITZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:19:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B50C06175F;
        Tue,  3 Aug 2021 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DDpLaAkMvs0t4FxlbtoZnNrEj2FCzGaXq4NTMjLUEYg=; b=otMzUJg+DdxQ5QskT0rY7FvTCL
        0FljeiyOPgExV4Uis7SFybh4HcHLGxlY/EdB2QFW/N2EJmgc6AGY/MvYzHWTvLL+d5h/76YggbaW7
        Z0Mo9/WuSuXP7z+//zBi8ifeSG3DqmLSBmf/HsC/b8mX9+QQKiEUOvBT3mCfEaEi0lID1lC3G8jVD
        Aca1XYx6EV44UEpTgPLriLZ+D/P5RErfroqGRD5LyC+33g2Ei6XZps0Fda4tqAWumCof8Z4QZCWCA
        7JuVQF5oWJZrAlircOjLXF22fPK3ybhTWUptzKMYsPkm3cWAlRDFx9LSldgsNY5kbkdRRdJHElk7L
        NQvHDZhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mApcH-004OvY-EY; Tue, 03 Aug 2021 08:17:52 +0000
Date:   Tue, 3 Aug 2021 09:17:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <YQj7oYHpz3zqOGCB@infradead.org>
References: <20210802221114.GG3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221114.GG3601466@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm on vacation this week, so just a quick note:

I'd love to see 1. and 2. from your list in a public branch ASAP,
maybe also 3 and 4 if they get positive reviews so that I can
rebased the iter stuff ontop of that so that I can repost the iter
series with that as a baseline.

I still haven't succeeded getting a working DAX setup, though.
