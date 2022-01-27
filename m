Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC049E72F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiA0QOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:14:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:5381 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243566AbiA0QOL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643300051; x=1674836051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3bb9JoZDY5PZwbc2+qweKuL9rGbUODs3lF1L0htuqdY=;
  b=RMCcOzadZHRxFsWu/M12Efnw3Hm7xsCFU0AI9Tke1FIvpYJHmqOfUmq6
   uIqgzaIENRBU1sX7bzbJrDVtRt5JwEa01iXNPKsd4fS2VHrIqeM0/EAJY
   /W1C29KnAOfYXoehVLmh1H4l2SqJSeJVpPtpv0rhKKuMMpobxa6uqUrrL
   fJa7Xex9wVVsEwF6ILpDjMfw635Cg20SGe17jUFaRLXvr3OjAGMgIVisd
   M0lT9OqkMrg/JlCNOdC9+uwoLwIIybuvrFu6eVWOizG/1RHefebx6YDI1
   +4liKlrzYIXJ4nEBCNp7fhW8KljqKNEekobQ0G2cf8HTNuROZGRT+M9CJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307609977"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="307609977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674765149"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 08:14:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD7PN-000Mm0-Ua; Thu, 27 Jan 2022 16:14:01 +0000
Date:   Fri, 28 Jan 2022 00:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v10 1/9] dax: Introduce holder for dax_device
Message-ID: <202201280053.mWAlT70p-lkp@intel.com>
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
[cannot apply to xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: arm-imx_v4_v5_defconfig (https://download.01.org/0day-ci/archive/20220128/202201280053.mWAlT70p-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f32dccb9a43b02ce4e540d6ba5dbbdb188f2dc7d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/57669ed05e93b37d995c5247eebe218ab2058c9a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
        git checkout 57669ed05e93b37d995c5247eebe218ab2058c9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/iomap/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/iomap/buffered-io.c:13:
>> include/linux/dax.h:73:16: warning: declaration of 'struct dax_holder_operations' will not be visible outside of this function [-Wvisibility]
                   const struct dax_holder_operations *ops)
                                ^
   1 warning generated.


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
