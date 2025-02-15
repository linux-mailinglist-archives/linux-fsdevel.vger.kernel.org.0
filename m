Return-Path: <linux-fsdevel+bounces-41772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F61A36C94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51E03B176D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8419CC36;
	Sat, 15 Feb 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaQJLhRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D318B484;
	Sat, 15 Feb 2025 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607021; cv=none; b=kAP6kjMWhrH1EP9kQrvz2K6+14o/US1ihqXl8grzlVaLyO0EeJMZDu/haAEYLFyKRsKMyXoBiCZWdWg5epLg0me40G6wmNYxyXtSUmKJzLncsjv1H+9tGVA2yDRo7Y3xEP0sf18UeVE6OiwhVKfXYwo6L7Zx6AaVq3/ClWOg3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607021; c=relaxed/simple;
	bh=8Z1xP31hwmqaAUASq29l4vz+9GKnK9tTM4TAZIAgEjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnOCA4KGn7S/rZowDqQAJcxJD6t2qvVEFpWNAUaIkO/yBnCc6feoiccvi1b/AXQ2EnWj1vVoCUaXuslBgvGg3d8DPUkbCEe0JKA71Twfe2wWIIq4lF/R6uYBWAIu2obelPEz9K0b+EaPHVMlz+pvz3AKG3FY2UpA39Z0HgE4Qyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaQJLhRL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739607019; x=1771143019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Z1xP31hwmqaAUASq29l4vz+9GKnK9tTM4TAZIAgEjQ=;
  b=CaQJLhRLwBMYUbFt8GQXz+aEdq+wzHxM485Ojc6D7HUqrJgjQO+ONHHA
   X9XBRHyBnxRfNV5Z6opbttNtO4yLdrfPusW4JaBdXNTFLnLMynzvXrcEt
   E+L/jA+xLHuOwsF6stIfnbFJfHioJjVQ17L+bJFCDgGT4f1uRQ8hEvYKh
   qvJ0R6FlyM7+o+EOSX+rJb8fdSDbKP8jejIt4LIU3SVW7dqfeEHSXUqlS
   Xtr/lYfdE1PBq2hSGZPpFRwzzvLvpRL4cxSaztmEDJHYCOW62yrEvqb8d
   doSNC4PPvbsBseRy5k0ZUYIYiAsKZ0VkaknkMbSqD2BnRZRJ76QHxVRCW
   w==;
X-CSE-ConnectionGUID: qdOo8fNXRNCCBjFtBu6KcA==
X-CSE-MsgGUID: TYJoTJ73THOOO/7C9Yd0Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40064499"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="40064499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 00:10:18 -0800
X-CSE-ConnectionGUID: bewlr2URSS6r3bJaAzTbLA==
X-CSE-MsgGUID: fd0/3d0CTemnZX0S3D0SMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150825252"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Feb 2025 00:10:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjDFd-001AcR-0H;
	Sat, 15 Feb 2025 08:10:13 +0000
Date: Sat, 15 Feb 2025 16:09:31 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <202502151519.0MA7hz8D-lkp@intel.com>
References: <20250214052204.3105610-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214052204.3105610-2-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus cifs/for-next xfs-linux/for-next linus/master v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfs-change-mkdir-inode_operation-to-return-alternate-dentry-if-needed/20250214-141741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250214052204.3105610-2-neilb%40suse.de
patch subject: [PATCH 1/3] Change inode_operations.mkdir to return struct dentry *
config: um-randconfig-001-20250215 (https://download.01.org/0day-ci/archive/20250215/202502151519.0MA7hz8D-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 910be4ff90d7d07bd4518ea03b85c0974672bf9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151519.0MA7hz8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151519.0MA7hz8D-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/hostfs/hostfs_kern.c:689:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct dentry *' [-Wint-conversion]
     689 |                 return -ENOMEM;
         |                        ^~~~~~~
   12 warnings and 1 error generated.


vim +689 fs/hostfs/hostfs_kern.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  681  
456289e0bd14ce NeilBrown         2025-02-14  682  static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
549c7297717c32 Christian Brauner 2021-01-21  683  				   struct dentry *dentry, umode_t mode)
^1da177e4c3f41 Linus Torvalds    2005-04-16  684  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  685  	char *file;
^1da177e4c3f41 Linus Torvalds    2005-04-16  686  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  687  
c5322220eb91b9 Al Viro           2010-06-06  688  	if ((file = dentry_name(dentry)) == NULL)
f1adc05e773830 Jeff Dike         2007-05-08 @689  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  690  	err = do_mkdir(file, mode);
e9193059b1b373 Al Viro           2010-06-06  691  	__putname(file);
456289e0bd14ce NeilBrown         2025-02-14  692  	if (err)
456289e0bd14ce NeilBrown         2025-02-14  693  		return ERR_PTR(err);
456289e0bd14ce NeilBrown         2025-02-14  694  	else
456289e0bd14ce NeilBrown         2025-02-14  695  		return dentry;
^1da177e4c3f41 Linus Torvalds    2005-04-16  696  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  697  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

