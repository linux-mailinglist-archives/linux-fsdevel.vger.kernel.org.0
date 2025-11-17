Return-Path: <linux-fsdevel+bounces-68737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B97C6496C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0E20345ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B60245012;
	Mon, 17 Nov 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxgnXrRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681539463;
	Mon, 17 Nov 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388490; cv=none; b=kfRvngYCEUfilbYsM6qX7zWxJuei4wtxBrPyL2I7AMFsUpcgqJbMzp6lachfFsqmBNst4ZScdOWEwRKChfFNSxJzsNjyDR7Yz1rPdUqcBYo2elDCgnG9iyJ4BJfBTyRMJhWcBL/OTgdj8bv2GmM2a2mXdJ+/elKlL9PZFyrpW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388490; c=relaxed/simple;
	bh=M26THjNlfMkmKsBJemZjpNdpo8Lu0cMCPqCNMjiXeRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/MDxbdRmSa0IWw/Y81cv5+SLZ1oum0BcLoOEuNUSbxlHhMEJJSaCF/u2GCHPVJP0X/Jkq3qniYvQeym3gYRs5bHZm/jAAHWN9x3O24l+iR1cCpWul4mP2JNILoUumc8MJdKgOmA3OGhiyPdp2O9nPaFsMaWQnEiU04ijJiRvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxgnXrRQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763388488; x=1794924488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M26THjNlfMkmKsBJemZjpNdpo8Lu0cMCPqCNMjiXeRk=;
  b=YxgnXrRQhFySOT/DD3g26fmMlttjs++ygrx8R6k4SaS7ynj9fBvhYq1G
   /5PYI4WBOfffa5b0YxngsJGknrBgQU/5RmNvkSiHlQd6DfwT/Ik1Po/vV
   iB2f19bSxUr0Ki2Jswk/rg6QiCiZUXhfM9bLlA401yC8K4vQZcUXadOuI
   NNGuhZ8ZbEv6wh8sG1XB121wzBwPwtVN24EFTsl731eQNVoXZZGaC7Gw2
   JUlmcaaP/Zknbs4bngHyA3W8LcFSvKk1VYtGaZ801qavopEqGjDO6hhrU
   x20q7gJcguVGOpiXhN4SLdiJhJSKnUN+ysIdD0CBuif2W6v1Boue6ELhC
   w==;
X-CSE-ConnectionGUID: 4oeALRBlQPqtxdwaoyt0+w==
X-CSE-MsgGUID: zUzbK076TxGvsG5eXzHWGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65322071"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65322071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:08:08 -0800
X-CSE-ConnectionGUID: jG+3AP1pSB6SC8XgN/SNxA==
X-CSE-MsgGUID: oQ5qCuP6RLeT91PmOAQ5zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="221353846"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 06:08:05 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKztj-0000dT-0Z;
	Mon, 17 Nov 2025 14:08:03 +0000
Date: Mon, 17 Nov 2025 22:07:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH v2 2/3] sysctl: add support for drop_caches for
 individual filesystem
Message-ID: <202511172149.q8geOAvk-lkp@intel.com>
References: <20251117112735.4170831-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117112735.4170831-3-yebin@huaweicloud.com>

Hi Ye,

kernel test robot noticed the following build errors:

[auto build test ERROR on viro-vfs/for-next]
[also build test ERROR on linus/master brauner-vfs/vfs.all v6.18-rc6 next-20251117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/vfs-introduce-reclaim_icache_sb-and-reclaim_dcache_sb-helper/20251117-193502
base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
patch link:    https://lore.kernel.org/r/20251117112735.4170831-3-yebin%40huaweicloud.com
patch subject: [PATCH v2 2/3] sysctl: add support for drop_caches for individual filesystem
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251117/202511172149.q8geOAvk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511172149.q8geOAvk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511172149.q8geOAvk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/drop_caches.c:108:8: error: call to undeclared function 'task_stack_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     108 |                                                  current_pt_regs(),
         |                                                  ^
   include/linux/ptrace.h:389:27: note: expanded from macro 'current_pt_regs'
     389 | #define current_pt_regs() task_pt_regs(current)
         |                           ^
   arch/x86/include/asm/processor.h:650:39: note: expanded from macro 'task_pt_regs'
     650 |         unsigned long __ptr = (unsigned long)task_stack_page(task);     \
         |                                              ^
   fs/drop_caches.c:119:37: error: call to undeclared function 'task_stack_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     119 |                 syscall_set_return_value(current, current_pt_regs(), 0,
         |                                                   ^
   include/linux/ptrace.h:389:27: note: expanded from macro 'current_pt_regs'
     389 | #define current_pt_regs() task_pt_regs(current)
         |                           ^
   arch/x86/include/asm/processor.h:650:39: note: expanded from macro 'task_pt_regs'
     650 |         unsigned long __ptr = (unsigned long)task_stack_page(task);     \
         |                                              ^
   2 errors generated.


vim +/task_stack_page +108 fs/drop_caches.c

    91	
    92	static void drop_fs_caches(struct callback_head *twork)
    93	{
    94		int ret;
    95		struct super_block *sb;
    96		static bool suppress;
    97		struct drop_fs_caches_work *work = container_of(twork,
    98				struct drop_fs_caches_work, task_work);
    99		unsigned int ctl = work->ctl;
   100		dev_t dev = work->dev;
   101	
   102		if (work->path) {
   103			struct path path;
   104	
   105			ret = kern_path(work->path, LOOKUP_FOLLOW, &path);
   106			if (ret) {
   107				syscall_set_return_value(current,
 > 108							 current_pt_regs(),
   109							 0, ret);
   110				goto out;
   111			}
   112			dev = path.dentry->d_sb->s_dev;
   113			/* Make this file's dentry and inode recyclable */
   114			path_put(&path);
   115		}
   116	
   117		sb = user_get_super(dev, false);
   118		if (!sb) {
   119			syscall_set_return_value(current, current_pt_regs(), 0,
   120						 -EINVAL);
   121			goto out;
   122		}
   123	
   124		if (ctl & BIT(0)) {
   125			lru_add_drain_all();
   126			drop_pagecache_sb(sb, NULL);
   127			count_vm_event(DROP_PAGECACHE);
   128		}
   129	
   130		if (ctl & BIT(1)) {
   131			reclaim_dcache_sb(sb);
   132			reclaim_icache_sb(sb);
   133			count_vm_event(DROP_SLAB);
   134		}
   135	
   136		if (!READ_ONCE(suppress)) {
   137			pr_info("%s (%d): %s: %d %u:%u\n", current->comm,
   138				task_pid_nr(current), __func__, ctl,
   139				MAJOR(sb->s_dev), MINOR(sb->s_dev));
   140	
   141			if (ctl & BIT(2))
   142				WRITE_ONCE(suppress, true);
   143		}
   144	
   145		drop_super(sb);
   146	out:
   147		kfree(work->path);
   148		kfree(work);
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

