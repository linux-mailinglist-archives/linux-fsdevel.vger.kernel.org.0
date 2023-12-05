Return-Path: <linux-fsdevel+bounces-4860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73A805069
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF60A2817AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7F56778
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yocccp6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96841A7;
	Tue,  5 Dec 2023 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701769840; x=1733305840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ynZxpIG44aYelXlmnhFzoUsvhHg41bdZ9yKRk1kUO+c=;
  b=Yocccp6lPdOKIhR76ZldZMtEpw5vpgT/zet3HSG1/uVgQvJz40kwRBmL
   /amdP+yXa3RnuhRPW7ZCLoglIkgs72CV2vCsG34dq2ervy0Eal4p+3M8j
   jk1IhHEQSK9lBj4o5QcgAkQ0m57tKB10Fgr86rol/UFbowDa+SDfVEtfF
   JATvQDFu7TlJLrAy779U8Tgc53YNXVS+MPnAmgbVg+y9oh0Tm+NPtnH6m
   58NS/XmMuzmNkqFINwjZrBTZD1gHRTKnU8Qf6Wl254thoTq13OU8YGtC3
   qpH8RUFwsLFomoOd50hxV18bT/xRb+IyWqBRkNP9CqXs5oGjJIVpIjdzM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15419161"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15419161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:50:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836922250"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="836922250"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Dec 2023 01:50:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAS4Y-0008hl-0w;
	Tue, 05 Dec 2023 09:50:34 +0000
Date: Tue, 5 Dec 2023 17:50:24 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table
 argument of handlers
Message-ID: <202312051727.wW4EJo6e-lkp@intel.com>
References: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.7-rc4]
[cannot apply to nf-next/master next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/sysctl-delete-unused-define-SYSCTL_PERM_EMPTY_DIR/20231204-165306
base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20231204-const-sysctl-v2-12-7a5060b11447%40weissschuh.net
patch subject: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table argument of handlers
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051727.wW4EJo6e-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051727.wW4EJo6e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051727.wW4EJo6e-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/s390/appldata/appldata_base.c: In function 'appldata_register_ops':
>> arch/s390/appldata/appldata_base.c:363:40: error: assignment to 'int (*)(const struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*)(const struct ctl_table *, int,  void *, long unsigned int *, long long int *)'} from incompatible pointer type 'int (*)(struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*)(struct ctl_table *, int,  void *, long unsigned int *, long long int *)'} [-Werror=incompatible-pointer-types]
     363 |         ops->ctl_table[0].proc_handler = appldata_generic_handler;
         |                                        ^
   cc1: some warnings being treated as errors


vim +363 arch/s390/appldata/appldata_base.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  340  
^1da177e4c3f41 Linus Torvalds   2005-04-16  341  
^1da177e4c3f41 Linus Torvalds   2005-04-16  342  /************************* module-ops management *****************************/
^1da177e4c3f41 Linus Torvalds   2005-04-16  343  /*
^1da177e4c3f41 Linus Torvalds   2005-04-16  344   * appldata_register_ops()
^1da177e4c3f41 Linus Torvalds   2005-04-16  345   *
^1da177e4c3f41 Linus Torvalds   2005-04-16  346   * update ops list, register /proc/sys entries
^1da177e4c3f41 Linus Torvalds   2005-04-16  347   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  348  int appldata_register_ops(struct appldata_ops *ops)
^1da177e4c3f41 Linus Torvalds   2005-04-16  349  {
13f8b7c5e6fa13 Roel Kluin       2008-10-28  350  	if (ops->size > APPLDATA_MAX_REC_SIZE)
37e3a6ac5a3046 Heiko Carstens   2007-11-20  351  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  352  
fdd9da76e2dec0 Joel Granados    2023-10-02  353  	ops->ctl_table = kcalloc(1, sizeof(struct ctl_table), GFP_KERNEL);
37e3a6ac5a3046 Heiko Carstens   2007-11-20  354  	if (!ops->ctl_table)
^1da177e4c3f41 Linus Torvalds   2005-04-16  355  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds   2005-04-16  356  
b1ad171efa089a Gerald Schaefer  2009-04-23  357  	mutex_lock(&appldata_ops_mutex);
^1da177e4c3f41 Linus Torvalds   2005-04-16  358  	list_add(&ops->list, &appldata_ops_list);
b1ad171efa089a Gerald Schaefer  2009-04-23  359  	mutex_unlock(&appldata_ops_mutex);
^1da177e4c3f41 Linus Torvalds   2005-04-16  360  
7db12246306ea6 Luis Chamberlain 2023-03-10  361  	ops->ctl_table[0].procname = ops->name;
7db12246306ea6 Luis Chamberlain 2023-03-10  362  	ops->ctl_table[0].mode = S_IRUGO | S_IWUSR;
7db12246306ea6 Luis Chamberlain 2023-03-10 @363  	ops->ctl_table[0].proc_handler = appldata_generic_handler;
7db12246306ea6 Luis Chamberlain 2023-03-10  364  	ops->ctl_table[0].data = ops;
^1da177e4c3f41 Linus Torvalds   2005-04-16  365  
9edbfe92a0a135 Joel Granados    2023-08-09  366  	ops->sysctl_header = register_sysctl_sz(appldata_proc_name, ops->ctl_table, 1);
37e3a6ac5a3046 Heiko Carstens   2007-11-20  367  	if (!ops->sysctl_header)
37e3a6ac5a3046 Heiko Carstens   2007-11-20  368  		goto out;
^1da177e4c3f41 Linus Torvalds   2005-04-16  369  	return 0;
37e3a6ac5a3046 Heiko Carstens   2007-11-20  370  out:
b1ad171efa089a Gerald Schaefer  2009-04-23  371  	mutex_lock(&appldata_ops_mutex);
37e3a6ac5a3046 Heiko Carstens   2007-11-20  372  	list_del(&ops->list);
b1ad171efa089a Gerald Schaefer  2009-04-23  373  	mutex_unlock(&appldata_ops_mutex);
37e3a6ac5a3046 Heiko Carstens   2007-11-20  374  	kfree(ops->ctl_table);
37e3a6ac5a3046 Heiko Carstens   2007-11-20  375  	return -ENOMEM;
^1da177e4c3f41 Linus Torvalds   2005-04-16  376  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  377  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

