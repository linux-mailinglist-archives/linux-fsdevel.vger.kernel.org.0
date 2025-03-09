Return-Path: <linux-fsdevel+bounces-43547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11729A584EF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 15:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B190E16AD6F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD91DE89D;
	Sun,  9 Mar 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3/ENNus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B81D79BE;
	Sun,  9 Mar 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530732; cv=none; b=UvLhckNpl3rR6FkxePK//713cXpHqZi82CTK/bKKZHDGqzAzSQKppiywh/5qs9n5XUtBp6B7m9umcNBrt4nj0atnH0iiLvpN4yV2WpiGtBlArt8poCyr9cIK6750OkHZLoAW0LndHwsQtt/sYeDyU5BNDRa0beih1/VtIbszdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530732; c=relaxed/simple;
	bh=ZWTyKCgzxgzSSnZYEH9mQTJDvRlV/PPeWnE8ql+GB+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR7qA3kmGlbFHDiL8J656TzShiSnxtVtC1bl4Cly8jfzMWVm3/7VdcqnnPdf6IUfxMQnR2awvmrTJ9SOD87rnJ0uGJHiRe45r0YnawnHDeV28nU4LlKUG/o5oKxfilTadXcqcQRrIvLol/92w8dZL/yDQLcqJwcamHjPqPeGL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3/ENNus; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741530729; x=1773066729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWTyKCgzxgzSSnZYEH9mQTJDvRlV/PPeWnE8ql+GB+Y=;
  b=L3/ENNusB9qZO8NGKxrGpsjiYFbDFspbdBD+H5eMMumSHiDl0h65sumq
   uaiF6T0s7qrJNruIUp8inXH0bYT7z5tPa1gKXA0JBb7JLNNYXCKTV9O8A
   y42jrTfUBpob4BJcq1Ye6h5obATzxAE5+HbEAoGaaF81YYoFAD1YQOKBM
   5Xtw3xZelg87rhAHK0HUbsxDRRTq5ZjHAHYYJ/hP/hdO7k838I26cyeaa
   T+N9tom0GiuCiVcWxALVKqCWZsyEaKH/+i7UGhsqSsiLVKXMmc/Np4rqz
   H2VWdtpjJfxo0xjhY1i/8Y1zdUCFzoVbHCI+yuqW0RFqnkwcMQjR3VXOq
   Q==;
X-CSE-ConnectionGUID: +XuAXZz/QLKE+RnWWWKI5A==
X-CSE-MsgGUID: LbhE7CbxQguP8h6ooFwI1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="59938766"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="59938766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:32:08 -0700
X-CSE-ConnectionGUID: aMco+C0zQ5qpV9QAErOFcw==
X-CSE-MsgGUID: ZxCFfxEnQMevnKssQarnOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123947082"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 09 Mar 2025 07:32:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHhC-0003BM-0K;
	Sun, 09 Mar 2025 14:32:02 +0000
Date: Sun, 9 Mar 2025 22:31:37 +0800
From: kernel test robot <lkp@intel.com>
To: Wen Yang <wen.yang@linux.dev>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Wen Yang <wen.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
	Dylan Yudaken <dylany@fb.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] eventfd: introduce configurable maximum value for
 eventfd
Message-ID: <202503092210.z9CcRYoe-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20250309 (https://download.01.org/0day-ci/archive/20250309/202503092210.z9CcRYoe-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092210.z9CcRYoe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092210.z9CcRYoe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/eventfd.c:251:69: error: use of undeclared identifier 'ucnt'
     251 |         return (ctx->maximum > ctx->count) && (ctx->maximum - ctx->count > ucnt);
         |                                                                            ^
   1 error generated.


vim +/ucnt +251 fs/eventfd.c

   248	
   249	static inline bool eventfd_is_writable(const struct eventfd_ctx *ctx)
   250	{
 > 251		return (ctx->maximum > ctx->count) && (ctx->maximum - ctx->count > ucnt);
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

