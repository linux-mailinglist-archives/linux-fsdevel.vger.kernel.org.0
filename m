Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B315316C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBJRFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 12:05:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:56432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhBJRFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:05:17 -0500
IronPort-SDR: kcIJxSSWbROliXwDaDrk3Aq4jOvnSoA/ZIpNhN9+PsumTExoXzrYgnf9GCpgb6fuPCg/CMFetC
 8spyDaR4DgMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169237408"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169237408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:04:02 -0800
IronPort-SDR: HxNZpxNQ3qg3nwq2kHejEo/ncl/66S8VQBIO5yDxjf9tyzYx3jacQ7VwtkZXn+sQc+D6qeKSy9
 cgAXbTMBmNQA==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="420603585"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:04:01 -0800
Date:   Wed, 10 Feb 2021 09:04:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210170401.GE3014244@iweiny-DESK2.sc.intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
 <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
 <20210210164134.GA2169678@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210164134.GA2169678@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:41:34PM +0000, Christoph Hellwig wrote:
> On Wed, Feb 10, 2021 at 08:29:01AM -0800, Ira Weiny wrote:
> > On Wed, Feb 10, 2021 at 12:55:02PM +0000, Christoph Hellwig wrote:
> > > On Tue, Feb 09, 2021 at 10:22:17PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
> > > > memory operations do not result in corrupted data in neighbor pages and
> > > > to make them consistent with zero_user().[1][2]
> > > 
> > > s/VM_BUG_ON/BUG_ON/g ?
> > 
> > Andrew wanted VM_BUG_ON.[1]
> 
> I don't care either way, but the patch uses BUG_ON, so the description
> should match.

Oh man...  I changed the commit message after spliting the patch and forgot to
change the code...  <doh>

Thanks,
Ira
