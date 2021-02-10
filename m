Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B93316736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhBJMz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBJMzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:55:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF229C061574;
        Wed, 10 Feb 2021 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=InazGvHrAmHBOnyPWm5jXswJnvdDfNBNTEI6Fmej6wM=; b=uCXRc4gQuDm+LXMV2yoxL5+31M
        R/7zP8DbLcxMmV4BnIF5NEohwBzFUR0YWPm0ndnIOTfFQkNWiYHVr1Eo6AHiPgi3+K21vdyQ3ioyN
        Q0nTY6VqjC7tTavy3mLL2dlJZEaOBCiQ4YBKl3OjqQPP1DddjTPTsZYIoveuZgDQH9LpRAuOlxMPW
        wxxRYbnpWJBCBcOcBztiaEivp+t7LcCdfGCAfQgcGgvKdW3hLs3GPqlGHi2HLQvCt92e2pvSgMFUU
        Kb9Iq9vPqxm5cG2UukCMfUD27tJCsTUrCbYS4dFGhhvTrZb4ZYefuy4uoXJ5SuTDWCKnPaS6J7XYE
        AFKATlAg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p1K-008rWU-Iz; Wed, 10 Feb 2021 12:55:02 +0000
Date:   Wed, 10 Feb 2021 12:55:02 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210125502.GD2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-5-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:22:17PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
> memory operations do not result in corrupted data in neighbor pages and
> to make them consistent with zero_user().[1][2]

s/VM_BUG_ON/BUG_ON/g ?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
