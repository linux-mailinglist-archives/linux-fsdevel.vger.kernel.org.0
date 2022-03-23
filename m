Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549F4E4A0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 01:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiCWA0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 20:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWA0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:26:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEEA1E3C3;
        Tue, 22 Mar 2022 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647995078; x=1679531078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1llhhRuUYu0p3KZy5HGXMGXTBwJ6iG5YHp4KNFFhZQ=;
  b=SL+vQdvottMuaA9g10IXLv6RZ9vxUxsd6Q4fpc7s3asOoccDKqnkGB/V
   J4KG4Xpr3x5VPZgQDFqd2bRm91VfBm5Z16yip/VJ+3YnN19yZiIgwaogp
   //5k4jtAubnreKeO/gN3Ybp3ME0LXHAN9r0RO2OYIyGCl/45VLMBUJ3/T
   8qbWGTDUQlOktpgRm0wy1gZufk+jRfPu8Z/nytkBkPiP6qI+vXaGi10TT
   xsYuJek1aBnXT8C315C2Fzhzy9EIcRNGiKGXMl25CotRyqoVLHMDNKP0Z
   IZJu4jRMDb9ioKglblOI9/iouxLQN1IPMY6JNMDRlZonhdVTCdP5dtoQq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="321186639"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="321186639"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 17:24:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="543960020"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2022 17:24:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWonj-000JS7-K5; Wed, 23 Mar 2022 00:24:35 +0000
Date:   Wed, 23 Mar 2022 08:24:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Kitt <steve@sk2.org>, Matthew Wilcox <willy@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] idr: Remove unused ida_simple_{get,remove}
Message-ID: <202203230845.E0LTB8eP-lkp@intel.com>
References: <20220322220602.985011-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322220602.985011-1-steve@sk2.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stephen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 5191290407668028179f2544a11ae9b57f0bcf07]

url:    https://github.com/0day-ci/linux/commits/Stephen-Kitt/idr-Remove-unused-ida_simple_-get-remove/20220323-062521
base:   5191290407668028179f2544a11ae9b57f0bcf07
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220323/202203230845.E0LTB8eP-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/13945a32161b59a82eca06de385ea0f38b88439e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephen-Kitt/idr-Remove-unused-ida_simple_-get-remove/20220323-062521
        git checkout 13945a32161b59a82eca06de385ea0f38b88439e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/eventfd.c: In function 'eventfd_free_ctx':
>> fs/eventfd.c:92:3: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
      92 |   ida_simple_remove(&eventfd_ida, ctx->id);
         |   ^~~~~~~~~~~~~~~~~
   fs/eventfd.c: In function 'do_eventfd':
>> fs/eventfd.c:426:12: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     426 |  ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
         |            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   fs/proc/generic.c: In function 'proc_alloc_inum':
>> fs/proc/generic.c:206:6: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     206 |  i = ida_simple_get(&proc_inum_ida, 0, UINT_MAX - PROC_DYNAMIC_FIRST + 1,
         |      ^~~~~~~~~~~~~~
   fs/proc/generic.c: In function 'proc_free_inum':
>> fs/proc/generic.c:217:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     217 |  ida_simple_remove(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
         |  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   block/blk-core.c: In function 'blk_alloc_queue':
>> block/blk-core.c:456:10: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     456 |  q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
         |          ^~~~~~~~~~~~~~
>> block/blk-core.c:506:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     506 |  ida_simple_remove(&blk_queue_ida, q->id);
         |  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   block/blk-sysfs.c: In function 'blk_release_queue':
>> block/blk-sysfs.c:796:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     796 |  ida_simple_remove(&blk_queue_ida, q->id);
         |  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/base/swnode.c: In function 'software_node_release':
>> drivers/base/swnode.c:750:3: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     750 |   ida_simple_remove(&swnode->parent->child_ids, swnode->id);
         |   ^~~~~~~~~~~~~~~~~
   drivers/base/swnode.c: In function 'swnode_register':
>> drivers/base/swnode.c:779:8: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     779 |  ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
         |        ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/input/input.c: In function 'input_get_new_minor':
>> drivers/input/input.c:2577:15: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
    2577 |   int minor = ida_simple_get(&input_ida,
         |               ^~~~~~~~~~~~~~
   drivers/input/input.c: In function 'input_free_minor':
>> drivers/input/input.c:2600:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
    2600 |  ida_simple_remove(&input_ida, minor);
         |  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/ptp/ptp_clock.c: In function 'ptp_clock_release':
>> drivers/ptp/ptp_clock.c:177:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     177 |  ida_simple_remove(&ptp_clocks_map, ptp->index);
         |  ^~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_clock.c: In function 'ptp_clock_register':
>> drivers/ptp/ptp_clock.c:212:10: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     212 |  index = ida_simple_get(&ptp_clocks_map, 0, MINORMASK + 1, GFP_KERNEL);
         |          ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   net/core/xdp.c: In function '__xdp_mem_allocator_rcu_free':
>> net/core/xdp.c:76:2: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
      76 |  ida_simple_remove(&mem_id_pool, xa->mem.id);
         |  ^~~~~~~~~~~~~~~~~
   net/core/xdp.c: In function '__mem_id_cyclic_get':
>> net/core/xdp.c:241:7: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     241 |  id = ida_simple_get(&mem_id_pool, mem_id_next, MEM_ID_MAX, gfp);
         |       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ida_simple_remove +92 fs/eventfd.c

e1ad7468c77ddb Davide Libenzi  2007-05-10  88  
562787a5c32ccd Davide Libenzi  2009-09-22  89  static void eventfd_free_ctx(struct eventfd_ctx *ctx)
562787a5c32ccd Davide Libenzi  2009-09-22  90  {
b556db17b0e7c4 Masatake YAMATO 2019-05-14  91  	if (ctx->id >= 0)
b556db17b0e7c4 Masatake YAMATO 2019-05-14 @92  		ida_simple_remove(&eventfd_ida, ctx->id);
562787a5c32ccd Davide Libenzi  2009-09-22  93  	kfree(ctx);
562787a5c32ccd Davide Libenzi  2009-09-22  94  }
562787a5c32ccd Davide Libenzi  2009-09-22  95  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
