Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5333F668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCQRRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCQRQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:16:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1CC06174A;
        Wed, 17 Mar 2021 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qo/0CZaBM3vkvFlSWE2vylgaMs07ND+ounCESWbPsMM=; b=WGk9Jgcw3Hce04yEcMePRI9NYv
        ygnDik4lNoZ362rDXAs3XCruJZIJMC5E45P7lWB7mm3n79CTiokm2MF2xPseygKgvhuDO+jtm0Sf2
        qHcUt8pXP1retMuf+tuRpBDPi3MY1kqrWzVn/7iQzWdQ0e8r0StY4PQEU6Bay09obpcMwAM0BHUFZ
        2ZljVb1X7T1I8EtltRiL6uvm80lOa5Eh/sTXU3bjImvVc/JFHG/YCq2JV5B5VUsrUQFhwT5Svp6BT
        FS2XmN1eqTOvJkZpLapn8DX+3Bsc2gqlqGdCYwNiUHC6LEqUi2O3xJCikZN9ROF0HDVeyCjGqPMJg
        hHC0WYhg==;
Received: from [2001:4bb8:18c:bb3:e3eb:4a4b:ba2f:224b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZmn-001tuO-KJ; Wed, 17 Mar 2021 17:16:47 +0000
Date:   Wed, 17 Mar 2021 18:16:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/25] mm/vmstat: Add functions to account folio
 statistics
Message-ID: <YFI5fO88/YF8vhAc@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline
> +void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)

This prototype style is weird and doesn't follow either of the preffered
styles..

>  static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
>  					     int migratetype)
>  {
> @@ -536,6 +584,24 @@ static inline void __dec_lruvec_page_state(struct page *page,
>  	__mod_lruvec_page_state(page, idx, -1);
>  }
>  
> +static inline void __mod_lruvec_folio_stat(struct folio *folio,
> +					   enum node_stat_item idx, int val)

.. like the ones that exist and are added by you just below.
