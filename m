Return-Path: <linux-fsdevel+bounces-71724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C045DCCF6C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 11:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A1E430215CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C372FFFB2;
	Fri, 19 Dec 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNc8DKvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB52FCBE1;
	Fri, 19 Dec 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140828; cv=none; b=PQUaOFIBxdSeWwF3Q1yuWcxChYujDpfGRvRJX9p8spJ9sbyEPQ1jv0/qJVWCAA6mlokTjHJLPg2N9N9fj+6BOLDuG1nADmzZFKpvL8h5n+BZrnOsKFk4eDlhrNQWg6aovFS81tRkYSKFO438wmeUskMAFv4PUMsVYnFboXMMTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140828; c=relaxed/simple;
	bh=8BY7MsSbnsn71LnSp65tqphE9Qb5MZ8K8yUt3zCJG6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6Vdn9K90fMhxdGTX3+1ni3zzjnEqdw2rY6Sg3w0SQpPMEBUNKoW+KJqURTZ/24zYKMWsMsbyk/OLxvCU8vGEpywZpvyX1JNWPz7dRBLhz5SRStFU8/qeI3EPiyTSTkOIKe9jV5doRALjzk9m/aIrJS/AwRE6zy7TvAOfXimqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNc8DKvY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766140825; x=1797676825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BY7MsSbnsn71LnSp65tqphE9Qb5MZ8K8yUt3zCJG6I=;
  b=JNc8DKvYtswISbrVr3naeeb1KoTTe15DQsZT+6sFqTOwytR0AqRzbRir
   1qfc1Pz7OpC4KGwgi2eNQWLlTsD4MdVtZvBHLiCFNtN5vomPa6l44UWWt
   fjxyw2eBCFzTC8umEeMWwA0i54le848nfb6PYFPOWhA1/W/q8FQyX4hmu
   C4U6MsepndhQ5STf8mCvI4cqhW+d3xppYCrvfwnBtbady4LzcoSL1KP/L
   hrfaIm5cz9Hmm7uEB6sCSP7TJsfmAjRZTHEzpHNGpb+i1mwbBjcjhD5/q
   Yo61d1ywugzik3Vax5R4hRko9XHPF6FZptn9+nuBiXDeC6jWP3ZGal203
   A==;
X-CSE-ConnectionGUID: ZS2quqtpTTO3DsjK3Lqc3w==
X-CSE-MsgGUID: x7W8Pz9/SaCDJlXkvZaTBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="85686270"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="85686270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 02:40:23 -0800
X-CSE-ConnectionGUID: BJoADojUTFqzr1CRVdRDqA==
X-CSE-MsgGUID: hfdY2f+FTYmnTZ6hDRnlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198895633"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.226])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 02:40:21 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 032B9120EC2;
	Fri, 19 Dec 2025 12:40:19 +0200 (EET)
Date: Fri, 19 Dec 2025 12:40:19 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] media: mc: fix potential use-after-free in
 media_request_alloc()
Message-ID: <aUUrk8v5s8SM_Thg@kekkonen.localdomain>
References: <20251209210903.603958-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209210903.603958-1-minipli@grsecurity.net>

Hi Mathias,

On Tue, Dec 09, 2025 at 10:09:03PM +0100, Mathias Krause wrote:
> Commit 6f504cbf108a ("media: convert media_request_alloc() to
> FD_PREPARE()") moved the call to fd_install() (now hidden in
> fd_publish()) before the snprintf(), making the later write to
> potentially already freed memory, as userland is free to call
> close() concurrently right after the call to fd_install() which
> may end up in the request_fops.release() handler freeing 'req'.
> 
> Fixes: 6f504cbf108a ("media: convert media_request_alloc() to FD_PREPARE()")
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

