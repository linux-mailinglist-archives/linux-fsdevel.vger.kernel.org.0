Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6F59825F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiHRLkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiHRLkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:40:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62526AA13;
        Thu, 18 Aug 2022 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660822803; x=1692358803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/sD5Of/3mVimLtQjOLOs/5oU2pRV+HIR8Nl9iA9iho=;
  b=CtamzSkFcJzcFyCcZOJsqg9R3dgmHz8YvAlk/ONFCmF5+d/a81EJA/Bl
   HM5pIuAR9xkfiiGBEXnrzAeGBA/q8/F9pZrZzB9KEa0pp0JgX5AHuMJbl
   u7ANeqDz6IEH0KyfLfVVJAbfrRQV1jYksRrSUnXOlBjn0Uobg+TmhKaS7
   nD9ZtQeS5oC5WbkJCH0I2V6yXidmESJ+SA2eFgCKpvAcDgaac7rnqjQpN
   BVLLtcrlO4l39w560Vrh6kkrsB58L8YcL/sviuOWneQnP483Jr1aI7v+n
   sXFHgjF5QvUZAE+Dt82fRp7r4z8YMlj6EAR7lwfmHkvc8Ef/1zKIhGTkH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293526487"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="293526487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="676030723"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2022 04:39:48 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOdsG-0000SF-1r;
        Thu, 18 Aug 2022 11:39:44 +0000
Date:   Thu, 18 Aug 2022 19:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        osalvador@suse.de, surenb@google.com, mawupeng1@huawei.com,
        rppt@kernel.org, charante@codeaurora.org, jsavitz@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
Message-ID: <202208181955.CIEgocmg-lkp@intel.com>
References: <20220818090430.2859992-3-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818090430.2859992-3-mawupeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wupeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220818]

url:    https://github.com/intel-lab-lkp/linux/commits/Wupeng-Ma/watermark-related-improvement-on-zone-movable/20220818-170659
base:    5b6a4bf680d61b1dd26629840f848d0df8983c62
config: s390-randconfig-r011-20220818 (https://download.01.org/0day-ci/archive/20220818/202208181955.CIEgocmg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d126658752d146244ef366f63b8edbb797dc5436
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wupeng-Ma/watermark-related-improvement-on-zone-movable/20220818-170659
        git checkout d126658752d146244ef366f63b8edbb797dc5436
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/page_alloc.o: in function `watermark_scale_factor_sysctl_handler':
   page_alloc.c:(.text+0xbaa2): undefined reference to `sysctl_vals'
>> s390-linux-ld: page_alloc.c:(.text+0xbaae): undefined reference to `sysctl_vals'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
