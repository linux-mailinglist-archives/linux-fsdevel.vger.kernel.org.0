Return-Path: <linux-fsdevel+bounces-74724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI/VCpb0b2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:33:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C74C525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0B9AA60B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF343AEF4A;
	Tue, 20 Jan 2026 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPjdOkVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9513AEF32;
	Tue, 20 Jan 2026 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941294; cv=none; b=BisqYDiTuN3iIE7ZMziD2a86kxf1y+mSVZ8gFU4QkYNpLbrRxmv1eu2GJQnY8x69uXzq5tADuDC9iAGCFZcpMYr+cor+HsPN/mjTcwlxtV0U27j94Lb1M7LWsL/pDdQwHSsQNxHTiSgr1VVFSHi0S6euQU8/2CAQbGGlZajxXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941294; c=relaxed/simple;
	bh=4iKz264BRql5CZson6CYwYFb1MyGRDfwFsmje3H4jfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwB6Q7tHbf/lbWZZwtUxyLEFPF1lnAgjHCAy3TaRTdnONT2FLtmSYI2jbNxGlppratW38OFLT8hTwTL9tNriBTuif/sMjzkS2VgfLr/w0e8qfJQVM2LTNLBp8R7QVOktMnVmfh0gedNAlYtHzv2tJHcoVaQ3NkpTlZ9BHzAMD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPjdOkVL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768941292; x=1800477292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4iKz264BRql5CZson6CYwYFb1MyGRDfwFsmje3H4jfA=;
  b=WPjdOkVLC0aPiwziE+U8O31MjbMo8ZDP7S48LfMZ2LYj2FgQvY6oA+wL
   9HTPCju0d8AFsMZAbI+QXgfA1kFWjFi8mcLI9nvLt82kdK3joDX7d16vw
   /1ms2e1OdiO6eJb00MN0FpyweM++cK1niAESQ8Ftqm2f1/RCdg2aFpW5O
   Hw2XP2Vzif1RJPqyiHZ74umWLH+hbzVq6CDgVlidjt9OhG0KgpNIhMG9U
   ECVvexNsvN5sDz1sr6CK1AU6t1ZwT0zMmkM/50ZcW2GxYeK7aPzSPiTWe
   oXf3tCKc+GzsgGDNokhGMjCZOStyqYPRiZN0eqJk2eeRBWDV/y2nAkFQS
   g==;
X-CSE-ConnectionGUID: tALJLO0dTZeXnQ7FxBokWw==
X-CSE-MsgGUID: oaQ6VbVTQvWPgyeoThqBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74015863"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="74015863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 12:34:51 -0800
X-CSE-ConnectionGUID: zFn94Ul7R1uFwOHzo6bLwA==
X-CSE-MsgGUID: 9UzYljz/R1+gguBsjlA2zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210674806"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 12:34:48 -0800
Date: Tue, 20 Jan 2026 22:34:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/4] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <aW_m5eRzqRJzFWnF@smile.fi.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
 <20260120230030.5813bfb1.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120230030.5813bfb1.ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-74724-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 896C74C525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:12:50AM +1100, David Disseldorp wrote:
> On Mon, 19 Jan 2026 21:38:39 +0100, Andy Shevchenko wrote:
> 
> > +	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
> > +	if (ret)
> > +		error("damaged header");
> 
> The changes look reasonable to me on first glance, but I think we really
> should improve the error handling to abort the state machine on
> malformed header here.
> 
> One further issue that we have is simple_strntoul()'s acceptance of
> "0x" prefixes for the hex strings - any initramfs which carries such
> prefixes will now result in an error.
> It's a pretty obscure corner case, but cpio is really easy to generate
> from printf(), so maybe there are some images out there which rely on
> this.
> 
> I've written an initramfs_test regression test for the "0x" prefix
> handling. I'll send it to the list.

Is it specified?

The standard refers to octal numbers, we seem to use hexadecimal.
I don't believe the 0x will ever appear here.

Otherwise, please point out to the specifications.

-- 
With Best Regards,
Andy Shevchenko



