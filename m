Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644E6BBD2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjCOTYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjCOTX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:23:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7ACA12;
        Wed, 15 Mar 2023 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678908191; x=1710444191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9sP0fffWNhdMp1rBkx03nYUwQIRh9b24r1RwtsdixcM=;
  b=CnWdm6GGfT7ikMAAlL6Yb9ru5inK0gV0fbMAbKnkOoji6dr1jN0FvjIu
   /1/zBgFxBrf0ig5vX9LpxfyLe/FCoPP7H0oYz4E6xC2NKdKI2cScUZaYE
   V5eM7MO84wh26tCv+hqVe1lLDE4dNj5mQiuSV9yJDKVc710iC6sHxk2BI
   AU5MACJw5XKTHa881v3nXSD03Mbq00NWqTIkqfvsuTzo3WU3zR1NDbgNy
   dOjtTBkLsxOjnr/UB4loHg+r4FCwf1t3sK4r55Ua9ZZf2hd848xEsAtHY
   VQ8LEVw3TcKKvO75Xy4gSZvnbJybckuPadd8hDOxQVruNNvlHsItXR4DA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365487326"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365487326"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 12:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679611491"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="679611491"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2023 12:23:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcWiE-0007yr-32;
        Wed, 15 Mar 2023 19:23:02 +0000
Date:   Thu, 16 Mar 2023 03:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Message-ID: <202303160333.XqIRz3JU-lkp@intel.com>
References: <20230315084938.2544737-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315084938.2544737-5-david@fromorbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230316/202303160333.XqIRz3JU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
        git checkout 8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/ fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160333.XqIRz3JU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:5,
                    from include/linux/uuid.h:11,
                    from fs/xfs/xfs_linux.h:10,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_super.c:7:
   fs/xfs/xfs_super.c: In function 'xfs_destroy_percpu_counters':
>> fs/xfs/xfs_super.c:1079:16: error: implicit declaration of function 'percpu_counter_sum_all'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
    1079 |                percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   fs/xfs/xfs_super.c:1078:9: note: in expansion of macro 'ASSERT'
    1078 |         ASSERT(xfs_is_shutdown(mp) ||
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +1079 fs/xfs/xfs_super.c

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
