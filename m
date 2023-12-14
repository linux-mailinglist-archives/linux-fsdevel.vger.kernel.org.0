Return-Path: <linux-fsdevel+bounces-6040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547048129F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0048DB21297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C815E9C;
	Thu, 14 Dec 2023 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9x4X4Da"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A36CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702541362; x=1734077362;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OnQUw6DzWKRZ62i8CUB/fgzvr585PtagxxnHnxESvAk=;
  b=b9x4X4Da3ZCofcrh6DRKkAPNE36e0L3meZKKfFZkdPn5150V0U5fmJ9f
   RkDtItZA8JnVQ0afh0u/Jl2f9NQMEkodtSSHKPqYi8SPY0fvPoUhRUQpK
   tf/dtXbvqxEjqnNMnIDzyqobSWv6Oa5IeVtnJ5iO4HmxY9PfKue47Y6/+
   T8eo8JBQ6OIbppsk8+NZn5fm98pP6svaM7JbNPMRS052b2KliY0qskqwi
   A1NeHGz+hiJaB5TCAe54xQDsYzu+aTa9PiZlZdZja8mQjiwhP4fdfaEje
   cY7tHGimZ/ArT1cUn0lrdWWSlgckgCWk9wHSlhXlkRjMzy7ZU207qku+/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375240935"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375240935"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917977879"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="917977879"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 00:09:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDgmU-000Lmt-1Z;
	Thu, 14 Dec 2023 08:09:18 +0000
Date: Thu, 14 Dec 2023 16:08:19 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:headers.unaligned 2/2] drivers/hid/hid-kye.c:11:10: fatal
 error: asm-generic/unaligned.h: No such file or directory
Message-ID: <202312141642.xwTolWpS-lkp@intel.com>
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
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20231214/202312141642.xwTolWpS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141642.xwTolWpS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141642.xwTolWpS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/hid-kye.c:11:10: fatal error: asm-generic/unaligned.h: No such file or directory
      11 | #include <asm-generic/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/net/can/usb/f81604.c:16:10: fatal error: asm-generic/unaligned.h: No such file or directory
      16 | #include <asm-generic/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c:4:10: fatal error: asm-generic/unaligned.h: No such file or directory
       4 | #include <asm-generic/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 drivers/hid/hid-kye.c

b8cd2d963da57a David Yang  2023-02-07 @11  #include <asm-generic/unaligned.h>
794227415f8f5f Jiri Kosina 2009-03-11  12  #include <linux/device.h>
794227415f8f5f Jiri Kosina 2009-03-11  13  #include <linux/hid.h>
794227415f8f5f Jiri Kosina 2009-03-11  14  #include <linux/module.h>
794227415f8f5f Jiri Kosina 2009-03-11  15  

:::::: The code at line 11 was first introduced by commit
:::::: b8cd2d963da57aba55afd7f57546e3bb69e9a2c1 HID: kye: Rewrite tablet descriptor fixup routine

:::::: TO: David Yang <mmyangfl@gmail.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

