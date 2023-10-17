Return-Path: <linux-fsdevel+bounces-526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167447CC4F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511811C2089B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10C436AD;
	Tue, 17 Oct 2023 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkgxR6Fe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AE41234
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 13:42:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF8101;
	Tue, 17 Oct 2023 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697550154; x=1729086154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjMtCk5O1IeM6c/+t6RZG+BjeG3s1Xc0Z5rkRQkLbmE=;
  b=KkgxR6FeOS5KRjUf4NgxmVf9dkPQ2zFz4+/BFuQ5QB76oE9c9syoNLB4
   tZBZjx7cDwHb5aKN9JzRzqMcNTmtgB9D+P4/CsDCwPUkRds6BTLLZ4rig
   K21ktsj8YRZzJ+agWgzRTkCKfYQIFRrCrjBQZOUkFafBw+aOxUIWoJrY+
   lJOZkXv4RH7nqm5YlhHxEbLyaEBoQ/QciwBLXY2sVx2goHBZaT2HJbBfY
   tEx/QyZSHrEVlkkK3oq+BXLdhYb1anBm+xMc5DiK0ZrNu7rjMIgp53UdO
   u07UZCRYs428mqclwbs16GXFaaxUQXVcCtP4IJaJ8gfcYHT2B/slyz5B8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366043295"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366043295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872564472"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="872564472"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:42:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qskL7-00000006Iqi-3hMI;
	Tue, 17 Oct 2023 16:42:29 +0300
Date: Tue, 17 Oct 2023 16:42:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS6PRdhHRehDC+02@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
 <20231017133245.lvadrhbgklppnffv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017133245.lvadrhbgklppnffv@quack3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > >   Hello Linus,

...

> > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > It has earlycon enabled and only what I got is watchdog
> > > > > trigger without a bit of information printed out.
> > 
> > Okay, seems false positive as with different configuration it
> > boots. It might be related to the size of the kernel itself.
> 
> Ah, ok, that makes some sense.

I should have mentioned that it boots with the configuration say "A",
while not with "B", where "B" = "A" + "C" and definitely the kernel
and initrd sizes in the "B" case are bigger.

-- 
With Best Regards,
Andy Shevchenko



