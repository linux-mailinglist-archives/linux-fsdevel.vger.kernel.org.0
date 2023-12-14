Return-Path: <linux-fsdevel+bounces-6032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A2812495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153CC1C2120F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C87EE;
	Thu, 14 Dec 2023 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZ9Mk6WZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FAA93
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 17:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702517231; x=1734053231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q2fXPl3j3g6lldgwaMkUzDf7HyUzXycR4rdwlV4eNMY=;
  b=CZ9Mk6WZAehlUUHGu6jaTEX5qrx1F89JUilsLZ7z6AroZJzIjUTbmSGB
   IXaAdIJ9bxYzO6RsoJjrhkZjxtIIeBEHJx3Dlm+HR/2W5xYJuMCB9qSoF
   nuk2CIIDUjm2+kLH1rqwzktbUomeGTOD/s9pQx+WBudavwKcucR3obsuD
   2E0qHgQVRa6PNF/ReFO7u9w1YRn6USYyH/l/XIGSgVWwwfHOYcp1qE3Z1
   7wsYsTjOM0Kfr8SI6xpmc+aSNjZOU3692w/a5rfip+Pn6TjVnuwkEOLzn
   Hzm7vC7FBXDwSZmP1EH/lHVrdbryL9lAoekgr+WNaxH6nFYBZK5tMMilj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="385469156"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="385469156"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="840097706"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="840097706"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2023 17:26:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDaUt-000LNh-2X;
	Thu, 14 Dec 2023 01:26:54 +0000
Date: Thu, 14 Dec 2023 09:25:30 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:headers.unaligned 2/2] include/linux/unaligned.h:119:16:
 sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <202312140955.cqLj4SLn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git headers.unaligned
head:   959598f725aa7721a4bad53c2e997c7255ff32dc
commit: 959598f725aa7721a4bad53c2e997c7255ff32dc [2/2] move asm/unaligned.h to linux/unaligned.h
config: x86_64-randconfig-123-20231214 (https://download.01.org/0day-ci/archive/20231214/202312140955.cqLj4SLn-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140955.cqLj4SLn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140955.cqLj4SLn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file:
>> include/linux/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
>> include/linux/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
>> include/linux/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
>> include/linux/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)

vim +119 include/linux/unaligned.h

803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  116  
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  118  {
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08 @119  	*p++ = val;
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08 @120  	*p++ = val >> 8;
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  122  }
803f4e1eab7a89 include/asm-generic/unaligned.h Arnd Bergmann 2021-05-08  123  

:::::: The code at line 119 was first introduced by commit
:::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

