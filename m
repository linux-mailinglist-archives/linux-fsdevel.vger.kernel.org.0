Return-Path: <linux-fsdevel+bounces-21871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EB90CAAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C44B2D4D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD4D156898;
	Tue, 18 Jun 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQ3+RYHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD715696F;
	Tue, 18 Jun 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708094; cv=none; b=bYvyBHHH0yYZ5sRzVwHnJaiCS5JRZ2HaNDPolgpPxi/8XjCO2y01xMtmJ1wwuckpu08bWvJ3Rq78wNj+x9vbQYXgyAeKemCAeIZoHBVgVACaAajoDk6lhOqpQ6bBYuQFculT5wEhG4d0Rp0bOpKMCmLoAioQ1QdDOVuso7ygx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708094; c=relaxed/simple;
	bh=e2j9tPr71G9COGAqpm4dvPHiyv9zdqsEbZNaiH19Qs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYp400nvUh4FpCkWK6E6yydvkX2drCkkXUzlPHdGIX+u7JzbjwjuntJIfEWQ9JEABIAN+BSIymVq+sOkaCR5AQ1ywQGju/02BUlm32JT5fPZTxt4x3v6Ev2oLi21bEWL4S/T42/WnozOuyZLkMCHI1gFgFYaQLJ7ch9s3OgvZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQ3+RYHf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718708092; x=1750244092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e2j9tPr71G9COGAqpm4dvPHiyv9zdqsEbZNaiH19Qs4=;
  b=mQ3+RYHfUMB+DzSZbQDsgORuIQyeAl94oOIQDhZP/7qjg5MJrJptYLWf
   FVLc+BekcPmzb9hMmzwnZ20JoMNhZN6tUlGwm5MBuf/Xl8L8dX4jMU8M0
   MsDiQ3FZWrSp4OtSE2fpNfh2T2N0RvP64KMjL5OLbhmPFZnssNqZMjCiQ
   ZGZVS+ZQxbTwcqdG/0YhqJAxanX2XBG/Vsd5NVg1kGz002a6SmSsaAo9I
   tP9Hd3Ij/modr7x1hb/ycYspn1jn85zXLD41UR7wKpWicOBtcKiQWxKfd
   GnQcol/WTaMvu/P7l8eQ+tEu12roadqbbViMfvCpUYT1XZ1TyOLBhTYur
   Q==;
X-CSE-ConnectionGUID: kOGoj8nAQgWY28jC/zuPgQ==
X-CSE-MsgGUID: HJSjtFIIRviTunX7Yo5LHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15540296"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15540296"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:54:52 -0700
X-CSE-ConnectionGUID: wupW+ub7TMirTcf+ZbKKwA==
X-CSE-MsgGUID: XlSls2vbRPGIL0IYXbgfQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41464837"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jun 2024 03:54:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJWU9-0005QW-0E;
	Tue, 18 Jun 2024 10:54:45 +0000
Date: Tue, 18 Jun 2024 18:54:30 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
	apais@linux.microsoft.com, ardb@kernel.org, bigeasy@linutronix.de,
	brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, apais@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
Message-ID: <202406181823.dr4ogEY0-lkp@intel.com>
References: <20240617234133.1167523-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617234133.1167523-2-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 831bcbcead6668ebf20b64fdb27518f1362ace3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/binfmt_elf-coredump-Log-the-reason-of-the-failed-core-dumps/20240618-074419
base:   831bcbcead6668ebf20b64fdb27518f1362ace3a
patch link:    https://lore.kernel.org/r/20240617234133.1167523-2-romank%40linux.microsoft.com
patch subject: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed core dumps
config: x86_64-buildonly-randconfig-002-20240618 (https://download.01.org/0day-ci/archive/20240618/202406181823.dr4ogEY0-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181823.dr4ogEY0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406181823.dr4ogEY0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/signal.c:29:
   include/linux/coredump.h: In function 'do_coredump':
>> include/linux/coredump.h:47:1: warning: no return statement in function returning non-void [-Wreturn-type]
    static inline int do_coredump(const kernel_siginfo_t *siginfo) {}
    ^~~~~~


vim +47 include/linux/coredump.h

    34	
    35	/*
    36	 * These are the only things you should do on a core-file: use only these
    37	 * functions to write out all the necessary info.
    38	 */
    39	extern void dump_skip_to(struct coredump_params *cprm, unsigned long to);
    40	extern void dump_skip(struct coredump_params *cprm, size_t nr);
    41	extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
    42	extern int dump_align(struct coredump_params *cprm, int align);
    43	int dump_user_range(struct coredump_params *cprm, unsigned long start,
    44			    unsigned long len);
    45	extern int do_coredump(const kernel_siginfo_t *siginfo);
    46	#else
  > 47	static inline int do_coredump(const kernel_siginfo_t *siginfo) {}
    48	#endif
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

