Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F493CF513
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhGTGaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhGTGa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:30:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22CC061574;
        Tue, 20 Jul 2021 00:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UzAuDd83H6Ob7ClOmB94gVc3oTlSRnahgjr4O8IG0zg=; b=SOycqF7cgrJLCUjNMTSwR9+YS4
        osRPymF8NcnruFpA8nQTQpHaVdhCHhVm6botg1ahqnJ3N/sobVsRQvNiDXYyTS0dc3J4D4gUKPJ/k
        5HwKGhJMeW8XNi8wVfOFEWIM6/0apEytmmM5Yl92q2JiFaxywNIwWAoLpF3Y3TwoD0s03qgkvaWO+
        WAGcIulqgWTjyBekCbt3Z1jZo5Apmwul2GTHsi1r7ewn8YsvOrjOMG18eoHBkT26O/t2Zeuf8C858
        M3mCTnSJ9e48msCpZyIerHQ5Yf/JDY/jTk7kvric9w/fXkyYT9jH/jdPB44Qu+5PKhGyyXBeo5v83
        b9f41zQg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jsk-007rBa-3I; Tue, 20 Jul 2021 07:09:59 +0000
Date:   Tue, 20 Jul 2021 09:09:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 11/17] iomap: Convert readahead and readpage to use a
 folio
Message-ID: <YPZ2raTFeF1oEsLs@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:55PM +0100, Matthew Wilcox (Oracle) wrote:
> Handle folios of arbitrary size instead of working in PAGE_SIZE units.

Ok, this is a real conflict vs the iter work, but otherwise it looks
fine.
