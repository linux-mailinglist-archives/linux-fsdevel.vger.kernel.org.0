Return-Path: <linux-fsdevel+bounces-1966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3F67E0D16
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 03:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4825B214F7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 02:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2691864;
	Sat,  4 Nov 2023 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7EnicEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5917CB
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 02:02:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096BD52
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699063351; x=1730599351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zw715J4q3WU4bZwvd53leZAIKCHUB3cv/rvHufvG6uo=;
  b=O7EnicEhbFCev4Ri4Qdwkfc3KsWqzuVh19hox67t00bN/xq0s700yhUc
   1A86zfPhYOQhQz5SOX7YBcJjZ6t8LV1sPzdPxWOmwh9YzrBH9CTOk5I9k
   94i5ZcFZRDpJUavbifbofzvb1zPt9VcDJtE1SfA1Y619zZArho2ibvJ0n
   nGfJtVe/H7nETDDIxNRWabRTfTNWWY+1T1+dyzc1vqNlYRU2BSu39ERQW
   gJ7PksiGa7mjIldnNJyQyWXHvLs3AVcUTaSERzxJcrNwLSr7SvfXQB/o+
   vCEC/8cawOW/CfICslmUkD9+FTHUkGjZcfqJ8I0twUfISIhkrYKjzcftK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387940292"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387940292"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 19:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="2914908"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Nov 2023 19:02:29 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qz5zX-0003EF-1e;
	Sat, 04 Nov 2023 02:02:27 +0000
Date: Sat, 4 Nov 2023 10:01:46 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.dcache 16/16] fs/dcache.c:1081:48: error:
 incompatible type for argument 2 of 'to_shrink_list'
Message-ID: <202311041021.xJLFuXJz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
head:   e565b3bc8b39fae7d3c4093e012df87ba1eed599
commit: e565b3bc8b39fae7d3c4093e012df87ba1eed599 [16/16] d_prune_aliases(): use a shrink list
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20231104/202311041021.xJLFuXJz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041021.xJLFuXJz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041021.xJLFuXJz-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/dcache.c: In function 'd_prune_aliases':
>> fs/dcache.c:1081:48: error: incompatible type for argument 2 of 'to_shrink_list'
    1081 |                         to_shrink_list(dentry, dispose);
         |                                                ^~~~~~~
         |                                                |
         |                                                struct list_head
   fs/dcache.c:898:69: note: expected 'struct list_head *' but argument is of type 'struct list_head'
     898 | static void to_shrink_list(struct dentry *dentry, struct list_head *list)
         |                                                   ~~~~~~~~~~~~~~~~~~^~~~
>> fs/dcache.c:1085:28: error: incompatible type for argument 1 of 'shrink_dentry_list'
    1085 |         shrink_dentry_list(dispose);
         |                            ^~~~~~~
         |                            |
         |                            struct list_head
   In file included from fs/dcache.c:35:
   fs/internal.h:209:32: note: expected 'struct list_head *' but argument is of type 'struct list_head'
     209 | extern void shrink_dentry_list(struct list_head *);
         |                                ^~~~~~~~~~~~~~~~~~


vim +/to_shrink_list +1081 fs/dcache.c

  1067	
  1068	/*
  1069	 *	Try to kill dentries associated with this inode.
  1070	 * WARNING: you must own a reference to inode.
  1071	 */
  1072	void d_prune_aliases(struct inode *inode)
  1073	{
  1074		LIST_HEAD(dispose);
  1075		struct dentry *dentry;
  1076	
  1077		spin_lock(&inode->i_lock);
  1078		hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
  1079			spin_lock(&dentry->d_lock);
  1080			if (!dentry->d_lockref.count)
> 1081				to_shrink_list(dentry, dispose);
  1082			spin_unlock(&dentry->d_lock);
  1083		}
  1084		spin_unlock(&inode->i_lock);
> 1085		shrink_dentry_list(dispose);
  1086	}
  1087	EXPORT_SYMBOL(d_prune_aliases);
  1088	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

