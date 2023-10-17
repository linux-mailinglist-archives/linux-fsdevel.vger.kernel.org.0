Return-Path: <linux-fsdevel+bounces-523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360757CC202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6771F2305F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C177D41E30;
	Tue, 17 Oct 2023 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+/hXgYC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777015AD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 11:49:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEABED;
	Tue, 17 Oct 2023 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697543394; x=1729079394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEvXlZd7hC9Cz+cD/T7akxPJP8WqqGcQyAHC5pKOQ1M=;
  b=A+/hXgYC+ybTpuzECQWibeJ0l2qmNkeuXQFvUcIvVU+QqdR50QSJ5CzE
   mwnIyP8Ke7FyVPfRxwoymTxc+x4DjzSNpB3aweB0pn/9YE6xkgkfoSajv
   GijOOZSu/iUeZHkKqs9AFmlsQbsxL6jmHq/cn/tbRT2qmjVkI3zPOgHM0
   IQChx/wW3pUymLxN97jH5GRiJSAgNAnXxks76Pf3yuEaKl29d4gE+1+nF
   pWbkv2r3Zoal+owV1dl/YdM1tlKuYAsAjg0li0hocLyyYQgNtnX4VXueo
   zmu6ng7WNN2HoE3BhIHg9hag/tDeethIa7kELejgYWqj4nf4HGCRX+j1H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471987901"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="471987901"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="899891366"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="899891366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:47:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qsia6-00000006H2r-0Z4L;
	Tue, 17 Oct 2023 14:49:50 +0300
Date: Tue, 17 Oct 2023 14:49:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS503UE540ZKUy08@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <20231017113628.coyq2wngiz5dnybs@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113628.coyq2wngiz5dnybs@quack3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:36:28PM +0200, Jan Kara wrote:
> On Tue 17-10-23 13:32:53, Andy Shevchenko wrote:

...

> That's strange because I don't see anything suspicious in the merge and
> furthermore I'd expent none of the changes in the merge to influence early
> boot in any way. Can you share your kernel config? What root filesystem do
> you use? Thanks for the report!

I just read this message and responded a few minutes before that the issue
somewhere else related to the configuration. Thanks for the prompt reply!

Still if you need to see the working/non-working configurations I can
share them.

-- 
With Best Regards,
Andy Shevchenko



