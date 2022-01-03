Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D2482F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiACJ3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 04:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiACJ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:29:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124DC061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ajB0JE/WO6eL9f2QszRWrZF4R71hfDomNptzBFnCXFo=; b=F56WTzhQuRnf/cPsLe7LjjMC/k
        nNnZtznCJMGW2ZOcuM4Jh8we7C2lFroJw8Mhkb2NophkwRnK6Ebr/j7FU5UceUSql0P4wKtydfNl1
        g+hP9uqw2w59nx8VlZWv7gzWTJOVtPAWOar+Zh7nEVBT2SWdW3sZln0NwF4yNkFBGmgNNvnIKpRfU
        Fnlr2hwE98ekGlS3KUlGiR2rRM9Y2hGENcUknk/9czs0AudjwV/xmSPou0vch27TBOZZ02T44yd/y
        2Ltp8CbcrFTdyxW07dqqoQeBpETkOQ9sK4OCse49eKkLdU1zN2prffXVA1oV2MP9dU4YNbUedH6CT
        kFYnMvRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4Jee-008gWM-FC; Mon, 03 Jan 2022 09:29:24 +0000
Date:   Mon, 3 Jan 2022 01:29:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <YdLB9BTKfpgz+bIv@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <YdHQnSqA10iwhJ85@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdHQnSqA10iwhJ85@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > This all passes xfstests with no new failures on both xfs and tmpfs.
> > I intend to put all this into for-next tomorrow.
> 
> As a result of Christoph's review, here's the diff.  I don't
> think it's worth re-posting the entire patch series.

Thanks, the changes look good to me.
