Return-Path: <linux-fsdevel+bounces-74743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HFeNSQIcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:56:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E24D568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A500DA2F017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE13AA190;
	Tue, 20 Jan 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3cbBynI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE343A4F4D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947521; cv=none; b=V2l/R0dN9H0btJYO/N2O1bkQimhvrqgi1YlRNcmqoSD5E9yVydKrYdoqDMnWoHm2LP45iYqxxS2KZDqNXeMTNq4Ki+7QyEtHKPZiT6mQWLy1X7pAjzyl4m8TYb59lTmmXv4LOEXAV1xOq8js0RaEtaXxqgN0JW0rRm+qq3sjwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947521; c=relaxed/simple;
	bh=7QgFvnHViuhT+CPQJ3L1dTOkNwBjZTgO0YkGzg7NGbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFV6yvZR6w8ahMkXBHgN8lBtSz/I0lSkfj7gl/0KXVI5idLytWO0PMhpb2Br2RgSoZ7SYnjc7HClq11+Ib8EDEfCjINxQ8TnB2aAZKq3YUGRkO/36gwsDs56UUiq7hYzDxUQg8OJpHuW19aR9zFZrH3C05q9L6Cxd+cY8XuTniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3cbBynI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768947517; x=1800483517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7QgFvnHViuhT+CPQJ3L1dTOkNwBjZTgO0YkGzg7NGbo=;
  b=N3cbBynI2/bNrvLu0s1UtD04pok4RmJopgCwQY3HhbFZQgybOy6W18/y
   UDSjemx+GiYK4BBumT94rNfI8Q6eCOFiXquhG/9EEIa7uYSRH0QCSxQ7w
   BKCWas1/9NJySh5WdPYqHbt9O685hYdMHhMsn6LyEg/YwMe0dLBrZCSBg
   6o0/y54v5lnFDP6BNQ6QGqisvYxH/rZhtOsW8VTl1I/gdHz1ROiVty7kT
   dfj2y1VSEVx1iJcUSX7/qYOKqzm/ik8RHH9SLwHlx5plnmGtbu7xSMnP5
   blZ0dPWq1qRPzRN0lyEQSCIr/kjT04TTK3AOVQjdSdRH24blU7TuhALPW
   A==;
X-CSE-ConnectionGUID: Kcs2RNhPSDGVyGVCF6eE/g==
X-CSE-MsgGUID: MoCa9bhGS+aH65GfGKGRPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57731359"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="57731359"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:18:34 -0800
X-CSE-ConnectionGUID: +idwEvY4Tt6PBE8SFtb1eA==
X-CSE-MsgGUID: phGnrTrjRK6JFRsXmt3QIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206295042"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:18:34 -0800
Date: Wed, 21 Jan 2026 00:18:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] initramfs_test: test header fields with 0x hex prefix
Message-ID: <aW__NwDBkzq_bePk@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
 <20260120204715.14529-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120204715.14529-3-ddiss@suse.de>
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
	TAGGED_FROM(0.00)[bounces-74743-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 276E24D568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:32:33AM +1100, David Disseldorp wrote:
> cpio header fields are 8-byte hex strings, but one "interesting"
> side-effect of our historic simple_str[n]toul() use means that a "0x"
> prefixed header field will be successfully processed when coupled
> alongside a 6-byte hex remainder string.

Should mention that this is against specifications.

> Test for this corner case by injecting "0x" prefixes into the uid, gid
> and namesize cpio header fields. Confirm that init_stat() returns
> matching uid and gid values.

This is should be considered as an invalid case and I don't believe
we ever had that bad header somewhere. The specification is clear
that the number has to be filled with '0' to the most significant
byte until all 8 positions are filled.

If any test case like this appears it should not be fatal.

-- 
With Best Regards,
Andy Shevchenko



