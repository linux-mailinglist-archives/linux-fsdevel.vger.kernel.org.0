Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B787272FF74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbjFNNGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbjFNNF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:05:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E121FF7;
        Wed, 14 Jun 2023 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686747955; x=1718283955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNR1CGlybaW16+0ie8Xomo54V9jN8wtg2oFB0nLPehs=;
  b=H4ZgI/0wxXC8Y9M5I3HQ143kGtg+8wLZO2k7p2n2IxiiHW088gQXF39Q
   7FzPuR69TXY2o30kgYpOAD2b47b63/arhrozyNAa1ZbUAMVx9fxeEBH7e
   G+3ln0LPPn+VhTQ7aJc8usKvYuOhGSawGLtaTa7VmHXWKXrmsilf5yQ6+
   lhHnWpZ4sbtpXxFPGY5bOOkvTBMqq5BYFtyu2ydabJGvBEECw/gj1KsFT
   qfPji0CUX8EgZnEf5y70dRkeOJ9qTnLyJkTHB1WbDx9YwnUe67YmVhB4T
   ZZDMI33YTk5yyJxwFnPifyNABQ3tBlho7TWlZ0lbUWqJ7dTNxfGwyRtAR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="343301575"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="343301575"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712062604"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="712062604"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2023 06:05:51 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9QC7-0000fI-0K;
        Wed, 14 Jun 2023 13:05:51 +0000
Date:   Wed, 14 Jun 2023 21:05:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, wsd_upstream@mediatek.com,
        wei-chin.tsai@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Message-ID: <202306142030.GjGWnIkY-lkp@intel.com>
References: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.4-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Chin-Tsai/kernel-process-fork-exit-export-symbol-for-fork-exit-tracing-functions/20230614-112218
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230614032038.11699-3-Wei-chin.Tsai%40mediatek.com
patch subject: [PATCH v2 2/3] memory: export symbols for memory related functions
config: arm-randconfig-r033-20230612 (https://download.01.org/0day-ci/archive/20230614/202306142030.GjGWnIkY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch char-misc char-misc-testing
        git checkout char-misc/char-misc-testing
        b4 shazam https://lore.kernel.org/r/20230614032038.11699-3-Wei-chin.Tsai@mediatek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306142030.GjGWnIkY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: vmlinux: 'arch_vma_name' exported twice. Previous export was in vmlinux
WARNING: modpost: EXPORT symbol "arch_vma_name" [vmlinux] version generation failed, symbol will not be versioned.
Is "arch_vma_name" prototyped in <asm/asm-prototypes.h>?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
