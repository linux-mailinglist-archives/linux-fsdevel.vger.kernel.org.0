Return-Path: <linux-fsdevel+bounces-3763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD237F7A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBA5B21083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDF39FC3;
	Fri, 24 Nov 2023 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5itPRvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452019A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700848282; x=1732384282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=usNefngan+CH7n4eh0VAAgj9P0Yi+vkNmsOTjqq2faM=;
  b=Z5itPRvdl2NcW3dsmZW8jmmSBBXgp5wup1VYHxLRMBNA3NIxgdfct40m
   q+v4f2lo/KFp9gZGj7IHqnbNlmgzdOkZPWXp4U7F+bRzWa5BXdqFO+6OL
   JuRNub65mAI1C8k80mLOk+fkDha88UneRYJ583Kj6SZXBGMzetjtdmEy9
   3ja/erqItXleb8Ge/NpribM0sH6N0h3xGmuSersTKYD8MZT0hp3jbxC7r
   ivTgvsDQNmZtsYR+4XCxEY5Yn0+YPJkZTb8x9dIc4iAl5+4zkiBsrOfVW
   YiAkbLySDC+mXsJPrSZKyU2BMpfVgJ+feo1lJbB3MKeaRT70ehQ1UvTVO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="423589539"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="423589539"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="767540158"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="767540158"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2023 09:51:21 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6aKk-00039M-2q;
	Fri, 24 Nov 2023 17:51:18 +0000
Date: Sat, 25 Nov 2023 01:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.csum-x86 4/18]
 arch/x86/include/asm/checksum_32.h:41:57: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202311250010.dikaDI0D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum-x86
head:   f6c1313680f1d2319d2061c63abeb76f820319b8
commit: 90c2bfd06916ac7c05129b36683bfd3424d8e0e4 [4/18] Fix the csum_and_copy_..._user() idiocy
config: i386-randconfig-061-20231124 (https://download.01.org/0day-ci/archive/20231125/202311250010.dikaDI0D-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250010.dikaDI0D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250010.dikaDI0D-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv4/raw.c: note: in included file (through arch/x86/include/asm/checksum.h, include/net/checksum.h, include/linux/skbuff.h, ...):
>> arch/x86/include/asm/checksum_32.h:41:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     expected restricted __wsum [usertype] v
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     got restricted __wsum_fault
>> arch/x86/include/asm/checksum_32.h:41:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     expected restricted __wsum
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     got restricted __wsum_fault
   net/ipv4/raw.c: note: in included file (through include/linux/skbuff.h, include/linux/pim.h, include/linux/mroute.h):
   include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
   include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
   include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]
--
   net/ipv4/ip_output.c: note: in included file (through arch/x86/include/asm/checksum.h, include/net/checksum.h, include/linux/skbuff.h, ...):
>> arch/x86/include/asm/checksum_32.h:41:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     expected restricted __wsum [usertype] v
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     got restricted __wsum_fault
>> arch/x86/include/asm/checksum_32.h:41:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     expected restricted __wsum
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     got restricted __wsum_fault
   net/ipv4/ip_output.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
   include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
   include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]
--
   net/ipv4/icmp.c: note: in included file (through arch/x86/include/asm/checksum.h, include/net/checksum.h, include/linux/skbuff.h, ...):
>> arch/x86/include/asm/checksum_32.h:41:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     expected restricted __wsum [usertype] v
   arch/x86/include/asm/checksum_32.h:41:57: sparse:     got restricted __wsum_fault
>> arch/x86/include/asm/checksum_32.h:41:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum @@     got restricted __wsum_fault @@
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     expected restricted __wsum
   arch/x86/include/asm/checksum_32.h:41:31: sparse:     got restricted __wsum_fault
   net/ipv4/icmp.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
   include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
   include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]
   net/ipv4/icmp.c: note: in included file (through include/linux/spinlock.h, include/linux/mmzone.h, include/linux/gfp.h, ...):
   include/linux/bottom_half.h:33:30: sparse: sparse: context imbalance in 'icmp_reply' - different lock contexts for basic block
   include/linux/bottom_half.h:33:30: sparse: sparse: context imbalance in '__icmp_send' - different lock contexts for basic block
   net/ipv4/icmp.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:95:59: sparse: sparse: self-comparison always evaluates to false

vim +41 arch/x86/include/asm/checksum_32.h

    31	
    32	/*
    33	 *	Note: when you get a NULL pointer exception here this means someone
    34	 *	passed in an incorrect kernel address to one of these functions.
    35	 *
    36	 *	If you use these functions directly please don't forget the
    37	 *	access_ok().
    38	 */
    39	static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
    40	{
  > 41		return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
    42	}
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

