Return-Path: <linux-fsdevel+bounces-24455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DE93F922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76242281B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53B156661;
	Mon, 29 Jul 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpd102Md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78015624B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265777; cv=none; b=uTeRWiY6Ww28M8c8nVEnpdD6I+6zlUHzDRU4LnpJ9PeJYIJEdnNzq3hG0OAEKF6lVDvOyv3dAS79scUEwjEd2Cgwn4XgLMVsJJUdH1xcJnCcSBoNl/Yv08+v5sfVDV6APa0huLbl4hpEGqVN70DFsKxBSsxJVeAdABMAlmfz0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265777; c=relaxed/simple;
	bh=CtQSPwdHc3W7zm8H8Hkkt/c8zANMM225OuY4qd31MN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BrM57WptmO6uDwm628bsX7R4WuggDzWYZceXOagb/l0iRJ9JUHqrlMRkAWTekrDRmjjTQjwcf8cOBxqH92cNdJ7aV7TIpkA25xkyheO39+8BOHdg7inljcDRf9bamzfb/MDr+Yl2cE/A/z8ObL6urFdQ0C03XVU7Dq+pQyTZoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpd102Md; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722265775; x=1753801775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CtQSPwdHc3W7zm8H8Hkkt/c8zANMM225OuY4qd31MN8=;
  b=Qpd102Mdh6okg9P+8T6Lj8q2mkAox9KD2GcCsiEu49JqkEVb+2jAf5wt
   eNCezv+r+VPHbWDpvllJLMihUcb2ycNm6BXY2n0I+xgLtkTPHiNKR49Qq
   sC0ynhxyy7b5IgyRKSavnKkLWjkA2L5jqk7JBydGj5tEnFNDgTLCPI8oY
   mBzmCvXtsuG1wUEMbCmyO9lq/+Uow/zfrrarhnKgytCJK0f0i899Oqjec
   0QBBCuLcH/IeZd7bvQGPkf7GGzd5BteWM21G5FiclsoqYBN4KUWLOrtNb
   NsEYq/bslFW09xWq6Le7BJ+Hk8xpMZMVrjt9NSODn++mhrz/ZSNNACGli
   g==;
X-CSE-ConnectionGUID: oFiE8tiZROKkwP8GinEcug==
X-CSE-MsgGUID: TS0kqionRsyuHJvhxpaW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30647991"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="30647991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:07:53 -0700
X-CSE-ConnectionGUID: gShN8NBuSJWYs41yErg+5Q==
X-CSE-MsgGUID: wtL7kPlHQQe2uYAGaeJx3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53972093"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2024 08:07:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYRyW-000rmy-2J;
	Mon, 29 Jul 2024 15:07:48 +0000
Date: Mon, 29 Jul 2024 23:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 28/39]
 arch/powerpc/platforms/cell/spu_syscalls.c:59:1: error: a function
 declaration without a prototype is deprecated in all versions of C
Message-ID: <202407292320.PzZHoHvG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   154eb19a802fdf8629273d414dbeb31eccb61587
commit: a5027b86a79716e98fe0b8e1247743dfb5a5c080 [28/39] switch spufs_calls_{get,put}() to CLASS() use
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240729/202407292320.PzZHoHvG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407292320.PzZHoHvG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407292320.PzZHoHvG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/platforms/cell/spu_syscalls.c:13:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/cell/spu_syscalls.c:59:1: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
      59 | DEFINE_CLASS(spufs_calls, struct spufs_calls *, spufs_calls_put(_T), spufs_calls_get())
         | ^
   include/linux/cleanup.h:111:48: note: expanded from macro 'DEFINE_CLASS'
     111 | static inline _type class_##_name##_constructor(_init_args)             \
         |                                                ^
   5 warnings and 1 error generated.


vim +59 arch/powerpc/platforms/cell/spu_syscalls.c

    58	
  > 59	DEFINE_CLASS(spufs_calls, struct spufs_calls *, spufs_calls_put(_T), spufs_calls_get())
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

