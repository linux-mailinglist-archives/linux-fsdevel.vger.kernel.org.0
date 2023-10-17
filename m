Return-Path: <linux-fsdevel+bounces-522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BE7CC1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C801C20C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8E41E2B;
	Tue, 17 Oct 2023 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Phe2fFGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2241746
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 11:46:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB9CEA;
	Tue, 17 Oct 2023 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697543185; x=1729079185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1CcpLM7NjkAxHRhrec0gYPa6etALuLRPeyBOXiAGDc=;
  b=Phe2fFGUR22Y46WwZzYdgQsEPTg70AiWTsPveKoogz7h4SEOzsQv6TAu
   t4qCIbdzmGNPwyDgy5qXp4j/Md0OsYyBGjlhX47ENnD014WU1WCODl9uC
   bBJmc6Ygx+byq2/o8LGBQQRww6E/WDA18LrflNUpo6JwEdiDoNaCuPStf
   C3mIy5avxhuoHVp/3rZmgtGLsHHxTuPw63nT5cMXpwNRZ5NVWo9Go3quU
   XIkojy6PLkyKhRjibP4nJlv5gn6G6mVJHPrE8bEgqBfLZZfmMJUnfyUpg
   265SGHZYze7PPW9q1UKjdnDsmQcNx9ZSm7rsRZeFCKkFK0rLGzQjlgsme
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365112931"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="365112931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785457515"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785457515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:46:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qsiWi-00000006GzZ-2iP3;
	Tue, 17 Oct 2023 14:46:20 +0300
Date: Tue, 17 Oct 2023 14:46:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > >   Hello Linus,

...

> > > This merge commit (?) broke boot on Intel Merrifield.
> > > It has earlycon enabled and only what I got is watchdog
> > > trigger without a bit of information printed out.

Okay, seems false positive as with different configuration it
boots. It might be related to the size of the kernel itself.

-- 
With Best Regards,
Andy Shevchenko



