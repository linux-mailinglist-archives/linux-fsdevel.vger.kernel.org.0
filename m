Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAE6B85E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 00:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCMXJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCMXJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:09:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03638C83B;
        Mon, 13 Mar 2023 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748933; x=1710284933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KshWSejkFbkeVBwakT7QiRHIr/W7baLNEGoxZeDhpeo=;
  b=c6+sPB9rnTyoE8r5QWk8wv7EiOqEu1Dct4dzAczEz1NfnzM3thHe4oQn
   6gGIodcueU1evOQIJ5iq2OVgrAgo8dhXLEyW4ulCtArO8u+Bo8ht5G5K8
   tgbY9FLsesTQyG3pme/+GwR3Z3M70evR8NLQk2PblSpK3/ujLPUIgOtgX
   QJ/uMBsK2jEkTh8IR+jAPect5WwLuOICUrbVl9lyDpPrPoknaxWRsaqvy
   K8E0ORL/ljiKt2uK7efEIapNOFaqeBj/K98f11WfoOFxcaFbc91Euz7Ed
   kSJ9VSxB1Q+qJTcYfg67QB2A7PmoBh2TSXSl2aH5ZmdjEVpZFQWN1kzlX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399871312"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="399871312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 16:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628806685"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="628806685"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 16:08:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbrHe-0006EC-0e;
        Mon, 13 Mar 2023 23:08:50 +0000
Date:   Tue, 14 Mar 2023 07:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
Subject: Re: [PATCH] nfs: use vfs setgid helper
Message-ID: <202303140652.dN7XrtM4-lkp@intel.com>
References: <20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

I love your patch! Yet something to improve:

[auto build test ERROR on eeac8ede17557680855031c6f305ece2378af326]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/nfs-use-vfs-setgid-helper/20230313-212725
base:   eeac8ede17557680855031c6f305ece2378af326
patch link:    https://lore.kernel.org/r/20230313-fs-nfs-setgid-v1-1-5b1fa599f186%40kernel.org
patch subject: [PATCH] nfs: use vfs setgid helper
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230314/202303140652.dN7XrtM4-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/503d040be490a519b2e483672702dcca530443ce
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Brauner/nfs-use-vfs-setgid-helper/20230313-212725
        git checkout 503d040be490a519b2e483672702dcca530443ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140652.dN7XrtM4-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfs/nfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
