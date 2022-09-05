Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BB5AD9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiIETg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiIETgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:36:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F206C501B5;
        Mon,  5 Sep 2022 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662406613; x=1693942613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6bhltE4/qQ+XMEyN4la0lF82k/ld24yMbh7+xAqjPk=;
  b=EMTFhP87xC9jD+wWySwA+mKjK3DpTrPnP3sWguvp5/ayDXywta2pLuYV
   O1SMip80mley7VRO5iKNNDuAXxeky+5Kv0F6xVN/7l2j+nQLAVmBFkpqo
   Be6ylAgwx6OhaPpWCExnq7Rj2jJ2lLVsg7fHwoVST6j1LqTwbDsc0ens7
   YLN+O0PgVUGcyCwAhi3FOzHWdbbfYI9a2iDSY9cI/7CYxKhLuEgZ31olC
   aQQDGb4+yJRnAGshoud+oalHug08zZuj+cW5WPO9vufoNVZ9JW1Oky/9R
   QAZeSK0Gpr8J5b6kY4HEI9k7aRyfShq67LlP0oOJM4lrDqQJXb9+4Ni3k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276186896"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276186896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 12:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="646991886"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2022 12:36:51 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVHtq-0004U8-2R;
        Mon, 05 Sep 2022 19:36:50 +0000
Date:   Tue, 6 Sep 2022 03:36:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED}
 instead of i_{zero/one_hundred}
Message-ID: <202209060328.fLZUY6st-lkp@intel.com>
References: <20220905124856.2233973-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905124856.2233973-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Liu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linus/master v6.0-rc4 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/kernel-sysctl-test-use-SYSCTL_-ZERO-ONE_HUNDRED-instead-of-i_-zero-one_hundred/20220905-201642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: hexagon-randconfig-r045-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060328.fLZUY6st-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/798f337855db358192d52c40620c4646856d19bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liu-Shixin/kernel-sysctl-test-use-SYSCTL_-ZERO-ONE_HUNDRED-instead-of-i_-zero-one_hundred/20220905-201642
        git checkout 798f337855db358192d52c40620c4646856d19bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: sysctl_vals
   >>> referenced by sysctl-test.c:69 (kernel/sysctl-test.c:69)
   >>>               sysctl-test.o:(sysctl_test_api_dointvec_table_maxlen_unset) in archive kernel/built-in.a
   >>> referenced by sysctl-test.c:69 (kernel/sysctl-test.c:69)
   >>>               sysctl-test.o:(sysctl_test_api_dointvec_table_maxlen_unset) in archive kernel/built-in.a
   >>> referenced by sysctl-test.c:69 (kernel/sysctl-test.c:69)
   >>>               sysctl-test.o:(sysctl_test_api_dointvec_table_maxlen_unset) in archive kernel/built-in.a
   >>> referenced 35 more times

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
