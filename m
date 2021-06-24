Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF33B3254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFXPOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:14:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CFC061574;
        Thu, 24 Jun 2021 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OX+lANPiZGvxTlDQ96tEYd1zyjA1DvX076Imm4QeeNY=; b=if2/Xho/z/d98VtoDncnYkqWbb
        12naERzdbyXq3MXtuFRNqloUyIy4xhAidr1ZQQr+3ArrKrYlwqP8rlNGYOf/fuxIYBc09awxNef3p
        u3d0hEJMcVObM85Uel/TSl+J9mwl5jaSzIXey4c/vFVluWKzZW5id6qT6spcDLwsf/kJiQdC+OvH6
        ub260sxVgEv93k419eSdK+Y3Zm6FIqBWsQKWLDyE7us7Z5mW6xpdhYVOlwrFXFlxlkWZisYtNS10X
        GAu9r2+68361gE4GFQX2Y7zQPbY0kpXzwKnDlPbI7zcT8M9fS/6G9LkXrfwEgFQea2Tdl1uZNzAtx
        19iAJMzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwR1R-00GhlE-IM; Thu, 24 Jun 2021 15:12:08 +0000
Date:   Thu, 24 Jun 2021 16:12:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/46] mm: Add folio_to_pfn()
Message-ID: <YNSgxdendo5cSTkT@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-2-willy@infradead.org>
 <YNLno34yXpRNnMRj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLno34yXpRNnMRj@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 08:49:55AM +0100, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:06PM +0100, Matthew Wilcox (Oracle) wrote:
> > The pfn of a folio is the pfn of its head page.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Maybe add a kerneldoc comment stating that?

/**
 * folio_to_pfn - Return the Page Frame Number of a folio.
 * @folio: The folio.
 *
 * A folio may contain multiple pages.  The pages have consecutive
 * Page Frame Numbers.
 *
 * Return: The Page Frame Number of the first page in the folio.
 */

