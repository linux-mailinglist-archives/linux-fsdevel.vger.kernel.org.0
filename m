Return-Path: <linux-fsdevel+bounces-3728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFF7F79A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC91C20D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235834186;
	Fri, 24 Nov 2023 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVt0mTA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304E1733;
	Fri, 24 Nov 2023 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700844437; x=1732380437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT2XVFcBH/DcAfOKfdIHo1zJ81GhWWUwC7YdVboVPM8=;
  b=dVt0mTA/UNxvyFN45tacqikO3xleilFxRS8x9m+YNBTBo0HsyragullG
   veySFUwhZhdtBrpCLeYURnoVXJrHETALpXHgn9oz2nw1tEYgpaJZMOcw2
   uhgsVI8x1MDZy4y7wr4ZaBNqebPHfrdY3OmCTpzWw8SEqhmKN5O8508jb
   +/IWAFXldX1pY7pQxmEhh96FNyejmr1sHUQ9Z2T6cRFmkHQjKnd8ac8ZN
   pHUkHfg1HrUaLcFSouoY53lUf8kygwtVH960DR0G9EdMp0ExyNhGvRzzh
   E56Lls3ulTY2NRqjRllnvWmpdxpc4zOagGWnUlvqXs+BlbWSODkpgFkqX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="423583743"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="423583743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 08:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="771302257"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="771302257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 08:47:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r6ZKk-0000000GmKc-1K72;
	Fri, 24 Nov 2023 18:47:14 +0200
Date: Fri, 24 Nov 2023 18:47:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZWDTkmQZ7uojegiS@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <9ba95b5e-72cb-445a-99b7-54dad4dab148@leemhuis.info>
 <5884527d-a4a2-44e2-96bc-4b300c9e2fb8@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5884527d-a4a2-44e2-96bc-4b300c9e2fb8@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 22, 2023 at 09:15:06AM +0100, Linux regression tracking #update (Thorsten Leemhuis) wrote:
> On 22.10.23 15:46, Linux regression tracking #adding (Thorsten Leemhuis)
> wrote:
> > On 17.10.23 12:27, Andy Shevchenko wrote:
> >> On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> >>>   Hello Linus,
> >>>
> >>>   could you please pull from
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
> >>
> >> This merge commit (?) broke boot on Intel Merrifield.
> >> It has earlycon enabled and only what I got is watchdog
> >> trigger without a bit of information printed out.
> >>
> >> I tried to give a two bisects with the same result.
> > 
> > #regzbot ^introduced 024128477809f8
> > #regzbot title quota: boot on Intel Merrifield after merge commit
> > 1500e7e0726e
> > #regzbot ignore-activity
> 
> Removing this from the tracking. To quote Linus from
> https://lore.kernel.org/all/CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com/
> 
> """
> The quota thing remains unexplained, and honestly seems like a timing
> issue that just happens to hit Andy. Very strange, but I suspect that
> without more reports (that may or may not ever happen), we're stuck.
> """
> 
> No other reports showed up afaik.

Yeah, have no time to dig into this more... Maybe later, who knows?

-- 
With Best Regards,
Andy Shevchenko



