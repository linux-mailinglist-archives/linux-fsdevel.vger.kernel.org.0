Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2331591B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhBIWH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:07:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:22690 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233350AbhBIWFO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:14 -0500
IronPort-SDR: qm3QDZKXVvUz7zK36R1cBmtYWTMjh9MmHmrEqnEf/VtC/ag/YXR087xiBAeOSqr2pPhsBdR/hE
 d16Vo7P0q9cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169646391"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="169646391"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:52:30 -0800
IronPort-SDR: KMBExiMqHPbOmuFWjVF8uvMMKlFrOnZlogo2zHUcOm/4gLUvrr15QrFYyuMFho/oWotwP63h6j
 qaE46oV2PR+w==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="578192087"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:52:30 -0800
Date:   Tue, 9 Feb 2021 13:52:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-ID: <20210209215229.GC2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210209151123.GT1993@suse.cz>
 <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
 <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
 <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:11:03PM -0800, Andrew Morton wrote:
> > > 
> > > It would be best to merge [1/4] via the btrfs tree.  Please add my
> > > 
> > > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > 
> > > Although I think it would be better if [1/4] merely did the code
> > > movement.  Adding those BUG_ON()s is a semantic/functional change and
> > > really shouldn't be bound up with the other things this patch series
> > > does.
> > 
> > I proposed this too and was told 'no'...
> > 
> > <quote>
> > If we put in into a separate patch, someone will suggest backing out the
> > patch which tells us that there's a problem.
> > </quote>
> > 	-- https://lore.kernel.org/lkml/20201209201415.GT7338@casper.infradead.org/
> 
> Yeah, no, please let's not do this.  Bundling an offtopic change into
> [1/4] then making three more patches dependent on the ontopic parts of
> [1/4] is just rude.
> 
> I think the case for adding the BUG_ONs can be clearly made.  And that
> case should at least have been clearly made in the [1/4] changelog!
> 
> (Although I expect VM_BUG_ON() would be better - will give us sufficient
> coverage without the overall impact.)

I'm ok with VM_BUG_ON()

> 
> Let's please queue this up separately.

Ok can I retain your Ack on the move part of the patch?  Note that it does
change kmap_atomic() to kmap_local_page() currently.

Would you prefer a separate change for that as well?

Ira

PS really CC'ing Matthew now...
