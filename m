Return-Path: <linux-fsdevel+bounces-66640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECADEC2723B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7315118923E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C7E2EDD74;
	Fri, 31 Oct 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MU6ig07P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FF25FA29;
	Fri, 31 Oct 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950844; cv=none; b=ZcK8QSNeNHceG3sDA9a26pen/MwlrGMl2XIDm+rKtBRSaEN3dZkZk8/yzim3/26zSLzq0zwNradjX7qJIBmghP4Kwgi3FaBP6qZtLq/AT28A49Gc3UM/WHxJ1cJWbWDKGlMqESo+qjigkfiQm53A00Ub63+/ldQ0U7kCCkZt7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950844; c=relaxed/simple;
	bh=r3vPPagarbLdHv2gqbl6ANprEGeb6pcMrvSRNr05Fgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+vE+2mBMOlxACLW/2+udrEXWVAtIvtYmnVjXWevG+Ag/rowIp8nVm2Ehhq2zVhOBq+B1JTJAzvx1wSGvdZmkJ8Penn9cYUVBwRxgq6TTS6flDfzc80Y7aLkO4l8yBaj8+SpV3G2aXwOgPAGANvIEiWqmYAQR71WxDpb2SQQJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MU6ig07P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761950842; x=1793486842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3vPPagarbLdHv2gqbl6ANprEGeb6pcMrvSRNr05Fgw=;
  b=MU6ig07P702xOqyGYTyS3bXjpW13UAc+o15zMA1qvlBcFn6opkT1EAP6
   WZFcsRukcGXtqmaxEXe3UsiLinNQwX+6Wx9tP9+/ecLh3PC70CjQvgbGo
   EiRLUzPwC1NeMu0fssZxRNz6avlmElCBRHncEM7UJeu1ESPLHCOuu64Vp
   87fPA1vQDHwkxwFbshLR5sH3KQHGAnKWuHiKT8opTnoi1S3R1As7GjhWQ
   Jj62671Y6sWplZbn2n/ooVHevZ2ebI7bwHJF5+YlkuI7XtempPmB+gfB1
   0OPXbs/2vjJfjiB3V+S2yl/HsUNRZpVofw2FbnQOazaNNcvKuA59oeVXV
   w==;
X-CSE-ConnectionGUID: qTotVJKSTAeGaIGDVdSSxQ==
X-CSE-MsgGUID: /ZnkBqGvQ2uugzE3IyOToQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75467971"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75467971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 15:47:22 -0700
X-CSE-ConnectionGUID: y20rF+GEQKCg1fBRC32BCQ==
X-CSE-MsgGUID: DeNe8T2iSau4hxBj3KmU3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="216999108"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 15:47:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vExtS-000NhY-1M;
	Fri, 31 Oct 2025 22:46:57 +0000
Date: Sat, 1 Nov 2025 06:43:03 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511010440.FLitz9Fi-lkp@intel.com>
References: <20251030105242.801528-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030105242.801528-1-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on linus/master brauner-vfs/vfs.all linux/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251030-185523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030105242.801528-1-mjguzik%40gmail.com
patch subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
config: i386-randconfig-061-20251031 (https://download.01.org/0day-ci/archive/20251101/202511010440.FLitz9Fi-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010440.FLitz9Fi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010440.FLitz9Fi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/d_path.c:195:9: sparse: sparse: context imbalance in 'prepend_path' - wrong count at exit
   fs/d_path.c:359:9: sparse: sparse: context imbalance in '__dentry_path' - wrong count at exit
>> fs/d_path.c:416:22: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/d_path.c:416:22: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/d_path.c:446:9: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
>> fs/namei.c:146:18: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/namei.c:146:18: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:163:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:169:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:191:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:197:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:203:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:208:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:249:18: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:249:18: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:261:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:267:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:294:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c:297:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/namei.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:871:25: sparse: sparse: context imbalance in 'leave_rcu' - unexpected unlock
   fs/namei.c:2518:19: sparse: sparse: context imbalance in 'path_init' - different lock contexts for basic block
--
   drivers/base/firmware_loader/main.c:229:9: sparse: sparse: context imbalance in 'free_fw_priv' - wrong count at exit
>> drivers/base/firmware_loader/main.c:509:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> drivers/base/firmware_loader/main.c:509:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   drivers/base/firmware_loader/main.c:591:9: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)

vim +416 fs/d_path.c

7a5cf791a74764 Al Viro 2018-03-05  393  
7a5cf791a74764 Al Viro 2018-03-05  394  /*
7a5cf791a74764 Al Viro 2018-03-05  395   * NOTE! The user-level library version returns a
7a5cf791a74764 Al Viro 2018-03-05  396   * character pointer. The kernel system call just
7a5cf791a74764 Al Viro 2018-03-05  397   * returns the length of the buffer filled (which
7a5cf791a74764 Al Viro 2018-03-05  398   * includes the ending '\0' character), or a negative
7a5cf791a74764 Al Viro 2018-03-05  399   * error value. So libc would do something like
7a5cf791a74764 Al Viro 2018-03-05  400   *
7a5cf791a74764 Al Viro 2018-03-05  401   *	char *getcwd(char * buf, size_t size)
7a5cf791a74764 Al Viro 2018-03-05  402   *	{
7a5cf791a74764 Al Viro 2018-03-05  403   *		int retval;
7a5cf791a74764 Al Viro 2018-03-05  404   *
7a5cf791a74764 Al Viro 2018-03-05  405   *		retval = sys_getcwd(buf, size);
7a5cf791a74764 Al Viro 2018-03-05  406   *		if (retval >= 0)
7a5cf791a74764 Al Viro 2018-03-05  407   *			return buf;
7a5cf791a74764 Al Viro 2018-03-05  408   *		errno = -retval;
7a5cf791a74764 Al Viro 2018-03-05  409   *		return NULL;
7a5cf791a74764 Al Viro 2018-03-05  410   *	}
7a5cf791a74764 Al Viro 2018-03-05  411   */
7a5cf791a74764 Al Viro 2018-03-05  412  SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
7a5cf791a74764 Al Viro 2018-03-05  413  {
7a5cf791a74764 Al Viro 2018-03-05  414  	int error;
7a5cf791a74764 Al Viro 2018-03-05  415  	struct path pwd, root;
7a5cf791a74764 Al Viro 2018-03-05 @416  	char *page = __getname();

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

