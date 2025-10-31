Return-Path: <linux-fsdevel+bounces-66646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49FC27368
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 00:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB24D4E864C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EB32E741;
	Fri, 31 Oct 2025 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7ifDlUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA828C035;
	Fri, 31 Oct 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954271; cv=none; b=JDdL8UvQrKq4O13A770Kn8cSq7UmgUurbOLqxysOSfL5F8AHkgDskez8fhNfEzr/zWe4+7KkeuJd2ejwb1OvwczGYrlTnxAJcawH1I3TsFj5elSM4q5MF8jhtrWt0ZJWW+wrBtwftZziozd3KUeyIYP7ATZJnZCG4j5imhqrTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954271; c=relaxed/simple;
	bh=4F4GE8moObfkI4AD5BFSPo4dzBLRFbZyvMAsHUdnGVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeStt3/ADoV0gAtzPGo2zQLy1tiEDztqv4wwtpETjxHCC2Kkf4O48RkPwFByYcOZBWYfwmyXQixkKOtwcF0J8uaGXSTHPU/TCivyrSQs3TRBXyiqver18EkGDuxIliJgAaAwhakEGmg+f5qk5w2cDtiZJa9qTsoPzThQLOIov/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7ifDlUY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761954270; x=1793490270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4F4GE8moObfkI4AD5BFSPo4dzBLRFbZyvMAsHUdnGVM=;
  b=a7ifDlUYBf1OHYXZSFgS+qObNDBfYJc1Y3GXTqB+DktcZBFfKyY0YN2s
   5iFhf5YMXtANTIBeEIxklHmm4RAb+gxpa3aTQHA1wdtm0nBqvm0pJzy8P
   b8WyoGPQyeRAgt7wKWmSIZpy9TMPtlJ3fGbhX9KW95dttTW//1X144Ton
   IZT5D1cGOO5Jw1fRPzNvdZQbCyzP+5KuSQQ/ucg6rjHasmsh5ebjiQr5+
   fd5ctw4stGg6CpfG94v2ePBMffqn8mbXboa8+GeP7a+X3MJkT+TlNdGPB
   URy0+5aT7EpJ6YNl229Y7J+Y+KxbKtAIv2UsatvHlWGJDYuIf9jamG6WD
   g==;
X-CSE-ConnectionGUID: 8KA02W4cRhypH2uV1ASnBg==
X-CSE-MsgGUID: vDG7/FxyS82GhIVjAGItAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63817655"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="63817655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:44:30 -0700
X-CSE-ConnectionGUID: zIh8qu8fTYmFkn99fGJt/w==
X-CSE-MsgGUID: 7kYQG7CdSXOxd/XxiC+U9w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2025 16:44:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEym2-000NjM-2B;
	Fri, 31 Oct 2025 23:43:33 +0000
Date: Sat, 1 Nov 2025 07:41:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, torvalds@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511010704.D6l8wp63-lkp@intel.com>
References: <20251031174220.43458-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031174220.43458-4-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on linus/master brauner-vfs/vfs.all v6.18-rc3 next-20251031]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/x86-fix-access_ok-and-valid_user_address-using-wrong-USER_PTR_MAX-in-modules/20251101-054539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251031174220.43458-4-mjguzik%40gmail.com
patch subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251101/202511010704.D6l8wp63-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010704.D6l8wp63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010704.D6l8wp63-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1016:
   In file included from include/linux/huge_mm.h:7:
>> include/linux/fs.h:54:10: fatal error: 'asm/runtime-const-accessors.h' file not found
      54 | #include <asm/runtime-const-accessors.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/arm/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +54 include/linux/fs.h

    51	
    52	#include <asm/byteorder.h>
    53	#ifndef MODULE
  > 54	#include <asm/runtime-const-accessors.h>
    55	#endif
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

