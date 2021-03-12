Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6A3397F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhCLUFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 15:05:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:22217 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234644AbhCLUFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:05:03 -0500
IronPort-SDR: rtRvRL2LkeJzTAdaaKKpBxomrTL2IaafcCKX+xxLwNMKw3nrl/HJlFazr0scqkWGGeS3+jsVfA
 T0xDgHq25c3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188977454"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188977454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 12:05:00 -0800
IronPort-SDR: 4FBujnPHzVKMGemsDs9zMwydsNGaVhrZP23a5Kmq1I/bUM3Y6N/leH4kCaK9t3fVQL/Bs8nRhR
 TSopgAANCS0w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="411122199"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 12:05:00 -0800
Date:   Fri, 12 Mar 2021 12:05:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Message-ID: <20210312200500.GG3014244@iweiny-DESK2.sc.intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210312194141.GT7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312194141.GT7604@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 08:41:41PM +0100, David Sterba wrote:
> On Tue, Feb 16, 2021 at 06:48:22PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > I am submitting these for 5.13.
> > 
> > Further work to remove more kmap() calls in favor of the kmap_local_page() this
> > series converts those calls which required more than a common pattern which
> > were covered in my previous series[1].  This is the second of what I hope to be
> > 3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
> > because I need to have more eyes on it before I'm sure about what to do.  For
> > now this series should be good to go for 5.13.
> > 
> > Also this series converts the kmaps in the raid5/6 code which required a fix to
> > the kmap'ings which was submitted in [2].
> 
> Branch added to for-next and will be moved to the devel queue next week.
> I've added some comments about the ordering requirement, that's
> something not obvious. There's a comment under 1st patch but that's
> trivial to fix if needed. Thanks.

I've replied to the first patch.  LMK if you want me to respin it.

Thanks!
Ira
