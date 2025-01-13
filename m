Return-Path: <linux-fsdevel+bounces-39040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4AA0B912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406A41636DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FC23ED67;
	Mon, 13 Jan 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjXWoaR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922323ED46;
	Mon, 13 Jan 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777266; cv=none; b=E9Fl/y02giKxnUbjie1BC9PPgPUCz1DUVULyoxNeBVh1YU8iAbGgoeCj7WAnK4sAtuI0JO3AiA3BvlWitzKyuwKWsC4v8C5KaY6H9zTDbsmvKM0pgbc/ee2not51K6q6sP7wJEhnmXprogPgVs6Q6UOgEswBPLE7UrrGr5ZFQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777266; c=relaxed/simple;
	bh=Daub8vm06w8IcRjMHeGOmiLMe3eJdiQxwNfwcfeWF2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ4l2xwi3JLfM2nrmlWK5kDZz5mdy19lveCDbTVztgOy5wRSaWYHz24EN4GcPvCTvGSiqsEdykOsyw2BH9j5ZsrPHDcqZFdt2pk6PK56RzCE+2DX9/7dTSjk5EkyrzSvCtPJZhkB+AwFOOk2iS17UZYS2x9WIWuooERCdk69uuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjXWoaR/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736777265; x=1768313265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Daub8vm06w8IcRjMHeGOmiLMe3eJdiQxwNfwcfeWF2w=;
  b=YjXWoaR/IaixGY0iaFhHTb0olwgMbN0/nslSs80kZL9j8wpB2niYmHWA
   eznc/NIZGof8U+axe0vzUrPfT6l1j9FbYzqyd2fQ3uj1byJ51nmZcCgXZ
   7tFqC/qpRhEjFOx9veu3pMIDTpx+IjVibP0A5dSehnW4zZZa6eU/1CAGM
   /67oOP2kut3ht3iUVgqMibT+1LaeWgfU9m9iGbl1rSAprwk3ftJNhcIVK
   8u+U8FejDDh+5UyWXGbIr5kkrjdk0RKcQu5mobuFBFi4JcF77LUC2k4OK
   wf/XrX2Nko+6muHWMMa93xlS8B5hiUI+Ngk/conpsoRTxwdnsB/k28CuW
   g==;
X-CSE-ConnectionGUID: T9QudyzLRRSQSFmYRUawmQ==
X-CSE-MsgGUID: pe66AlJoQ/q5JtaGQG0BUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40980047"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40980047"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:07:37 -0800
X-CSE-ConnectionGUID: ubPh+2y6SDe1z80joJq8Kg==
X-CSE-MsgGUID: asJbCXYfTLCwN1vcFS+m3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104448520"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 13 Jan 2025 06:07:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DA7883B7; Mon, 13 Jan 2025 16:07:28 +0200 (EET)
Date: Mon, 13 Jan 2025 16:07:28 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Remove PG_reclaim
Message-ID: <v7on5acvkgseggdrhgicq3slzecnnfdknvm3s4ohblaazhfdui@y2pdupkfe2cw>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <Z4UZDAWj_8Ez-vN-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UZDAWj_8Ez-vN-@casper.infradead.org>

On Mon, Jan 13, 2025 at 01:45:48PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 13, 2025 at 11:34:45AM +0200, Kirill A. Shutemov wrote:
> > Use PG_dropbehind instead of PG_reclaim and remove PG_reclaim.
> 
> I was hoping we'd end up with the name PG_reclaim instead of the name
> PG_dropbehind.  PG_reclaim is a better name for this functionality.

I got burned by re-using the name with MAX_ORDER redefinition.
I guess it is less risky as it is less used, but still...

Anyway, it can be done with a patch on top of the patchset. We must get
rid of current PG_reclaim first.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

