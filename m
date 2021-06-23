Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57113B1568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWIKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWIKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61780C061574;
        Wed, 23 Jun 2021 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s0d8JTUB1/iJ0/Hk5yG5Evr+fy0RTYmyaYwNwEt6dR0=; b=kDaL3XwXuN5IM/j/oV/Xk0NhIg
        DeWLWiIlQg605bdIVW3YfMVIiicDR4Nbia+LCL0KbRCfNvLxmErN/1tNg8Y1IcF64PHxWKT1WmSQQ
        sDdVf7z39up166bMwVIrs94pSXxNOn/p3ZhbWPE9Xuq916hTtQF7nsMyM6com7JlJDgwDwLHlyPy/
        JcBYrW6ZKUm1xhY3tgCyfom8oXN0y/3mw1N2+FAN0J0Z3s+46YYQinnsDZno3IPv4H/Mw/tGVWLGt
        IuVMJPv8JQ6ZDpaUfVziSBaM51gXjdO5fpOjPwpp0quHDLa7PgTI8vgz3vak5uCB8v/2w3EsL2NCk
        Bja8PmRg==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxua-00FBuJ-94; Wed, 23 Jun 2021 08:07:11 +0000
Date:   Wed, 23 Jun 2021 10:07:03 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/46] mm/swap: Add folio_mark_accessed()
Message-ID: <YNLrp/QMEX20318Q@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:14PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert mark_page_accessed() to folio_mark_accessed().  It already
> operated on the entire compound page, but now we can avoid calling
> compound_head quite so many times.  Shrinks the function from 424 bytes
> to 295 bytes (shrinking by 129 bytes).  The compatibility wrapper is 30
> bytes, plus the 8 bytes for the exported symbol means the kernel shrinks
> by 91 bytes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
