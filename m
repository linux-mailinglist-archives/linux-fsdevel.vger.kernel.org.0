Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7A23A7718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhFOGcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOGcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:32:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDAC061574;
        Mon, 14 Jun 2021 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zLCiIpzK+kcp6Mu0sXVhu66dLPoplfLNaGiu3IZTzOM=; b=f4qXb/3vU2bvOusBXqogJToa4Y
        1eT/cZnqyljGZM+Nyi0gPgfsjeDj4Y0Twh/kubcIAiBMc1qkFIQi2i8kKKwMyxfNwZ9U/OileSamF
        1G0h+65WoHwgZwT41Y5C8EOb6tcZAVK9MO9axzZNOqknfCeA+crI2WO4LFAG2e7pqZrWOQexf0it0
        zm4eHmkvq4T7TyomtUBzKKwpYeTfcDoVIKe+h9SzyxWj4czGz3MZer7XjnGt0qjfElgvjYczJYKkF
        GzN/o/o5mXQvYgxAJWW/okbkXVyvV1tMR5CKKYrzqD1n7fqvd928MTHasuvnme5EUW679lvtL/cAn
        enNUrWGw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2Zw-006AOo-8n; Tue, 15 Jun 2021 06:29:42 +0000
Date:   Tue, 15 Jun 2021 07:29:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 24/33] mm/swap: Add folio_rotate_reclaimable()
Message-ID: <YMhI1M9OBZ8//Xx4@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
 <20210614201435.1379188-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614201435.1379188-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:14:26PM +0100, Matthew Wilcox (Oracle) wrote:
> Move the declaration into mm/internal.h and rename
> rotate_reclaimable_page() to folio_rotate_reclaimable().

This commit log kinda suggests it was only renamed while it obviously
was also changed to take a folio * argument, leading to the improvements
mentioned below.  Maybe make that a little more clear?
