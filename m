Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59930529AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 09:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiEQHRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiEQHRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 03:17:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA336309;
        Tue, 17 May 2022 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652771835; x=1684307835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LgMjJb8c49xHlzmhhMtKCfBy0h8ObKZau2vBdPT2oV4=;
  b=gHOc6jCkACEK7Kue+StMNb3BQFWPMGxkd/bJKyV9dwnxY6yCdwwf5Ezy
   LRbb92gTrpAVCut9J9ho+oPPYeEeE7VzV5Dov/CNetrcfffer/XYXJ+84
   wsj/TzYRo+sq6fIIx6BHuqTFAb4mWReUTPEMrZznSCyvJ5reEqa+Gc6bq
   dK1V2ibPgXdKdFTt7M1YAsQoynNhZJFHea3huiefbOr4MZ7YPT14jIKkB
   HAfav7jdeAqvVDl9iGt65n3L4/Go5F9uOWtZfKnTi9x/lPVpwypV9zQe6
   QeokQk118wJmxxjZvIigXQmBwXEh0yjHDtHj6OEvZ0VXfEi+GNhfz6BCg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="253144290"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="253144290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="555645145"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 00:17:11 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqrSB-0000iT-7u;
        Tue, 17 May 2022 07:17:11 +0000
Date:   Tue, 17 May 2022 15:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <202205171541.x3KcGj83-lkp@intel.com>
References: <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on linux/master linus/master v5.18-rc7 next-20220516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220517-044904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220517/202205171541.x3KcGj83-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d1fc23ae264424a2007ef5a3cfc1b4dbc8d82db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220517-044904
        git checkout 4d1fc23ae264424a2007ef5a3cfc1b4dbc8d82db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/notify/fanotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/sysctl.h:26,
                    from include/linux/fanotify.h:5,
                    from fs/notify/fanotify/fanotify_user.c:2:
   fs/notify/fanotify/fanotify_user.c: In function 'process_access_response':
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:576:19: note: in expansion of macro 'KERN_DEBUG'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:325:9: note: in expansion of macro 'pr_debug'
     325 |         pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
         |         ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
