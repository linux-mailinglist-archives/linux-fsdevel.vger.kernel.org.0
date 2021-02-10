Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826E4316B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhBJQon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhBJQm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:42:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA0C06174A;
        Wed, 10 Feb 2021 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v9yRMlvHCXlBWJoLZkr6GmF3X21NdcNOdmmcwmQ1wz4=; b=ZOlYhvxCmn92QujUmMYgBIPZVP
        5YxBTBFobbzdLHFwIbywWhaip4VxFsEGHF0391VEjMt88YoFxNGZb6WB1e/60S+AFzJ5Dspc1fC9b
        GW+BvuLwQMhhHN8spE3w3mzx2syXtq6Q6qvn6PFvS/5yNFAlYEBynuRYF9hnsrPR361M7LAPidXaP
        P5roLkekwQssjJ1dZ6D+AbruBWdDQA8uUQgeg7E2MjRRRDkW8P8Yel7GKRkSlA8GjBbYq+gPY3NQJ
        wAi+uYbXy22iC0cXqPPHuxKILei5ja+m4VfsA/c+sc+gbtIj3smmZywjjyl17uuXq3wBryTPXq/1J
        RGEcobmA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9sYY-0096RT-83; Wed, 10 Feb 2021 16:41:34 +0000
Date:   Wed, 10 Feb 2021 16:41:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210164134.GA2169678@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
 <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:29:01AM -0800, Ira Weiny wrote:
> On Wed, Feb 10, 2021 at 12:55:02PM +0000, Christoph Hellwig wrote:
> > On Tue, Feb 09, 2021 at 10:22:17PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
> > > memory operations do not result in corrupted data in neighbor pages and
> > > to make them consistent with zero_user().[1][2]
> > 
> > s/VM_BUG_ON/BUG_ON/g ?
> 
> Andrew wanted VM_BUG_ON.[1]

I don't care either way, but the patch uses BUG_ON, so the description
should match.
