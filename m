Return-Path: <linux-fsdevel+bounces-43546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320FA584EE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106447A5A2D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3D1DE3D7;
	Sun,  9 Mar 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHjvrWCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424E1805A;
	Sun,  9 Mar 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530729; cv=none; b=OiZKP/TOYRHraSx7HHB591OH3qikWErULBNUUEGlbWiwsrsgRU0YNjwZuNbwLCnW9ILpsXhUHV1OJeTk6ufg6RQAo3BSSr67ErJTIxQ5zPlBXGJ4E7rJYPjfW2ZpIhMdF4cW5uSZxDkyg4NVqx3N6wvxeHqpNfAPijsnfT95QYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530729; c=relaxed/simple;
	bh=Ti2DMm80WbUBc2ExKC60hjSqeSo8ZUKPZArTIBKllvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMsaVkOMT/tM2RUsa7lQd5jmE/ywJB2ZiKRzVZEVQPURax26865KnJWPzlIQ+mxoqdYvAXNrgycviQn6xacB5i3m30fXdR8bXtVp4yzE2B6tsl4IDGJcbmuT/Ga4vo7GxwghtE/sGQ+sTReyefqYEsj+0+P1CQbvwaLj9PGqC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHjvrWCX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741530728; x=1773066728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ti2DMm80WbUBc2ExKC60hjSqeSo8ZUKPZArTIBKllvM=;
  b=jHjvrWCX7YZcP8qK22L9nMqPgT01dmelLG5sbI8cXdPlVuQDVW56XTfO
   T1r9FrsA6PYAAo0L2Q8hwgP4QfQUZ2Vke4gsT5ygtTMc6+T7O0VMW6ILE
   RpRsO1kuWwI/oCBI4JZRRrRc4uI2P+Yib6VTDJQUigTS5WH+hrcMczYgY
   z39FdBrv+0mKrcKQrFczUryKV7vZl1cg0fADEi2Au0pIH3BFKmazsjHJU
   uR49OC9aWil+ee26XpXrLkbyn0WYg6wA2thvfWFSmz86lAYvqTl0kKbRq
   Tt22ebZ3TcbQSs+7TjHu2UV+BAhDN4WZOUeImDyCuht1q9w9cCrH1QoVm
   A==;
X-CSE-ConnectionGUID: PxQ9WBlmTM++MXuCi+HSqw==
X-CSE-MsgGUID: cdeqYLIbRRqL4diCajqp6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="59938760"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="59938760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:32:07 -0700
X-CSE-ConnectionGUID: XYtqj3AOTVOMo3vKUN0AcQ==
X-CSE-MsgGUID: RTmPoT6TTX68oHd4+7DbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123947083"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 09 Mar 2025 07:32:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHhC-0003BO-0O;
	Sun, 09 Mar 2025 14:32:02 +0000
Date: Sun, 9 Mar 2025 22:31:38 +0800
From: kernel test robot <lkp@intel.com>
To: Wen Yang <wen.yang@linux.dev>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Wen Yang <wen.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, Dylan Yudaken <dylany@fb.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] eventfd: introduce configurable maximum value for
 eventfd
Message-ID: <202503092223.G4FJDVsM-lkp@intel.com>
References: <20250309055003.32194-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309055003.32194-1-wen.yang@linux.dev>

Hi Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Yang/eventfd-introduce-configurable-maximum-value-for-eventfd/20250309-135152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250309055003.32194-1-wen.yang%40linux.dev
patch subject: [PATCH v3] eventfd: introduce configurable maximum value for eventfd
config: i386-buildonly-randconfig-003-20250309 (https://download.01.org/0day-ci/archive/20250309/202503092223.G4FJDVsM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092223.G4FJDVsM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092223.G4FJDVsM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/eventfd.c: In function 'eventfd_is_writable':
>> fs/eventfd.c:251:76: error: 'ucnt' undeclared (first use in this function); did you mean 'uint'?
     251 |         return (ctx->maximum > ctx->count) && (ctx->maximum - ctx->count > ucnt);
         |                                                                            ^~~~
         |                                                                            uint
   fs/eventfd.c:251:76: note: each undeclared identifier is reported only once for each function it appears in
>> fs/eventfd.c:252:1: warning: control reaches end of non-void function [-Wreturn-type]
     252 | }
         | ^


vim +251 fs/eventfd.c

   248	
   249	static inline bool eventfd_is_writable(const struct eventfd_ctx *ctx)
   250	{
 > 251		return (ctx->maximum > ctx->count) && (ctx->maximum - ctx->count > ucnt);
 > 252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

