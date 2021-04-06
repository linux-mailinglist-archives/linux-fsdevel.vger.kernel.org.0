Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2235554C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbhDFNgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbhDFNgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:36:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A238C06174A;
        Tue,  6 Apr 2021 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sFos5Am2WOHKunK4sb1uTLPyIWgheGtp6/8nhKqbdyk=; b=RE2tqCLPmm2p2Jiim5zD/uNDIf
        4dYiLD6byhAOHa9CQnPYUuFte6PbKdi/VRbRJode1q3O2/VD/3/EpFfx8BpgGzNuHk+ehhFBK6Pm1
        31EYVCfV4hTLzNBmWEaSmhCOp4q5bWa8Ta3DlPmp9bhGBRjwzfCH8FPtRYROvo2PujLx4TGVFmP/4
        qmaLpBC7sQHnkLcEURIjo3k71nJSWEDXKQVQfc9UDAyibiQYYWpBo/DJlqYQ+17oKT+KSEbMyaweY
        zF6fhHt1mGBg00sfF/LXbutqZqWch1YlZaqZpaOar4EsSvjlr/ACp8Uq2cq5hAZx7LdL2kCqQMRu+
        t5ziZR6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlqk-00Cron-0w; Tue, 06 Apr 2021 13:35:04 +0000
Date:   Tue, 6 Apr 2021 14:34:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 08/27] mm: Create FolioFlags
Message-ID: <20210406133434.GG3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:09PM +0100, Matthew Wilcox (Oracle) wrote:
> These new functions are the folio analogues of the PageFlags functions.
> If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio is not a tail
> page at every invocation.  Note that this will also catch the PagePoisoned
> case as a poisoned page has every bit set, which would include PageTail.
> 
> This saves 1727 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
