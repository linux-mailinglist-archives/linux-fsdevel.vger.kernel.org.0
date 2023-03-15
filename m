Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC86BBDD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 21:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCOUOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCOUOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:14:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4497A251;
        Wed, 15 Mar 2023 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678911247; x=1710447247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qEn7eVh0qey1R5xO+bISf9zYigLUClqJeIB9C6QUd5k=;
  b=M/7ZWE86qpa0w3RSBTP7j1hQFvIBBXoE6d9kfMrJ330jfVxpyAojdJax
   enLha2QoI7/Q9TaXLOxhMK35RRLJdxUGb1fVbd1v9Xkw+r7Msqq/uNxRf
   62uA62A/ToHQfXXnIZT34s/xjciaLlPSqnz7cCrNBnfHd4PiKFO9f/PJw
   GqBTX/LbZgs/ycG1WSiLmfzGF+C0Gf92Ezq1cUX+ym6BtCKJMCPIWu5tR
   jg9zxxzoeajLf5DKwiBYr/9Py4NDdK5MM7U4hO6e1dKb70lj9cTQ0natz
   1mENKDeZNjJcIhEEpeCRieEojIaQLPqENV8zXDPpyU8hAjWzpjoabzaV3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424080612"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424080612"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 13:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="743854712"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743854712"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2023 13:14:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcXVc-00080R-0M;
        Wed, 15 Mar 2023 20:14:04 +0000
Date:   Thu, 16 Mar 2023 04:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: Re: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Message-ID: <202303160421.bnmiVRCM-lkp@intel.com>
References: <20230315084938.2544737-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315084938.2544737-5-david@fromorbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc2 next-20230315]
[cannot apply to dennis-percpu/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
patch link:    https://lore.kernel.org/r/20230315084938.2544737-5-david%40fromorbit.com
patch subject: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
config: riscv-randconfig-r042-20230313 (https://download.01.org/0day-ci/archive/20230316/202303160421.bnmiVRCM-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
        git checkout 8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160421.bnmiVRCM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_super.c:1079:9: error: call to undeclared function 'percpu_counter_sum_all'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                  percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
                  ^
   fs/xfs/xfs_super.c:1079:9: note: did you mean 'percpu_counter_sum'?
   include/linux/percpu_counter.h:193:19: note: 'percpu_counter_sum' declared here
   static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
                     ^
   1 error generated.


vim +/percpu_counter_sum_all +1079 fs/xfs/xfs_super.c

8757c38f2cf6e5 Ian Kent        2019-11-04  1070  
8757c38f2cf6e5 Ian Kent        2019-11-04  1071  static void
8757c38f2cf6e5 Ian Kent        2019-11-04  1072  xfs_destroy_percpu_counters(
8757c38f2cf6e5 Ian Kent        2019-11-04  1073  	struct xfs_mount	*mp)
8757c38f2cf6e5 Ian Kent        2019-11-04  1074  {
8757c38f2cf6e5 Ian Kent        2019-11-04  1075  	percpu_counter_destroy(&mp->m_icount);
8757c38f2cf6e5 Ian Kent        2019-11-04  1076  	percpu_counter_destroy(&mp->m_ifree);
8757c38f2cf6e5 Ian Kent        2019-11-04  1077  	percpu_counter_destroy(&mp->m_fdblocks);
75c8c50fa16a23 Dave Chinner    2021-08-18  1078  	ASSERT(xfs_is_shutdown(mp) ||
c35278f526edf1 Ye Bin          2023-03-14 @1079  	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
8757c38f2cf6e5 Ian Kent        2019-11-04  1080  	percpu_counter_destroy(&mp->m_delalloc_blks);
2229276c528326 Darrick J. Wong 2022-04-12  1081  	percpu_counter_destroy(&mp->m_frextents);
8757c38f2cf6e5 Ian Kent        2019-11-04  1082  }
8757c38f2cf6e5 Ian Kent        2019-11-04  1083  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
