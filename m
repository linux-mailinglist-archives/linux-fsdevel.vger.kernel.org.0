Return-Path: <linux-fsdevel+bounces-74736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOZJCL1b2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:35:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DDC4C5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE20558EFAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66B3E9F76;
	Tue, 20 Jan 2026 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lY4euZLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C73DA7C4;
	Tue, 20 Jan 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943883; cv=none; b=D5l3qGEyuoDWt6qw/Nvwnynto+SgmdPv+MFfxTHh99qYJM1xslDGC2Io7RYIAZskYHn61TvI2mA0HNLdtGdrAl/A7/TqZ2UJzmtLBXoCYTEc1b5j1XOrsCopAO9EguGJHozXS6kvYT0oVMoevIcThKkusmp+C95oWKY5aTFpMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943883; c=relaxed/simple;
	bh=8ve3qgALagBaWRTPkEFVGsd1px9eNQ247Cw2MAcC4L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwQvGvvZ0jpnhbq/EDHZHmscFJOMhjGH5oqYaSUG9rddK9/pcbwgiVhZKWWhnGZJf7Hcy5ivBEqrczN9sCynGnFtAz8Zt/5q69uMSj52heFrriKGfzgMXVVpBqT5fAxbW0kcfWCrX1XhjZ4bthEtffVU4HjBjV38ZfXEbJ1pw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lY4euZLm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768943881; x=1800479881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ve3qgALagBaWRTPkEFVGsd1px9eNQ247Cw2MAcC4L0=;
  b=lY4euZLmDuDhjqmBetTIR+rEoYUUYaqedmkuuCAIzAA23doGr423KWKa
   +ZDxBzh5P8TGO2tz+XkdF8pJ3uei5mfUo+DYL9uKmqWvwgRWyDnQf8lrG
   9DDLvByx/mPoeU0ZPQ3qQPkHbbiR+kZmN2xaTZG5KbaimO2EtKaWumgMu
   AKGSktlLOcMVKgI+dhxjOHfMwCqEBNSFhlDg2AUBceB2J+qKq4hcVfcGi
   wXgSjtEUZfATDDUDadW6uLpl1j1oyoEZbXaHYDBYrWQQ/TaXP2aj86UKy
   OsttU5hvcgb1NKlYFu1rdxauJKLjvnzSYIcdJRVrrsvC9kOBbz11Mx3Jr
   w==;
X-CSE-ConnectionGUID: /gfoI7IAQSSpFlRXu+Vzgw==
X-CSE-MsgGUID: hfHSR4ldSGyTmlH7CMZeKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81541351"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81541351"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:18:00 -0800
X-CSE-ConnectionGUID: IkRfyleOQ0WMKRHEauY53Q==
X-CSE-MsgGUID: O2Fe0fx+R5yOCSIy9Q2vng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="237484645"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:17:58 -0800
Date: Tue, 20 Jan 2026 23:17:55 +0200
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
Message-ID: <aW_xA0wbC2bf981d@smile.fi.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
 <20260120230030.5813bfb1.ddiss@suse.de>
 <aW_m5eRzqRJzFWnF@smile.fi.intel.com>
 <20260121080015.6aca8808.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121080015.6aca8808.ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-74736-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 30DDC4C5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:00:15AM +1100, David Disseldorp wrote:
> On Tue, 20 Jan 2026 22:34:45 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 07:12:50AM +1100, David Disseldorp wrote:
> > > On Mon, 19 Jan 2026 21:38:39 +0100, Andy Shevchenko wrote:

...

> > > > +	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
> > > > +	if (ret)
> > > > +		error("damaged header");  
> > > 
> > > The changes look reasonable to me on first glance, but I think we really
> > > should improve the error handling to abort the state machine on
> > > malformed header here.
> > > 
> > > One further issue that we have is simple_strntoul()'s acceptance of
> > > "0x" prefixes for the hex strings - any initramfs which carries such
> > > prefixes will now result in an error.
> > > It's a pretty obscure corner case, but cpio is really easy to generate
> > > from printf(), so maybe there are some images out there which rely on
> > > this.
> > > 
> > > I've written an initramfs_test regression test for the "0x" prefix
> > > handling. I'll send it to the list.  
> > 
> > Is it specified?
> > 
> > The standard refers to octal numbers, we seem to use hexadecimal.
> > I don't believe the 0x will ever appear here.
> > 
> > Otherwise, please point out to the specifications.
> 
> The kernel initramfs specification is at
> Documentation/driver-api/early-userspace/buffer-format.rst :

Thanks!

>   The structure of the cpio_header is as follows (all fields contain
>   hexadecimal ASCII numbers fully padded with '0' on the left to the
>   full width of the field, for example, the integer 4780 is represented
>   by the ASCII string "000012ac"):
>   ...
> 
> I.e. a "0x" isn't specified as valid prefix. I don't feel strongly
> regarding diverging from existing behaviour,

> but it should still be
> considered (and documented) as a potentially user-visible regression.

I disagree, this is not specified and should not be used. The CPIO archive in
the original form doesn't specify leading 0 for octals (at least how I read it,
please correct me, if I'm wrong).

https://pubs.opengroup.org/onlinepubs/007908799/xcu/pax.html

-- 
With Best Regards,
Andy Shevchenko



