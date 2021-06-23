Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1973B1745
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFWJxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:53:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4CC061574;
        Wed, 23 Jun 2021 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wX68kOPzYETyqJ2SCKqkqr7ukc9cCZeyMzMIUFAMr1E=; b=XjutMCRefnRt22zx8OdxtQ4Jsg
        G0r0exLUeLlGZZJ2j24THQD6fRqFPEuAXiq0Dshb3s0GUgZe+QEUorXxMlYKxO4F9zyL4Fdk8CfZn
        v4KNESEHhSvdB46CAz7mlCGzgJ6WCEZU4UVb4k3uOjmUmzIsk+1rqrhiC517KTkOCglo+8RiMqYxT
        SX/9lMehzoV76Ms83Y5kVTb3Bfw1/KyPX3p5zmrQ4il5X37RrzfaDgStrud1IT6P/mZ6oT2eltFM4
        Pb6u9YvlQngryCf4uIS+9F1fizTp83sRZNIXMfVQHDLh1etXSGYUqxY+bO2yydSUeCT84kL5yT4k1
        8XHyxp9w==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzWH-00FHgM-KV; Wed, 23 Jun 2021 09:50:13 +0000
Date:   Wed, 23 Jun 2021 11:50:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 36/46] mm/filemap: Add readahead_folio()
Message-ID: <YNMDzHwIA4neIPDD@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-37-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-37-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:41PM +0100, Matthew Wilcox (Oracle) wrote:
> The pointers stored in the page cache are folios, by definition.
> This change comes with a behaviour change -- callers of readahead_folio()
> are no longer required to put the page reference themselves.  This matches
> how readpage works, rather than matching how readpages used to work.

The way this stores and retrieves different but compatible types from the
same xarray is a little nasty.  But I guess we'll have to live with it for
now, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
