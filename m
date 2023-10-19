Return-Path: <linux-fsdevel+bounces-765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D67CFD3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933101C202F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532F1EB56;
	Thu, 19 Oct 2023 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDOt0ePm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09913199A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:49:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A37114;
	Thu, 19 Oct 2023 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697726965; x=1729262965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xKjXmfpvYB4Hz8IbECMTHSmbNOsKSD8+R6RguTXxNVk=;
  b=bDOt0ePmjD/sHKg/wuotw9fvG6ze9HlrIjL93M28LJ6U5ncnOGxdUV6o
   jtbBvK4GJfQomju0gsUVPVNFH2kIJ6k8lLzkEoulvZNHwZ8Hjw2/FXsKP
   rMTp0wyq6NnnTSkpK9wLF50F+5Fre8ZJ3NCo2kIDnhyOVrCfJiTAvJW2/
   +3ULJc5lsw6gRvhJmRNpu+6C5eW1t+mExnJGphrlCCnCREm6Z6VoRMDul
   UHYKgB0dDP9TPeKO8+rC4EiUew1xToxZfKoT0sn/A7SOezIawkTiyqMlx
   Fsiummfkuo/qoopBgnHgom5KtX8bYlj59uj5LCzJV8akwbtZkV+rdIcrQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390156488"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="390156488"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="930628206"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="930628206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:49:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qtUKs-00000006u6q-2ctA;
	Thu, 19 Oct 2023 17:49:18 +0300
Date: Thu, 19 Oct 2023 17:49:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFB7j4Jwlp6yj28@smile.fi.intel.com>
References: <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTE5a3L4LdsuoTJx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTE5a3L4LdsuoTJx@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 19, 2023 at 05:12:59PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 03:01:43PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 19, 2023 at 12:18:54PM +0200, Jan Kara wrote:
> > > On Thu 19-10-23 11:46:58, Andy Shevchenko wrote:
> > > > On Wed, Oct 18, 2023 at 08:46:13PM +0200, Jan Kara wrote:
> > > > > On Tue 17-10-23 19:02:52, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 17, 2023 at 06:34:50PM +0300, Andy Shevchenko wrote:
> > > > > > > On Tue, Oct 17, 2023 at 06:14:54PM +0300, Andy Shevchenko wrote:
> > > > > > > > On Tue, Oct 17, 2023 at 05:50:10PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > > > > > > > > > > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > > > > > > > > > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > > > > > > > > > > >   Hello Linus,

...

> > > > > > > > > > > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > > > > > > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > > > > > > > > > > trigger without a bit of information printed out.
> > > > > > > > > > > > 
> > > > > > > > > > > > Okay, seems false positive as with different configuration it
> > > > > > > > > > > > boots. It might be related to the size of the kernel itself.
> > > > > > > > > > > 
> > > > > > > > > > > Ah, ok, that makes some sense.
> > > > > > > > > > 
> > > > > > > > > > I should have mentioned that it boots with the configuration say "A",
> > > > > > > > > > while not with "B", where "B" = "A" + "C" and definitely the kernel
> > > > > > > > > > and initrd sizes in the "B" case are bigger.
> > > > > > > > > 
> > > > > > > > > If it's a size (which is only grew from 13M->14M), it's weird.
> > > > > > > > > 
> > > > > > > > > Nevertheless, I reverted these in my local tree
> > > > > > > > > 
> > > > > > > > > 85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
> > > > > > > > > 786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
> > > > > > > > > 76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
> > > > > > > > > f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"
> > > > > > > > > 
> > > > > > > > > and it boots again! So, after this merge something affects one of this?
> > > > > > > > > 
> > > > > > > > > I'll continuing debugging which one is a culprit, just want to share
> > > > > > > > > the intermediate findings.
> > > > > > > > 
> > > > > > > > CONFIG_DEBUG_LIST with this merge commit somehow triggers this issue.
> > > > > > > > Any ideas?
> > > > > > 
> > > > > > > Dropping CONFIG_QUOTA* helps as well.
> > > > > > 
> > > > > > More precisely it's enough to drop either from CONFIG_DEBUG_LIST and CONFIG_QUOTA
> > > > > > to make it boot again.
> > > > > > 
> > > > > > And I'm done for today.
> > > > > 
> > > > > OK, thanks for debugging! So can you perhaps enable CONFIG_DEBUG_LIST
> > > > > permanently in your kernel config and then bisect through the quota changes
> > > > > in the merge? My guess is commit dabc8b20756 ("quota: fix dqput() to follow
> > > > > the guarantees dquot_srcu should provide") might be the culprit given your
> > > > > testing but I fail to see how given I don't expect any quotas to be used
> > > > > during boot of your platform... BTW, there's also fixup: 869b6ea160
> > > > > ("quota: Fix slow quotaoff") merged last week so you could try testing a
> > > > > kernel after this fix to see whether it changes anything.
> > > > 
> > > > It's exactly what my initial report is about, CONFIG_DEBUG_LIST was there
> > > > always with CONFIG_QUOTA as well.
> > > 
> > > Ah, ok.
> > > 
> > > > Two bisections (v6.5 .. v6.6-rc1 & something...v6.6-rc6) pointed out to
> > > > merge commit!
> > > 
> > > I thought CONFIG_DEBUG_LIST arrived through one path, some problematic
> > > quota change arrived through another path and because they cause problems
> > > only together, then bisecting to the merge would be exactly the outcome.
> > > Alas that doesn't seem to be the case :-|.
> > > 
> > > > I _had_ tried to simply revert the quota changes (I haven't
> > > > said about that before) and it didn't help. I'm so puzzled with all this.
> > > 
> > > Aha, OK. If even reverting quota changes doesn't help, then it's really
> > > weird...
> > 
> > Lemme to confirm that, it might be that I forgot to update configuration in
> > between.
> 
> So, what I have done so far.
> 1) I have cleaned ccaches and stuff as I used it to avoid collisions;
> 2) I have confirmed that CONFIG_DEBUG_LIST affects boot, the repo
>    I'm using is published here [0][1];
> 3) reverted quota patches until before this merge ([2] - last patch),
>    still boots;
> 4) reverted disabling of CONFIG_DEBUG_LIST [2], doesn't boot;
> 5) okay, rebased on top of merge, i.e. 1500e7e0726e,  with DEBUG_LIST [3],
>    doesn't boot;
> 6) rebased [3] on one merge before, i.e. 63580f669d7f [4], voilà -- it boots!;
> 
> And (tadaam!) I have had an idea for a while to replace GCC with LLVM
> (at least for this test), so [0] boots as well!
> 
> So, this merge triggered a bug in GCC, seems like... And it's _the_ merge
> commit, which is so-o weird!
> 
> $ gcc --version
> gcc (Debian 13.2.0-4) 13.2.0
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

For the cleaner experiment I took [0], cleaned $OUTPUT and ccache (fully)
and build the kernel with

$ clang --version
Debian clang version 16.0.6 (15)
	Target: x86_64-pc-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin

it boots,

Then I have done the same with GCC (see above the version)
and it does not boot.

[0]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-dbg-list/
[1]: https://bitbucket.org/andy-shev/linux/src/test-mrfld/
[2]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-no-quota-dbg-list/
[3]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-after-merge-dbg-list/
[4]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-before-merge/

-- 
With Best Regards,
Andy Shevchenko



