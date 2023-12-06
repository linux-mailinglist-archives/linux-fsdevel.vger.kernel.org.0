Return-Path: <linux-fsdevel+bounces-4920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EBF80637F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D81B20901
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA26AA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPcaFp0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9511A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 16:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701822605; x=1733358605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YgoQtOELF5U4OWPViW6jdVegrIHcOMZK442I1HFX9WE=;
  b=WPcaFp0OSkV4rhLPnglvBaUX9WxAWwAZGPP4q3zKchwotJllWPrfHX7c
   V8z/P8XfrsHg7mmsNPRgKfYavSBGCu30N+TZf4GAY8VOSmQ4YxI9cY/Oh
   9DaVDdNsKtQ3NWHv7CI7JWhPLFO289HhEPljX4KFdVsTTKtt8nQmGnJOs
   RIJWKkNlAnHctSyxiYEZdA+TghxmjvSPa9RLJXLE6Q/C2JP79kQHuVwXL
   JHc42FjFYuil91gr8mfjcsQ8ZucuQCbDaX8L2EGGEh48IIFlmYLTpT5IL
   WCj8PaHqrPcbxokSZdiCn/UEmehhqgm/g7OjaYn3i6FivGuwRujjgrCxh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374163844"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="374163844"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771112926"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="771112926"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2023 16:30:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAfnd-0009x6-28;
	Wed, 06 Dec 2023 00:30:01 +0000
Date: Wed, 6 Dec 2023 08:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:carved-up-__dentry_kill 22/28] fs/dcache.c:1101:33: error:
 'dentry' undeclared
Message-ID: <202312060802.HxDqIoDc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git carved-up-__dentry_kill
head:   20f7d1936e8a2859fee51273c8ffadcca4304968
commit: c73bce0494d44e0d26ec351106558e4408cf1cd9 [22/28] step 3: have __dentry_kill() return the parent
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231206/202312060802.HxDqIoDc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060802.HxDqIoDc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060802.HxDqIoDc-lkp@intel.com/

Note: the viro-vfs/carved-up-__dentry_kill HEAD 20f7d1936e8a2859fee51273c8ffadcca4304968 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/dcache.c: In function 'shrink_kill':
>> fs/dcache.c:1101:33: error: 'dentry' undeclared (first use in this function)
    1101 |         struct dentry *parent = dentry->d_parent;
         |                                 ^~~~~~
   fs/dcache.c:1101:33: note: each undeclared identifier is reported only once for each function it appears in
>> fs/dcache.c:1102:33: error: expected expression before 'if'
    1102 |         if (parent != victim && if (!--parent->d_lockref.count)
         |                                 ^~
>> fs/dcache.c:1107:1: error: expected expression before '}' token
    1107 | }
         | ^


vim +/dentry +1101 fs/dcache.c

  1098	
  1099	static inline void shrink_kill(struct dentry *victim, struct list_head *list)
  1100	{
> 1101		struct dentry *parent = dentry->d_parent;
> 1102		if (parent != victim && if (!--parent->d_lockref.count)
  1103			to_shrink_list(parent, list);
  1104		parent = __dentry_kill(dentry);
  1105		if (parent)
  1106			spin_unlock(&parent->d_lock);
> 1107	}
  1108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

