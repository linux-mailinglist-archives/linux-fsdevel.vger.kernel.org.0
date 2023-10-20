Return-Path: <linux-fsdevel+bounces-851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973667D15CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199B3B21554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7B2230F;
	Fri, 20 Oct 2023 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWwsuBto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFC21104
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 18:29:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53978D8;
	Fri, 20 Oct 2023 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697826572; x=1729362572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RV7eYTrVoYda1avxZkkjEOSNEkZA1PkbTCOaAUMlZ5c=;
  b=HWwsuBto1Qh1GN4nXt55QxeQjEoQS0aqIyAmnQA8ZXm2xzoLwwA4k8PR
   PrNjsaaI8IM7JlOwXS9SBZSgeuJxDDAriJgPXQBil4FP0AYcgyRdZN3+j
   MJV2oEP3KQ/NTZQEy7RopJPw8I9bVeJqJF5HgUc+0htmO9Bzzl81i0OcJ
   MWjrcbeGj+ZrUtBwCfQQEhpBjuiE817dykUYcNGKeUDdcMeo2EgkNfkOd
   e0cMX1jspRqsE+V1p2fIvbPVcYBpNQtKTDRnGE8EWogSjZX+dIBjb/5oE
   Q4QJwVFMzPGNWqUBEWXtTlayzKNh5ZfRYLWdrBUq41QkvKF1aocJqOrej
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="390437274"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="390437274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881146601"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881146601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:29:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qtuFR-00000007EBH-21bP;
	Fri, 20 Oct 2023 21:29:25 +0300
Date: Fri, 20 Oct 2023 21:29:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Baokun Li <libaokun1@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 20, 2023 at 10:23:57AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 07:52, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> That said - while unlikely, mind just sending me the *failing* copy of
> the fs/quota/dquot.o object file, and I'll take a look at the code
> around that call. I've looked at enough code generation issues that
> it's worth trying..

For the sake of purity, I have rebuilt the whole tree to confirm it doesn't boot.
Here [7] is what I got.

I'll reply to this with the attached object file, I assume it won't go to the
mailing list, but should be available in your mailbox.

[7]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-jr/

-- 
With Best Regards,
Andy Shevchenko



