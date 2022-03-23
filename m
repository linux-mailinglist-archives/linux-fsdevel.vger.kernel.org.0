Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA34E4A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiCWBiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiCWBiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:38:08 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C311A20;
        Tue, 22 Mar 2022 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647999399; x=1679535399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7Hv6TGPYjfl8Im7U1axrYGriaS+TMvEbfrlFIFsNSU=;
  b=bLek4mELZ/viSelozJ8o7u/QWqi9dpTU/UegooLbuFtZSOIHGEUv2S8Z
   SniDkqgv+M1SXrJQ3mFyfQQpdtUBSni2Z7zUv3XGAXXt1ERRhShFTQ7Mp
   kHry7dTCZja/2uRA4loWTjA7EPstfknW8f6yayqLo1Vvm1G/qsO2Qan5S
   CHGm2ToVIHkGMsD72rsjxklbYjeyjRTMvc6kfOOQj8ITQk1jypcpqUqKM
   N3fgKa4VPvJdkxjlE1u+XISkLR+gN4P0Tol9Cx1cay1aUzuU0kl0dskUg
   YBYwjghoCNcYeAWbKtd45b0KMDqzFmSYHlwSvu0qutDe8YnAR2LVgVE4y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="318706960"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="318706960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 18:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="649246588"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2022 18:36:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWpvQ-000JVC-O9; Wed, 23 Mar 2022 01:36:36 +0000
Date:   Wed, 23 Mar 2022 09:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Kitt <steve@sk2.org>, Matthew Wilcox <willy@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] idr: Remove unused ida_simple_{get,remove}
Message-ID: <202203230914.b9Om2yrQ-lkp@intel.com>
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
config: arm-randconfig-p002-20220320 (https://download.01.org/0day-ci/archive/20220323/202203230914.b9Om2yrQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/13945a32161b59a82eca06de385ea0f38b88439e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephen-Kitt/idr-Remove-unused-ida_simple_-get-remove/20220323-062521
        git checkout 13945a32161b59a82eca06de385ea0f38b88439e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/base/ drivers/firmware/arm_scmi/ drivers/usb/chipidea/ drivers/usb/gadget/function/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/soc.c: In function 'soc_release':
>> drivers/base/soc.c:107:9: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     107 |         ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
         |         ^~~~~~~~~~~~~~~~~
   drivers/base/soc.c: In function 'soc_device_register':
>> drivers/base/soc.c:142:15: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     142 |         ret = ida_simple_get(&soc_ida, 0, 0, GFP_KERNEL);
         |               ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/firmware/arm_scmi/bus.c: In function 'scmi_device_create':
>> drivers/firmware/arm_scmi/bus.c:184:14: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     184 |         id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
         |              ^~~~~~~~~~~~~~
>> drivers/firmware/arm_scmi/bus.c:207:9: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     207 |         ida_simple_remove(&scmi_bus_id, id);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/usb/chipidea/core.c: In function 'ci_hdrc_add_device':
>> drivers/usb/chipidea/core.c:856:14: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
     856 |         id = ida_simple_get(&ci_ida, 0, 0, GFP_KERNEL);
         |              ^~~~~~~~~~~~~~
>> drivers/usb/chipidea/core.c:886:9: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
     886 |         ida_simple_remove(&ci_ida, id);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/usb/gadget/function/f_hid.c: In function 'hidg_get_minor':
>> drivers/usb/gadget/function/f_hid.c:1031:15: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
    1031 |         ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
         |               ^~~~~~~~~~~~~~
>> drivers/usb/gadget/function/f_hid.c:1033:17: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
    1033 |                 ida_simple_remove(&hidg_ida, ret);
         |                 ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/usb/gadget/function/f_printer.c: In function 'gprinter_get_minor':
>> drivers/usb/gadget/function/f_printer.c:1319:15: error: implicit declaration of function 'ida_simple_get' [-Werror=implicit-function-declaration]
    1319 |         ret = ida_simple_get(&printer_ida, 0, 0, GFP_KERNEL);
         |               ^~~~~~~~~~~~~~
>> drivers/usb/gadget/function/f_printer.c:1321:17: error: implicit declaration of function 'ida_simple_remove' [-Werror=implicit-function-declaration]
    1321 |                 ida_simple_remove(&printer_ida, ret);
         |                 ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ida_simple_remove +107 drivers/base/soc.c

74d1d82cdaaec7 Lee Jones          2012-02-06  102  
74d1d82cdaaec7 Lee Jones          2012-02-06  103  static void soc_release(struct device *dev)
74d1d82cdaaec7 Lee Jones          2012-02-06  104  {
74d1d82cdaaec7 Lee Jones          2012-02-06  105  	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
74d1d82cdaaec7 Lee Jones          2012-02-06  106  
c31e73121f4c1e Murali Nalajala    2019-10-07 @107  	ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
c31e73121f4c1e Murali Nalajala    2019-10-07  108  	kfree(soc_dev->dev.groups);
74d1d82cdaaec7 Lee Jones          2012-02-06  109  	kfree(soc_dev);
74d1d82cdaaec7 Lee Jones          2012-02-06  110  }
74d1d82cdaaec7 Lee Jones          2012-02-06  111  
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  112  static struct soc_device_attribute *early_soc_dev_attr;
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  113  
74d1d82cdaaec7 Lee Jones          2012-02-06  114  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
74d1d82cdaaec7 Lee Jones          2012-02-06  115  {
74d1d82cdaaec7 Lee Jones          2012-02-06  116  	struct soc_device *soc_dev;
c31e73121f4c1e Murali Nalajala    2019-10-07  117  	const struct attribute_group **soc_attr_groups;
74d1d82cdaaec7 Lee Jones          2012-02-06  118  	int ret;
74d1d82cdaaec7 Lee Jones          2012-02-06  119  
1da1b3628df34a Geert Uytterhoeven 2016-09-27  120  	if (!soc_bus_type.p) {
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  121  		if (early_soc_dev_attr)
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  122  			return ERR_PTR(-EBUSY);
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  123  		early_soc_dev_attr = soc_dev_attr;
6e12db376b60b7 Geert Uytterhoeven 2017-03-09  124  		return NULL;
1da1b3628df34a Geert Uytterhoeven 2016-09-27  125  	}
1da1b3628df34a Geert Uytterhoeven 2016-09-27  126  
74d1d82cdaaec7 Lee Jones          2012-02-06  127  	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
74d1d82cdaaec7 Lee Jones          2012-02-06  128  	if (!soc_dev) {
74d1d82cdaaec7 Lee Jones          2012-02-06  129  		ret = -ENOMEM;
74d1d82cdaaec7 Lee Jones          2012-02-06  130  		goto out1;
74d1d82cdaaec7 Lee Jones          2012-02-06  131  	}
74d1d82cdaaec7 Lee Jones          2012-02-06  132  
c31e73121f4c1e Murali Nalajala    2019-10-07  133  	soc_attr_groups = kcalloc(3, sizeof(*soc_attr_groups), GFP_KERNEL);
c31e73121f4c1e Murali Nalajala    2019-10-07  134  	if (!soc_attr_groups) {
c31e73121f4c1e Murali Nalajala    2019-10-07  135  		ret = -ENOMEM;
c31e73121f4c1e Murali Nalajala    2019-10-07  136  		goto out2;
c31e73121f4c1e Murali Nalajala    2019-10-07  137  	}
c31e73121f4c1e Murali Nalajala    2019-10-07  138  	soc_attr_groups[0] = &soc_attr_group;
c31e73121f4c1e Murali Nalajala    2019-10-07  139  	soc_attr_groups[1] = soc_dev_attr->custom_attr_group;
c31e73121f4c1e Murali Nalajala    2019-10-07  140  
74d1d82cdaaec7 Lee Jones          2012-02-06  141  	/* Fetch a unique (reclaimable) SOC ID. */
cfcf6a91aa0d59 Lee Duncan         2015-10-01 @142  	ret = ida_simple_get(&soc_ida, 0, 0, GFP_KERNEL);
cfcf6a91aa0d59 Lee Duncan         2015-10-01  143  	if (ret < 0)
c31e73121f4c1e Murali Nalajala    2019-10-07  144  		goto out3;
cfcf6a91aa0d59 Lee Duncan         2015-10-01  145  	soc_dev->soc_dev_num = ret;
74d1d82cdaaec7 Lee Jones          2012-02-06  146  
74d1d82cdaaec7 Lee Jones          2012-02-06  147  	soc_dev->attr = soc_dev_attr;
74d1d82cdaaec7 Lee Jones          2012-02-06  148  	soc_dev->dev.bus = &soc_bus_type;
74d1d82cdaaec7 Lee Jones          2012-02-06  149  	soc_dev->dev.groups = soc_attr_groups;
74d1d82cdaaec7 Lee Jones          2012-02-06  150  	soc_dev->dev.release = soc_release;
74d1d82cdaaec7 Lee Jones          2012-02-06  151  
74d1d82cdaaec7 Lee Jones          2012-02-06  152  	dev_set_name(&soc_dev->dev, "soc%d", soc_dev->soc_dev_num);
74d1d82cdaaec7 Lee Jones          2012-02-06  153  
74d1d82cdaaec7 Lee Jones          2012-02-06  154  	ret = device_register(&soc_dev->dev);
c31e73121f4c1e Murali Nalajala    2019-10-07  155  	if (ret) {
c31e73121f4c1e Murali Nalajala    2019-10-07  156  		put_device(&soc_dev->dev);
c31e73121f4c1e Murali Nalajala    2019-10-07  157  		return ERR_PTR(ret);
c31e73121f4c1e Murali Nalajala    2019-10-07  158  	}
74d1d82cdaaec7 Lee Jones          2012-02-06  159  
74d1d82cdaaec7 Lee Jones          2012-02-06  160  	return soc_dev;
74d1d82cdaaec7 Lee Jones          2012-02-06  161  
74d1d82cdaaec7 Lee Jones          2012-02-06  162  out3:
c31e73121f4c1e Murali Nalajala    2019-10-07  163  	kfree(soc_attr_groups);
74d1d82cdaaec7 Lee Jones          2012-02-06  164  out2:
74d1d82cdaaec7 Lee Jones          2012-02-06  165  	kfree(soc_dev);
74d1d82cdaaec7 Lee Jones          2012-02-06  166  out1:
74d1d82cdaaec7 Lee Jones          2012-02-06  167  	return ERR_PTR(ret);
74d1d82cdaaec7 Lee Jones          2012-02-06  168  }
f7ccc7a397cf2e Vinod Koul         2019-07-24  169  EXPORT_SYMBOL_GPL(soc_device_register);
74d1d82cdaaec7 Lee Jones          2012-02-06  170  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
