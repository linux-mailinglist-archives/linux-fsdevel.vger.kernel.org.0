Return-Path: <linux-fsdevel+bounces-57424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FDB21500
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9924610D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C64A2E2DF0;
	Mon, 11 Aug 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnnj7TI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915C72600;
	Mon, 11 Aug 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938620; cv=none; b=kDN58pbFM48wD6WFVXCb9dGfyYX5GTAGWLOGFuO3nBpRPTq5O3hjSgpV8w4VAtKVsEVXGqlzeYHOiI93Ty6gkFtiG67TEcZn8YhAUw68Cylck/weQPS965r17aHVz5Rpx7iMyWrQK35WoKV0O6dEfKGi59xjKB67lh4AORrrrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938620; c=relaxed/simple;
	bh=/1h1FXQ8wlbSgFHXbQzagekP6WBsykBAbMExF88232A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8kdyZtotZhaNpaVc6UvjFN2dqzgn0PXkO2Z3BOAOSbpE4nXrgGOG3GozpvkaTpV+cXh5FJuVLtbLAAE/zov2I52N4fZ9Rs87HgArJYwCg1/dxgTvpXgTab31W5f7XeywycUWqTzqZN2JmUGkmIABFu7PKpnjQSyRtOnnFdW9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnnj7TI2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754938619; x=1786474619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1h1FXQ8wlbSgFHXbQzagekP6WBsykBAbMExF88232A=;
  b=Pnnj7TI22M/wvUQDA78sBsJeug6tdbnzc6tMcoEMXCDeXuZ+/1PX66TL
   nt95+jNkA1Cpq9bO3VPBo8c6nSHglAJfv9ynUxQ2x0SL+lGfZeH1+ClFZ
   WH1Y+mJEuF+AVYPA94khQZJSKKDHdj42M+3Z+gHdhHFBYQTLfNYzch+zA
   lL7GsI2mjIHmk3Gk8ItKBa1ZGF48M5dQt3sNCryzJebeaEC10dYrs9ld9
   CQNDL6WG0bIY4JQ0pEk+tv69Xwwr4CytfMXEE0gDjbE0KgPAI7fW0WFUU
   gMSKZ6INDw43vm6bl8Hy8G6GX2Ljik8ejShDnWjNaHGD9yJJPbLzyhhAF
   Q==;
X-CSE-ConnectionGUID: Je30W+SHQEu6DShDcy1vkQ==
X-CSE-MsgGUID: GMyWzhJfQsC7si7eDViI3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57344995"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57344995"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:56:58 -0700
X-CSE-ConnectionGUID: vpWZx5ZjTIuthikuHuwiLg==
X-CSE-MsgGUID: gJZTJWVSR5qvoV1h6E7NgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165192786"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 11:56:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulXhL-00069Y-0y;
	Mon, 11 Aug 2025 18:56:44 +0000
Date: Tue, 12 Aug 2025 02:55:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <202508120250.Eooq2ydr-lkp@intel.com>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>

Hi Dominique,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Dominique-Martinet-via-B4-Relay/iov_iter-iterate_folioq-fix-handling-of-offset-folio-size/20250811-154319
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250811-iot_iter_folio-v1-1-d9c223adf93c%40codewreck.org
patch subject: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >= folio size
config: i386-buildonly-randconfig-002-20250811 (https://download.01.org/0day-ci/archive/20250812/202508120250.Eooq2ydr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508120250.Eooq2ydr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508120250.Eooq2ydr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/iov_iter.c:14:
>> include/linux/iov_iter.h:171:7: warning: variable 'remain' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     171 |                 if (skip >= fsize)
         |                     ^~~~~~~~~~~~~
   include/linux/iov_iter.h:190:7: note: uninitialized use occurs here
     190 |                 if (remain)
         |                     ^~~~~~
   include/linux/iov_iter.h:171:3: note: remove the 'if' if its condition is always false
     171 |                 if (skip >= fsize)
         |                 ^~~~~~~~~~~~~~~~~~
     172 |                         goto next;
         |                         ~~~~~~~~~
   include/linux/iov_iter.h:163:22: note: initialize the variable 'remain' to silence this warning
     163 |                 size_t part, remain, consumed;
         |                                    ^
         |                                     = 0
   1 warning generated.


vim +171 include/linux/iov_iter.h

   143	
   144	/*
   145	 * Handle ITER_FOLIOQ.
   146	 */
   147	static __always_inline
   148	size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
   149			      iov_step_f step)
   150	{
   151		const struct folio_queue *folioq = iter->folioq;
   152		unsigned int slot = iter->folioq_slot;
   153		size_t progress = 0, skip = iter->iov_offset;
   154	
   155		if (slot == folioq_nr_slots(folioq)) {
   156			/* The iterator may have been extended. */
   157			folioq = folioq->next;
   158			slot = 0;
   159		}
   160	
   161		do {
   162			struct folio *folio = folioq_folio(folioq, slot);
   163			size_t part, remain, consumed;
   164			size_t fsize;
   165			void *base;
   166	
   167			if (!folio)
   168				break;
   169	
   170			fsize = folioq_folio_size(folioq, slot);
 > 171			if (skip >= fsize)
   172				goto next;
   173			base = kmap_local_folio(folio, skip);
   174			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
   175			remain = step(base, progress, part, priv, priv2);
   176			kunmap_local(base);
   177			consumed = part - remain;
   178			len -= consumed;
   179			progress += consumed;
   180			skip += consumed;
   181			if (skip >= fsize) {
   182	next:
   183				skip = 0;
   184				slot++;
   185				if (slot == folioq_nr_slots(folioq) && folioq->next) {
   186					folioq = folioq->next;
   187					slot = 0;
   188				}
   189			}
   190			if (remain)
   191				break;
   192		} while (len);
   193	
   194		iter->folioq_slot = slot;
   195		iter->folioq = folioq;
   196		iter->iov_offset = skip;
   197		iter->count -= progress;
   198		return progress;
   199	}
   200	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

