Return-Path: <linux-fsdevel+bounces-74858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ/eJhvacGnCaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:52:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1745857F01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0279670D4DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724B32D0FD;
	Wed, 21 Jan 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8oGaAd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1923183F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001477; cv=none; b=UV7elaR+cf3o0cq+9cHbyXPRSS2IwT7MXfeWW9nAGSxfshMKQH+8g/tBaRV2wXOnGQrwhy3/tKJ632S3D1yU5S90/c8FeDPm8fD+npvvWvm3dxQQciBaNmAt1+YB7TyzgdJbU3Olze+dqMZU2zPimw07QvCQ/KkxHMWe0SYAAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001477; c=relaxed/simple;
	bh=Y3X1XhjiVRFOfiPrJwgH21byS/ipzBUTl66x8Y1vzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cknp4Bo839KhqLzGtVLK9wzG66nsr01QKiiJpTA/F2IdblfGrVlOGf/jexIcKgqwqSXJF2EMEgi8TJzccDU1YGp/H0eP0ed0UHBsMPL/owCt2X+55XrAMc0a8ajuEMyBPjaMDiNxQuouyfjGMtViSfX3HYTYRMX1B1oOt1fuox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8oGaAd9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001476; x=1800537476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3X1XhjiVRFOfiPrJwgH21byS/ipzBUTl66x8Y1vzFI=;
  b=P8oGaAd9SHSVnYpsZlTJ/Qc2oC63TxEeOLWZYvMbZgFW84h1POkkXO1C
   ghkDlDlNSEFDjbcfb57JVys+Sr0q7tBbaqCKwrCsuHJ/dDvYk9B8prWQf
   fTNK+E7FIIoYMfz1/2blzZztqZ7sT9SXwYYlFPNFynpOpPZfy3Vs51092
   3FK9+feDIgjagbG7SxvqxDVzh/+ouzw6yfwArWT1xBbPUh2vahm81RLB+
   IV1e7boQY//JYU+b6oen6/bwG8CDKEmPrBx6jkVGH64CaTKPmL99fH7HM
   Xc+bt4m5GXcjC/zwnExHLGcCwpmpj3f7Mlaztg8+SjMaQ2Zsf5MI/WVEV
   g==;
X-CSE-ConnectionGUID: CIWQ0NIPTsG98TTSkHvffw==
X-CSE-MsgGUID: gP0msyhpTiqmg6+UHaD2Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69952070"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69952070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:17:55 -0800
X-CSE-ConnectionGUID: eBPUADYtRL+V3dJzwob1Bw==
X-CSE-MsgGUID: TWWLheAVSGKdRtn+Vq8nJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210953911"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:17:55 -0800
Date: Wed, 21 Jan 2026 15:17:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] initramfs_test: add fill_cpio() format parameter
Message-ID: <aXDR_9_r6wBpYvjS@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
 <20260120204715.14529-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120204715.14529-2-ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-74858-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,smile.fi.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 1745857F01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:32:32AM +1100, David Disseldorp wrote:
> fill_cpio() uses sprintf() to write out the in-memory cpio archive from
> an array of struct initramfs_test_cpio. This change allows callers to
> override the cpio sprintf() format string so that future tests can
> intentionally corrupt the header with non-hex values.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Assuming we agreed with the fact that the followed user is non-standard
and against the current specifications and may be changed in the future.

-- 
With Best Regards,
Andy Shevchenko



