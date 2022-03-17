Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970EF4DBCA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 02:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358365AbiCQBvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348344AbiCQBu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:50:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0115A25;
        Wed, 16 Mar 2022 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647481784; x=1679017784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ka6d0lABbmnahsHXH4pHTLfnPB31dmhthO1bViS7IE=;
  b=PaAIOTsOU2QsfIBKADODXt/XwZQPFIDBMYR0VkU0H2zVJ2SXK1zRD2WN
   e/ohRjpBGJdMyICwon/7eJZuivGD2Olc2NGYUU6GQDef0SJilEVAARiwR
   K6VVPKFFOx0UkSES93nQSBcPWbr/PnTiBok0bmQ+beZcH/LLJWjXBoJjv
   y2bTBzjo8oYfBZtxUjzlOYxXBpgG/Pg665ZuZXTICW4fUvO600bBsrX45
   zlQhY6i0z0NZRCepkYKoUlFeSGN7QnSvmazWh8iWjovUhfl5Kc34XJPOQ
   KK6GTyq78q7eldRJrmK9WMgjrCJbieMTG8l5GnoQRBBrMX+Gbp2Wr73X3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256709192"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256709192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581131644"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 18:49:39 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUfGk-000DAz-Af; Thu, 17 Mar 2022 01:49:38 +0000
Date:   Thu, 17 Mar 2022 09:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 11/22] erofs: register global fscache volume
Message-ID: <202203170912.gk2sqkaK-lkp@intel.com>
References: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17-rc8]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: parisc-randconfig-m031-20220317 (https://download.01.org/0day-ci/archive/20220317/202203170912.gk2sqkaK-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f52882624bb750e533d0ffa591c3903f08f6d8bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
        git checkout f52882624bb750e533d0ffa591c3903f08f6d8bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: fs/erofs/fscache.o: in function `erofs_exit_fscache':
>> (.text+0x18): undefined reference to `__fscache_relinquish_volume'
   hppa-linux-ld: fs/erofs/fscache.o: in function `erofs_init_fscache':
>> (.init.text+0x18): undefined reference to `__fscache_acquire_volume'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
