Return-Path: <linux-fsdevel+bounces-57205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E79B1F8CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 09:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C0F16E783
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9E2367C5;
	Sun, 10 Aug 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFPtZAip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186D23371B;
	Sun, 10 Aug 2025 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810471; cv=none; b=l67kgiVviwPe2eU0AnfWGaAl3JfPauPM2KXe+/Xfhmo/C0V/wvgxlWT571asqViKqOWO9yfq4zMJSywxDwYxjNH527J6ioMTgeWY1XE4N5PqnyrbltGIfuR0rLkGjFVTwz8/It6aBxYcXmYNAOYQtosDegpgVj38ZtEcrX8vsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810471; c=relaxed/simple;
	bh=viZgYnXspg3PkW4FdhPt00V+Jwof3yfbXCGtUIORUQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxr3736w8QvlUBt9ULkvQ9ue8xyKOGX8vvv94BAXGxB/Usyy6l1sjAHJGrReZDotCWsoSuuB34S7WKnGwTXag4AIF9a7iSGb2DMJDlJE1xS9EpWfIawaGd2n6mJBpiQvf6Ek0QHKWcvjuINBx22KFdajcy6ssoaliCDld1y/LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFPtZAip; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754810469; x=1786346469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=viZgYnXspg3PkW4FdhPt00V+Jwof3yfbXCGtUIORUQU=;
  b=BFPtZAipHhZ7jl/B+BpJ27Cn7GsrPezCnBKr1KtaNUh5Jzg3QbMVCan0
   yWFk8p49c/UylcRcZLQ/vlO3xNFdxHlj2rAoxOC+576TTPjVrwbx2Hb2k
   rgWOajo0/okZKNL5fLvLPvEMzxuem7+r5i8spR6jUaQYWejUZrnR591PC
   OJ97Swt2nI4EGrifzm7MZK2n5+dYId0flb1tR8EMvLNqx69e84iLWtyal
   RIukgEm9IrLcNZ5iI91n30Ov4MH3jAq8/QjfZZI+Y0IaleTlUvgHGzlzs
   osOhBleWrX86sMrVEfHh/+DQtBkN0CjZdIauiXxNqmTLTnY96991aWNXc
   Q==;
X-CSE-ConnectionGUID: Vne9u/adTnWqHnlAZvCOCw==
X-CSE-MsgGUID: DLvPQlrbTnybaJxsBy4rzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="60725832"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60725832"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 00:21:02 -0700
X-CSE-ConnectionGUID: +4rPBRM2RvWwtFFnsyt9dw==
X-CSE-MsgGUID: peQcAeyxT1O7Awq3gY0fpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166064655"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Aug 2025 00:20:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ul0MR-0005Ca-2t;
	Sun, 10 Aug 2025 07:20:55 +0000
Date: Sun, 10 Aug 2025 15:20:54 +0800
From: kernel test robot <lkp@intel.com>
To: alexjlzheng@gmail.com, brauner@kernel.org, djwong@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
Message-ID: <202508101424.M8eWrUjI-lkp@intel.com>
References: <20250810044806.3433783-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810044806.3433783-2-alexjlzheng@tencent.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.16 next-20250808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alexjlzheng-gmail-com/iomap-make-sure-iomap_adjust_read_range-are-aligned-with-block_size/20250810-125014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250810044806.3433783-2-alexjlzheng%40tencent.com
patch subject: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20250810/202508101424.M8eWrUjI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508101424.M8eWrUjI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508101424.M8eWrUjI-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/iomap/buffered-io.o: in function `iomap_adjust_read_range':
>> buffered-io.c:(.text+0xa8a): undefined reference to `__moddi3'
>> m68k-linux-ld: buffered-io.c:(.text+0xaa8): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

