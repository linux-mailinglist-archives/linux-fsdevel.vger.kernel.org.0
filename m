Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5385D4699EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 16:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbhLFPEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 10:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbhLFPDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:03:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77F2C061A83;
        Mon,  6 Dec 2021 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8VMrIrsRIgEDSgL38NQvmo3LTXEm/gtXJ2dOprMYkt0=; b=us0+RMgfuwjLbk/WJofeMplwvk
        9LDGjmLSCagyzywM96QYs2/xsDKdjB1RPWBIWoM752NYH/S4lL6pnw8uprBCPfoUCiScvIRp8Nwa2
        PjUnTc8zEaSEX0Cqv0FwxjHvR86f2hsGszisH/1r7CuPOFoo7NZ2qvCyVlS78hESYoCNwWsqBhOkk
        ZX/Vs8sQAG9LTQpPPAnK+fit7xfaUNoyg5Rr4k4+pWac+hjP/uteGDJ98gt1lvsVZVul9WkY2rQq2
        fVEgqqIItpjkr2rLGEEl6FCHmh9OJ711bpGNyYZqZ28EbjrHA4pko/0ItmQPQ4fz2QLssSoJUMJw+
        4JFvlQOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFTS-004xVP-U5; Mon, 06 Dec 2021 15:00:15 +0000
Date:   Mon, 6 Dec 2021 15:00:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] iov_iter: Move internal documentation
Message-ID: <Ya4lfkfoc7idPCYZ@casper.infradead.org>
References: <20211206145220.1175209-1-willy@infradead.org>
 <20211206145220.1175209-4-willy@infradead.org>
 <20211206145534.GC8794@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206145534.GC8794@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:55:34PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 06, 2021 at 02:52:20PM +0000, Matthew Wilcox (Oracle) wrote:
> > Document the interfaces we want users to call (ie copy_mc_to_iter()
> > and copy_from_iter_flushcache()), not the internal interfaces.
> 
> Except that no one actually calls them, and I have series to remove them
> that just needs a little brushing off.

Glad I didn't spend any time fixing the grammar.  I have no problem with
dropping this patch from the series.
