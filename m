Return-Path: <linux-fsdevel+bounces-66644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F43C272FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 00:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACC724E8336
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19532C950;
	Fri, 31 Oct 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZmjR12q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86A2EFD92;
	Fri, 31 Oct 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953531; cv=none; b=dMi6AMroHfYxYqVEXS7wXKW+Zyx4v1UuZQPrHbow+f0XfymNsXPykzed9ska8oEuFAq5XG/+3GUNvdRDzDl8IPDS13wV3yOLfcaXD8E5tTzX0mmpKYOeRqmER6bKMxBmBYROspJOMma/U+hfm05+dCMW6dkRAx9X1QePFcBSwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953531; c=relaxed/simple;
	bh=h+r0tqFwhhtjNk7d58FTTkux3ySidbSHA65iwckG4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqI0R0dqWhxRJmTs6DEOp5Bi0SsxAH4eP+SPUvYenW5ap0/Pg8bswVB77QD5VvI1ZE1/HNbYTsrxjrYYfew2MNiAeMwMHnO1NbXgYcYspyTw/HQUkgFNDwszVgbCQXnFgzWLEo2GwNjKs1fWGVZ+e3Kv5Nhm1MphH02rD3AE/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZmjR12q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761953530; x=1793489530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h+r0tqFwhhtjNk7d58FTTkux3ySidbSHA65iwckG4zY=;
  b=OZmjR12q/3j4bWzWVTzMSXKEdCVgF9lHX8t3LUtTpCNTGX7l+HCbbmwM
   ++M5FVL53LNOv61iPqJ3kFUMbfz684TCUEY0mxWKGSdFLRPUcZ76lmADu
   MacQSr/LNw/9N6mXsGtpp8+n94Giltnq8PeLxzykVsahxmh1Ow80/ATYy
   VAK47shw/5in5t6zYsP4wimRLcOa0Xw+FgrDzZ8+P0358+CTTIVS5Dg7A
   UGZp1vyqcm5Nq9PEQB/5rfqBCFLU+iDNqn6v8+2SSahljKW+SvRQESVQq
   lE4Dncc5P9nLkz22lWEWgvDc5Sm/vKG9SOStIL+4+/kz2f4MMvj9J68hU
   A==;
X-CSE-ConnectionGUID: u27puJaOTOW+Aoa6zKTbhw==
X-CSE-MsgGUID: njfkjZegTKC89lYefjH7tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63140428"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="63140428"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:32:09 -0700
X-CSE-ConnectionGUID: 2PAsw1AfSUqU0iBpZvJi8Q==
X-CSE-MsgGUID: zUGAZRtjTl2DJjLHGudMnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186686652"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 31 Oct 2025 16:32:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEyaU-000Nii-0P;
	Fri, 31 Oct 2025 23:31:58 +0000
Date: Sat, 1 Nov 2025 07:30:11 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, torvalds@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511010731.B5nbGjbm-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on linus/master brauner-vfs/vfs.all v6.18-rc3 next-20251031]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/x86-fix-access_ok-and-valid_user_address-using-wrong-USER_PTR_MAX-in-modules/20251101-054539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251031174220.43458-4-mjguzik%40gmail.com
patch subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20251101/202511010731.B5nbGjbm-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010731.B5nbGjbm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010731.B5nbGjbm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/dcache.c:38:
   In file included from ./arch/um/include/generated/asm/runtime-const.h:1:
>> include/asm-generic/runtime-const.h:11:9: warning: 'runtime_const_ptr' macro redefined [-Wmacro-redefined]
      11 | #define runtime_const_ptr(sym) (sym)
         |         ^
   arch/x86/include/asm/runtime-const-accessors.h:21:9: note: previous definition is here
      21 | #define runtime_const_ptr(sym) ({                               \
         |         ^
   In file included from fs/dcache.c:38:
   In file included from ./arch/um/include/generated/asm/runtime-const.h:1:
>> include/asm-generic/runtime-const.h:12:9: warning: 'runtime_const_shift_right_32' macro redefined [-Wmacro-redefined]
      12 | #define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
         |         ^
   arch/x86/include/asm/runtime-const-accessors.h:35:9: note: previous definition is here
      35 | #define runtime_const_shift_right_32(val, sym) ({               \
         |         ^
   2 warnings generated.


vim +/runtime_const_ptr +11 include/asm-generic/runtime-const.h

e78298556ee5d8 Linus Torvalds 2024-06-04   4  
e78298556ee5d8 Linus Torvalds 2024-06-04   5  /*
e78298556ee5d8 Linus Torvalds 2024-06-04   6   * This is the fallback for when the architecture doesn't
e78298556ee5d8 Linus Torvalds 2024-06-04   7   * support the runtime const operations.
e78298556ee5d8 Linus Torvalds 2024-06-04   8   *
e78298556ee5d8 Linus Torvalds 2024-06-04   9   * We just use the actual symbols as-is.
e78298556ee5d8 Linus Torvalds 2024-06-04  10   */
e78298556ee5d8 Linus Torvalds 2024-06-04 @11  #define runtime_const_ptr(sym) (sym)
e78298556ee5d8 Linus Torvalds 2024-06-04 @12  #define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
e78298556ee5d8 Linus Torvalds 2024-06-04  13  #define runtime_const_init(type,sym) do { } while (0)
e78298556ee5d8 Linus Torvalds 2024-06-04  14  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

