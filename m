Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED93B5909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF1GVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1GVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:21:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D984C061574;
        Sun, 27 Jun 2021 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xMH8quXQ1KpWPHQ/uSY3qrmdHTNL0PryLpfY1lJx2As=; b=iWmFPkkIzsRjeKkXUXSj1vkwO3
        Opc9hXPZSxrq59VAAIL4MKfAvvLICTMq7YzIdJfPyoLMiicmO9d6mLrbmRtUxQ9gvR78JX8LRpZ5d
        2YW/N99ZjFSL4HWkTuCqa5fTgpbFWhlQQgtbZU9ZYidjkCoFJDT/zR+CujqyWCfvzANW1izB7AcRm
        c/D0742mwQsHmcl7juN3pVd2PsNkQDIkRcmPnMa0+B19cqqB1NbojPjOzsW+ql6Lvo109Sz+V1ph+
        zXB35fnSX4wO2LXWPh+pkqj9WzrNUupNSDr/ptvFj9BrqAWapjEcMZdVBOg5QzH6GvSEe3DmsvklF
        A9R904fw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkaw-002eLV-Ka; Mon, 28 Jun 2021 06:18:18 +0000
Date:   Mon, 28 Jun 2021 07:18:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/46] mm: Add folio_to_pfn()
Message-ID: <YNlpoi75wI+h89mQ@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-2-willy@infradead.org>
 <YNLno34yXpRNnMRj@infradead.org>
 <YNSgxdendo5cSTkT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSgxdendo5cSTkT@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:12:05PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 08:49:55AM +0100, Christoph Hellwig wrote:
> > On Tue, Jun 22, 2021 at 01:15:06PM +0100, Matthew Wilcox (Oracle) wrote:
> > > The pfn of a folio is the pfn of its head page.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Maybe add a kerneldoc comment stating that?
> 
> /**
>  * folio_to_pfn - Return the Page Frame Number of a folio.
>  * @folio: The folio.
>  *
>  * A folio may contain multiple pages.  The pages have consecutive
>  * Page Frame Numbers.
>  *
>  * Return: The Page Frame Number of the first page in the folio.
>  */

Looks fine.
