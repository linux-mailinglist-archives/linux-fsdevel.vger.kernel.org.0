Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A07A5408
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjIRUYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjIRUYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:24:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571058F;
        Mon, 18 Sep 2023 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695068678; x=1726604678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cD9aWdh0g+KCQJtJTKordl0I6iSumVWkrBzStxTXKAw=;
  b=Yj+lFZuos7ASvmLA627iGkQqXDm4qLAS+exmhVsXeELWrBxV4+CvrMiJ
   t9i1bSNHZLM7BCyJR9sw2EfYPS/dMcxhgXCC/oxwc69ZkqmCtu2QO/Ii9
   kTwJb6PnmJi57X8uP9Um/jvxRAJnPakbfAZ2it53CkhBVliBR9Xkgt2yi
   TxJVIlpCsrSDeb1R5Xx+px8ANCKBKtnra+QPIc6jozw4Iex0XaQaInfN9
   lBi2C24uY4O3FwD9NEuFV0ZYrMAPE4/XdK5AOp+6ddgRgF7NRtl4zvPNr
   JIkd3TJZVem8nuOH2RvEKq+un8isjsy5DHg1FG9kCTMJsi7KLia9clvTW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466110213"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="466110213"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 13:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775263452"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="775263452"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 13:24:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiKnJ-0006RF-2x;
        Mon, 18 Sep 2023 20:24:33 +0000
Date:   Tue, 19 Sep 2023 04:24:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Kellermann <max.kellermann@ionos.com>, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, amir73il@gmail.com,
        max.kellermann@ionos.com
Subject: Re: [PATCH 4/4] arch: register inotify_add_watch_at
Message-ID: <202309190447.Md4xeYhu-lkp@intel.com>
References: <20230918123217.932179-4-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918123217.932179-4-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/asm]
[also build test ERROR on linus/master v6.6-rc2]
[cannot apply to jack-fs/fsnotify arm64/for-next/core next-20230918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/inotify_user-move-code-to-do_inotify_add_watch/20230918-203410
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20230918123217.932179-4-max.kellermann%40ionos.com
patch subject: [PATCH 4/4] arch: register inotify_add_watch_at
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20230919/202309190447.Md4xeYhu-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309190447.Md4xeYhu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309190447.Md4xeYhu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> or1k-linux-ld: arch/openrisc/kernel/sys_call_table.o:(.data+0x718): undefined reference to `sys_inotify_add_watch_at'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
