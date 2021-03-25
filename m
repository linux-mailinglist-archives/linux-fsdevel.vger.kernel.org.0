Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C839E349503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCYPLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:11:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:23427 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhCYPKt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:10:49 -0400
IronPort-SDR: zZoJS4eICzrYsv76NatE7PzRA54ekUwnFIzPXXN1huSP4fvb2cPrFwyii8XUw6KgJ7BmzE9MiN
 hJbBZxkkEVRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="252305246"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="252305246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:10:48 -0700
IronPort-SDR: dPvFJNBPXz+6hB+ecIHrgxpLZawb8lLhygnp4vUuH4RjI/fPMOirG8taFHfKyYVt+tqxrpbPgs
 xtVQhWYMifZA==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="416044528"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:10:48 -0700
Date:   Thu, 25 Mar 2021 08:10:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com, clm@fb.com,
        dsterba@suse.com, ebiggers@kernel.org, hch@infradead.org,
        dave.hansen@intel.com
Subject: Re: [RFC PATCH 6/8] ext4: use memcpy_to_page() in pagecache_write()
Message-ID: <20210325151047.GX3014244@iweiny-DESK2.sc.intel.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-7-chaitanya.kulkarni@wdc.com>
 <YFycvk4aMoPAZcwJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFycvk4aMoPAZcwJ@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:22:54AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Feb 07, 2021 at 11:04:23AM -0800, Chaitanya Kulkarni wrote:
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >  fs/ext4/verity.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Hi, were you expecting to have file system maintainers take these
> patches into their own trees?  The ext4 patches look good, and unless
> you have any objections, I can take them through the ext4 tree.

I should have sent the lore link to the fix:

https://lore.kernel.org/linux-f2fs-devel/BYAPR04MB496564B786E293FDA21D06E6868F9@BYAPR04MB4965.namprd04.prod.outlook.com/

Sorry,
Ira
