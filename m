Return-Path: <linux-fsdevel+bounces-50857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10914AD0670
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE97516D819
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622A289820;
	Fri,  6 Jun 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUI86Mlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D528540B;
	Fri,  6 Jun 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226209; cv=none; b=ACrP+aRZ5h/OuSMteK6a60Npxcz9XzSGPIl9Hjl3ranCRbN/YidZOfEyxGcl636Qoy6GNL7fRV0zdtrgTbIq3WnNTe+aPAxHIYzKpy56rkl8aGyiP+uSuj5+eDkc6ZWjtuU4w4AQaVZQCsO9jQ3DkZHKLuugw/aJaWxTC6+DpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226209; c=relaxed/simple;
	bh=+IX4WKBZZKukb5l31BrwLrifavSSKeTEFgSJhIO2aPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANII8rMjBhf3KN2OVKakR8LP7NLcl61efaffkGz5WskCj1G6e7hT7dMDMYCHYk5c9mAMrEC79aiQo9HP0lOM+EQ+2lqFor+1KEiMyofXxPsquLQny+AIjOT2uAl9l8Es1NfzRSvs+IsLXgMHtcniw9KLXkoh5C4nrStxO49dhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUI86Mlg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749226207; x=1780762207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IX4WKBZZKukb5l31BrwLrifavSSKeTEFgSJhIO2aPo=;
  b=WUI86MlgIgMVk1BknhGdq//F+O+VPlhooHMZb6m7EJ6twl1ICg9rLP1H
   +Jg0VG9zIe6p2Ft9QsJtIBbq6sK2Ws89+9/Ah1ZhWW0dQv06aOjgRth5S
   k/Pwi+w4OosX1xdVBt8cpCDYCKgTkokik4SivGGN7kRTR2x2Wu1+aFje5
   GM8Wa6/Z3S0zE6XmS++GcfbTRJWfkYfwC60EpYYWFELGbKI9nOUgUPWbD
   yAM5+GcgSWwa9BzSnnZPggd/G2Gdc3Er0UCpW46+qmAGVxb8UN9mSs+SC
   1uwIm9V33D8NZZHsW8jCZPvf3pSBoFlHWj6S4p3ieMyJ0+FbYlKLh7/Dt
   w==;
X-CSE-ConnectionGUID: 69Uz32lHSWW61d6+jnMi1w==
X-CSE-MsgGUID: iAUI6EraQLGf/9rFrw2rQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="76777635"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="76777635"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:10:07 -0700
X-CSE-ConnectionGUID: nyWXBveVRTC3UmUgbte1Lg==
X-CSE-MsgGUID: JZH4q7TNQBStGKrcbMx7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="145798292"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2025 09:10:02 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNZdo-00056d-2U;
	Fri, 06 Jun 2025 16:10:00 +0000
Date: Sat, 7 Jun 2025 00:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH] locking: detect spin_lock_irq() call with disabled
 interrupts
Message-ID: <202506062318.7g54PAh3-lkp@intel.com>
References: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>

Hi Pavel,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on sysctl/sysctl-next akpm-mm/mm-nonmm-unstable tip/master linus/master v6.15 next-20250606]
[cannot apply to mcgrof/sysctl-next tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/locking-detect-spin_lock_irq-call-with-disabled-interrupts/20250606-175911
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250606095741.46775-1-ptikhomirov%40virtuozzo.com
patch subject: [PATCH] locking: detect spin_lock_irq() call with disabled interrupts
config: riscv-randconfig-002-20250606 (https://download.01.org/0day-ci/archive/20250606/202506062318.7g54PAh3-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506062318.7g54PAh3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506062318.7g54PAh3-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:8:
>> include/linux/spinlock.h:375:1: warning: data definition has no type or storage class
    DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
    ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock.h:375:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
>> include/linux/spinlock.h:376:5: warning: parameter names (without types) in function declaration
        debug_spin_lock_irq_with_disabled_interrupts);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h: In function 'spin_lock_irq':
>> include/linux/spinlock.h:382:6: error: implicit declaration of function 'static_branch_unlikely' [-Werror=implicit-function-declaration]
     if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
         ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock.h:382:30: error: 'debug_spin_lock_irq_with_disabled_interrupts' undeclared (first use in this function)
     if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:382:30: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/spinlock.h:384:4: error: implicit declaration of function 'static_branch_disable'; did you mean 'stack_trace_save'? [-Werror=implicit-function-declaration]
       static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
       ^~~~~~~~~~~~~~~~~~~~~
       stack_trace_save
   include/linux/spinlock.h: In function 'spin_unlock_irq':
   include/linux/spinlock.h:415:30: error: 'debug_spin_lock_irq_with_disabled_interrupts' undeclared (first use in this function)
     if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:98: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=2202685202
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1275: prepare0] Error 2 shuffle=2202685202
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2202685202
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2202685202
   make: Target 'prepare' not remade because of errors.


vim +375 include/linux/spinlock.h

   373	
   374	#ifdef CONFIG_DEBUG_SPINLOCK
 > 375	DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
 > 376				 debug_spin_lock_irq_with_disabled_interrupts);
   377	#endif
   378	
   379	static __always_inline void spin_lock_irq(spinlock_t *lock)
   380	{
   381	#ifdef CONFIG_DEBUG_SPINLOCK
 > 382		if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
   383			if (raw_irqs_disabled()) {
 > 384				static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
   385				WARN(1, "spin_lock_irq() called with irqs disabled!\n");
   386			}
   387		}
   388	#endif
   389		raw_spin_lock_irq(&lock->rlock);
   390	}
   391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

