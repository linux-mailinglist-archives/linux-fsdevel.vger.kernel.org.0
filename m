Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADA47E04D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbhLWIWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbhLWIWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285DC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3fhX2lXQENz8PxTBWIZeIUsBq/tz4Ah/OxwI76N9yhE=; b=BNG8uCx5UeyrLQ1bnTA74+asvJ
        JlXiJhLbSikskL8EVEpuPiOeYJexGLM8kpEWRBPYDVuilZ40rtnXzXor+YmbhwpXSnXf7TJ30+dy3
        sxrm8j6raYral7AgLoZ/ixrq5mZaTdmijeOgAV8GJBfPQ1z/tV2RE5IBR56sDw3rI8GOcR7Slomvl
        s2wWql3pRUrCKPllI7Sgp9qz4FQZjOgQ26vIAJQRDGfttMgMIKfxQC2dj9DYemGkMTeJMx0hI6L6G
        wdBLQYJ9MAdff016Q5rYXKWOrjj6w9jgHDTnIq8KNwh8EEPMHfSFdTDpNfp4eUwHFFFwc9kNsNizj
        vUhqCJ1A==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMM-00CChf-L5; Thu, 23 Dec 2021 08:21:59 +0000
Date:   Thu, 23 Dec 2021 09:21:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 38/48] truncate: Add invalidate_complete_folio2()
Message-ID: <YcQxo1TTErlUVG8Z@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-39-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-39-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:46AM +0000, Matthew Wilcox (Oracle) wrote:
> Convert invalidate_complete_page2() to invalidate_complete_folio2().
> Use filemap_free_folio() to free the page instead of calling ->freepage
> manually.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although eventually we need to get rid of this silly *2 naming here.
