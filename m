Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B7316B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhBJQa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:30:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:32202 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhBJQaB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:30:01 -0500
IronPort-SDR: lTjb4cQGJIjUySLmek255K23yym3kNe6KK4mr9CG0uGurB4jMbe9gLrQgFAEEGvFL+SNj9XPDQ
 feZJ7UbXODcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169778346"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169778346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:29:02 -0800
IronPort-SDR: AYf6TBHe7hFQu5odPDodiEpYgJjxIRpODyBbKEVhKr2MPMRfJ6K0GrwNMuXpEvdqeYHyXXgvj7
 0MggOcPvgHqA==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="396767390"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:29:02 -0800
Date:   Wed, 10 Feb 2021 08:29:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210125502.GD2111784@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:55:02PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 09, 2021 at 10:22:17PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
> > memory operations do not result in corrupted data in neighbor pages and
> > to make them consistent with zero_user().[1][2]
> 
> s/VM_BUG_ON/BUG_ON/g ?

Andrew wanted VM_BUG_ON.[1]

And I thought it was a good idea.  Any file system development should have
tests with DEBUG_VM which should cover Matthew's concern while not having the
overhead in production.  Seemed like a decent compromise?

Ira

[1] https://lore.kernel.org/lkml/20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org/

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
