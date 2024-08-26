Return-Path: <linux-fsdevel+bounces-27132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FDE95EDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F76A1F2196B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41079146A61;
	Mon, 26 Aug 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrDhllmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61F145B39;
	Mon, 26 Aug 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666042; cv=none; b=GwY07sU+TY7cYSmHsPqOpGzCbDdAKaKu+I6xREpi7S72HTbUaZsitWIA3MsbjLCB7+tETOi18vppDOfx1IwESH8nO7NSuuCtWlYl/kL+vy0KM7Lgr6PFa4HIYCAuswrMlNoQA6Mm7gIDpR/7ZPhdti45aCdemCFWUZczXE/WVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666042; c=relaxed/simple;
	bh=vcYdnQgyCRay33ToVuzJbo8c+h90tN2Lwg3BJDUr05I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rImnKq5dzsiuZ6ehFCJT1+WoFABrA56AG8o33Z8kWrXApMM6vozdknL01LPqOy2R5GOIEUxeF5UgNQx+RoATHDh9GsBdNiMwPzt7RQDSoxappCg9zejWsFe/bp5ivajF759H7CIUAfsiYvpe/Rn+S2ylUe/wFtUVauJ6YieqZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrDhllmh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724666040; x=1756202040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vcYdnQgyCRay33ToVuzJbo8c+h90tN2Lwg3BJDUr05I=;
  b=HrDhllmhAcd+BMObqsqqZn/tzxz97/yzvr7f8uD3PFZh04KOXuGVHwEW
   fSV3okNtubrh9GhO64UkWGLnVtXKFeT+NC4wwR6tSzGWcAc0UT7OuQ09A
   qs31MI96+w1c1BzvCFzngY/UHlaMB4TPBE/AWLc3weoay1OozbqsEw6aY
   khDcN4G3NkKcf1UF+ZYTy2uwgiXfr5Z78jgqrByY4RsqiwlqAa6PnaDDA
   iBiUdIwLoZoc3R5X+95ZXB6hEKznvFsDG79a00J4Ks4lYKg/MS3T3hq3x
   /s7chvY60SRvYObNWANmS6PdAZXhyHQwU8qQtNXjrJdyAoLCA0WnS6HlG
   w==;
X-CSE-ConnectionGUID: 3FTmYfuqS16tibRFs4Zq7g==
X-CSE-MsgGUID: Gd1qVGoyT0GIkq6g9B9O1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="48467951"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="48467951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:53:59 -0700
X-CSE-ConnectionGUID: UmlrG8MtTlybU7QDnnFdgA==
X-CSE-MsgGUID: uey+g6LCQp2NzzOVcPT78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93193023"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2024 02:53:53 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siWQ2-000Gql-0l;
	Mon, 26 Aug 2024 09:53:50 +0000
Date: Mon, 26 Aug 2024 17:53:25 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
Message-ID: <202408261757.D4gOewE9-lkp@intel.com>
References: <315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes shuah-kselftest/next shuah-kselftest/fixes crng-random/master linus/master v6.11-rc5 next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/asm-generic-unaligned-h-Extract-common-header-for-vDSO/20240826-103525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
config: x86_64-buildonly-randconfig-002-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261757.D4gOewE9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261757.D4gOewE9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261757.D4gOewE9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/events/page_ref.h:11,
                    from mm/debug_page_ref.c:6:
>> include/trace/events/mmflags.h:168:5: warning: "VM_DROPPABLE" is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |     ^~~~~~~~~~~~
>> include/trace/events/mmflags.h:168:21: warning: "VM_NONE" is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |                     ^~~~~~~
   In file included from include/trace/events/page_ref.h:11,
                    from include/trace/define_trace.h:95,
                    from include/trace/events/page_ref.h:135:
>> include/trace/events/mmflags.h:168:5: warning: "VM_DROPPABLE" is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |     ^~~~~~~~~~~~
>> include/trace/events/mmflags.h:168:21: warning: "VM_NONE" is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |                     ^~~~~~~
   In file included from include/trace/events/page_ref.h:11,
                    from include/trace/trace_events.h:94,
                    from include/trace/define_trace.h:102:
>> include/trace/events/mmflags.h:169: warning: "IF_HAVE_VM_DROPPABLE" redefined
     169 | # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
         | 
   include/trace/events/mmflags.h:171: note: this is the location of the previous definition
     171 | # define IF_HAVE_VM_DROPPABLE(flag, name)
         | 


vim +/VM_DROPPABLE +168 include/trace/events/mmflags.h

   167	
 > 168	#if VM_DROPPABLE != VM_NONE
 > 169	# define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
   170	#else
   171	# define IF_HAVE_VM_DROPPABLE(flag, name)
   172	#endif
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

