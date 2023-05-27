Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E6713496
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjE0L7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjE0L7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 07:59:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF29C;
        Sat, 27 May 2023 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685188747; x=1716724747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmFzT5pRn/sMBj6n/h4s8aWxiX/SSMMcVknEBskT0dM=;
  b=K7eC7VpxjzQ960JnYz4W55w4DHdI/32XmvGOuXdSFw8h9vyYY2ZWi1q+
   5hygpEx3ZUMNsOZsdvrYmuva+rZphamE//OhcYN07QpkzkBc5eyfTRj2t
   v/5m8VjzQULwK1TdlZduYTeTcK48oza/tHazFi3kwYv4m2BPB0fxRsSMo
   z5Ugbp0rUskyTUIpBfckhTmmROQ7EtE20T5H0YqLE4UfkDop08QH/AHvU
   GaRnVQAxKbZ4m6KcEikekDmgQ5LMsTigRf8RfK/sFkEoPaj4AKue/EKUM
   griyrSRZGelVMSJlcUKzLxK8TWR2spXJk4IrHU79DhnVFAHrdLFmaZfPE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="353233925"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="353233925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="817840390"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="817840390"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2023 04:59:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2sZZ-000Jwo-1L;
        Sat, 27 May 2023 11:59:01 +0000
Date:   Sat, 27 May 2023 19:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: add counter for write delegation recall due to
 conflict with GETATTR
Message-ID: <202305271936.3kL7Ufxk-lkp@intel.com>
References: <1685122722-18287-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685122722-18287-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dai,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/NFSD-handle-GETATTR-conflict-with-write-delegation/20230527-013936
base:   linus/master
patch link:    https://lore.kernel.org/r/1685122722-18287-3-git-send-email-dai.ngo%40oracle.com
patch subject: [PATCH 2/2] NFSD: add counter for write delegation recall due to conflict with GETATTR
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20230527/202305271936.3kL7Ufxk-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a90d0ca71c9459b76f9faa8c704c029ac8066d00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dai-Ngo/NFSD-handle-GETATTR-conflict-with-write-delegation/20230527-013936
        git checkout a90d0ca71c9459b76f9faa8c704c029ac8066d00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271936.3kL7Ufxk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/nfsd/nfsd.h:28,
                    from fs/nfsd/state.h:42,
                    from fs/nfsd/xdr4.h:40,
                    from fs/nfsd/trace.h:17,
                    from fs/nfsd/trace.c:4:
   fs/nfsd/stats.h: In function 'nfsd_stats_wdeleg_getattr_inc':
>> fs/nfsd/stats.h:99:47: error: 'NFSD_STATS_WDELEG_GETATTR' undeclared (first use in this function)
      99 |         percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/stats.h:99:47: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from fs/nfsd/nfsd.h:28,
                    from fs/nfsd/export.c:21:
   fs/nfsd/stats.h: In function 'nfsd_stats_wdeleg_getattr_inc':
>> fs/nfsd/stats.h:99:47: error: 'NFSD_STATS_WDELEG_GETATTR' undeclared (first use in this function)
      99 |         percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/stats.h:99:47: note: each undeclared identifier is reported only once for each function it appears in
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:1005:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
    1005 |         struct inode            *inode;
         |                                  ^~~~~
--
   In file included from fs/nfsd/nfsd.h:28,
                    from fs/nfsd/state.h:42,
                    from fs/nfsd/xdr4.h:40,
                    from fs/nfsd/trace.h:17,
                    from fs/nfsd/trace.c:4:
   fs/nfsd/stats.h: In function 'nfsd_stats_wdeleg_getattr_inc':
>> fs/nfsd/stats.h:99:47: error: 'NFSD_STATS_WDELEG_GETATTR' undeclared (first use in this function)
      99 |         percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/stats.h:99:47: note: each undeclared identifier is reported only once for each function it appears in
   In file included from fs/nfsd/trace.h:1589:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.


vim +/NFSD_STATS_WDELEG_GETATTR +99 fs/nfsd/stats.h

    96	
    97	static inline void nfsd_stats_wdeleg_getattr_inc(void)
    98	{
  > 99		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
