Return-Path: <linux-fsdevel+bounces-6038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DCA81288F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 07:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29301C214A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DFD531;
	Thu, 14 Dec 2023 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0UDHtyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3736E125
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 22:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702536659; x=1734072659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3I74hwwmjqQrsZeqa16ciqhnvdtU1Wt3fbCXMVDS+IU=;
  b=a0UDHtyAc5fuIWzyjd32BdScGEOKASs43UAz+6g3TP5uOBSCT6HJ3XK2
   RQtIQIUCdvYvJ4OXt7qHmmZFnnWjE+b9bm3fFh8DJTxRWHXXMqMSFHMq9
   s9pozk9J7yBzW2BJtyyIjp6itZmwlnvCoGS7Xa7grLkB2+If+ranv1tuT
   BO1MWD38lVu88Hk5y0HmzjTvKBi2kdrBh02SBbIeZ9cwkHnKYs0kcXQdV
   I5avWr1lAMHABO7nVC860hsXtmJlkyPlxNmo82tqr3JLEyx0FVmbfyJIr
   OYmpkO15sLgG93wX4ebrLuqNym6xKtY1BQUipMKMB8en0coOShhmlEwUU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394822543"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="394822543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 22:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750412914"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750412914"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2023 22:50:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDfYd-000Lhr-0a;
	Thu, 14 Dec 2023 06:50:55 +0000
Date: Thu, 14 Dec 2023 14:50:07 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:headers.unaligned 2/2] drivers/cxl/core/trace.h:11:10:
 fatal error: asm-generic/unaligned.h: No such file or directory
Message-ID: <202312141458.agmsUCZB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git headers.unaligned
head:   959598f725aa7721a4bad53c2e997c7255ff32dc
commit: 959598f725aa7721a4bad53c2e997c7255ff32dc [2/2] move asm/unaligned.h to linux/unaligned.h
config: i386-buildonly-randconfig-002-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141458.agmsUCZB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141458.agmsUCZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141458.agmsUCZB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/pci.c:13:
>> drivers/cxl/core/trace.h:11:10: fatal error: asm-generic/unaligned.h: No such file or directory
      11 | #include <asm-generic/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 drivers/cxl/core/trace.h

2f6e9c305127f8 include/trace/events/cxl.h Dave Jiang       2022-11-29   8  
2f6e9c305127f8 include/trace/events/cxl.h Dave Jiang       2022-11-29   9  #include <linux/tracepoint.h>
ddf49d57b841e5 drivers/cxl/core/trace.h   Alison Schofield 2023-04-18  10  #include <linux/pci.h>
6ebe28f9ec7228 drivers/cxl/core/trace.h   Ira Weiny        2023-01-17 @11  #include <asm-generic/unaligned.h>
6ebe28f9ec7228 drivers/cxl/core/trace.h   Ira Weiny        2023-01-17  12  

:::::: The code at line 11 was first introduced by commit
:::::: 6ebe28f9ec7228e1a35df6074695ac11d7cdcf68 cxl/mem: Read, trace, and clear events on driver load

:::::: TO: Ira Weiny <ira.weiny@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

