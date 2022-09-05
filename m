Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9195AD930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIESpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIESpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:45:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C925AC7F;
        Mon,  5 Sep 2022 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662403552; x=1693939552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EY1MjljdPNHLKX836Z9FTt6MJpjyoZ0H1rkOtcYPbbQ=;
  b=Y5q6ojAgKp82DAFVdFm7zUX3foqm/W9z4WQML/0IkDi+/irHHs8zjKmP
   DuPZyywTyBegQg9sjITCk6q0QSg+eXy/KsKZEPdPw3GOBiJE+DU21cJ/y
   6H4pHI9raEBcXHOSUr6JddPsj0qq1LHim6PRNjeqPK2HH/IA5DiueIsMo
   y7ILYyKA7lEbQqXS6A4HKrtHLPMmJOY5Ws4d7cGHruuaK4wMSCbUIfnSm
   tOx0J1o31XjINWCaebKfKuCSp2mWuOLr5rwUVO7vsaTcryy9RZQhvElRK
   Bf3bRr08uNUqZiopBGloP/l6H8N3dyj/VaCMljtEeeJVcRQTDADtkGFgk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="296443327"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="296443327"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="682143149"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 11:45:50 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVH6T-0004RJ-1N;
        Mon, 05 Sep 2022 18:45:49 +0000
Date:   Tue, 6 Sep 2022 02:45:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED}
 instead of i_{zero/one_hundred}
Message-ID: <202209060226.JaYG1goK-lkp@intel.com>
References: <20220905124856.2233973-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905124856.2233973-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Liu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linus/master v6.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/kernel-sysctl-test-use-SYSCTL_-ZERO-ONE_HUNDRED-instead-of-i_-zero-one_hundred/20220905-201642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: m68k-randconfig-r015-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060226.JaYG1goK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/798f337855db358192d52c40620c4646856d19bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liu-Shixin/kernel-sysctl-test-use-SYSCTL_-ZERO-ONE_HUNDRED-instead-of-i_-zero-one_hundred/20220905-201642
        git checkout 798f337855db358192d52c40620c4646856d19bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: section .rodata VMA [0000000000002000,000000000096449f] overlaps section .text VMA [0000000000000400,0000000000a7156f]
   m68k-linux-ld: kernel/sysctl-test.o: in function `sysctl_test_dointvec_read_happy_single_positive':
>> kernel/sysctl-test.c:185: undefined reference to `sysctl_vals'
   m68k-linux-ld: kernel/sysctl-test.o: in function `sysctl_test_dointvec_read_happy_single_negative':
   kernel/sysctl-test.c:216: undefined reference to `sysctl_vals'
   m68k-linux-ld: kernel/sysctl-test.o: in function `sysctl_test_dointvec_write_happy_single_positive':
   kernel/sysctl-test.c:245: undefined reference to `sysctl_vals'
   m68k-linux-ld: kernel/sysctl-test.o: in function `sysctl_test_dointvec_write_happy_single_negative':
   kernel/sysctl-test.c:275: undefined reference to `sysctl_vals'
   m68k-linux-ld: kernel/sysctl-test.o: in function `sysctl_test_api_dointvec_null_tbl_data':
   kernel/sysctl-test.c:18: undefined reference to `sysctl_vals'
   m68k-linux-ld: kernel/sysctl-test.o:kernel/sysctl-test.c:18: more undefined references to `sysctl_vals' follow
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o


vim +185 kernel/sysctl-test.c

2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  176  
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  177  /*
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  178   * Test that we can read a two digit number in a sufficiently size buffer.
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  179   * Nothing fancy.
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  180   */
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  181  static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  182  {
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  183  	int data = 0;
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  184  	/* Good table. */
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23 @185  	struct ctl_table table = {
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  186  		.procname = "foo",
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  187  		.data		= &data,
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  188  		.maxlen		= sizeof(int),
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  189  		.mode		= 0644,
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  190  		.proc_handler	= proc_dointvec,
798f337855db358 Liu Shixin   2022-09-05  191  		.extra1		= SYSCTL_ZERO,
798f337855db358 Liu Shixin   2022-09-05  192  		.extra2         = SYSCTL_ONE_HUNDRED,
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  193  	};
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  194  	size_t len = 4;
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  195  	loff_t pos = 0;
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  196  	char *buffer = kunit_kzalloc(test, len, GFP_USER);
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  197  	char __user *user_buffer = (char __user *)buffer;
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  198  	/* Store 13 in the data field. */
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  199  	*((int *)table.data) = 13;
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  200  
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  201  	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  202  					       user_buffer, &len, &pos));
388ca2e024dd5e6 David Gow    2021-05-13  203  	KUNIT_ASSERT_EQ(test, 3, len);
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  204  	buffer[len] = '\0';
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  205  	/* And we read 13 back out. */
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  206  	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  207  }
2cb80dbbbaba4f2 Iurii Zaikin 2019-09-23  208  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
