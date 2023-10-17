Return-Path: <linux-fsdevel+bounces-533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52817CC6C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D5B2128D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760E43AB5;
	Tue, 17 Oct 2023 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8mzifYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94291436AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 14:50:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DB3C2B;
	Tue, 17 Oct 2023 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697554219; x=1729090219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=llRKd5U2MVjzqZMgmHIQBtRjZKJxSsrlZ+a2E5TyrW4=;
  b=Z8mzifYEGT14H96cMX6Ui92gzRfXuFPHWX1Q4RpMx2nldGtwwa7WP9h9
   xPkoe4zOrVz3MUaRGnOiAqqGTqAQW+VUPXQfq2+ZN4k259yxrntBk//mJ
   /bN5HTg5X6nTEG+REimbIaWMyE7a9wQT4kk1lVSz2yE0f92Pwm+l66YuT
   Ik2TJVvLwZmaXiTA4reyD+2ZLUPgHJGf5m3azxz/OJRuKZ/M1IhRPCCha
   bdS4pyZQ6ZmY4/7mT9aEu1EoqL3KH6LdzWb8VyU1I7tjP5W20CQKnSRgR
   RVhOQlOQid1kMTzURoftWDO0WW1304kfXhR2F/XaeySb8hvdCUEeXpNoz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376162569"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="376162569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="899931597"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="899931597"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:48:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qslOc-00000006Jzr-2zgU;
	Tue, 17 Oct 2023 17:50:10 +0300
Date: Tue, 17 Oct 2023 17:50:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
 <20231017133245.lvadrhbgklppnffv@quack3>
 <ZS6PRdhHRehDC+02@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6PRdhHRehDC+02@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > >   Hello Linus,

...

> > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > trigger without a bit of information printed out.
> > > 
> > > Okay, seems false positive as with different configuration it
> > > boots. It might be related to the size of the kernel itself.
> > 
> > Ah, ok, that makes some sense.
> 
> I should have mentioned that it boots with the configuration say "A",
> while not with "B", where "B" = "A" + "C" and definitely the kernel
> and initrd sizes in the "B" case are bigger.

If it's a size (which is only grew from 13M->14M), it's weird.

Nevertheless, I reverted these in my local tree

85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"

and it boots again! So, after this merge something affects one of this?

I'll continuing debugging which one is a culprit, just want to share
the intermediate findings.

-- 
With Best Regards,
Andy Shevchenko



