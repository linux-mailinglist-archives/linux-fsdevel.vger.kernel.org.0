Return-Path: <linux-fsdevel+bounces-3762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B57F7A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D76E281598
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B639FC3;
	Fri, 24 Nov 2023 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SR34irpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545E171D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700848277; x=1732384277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1gOSGqHr2oFSCkFY/LYbsCiRzMT+F9vwSVPP7+cOIJM=;
  b=SR34irpSwZ7Sj3TETGLkHUbv5i0voGj+8vE8fjA5Z1Ho9nZe7LAV5WJG
   v8xGNiTlRgNvvc7gPI14gbreIdZAf1/qgbJ7Mo23CwMtd2noGj0eHUtO3
   SxHmhhgFWjFywMxshHkpYCMxlvxyzkdTke5u9jNyD0VmMvSjNicrNqJyv
   NJoesaEBIRSMhs2Erj97MGHOTE8I0lliOi/qif9BjdPp+OO9DkabaZJHR
   nE1imgay0ye5SQUf1yKaCH11JdK7ym1KZ1vSSE0V3NKJsLujLbrUbAS9B
   8aP2kSqnUb+OPg59Cg+oLyuW+2XRVFqa6c3QmsyT5DRkfZid+Mvl51LRc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382853554"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382853554"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="761011124"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="761011124"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2023 09:51:15 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6aKf-00039H-1X;
	Fri, 24 Nov 2023 17:51:13 +0000
Date: Sat, 25 Nov 2023 01:50:33 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.csum-x86 4/18] net/core/datagram.c:745:55: sparse:
 sparse: incorrect type in argument 1 (different base types)
Message-ID: <202311250023.ySjyjo9L-lkp@intel.com>
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
config: x86_64-randconfig-123-20231124 (https://download.01.org/0day-ci/archive/20231125/202311250023.ySjyjo9L-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250023.ySjyjo9L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250023.ySjyjo9L-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/datagram.c:745:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault [usertype] next @@
   net/core/datagram.c:745:55: sparse:     expected restricted __wsum [usertype] v
   net/core/datagram.c:745:55: sparse:     got restricted __wsum_fault [usertype] next
>> net/core/datagram.c:745:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] csum2 @@     got restricted __wsum_fault @@
   net/core/datagram.c:745:54: sparse:     expected restricted __wsum [usertype] csum2
   net/core/datagram.c:745:54: sparse:     got restricted __wsum_fault
   net/core/datagram.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
   include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
   include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]
--
>> net/core/skbuff.c:6971:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] v @@     got restricted __wsum_fault [usertype] next @@
   net/core/skbuff.c:6971:55: sparse:     expected restricted __wsum [usertype] v
   net/core/skbuff.c:6971:55: sparse:     got restricted __wsum_fault [usertype] next
>> net/core/skbuff.c:6971:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] csum2 @@     got restricted __wsum_fault @@
   net/core/skbuff.c:6971:54: sparse:     expected restricted __wsum [usertype] csum2
   net/core/skbuff.c:6971:54: sparse:     got restricted __wsum_fault
   net/core/skbuff.c: note: in included file (through include/net/net_namespace.h, include/linux/inet.h):
   include/linux/skbuff.h:2703:28: sparse: sparse: self-comparison always evaluates to false
   net/core/skbuff.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:36:17: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __wsum_fault @@     got restricted __wsum [usertype] @@
   include/net/checksum.h:36:17: sparse:     expected restricted __wsum_fault
   include/net/checksum.h:36:17: sparse:     got restricted __wsum [usertype]

vim +745 net/core/datagram.c

   737	
   738	static __always_inline
   739	size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
   740				      size_t len, void *from, void *priv2)
   741	{
   742		__wsum *csum = priv2;
   743		__wsum_fault next = csum_and_copy_to_user(from + progress, iter_to, len);
   744	
 > 745		*csum = csum_block_add(*csum, from_wsum_fault(next), progress);
   746		return !wsum_is_fault(next) ? 0 : len;
   747	}
   748	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

