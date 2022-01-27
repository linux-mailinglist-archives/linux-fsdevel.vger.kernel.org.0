Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7279C49E7EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiA0QpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:45:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:21456 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244072AbiA0QpI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643301908; x=1674837908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0XYCULJz8eCwunpqt4WW86gJKS6aVCwiIa+rTXc0vrY=;
  b=YUpUQhuP2P2ONDNu4UHFwQJz3C8gKeIwbv2Vx8nQgLz/ReIXjxEID2Ky
   0Jph+dEdAQQqGcvt0XFhWQTyWBHWg157Ti94RXIry4Z/nT61+boVAypni
   xGsMDgaVjCz8NDhlbPnfs2y8wx8lq3S6RQEDLZhFvp4F+RlApPiRMpPod
   petoW8eQmz5jGdW3KTw9nYhYGDm36P2kr6y1rFhqJ+dtccCT+lmaaiZze
   etRAVh8xAjcKU2Pe3tIemI1n1SV+LgGhMM+0aQOjRuIlFLfDnjGqnlN7q
   Lc6u9VRbUHWD+gzttJNs2IqYsujht23Skitdpch+9ccRd7KRtqe9XtWtk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244510328"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="244510328"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="477935447"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2022 08:45:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD7tP-000MoH-LD; Thu, 27 Jan 2022 16:45:03 +0000
Date:   Fri, 28 Jan 2022 00:44:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v10 1/9] dax: Introduce holder for dax_device
Message-ID: <202201280035.A565CZYV-lkp@intel.com>
References: <20220127124058.1172422-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127124058.1172422-2-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc1 next-20220127]
[cannot apply to xfs-linux/for-next hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220128/202201280035.A565CZYV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/57669ed05e93b37d995c5247eebe218ab2058c9a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
        git checkout 57669ed05e93b37d995c5247eebe218ab2058c9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from mm/filemap.c:15:
>> include/linux/dax.h:73:30: warning: 'struct dax_holder_operations' declared inside parameter list will not be visible outside of this definition or declaration
      73 |                 const struct dax_holder_operations *ops)
         |                              ^~~~~~~~~~~~~~~~~~~~~


vim +73 include/linux/dax.h

    48	
    49	void dax_register_holder(struct dax_device *dax_dev, void *holder,
    50			const struct dax_holder_operations *ops);
    51	void dax_unregister_holder(struct dax_device *dax_dev);
    52	void *dax_get_holder(struct dax_device *dax_dev);
    53	void put_dax(struct dax_device *dax_dev);
    54	void kill_dax(struct dax_device *dax_dev);
    55	void dax_write_cache(struct dax_device *dax_dev, bool wc);
    56	bool dax_write_cache_enabled(struct dax_device *dax_dev);
    57	bool dax_synchronous(struct dax_device *dax_dev);
    58	void set_dax_synchronous(struct dax_device *dax_dev);
    59	/*
    60	 * Check if given mapping is supported by the file / underlying device.
    61	 */
    62	static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
    63						     struct dax_device *dax_dev)
    64	{
    65		if (!(vma->vm_flags & VM_SYNC))
    66			return true;
    67		if (!IS_DAX(file_inode(vma->vm_file)))
    68			return false;
    69		return dax_synchronous(dax_dev);
    70	}
    71	#else
    72	static inline void dax_register_holder(struct dax_device *dax_dev, void *holder,
  > 73			const struct dax_holder_operations *ops)
    74	{
    75	}
    76	static inline void dax_unregister_holder(struct dax_device *dax_dev)
    77	{
    78	}
    79	static inline void *dax_get_holder(struct dax_device *dax_dev)
    80	{
    81		return NULL;
    82	}
    83	static inline struct dax_device *alloc_dax(void *private,
    84			const struct dax_operations *ops)
    85	{
    86		/*
    87		 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
    88		 * NULL is an error or expected.
    89		 */
    90		return NULL;
    91	}
    92	static inline void put_dax(struct dax_device *dax_dev)
    93	{
    94	}
    95	static inline void kill_dax(struct dax_device *dax_dev)
    96	{
    97	}
    98	static inline void dax_write_cache(struct dax_device *dax_dev, bool wc)
    99	{
   100	}
   101	static inline bool dax_write_cache_enabled(struct dax_device *dax_dev)
   102	{
   103		return false;
   104	}
   105	static inline bool dax_synchronous(struct dax_device *dax_dev)
   106	{
   107		return true;
   108	}
   109	static inline void set_dax_synchronous(struct dax_device *dax_dev)
   110	{
   111	}
   112	static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
   113					struct dax_device *dax_dev)
   114	{
   115		return !(vma->vm_flags & VM_SYNC);
   116	}
   117	#endif
   118	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
