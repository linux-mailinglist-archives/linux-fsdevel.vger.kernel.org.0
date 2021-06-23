Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01A3B16C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWJ0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJ0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:26:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DAC061574;
        Wed, 23 Jun 2021 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=oQrrM6IdYDWQ2PhDILWxxX7TKD
        IKYS/sS/uixRYBLF6aHEDICErnXw+fQYq1uIFwAA8E2ATZ+5DapYMbu+amlc98Y6BDVEKMPDP0aPE
        Gw3AkL0tKMEkT+Oel/88puB7B0SipPc1+SUbiFRO7cQXwN7zr2UmSNlIFOfAWq2Vy1t8t4AdNYFxf
        rIFexMbBZhNT4CY6wOxaJZw/MgdEUepOyUnXvIZlJkRgCjCIayUv5XMXgXAIDWjt/lRW+BYU0sLk8
        gQOJbhuLlmfSmHBtxft1nkS5qI4Ig6iG3xV2zsJDIIADEapw9LkHKWbmtMUX138xIrF/ZKGkzLLTs
        JZEWMRIw==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvz73-00FG6F-Bn; Wed, 23 Jun 2021 09:24:09 +0000
Date:   Wed, 23 Jun 2021 11:21:51 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 26/46] mm/writeback: Add folio_mark_dirty()
Message-ID: <YNL9L6RgFHcYjjWe@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-27-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
