Return-Path: <linux-fsdevel+bounces-74880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEMTKLcRcWlEcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:49:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EE5ABEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAD06508423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D449550C;
	Wed, 21 Jan 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNZqq5X7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A4495503
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013047; cv=none; b=GUtY3qMBlQxkHuEtg1yQv1Zl6weCImYCPD7oTFAK4eFn+w5J5owEc2Sx0jCVQrGK969Nmux291JkA6uiH2/gCDip4/BGtHm74ObvqSWWoZwhYalocDQxhayta8w/tDQ6MbeQj5G2cybGfuPAJ0pW0las6R2ixnW/1LtsHp4TNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013047; c=relaxed/simple;
	bh=W7Zu0PnTuLRBAozsYxYe5Hg7VKxLQ9M7sbpOyn4RmMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCqvRa0BbrWTsEvqjmfSEsgmk5vFzjgVW+Y/O/dxSJ/mEqkCQzRL7DKLhCU31UvOdVXdZB14o2t6UHaJsQLKzx7yXkuxX3y4sRxIse+qEUGh/f5bVgJg29GQIO+KJbcXvWMIdxJWne0d0F/mwZYmNJs54piAMK31Z0YaoMJx3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNZqq5X7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769013046; x=1800549046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7Zu0PnTuLRBAozsYxYe5Hg7VKxLQ9M7sbpOyn4RmMQ=;
  b=WNZqq5X78iOztvPZVd8+7s95WkNfqQ7Svar38ejMrA257fVRu0Zjw1/I
   FQaQBFIHbI2KCd4bxdZ9U1ZyBIBxEMgGBA58wB04H4zx5W6/AV4xwUpcE
   DfHDcjt0fiCNdu9v7S6hmOj7F8q1cultnFyTb2CjU7An7pHrCWpScDFtq
   npn6jy2oCsIKMwgwjO/QD4MNAEcSnkM1TqjA1zD0dGpbusgDCCAz7VlSk
   wgtVeKHQFSNsUWBxjwizPJsphfmw0RFANDuK6+TWgQDuDLElkk6BN1MFs
   asSUBd3/wvzji1TNDPNKQsf7RqqdYEQxQCno4b8+iH1VVkos6IYTP8h8E
   g==;
X-CSE-ConnectionGUID: 2paRhTPsSOalNZC0Or8PVQ==
X-CSE-MsgGUID: F04kcPHJRw2WFm0slM0HTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80547322"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80547322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:30:38 -0800
X-CSE-ConnectionGUID: eqQqczg1RouwDlmtojD5+A==
X-CSE-MsgGUID: EDbtCJZhTyi03Ib/fkB24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206092817"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:30:34 -0800
Date: Wed, 21 Jan 2026 18:30:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] initramfs_test: test header fields with 0x hex prefix
Message-ID: <aXD_KOVfZigByV5n@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
 <20260120204715.14529-3-ddiss@suse.de>
 <aW__NwDBkzq_bePk@smile.fi.intel.com>
 <20260121201936.0580e4de.ddiss@suse.de>
 <aXDRithD3DsGiXBc@smile.fi.intel.com>
 <20260122031702.5e2e73c8.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122031702.5e2e73c8.ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-74880-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3D5EE5ABEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 22, 2026 at 03:17:02AM +1100, David Disseldorp wrote:
> On Wed, 21 Jan 2026 15:15:54 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 08:42:05PM +1100, David Disseldorp wrote:
> > > On Wed, 21 Jan 2026 00:18:31 +0200, Andy Shevchenko wrote:  
> > > > On Wed, Jan 21, 2026 at 07:32:33AM +1100, David Disseldorp wrote:  
> > > > > cpio header fields are 8-byte hex strings, but one "interesting"
> > > > > side-effect of our historic simple_str[n]toul() use means that a "0x"
> > > > > prefixed header field will be successfully processed when coupled
> > > > > alongside a 6-byte hex remainder string.    
> > > > 
> > > > Should mention that this is against specifications.
> 
> I've added this and will send as v2.

Thanks!

> > > > > Test for this corner case by injecting "0x" prefixes into the uid, gid
> > > > > and namesize cpio header fields. Confirm that init_stat() returns
> > > > > matching uid and gid values.    
> > > > 
> > > > This is should be considered as an invalid case and I don't believe
> > > > we ever had that bad header somewhere. The specification is clear
> > > > that the number has to be filled with '0' to the most significant
> > > > byte until all 8 positions are filled.
> > > > 
> > > > If any test case like this appears it should not be fatal.  
> > > 
> > > Yes, the test case can easily be changed to expect an unpack_to_rootfs()
> > > error (or dropped completely). The purpose is just to ensure that the
> > > user visible change is a concious decision rather than an undocumented
> > > side effect.  
> > 
> > Can you say this clearly in the commit message? With that done I will have
> > no objections as it seems we all agree with the possible breakage of this
> > "feature" (implementation detail).
> 
> Sure, I think it'd make sense to put the v2 test patches as 1/2 in your
> series such that your subsequent hex2bin() patch modifies the test to
> expect error. E.g.

Yes! Thanks for providing a PoC. Maybe you can do it as a formal patch that
I can simply take into my next version?

-- 
With Best Regards,
Andy Shevchenko



