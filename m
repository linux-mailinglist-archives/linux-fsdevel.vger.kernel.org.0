Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C95A337FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCKVbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 16:31:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:40304 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCKVau (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:30:50 -0500
IronPort-SDR: LF0e03fZJPwUGNmFY9BNzgizS6DVe/81WRuuJpOPaeiy2pqSfOka+4nlJHx8o3uG2xAijIcPlk
 mRjjWKPDL6RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188783606"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188783606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 13:30:45 -0800
IronPort-SDR: DlRAVzb0h1LKCjR04Ra2E/3XWPdAp2Fxpkv9nhQVAdjWKKQblommhVGUuywhcc+8s8w5mCffqe
 vtDIdfgFLSPw==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="410768023"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 13:30:45 -0800
Date:   Thu, 11 Mar 2021 13:30:45 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Message-ID: <20210311213045.GT3014244@iweiny-DESK2.sc.intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:48:22PM -0800, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> I am submitting these for 5.13.

Just a friendly ping on this set.

Ira

> 
> Further work to remove more kmap() calls in favor of the kmap_local_page() this
> series converts those calls which required more than a common pattern which
> were covered in my previous series[1].  This is the second of what I hope to be
> 3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
> because I need to have more eyes on it before I'm sure about what to do.  For
> now this series should be good to go for 5.13.
> 
> Also this series converts the kmaps in the raid5/6 code which required a fix to
> the kmap'ings which was submitted in [2].
> 
> Thanks,
> Ira
> 
> [1] https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
> [2] https://lore.kernel.org/lkml/20210205163943.GD5033@iweiny-DESK2.sc.intel.com/
> 
> 
> Ira Weiny (4):
>   fs/btrfs: Convert kmap to kmap_local_page() using coccinelle
>   fs/btrfs: Convert raid5/6 kmaps to kmap_local_page()
>   fs/btrfs: Use kmap_local_page() in __btrfsic_submit_bio()
>   fs/btrfs: Convert block context kmap's to kmap_local_page()
> 
>  fs/btrfs/check-integrity.c | 12 ++++----
>  fs/btrfs/compression.c     |  4 +--
>  fs/btrfs/inode.c           |  4 +--
>  fs/btrfs/lzo.c             |  9 +++---
>  fs/btrfs/raid56.c          | 61 +++++++++++++++++++-------------------
>  5 files changed, 44 insertions(+), 46 deletions(-)
> 
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
