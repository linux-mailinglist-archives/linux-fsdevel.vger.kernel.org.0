Return-Path: <linux-fsdevel+bounces-74628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDTeI9xwcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:23:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE252018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA3126287AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0EA427A03;
	Tue, 20 Jan 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f33vBXqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F43E9F7B;
	Tue, 20 Jan 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913221; cv=none; b=kESIjID3XBUvodPmEV5+AHx5zaPUbJN1MDX1Sp+N9l7XGhU7JtPMt2J2wq81+jOzbhAoymE2yvqnIbNCon786bfYMVBHocOlca/3WnjmcKdjK18ReglMsjLAUIccZuysQZ0xKiPNkZeklH4bTu14sw/g6VJDWAJdl1HyoIRJwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913221; c=relaxed/simple;
	bh=MmzOoKd/wNqL5KSJd1ZEdXF5+T+/2LvfFcn3ogyRvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF3AueHcuriq7ltwelhPFbRZSoNZb9sw1c1uRKMEkKmsFAYZzpWFHF/mvbMUQc7duPIgUZdf/htwyvKpsZT1YMK6nvYkIj2/0/J2YhcHV41HC61mwHnVBujmDAJAqIt9oLlpMbpHjQs9gh48zH9LbvQ9xyOpTPf0kk2bZMoqLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f33vBXqa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768913220; x=1800449220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmzOoKd/wNqL5KSJd1ZEdXF5+T+/2LvfFcn3ogyRvX0=;
  b=f33vBXqaGChhURNq8t6NvWZZMu5jdnRV9UUfYMI2SEdy2bMSryNQo4nK
   whYgLEHvItMsxfV3qtm5MLb5KwH+OilgidSeCrz3PJRiojilJJfBHiLFE
   gAUunxg9p4k4V3OOAnq3+YWCwgBpTScg29ark7FjBLW3lMaxfY/SW1BYK
   HFFp2R9rLObfC1G4akn/nsJjbvhvE26m12LawbLm5dMrfsSIgrWe6Z7VZ
   3BtIAg+OXuthNL5pSwTcQ0AdNtCH+S4LrsHsDhXU9iCd5FQF1uC+OuqzW
   G5pIJIjcFtAEkfPbLn1NGOeCDJ8pmVFMTiZIycB6mBjtRlgZhVBesfvaw
   Q==;
X-CSE-ConnectionGUID: Om2yvLbCQoi7qYKQOWuUXQ==
X-CSE-MsgGUID: yCjwwA2IRlqk8uzZ0Se4uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73746553"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73746553"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 04:46:59 -0800
X-CSE-ConnectionGUID: tk9BI2UETfCo7qkR6kUHHQ==
X-CSE-MsgGUID: k5Z4+kXbQhSzCPsvrLoDvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229046329"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 04:46:56 -0800
Date: Tue, 20 Jan 2026 14:46:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v1 0/4] initramfs: get rid of custom hex2bin()
Message-ID: <aW95Pk3f0GGtyNrY@smile.fi.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260120-umleiten-gehackt-abb27d77dd73@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-umleiten-gehackt-abb27d77dd73@brauner>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-74628-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 04DE252018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:20:41PM +0100, Christian Brauner wrote:
> > Here is the refactoring to show that. This is assumed to go via PRINTK
> > tree.
> 
> No, initramfs is maintained by the VFS and we already carry other patches.

If this applies cleanly, take them through it, I will be glad, thanks!

> If you want the kstrtox changes to go another route then I will take the
> first two changes in a stable branch that can be merged.

I am fine with this route as long as the custom approach is gone.

> > I have tested this on x86, but I believe the same result will be
> > on big-endian CPUs (I deduced that from how strtox() works).
> 
> Did you rerun the kunit tests the original change was part of or did you
> do some custom testing?

I'm not sure I understand the point. There were no test cases added for
simple_strntoul() AFAICS. Did I miss anything?

(If I didn't that is the second point on why the patches didn't get enough
 time for review and not every stakeholder seen them, usually we require
 the test cases for new APIs.)

-- 
With Best Regards,
Andy Shevchenko



