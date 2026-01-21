Return-Path: <linux-fsdevel+bounces-74857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBd+ApfZcGnCaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:50:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F0457EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A73A702732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940C4418ED;
	Wed, 21 Jan 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWaFja05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35423F23CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001360; cv=none; b=h3xmlwLpF0TlBsxBwraINQlXXg3nAQB+bDELn/npquQikpgT97fzMIQYPMHoI+UvANUcEMAPWQKwqRE0xNVpxYXGFxapBj6PlXGCvKcrIWDAK6osApwPAiSnpESlknIpMEDaTFj0m0Z9rYXUXClfkW5kkG08ygU/WUtli1dN3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001360; c=relaxed/simple;
	bh=dewnZVijgSiohMkRiALOtaHkBQpUO6NYQRyzB0tx2J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2qIUvQDd/d5rBGqAcEULY/0i6R65MDCMc42pG4etyLfFY58RYVKKHsCLUpRBy006xIuMWDvIgBG3tnva5oa57Typ/AhrNJFqzxhggwEGhZQycd1DJyz3A/21r9tZnAisKw0YPf0erVcyH9ZQuGFAf9gPoeXO586sNYQzlSNvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWaFja05; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001359; x=1800537359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dewnZVijgSiohMkRiALOtaHkBQpUO6NYQRyzB0tx2J8=;
  b=YWaFja05fffy28uGqrxXJmhBu5SXHdwldNEQkQdqpIug+0LILohWXwSh
   Abz8SBu0JGpk7mrQ7CJCgucSKNGaZJAVtadL4WPdNEz85E0/pamdu0rOk
   nIZ0DyR7X1W4yf+cWglgSjAj0rqWUU733D8PKjU08K62ptKxfcXa7VC0f
   PZCjvsvkvrC3qEMaJWEPuM+ENgPOXL6IjSRcpGtB7K3f2pr9cJuihCTrl
   QRKP/miEwRTBx8LHSoRXtf78ZLWRNyRYg07EZC/37BGVeCVEITAth9RjS
   v19ZPg6OWnxGUCcpB+Z9CwXJmpu4QKp6/MJQO6f42e+ZbEwoI0VUoQL3w
   w==;
X-CSE-ConnectionGUID: 1Dv3xAoFR02jXQdOM4rRIg==
X-CSE-MsgGUID: /IockckRQjOZHDJbmU6SKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80854191"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80854191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:15:58 -0800
X-CSE-ConnectionGUID: 4sjXPOaIQdu5qHxaCXH5zQ==
X-CSE-MsgGUID: 0/5bYefbSwCyyP/Ii6Dl5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206360265"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:15:56 -0800
Date: Wed, 21 Jan 2026 15:15:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] initramfs_test: test header fields with 0x hex prefix
Message-ID: <aXDRithD3DsGiXBc@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
 <20260120204715.14529-3-ddiss@suse.de>
 <aW__NwDBkzq_bePk@smile.fi.intel.com>
 <20260121201936.0580e4de.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121201936.0580e4de.ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-74857-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 76F0457EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:42:05PM +1100, David Disseldorp wrote:
> On Wed, 21 Jan 2026 00:18:31 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 07:32:33AM +1100, David Disseldorp wrote:
> > > cpio header fields are 8-byte hex strings, but one "interesting"
> > > side-effect of our historic simple_str[n]toul() use means that a "0x"
> > > prefixed header field will be successfully processed when coupled
> > > alongside a 6-byte hex remainder string.  
> > 
> > Should mention that this is against specifications.
> > 
> > > Test for this corner case by injecting "0x" prefixes into the uid, gid
> > > and namesize cpio header fields. Confirm that init_stat() returns
> > > matching uid and gid values.  
> > 
> > This is should be considered as an invalid case and I don't believe
> > we ever had that bad header somewhere. The specification is clear
> > that the number has to be filled with '0' to the most significant
> > byte until all 8 positions are filled.
> > 
> > If any test case like this appears it should not be fatal.
> 
> Yes, the test case can easily be changed to expect an unpack_to_rootfs()
> error (or dropped completely). The purpose is just to ensure that the
> user visible change is a concious decision rather than an undocumented
> side effect.

Can you say this clearly in the commit message? With that done I will have
no objections as it seems we all agree with the possible breakage of this
"feature" (implementation detail).

-- 
With Best Regards,
Andy Shevchenko



