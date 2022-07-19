Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29457A49A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiGSRGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiGSRG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:06:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF94D17A;
        Tue, 19 Jul 2022 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658250386; x=1689786386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dsJls4KRRqMsihgdj/1B2WwrHafjlZ5+4bCu3VElhgw=;
  b=i8Uxk9eJt+mLzlH1CQmYRq0Aj3IQY4UG+tzANUzPBCdtkVQX0bzfE0Jk
   awM50SF+nbO7eCtmiHrWadRMlWaWKu8wCNx+xtAiMadhz/8l7bjXIn6qy
   8zWWk7tgFfldln/mzuK1QYioTTjlvub9aHUr8sWBbMDf1XVCDghynaz0C
   GANxO6pw1bw0kTwpVdPqB7q23w1e7epQ4RmSUEIV+Ri3ibj7Kj6TvjAJI
   3yxMSFG8UECDjyzpkrRd7yk5c4yHmQQUeNQqumpv+A580jgGvo4ReyYgY
   Cswvo2EAlMf2xyyZk3yL/QrkTCrlRMEagKDBNBu8btyYnCnhel+eFBMaC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269570882"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="269570882"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="665514274"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2022 10:06:22 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDqft-0005qE-ME;
        Tue, 19 Jul 2022 17:06:21 +0000
Date:   Wed, 20 Jul 2022 01:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: Re: [PATCH v3] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <202207200113.9R6VYmdT-lkp@intel.com>
References: <20220719065551.154132-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719065551.154132-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeremy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v5.19-rc7 next-20220719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Bongio/Add-ioctls-to-get-set-the-ext4-superblock-uuid/20220719-145724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: i386-randconfig-a005-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200113.9R6VYmdT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d53b0a271606a7f5c7b0f1a1f3fec9a34e771205
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeremy-Bongio/Add-ioctls-to-get-set-the-ext4-superblock-uuid/20220719-145724
        git checkout d53b0a271606a7f5c7b0f1a1f3fec9a34e771205
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/ioctl.c:1149:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret = 0;
               ^
   1 warning generated.


vim +/ret +1149 fs/ext4/ioctl.c

  1145	
  1146	static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
  1147				struct fsuuid __user *ufsuuid)
  1148	{
> 1149		int ret = 0;
  1150		struct fsuuid fsuuid;
  1151		__u8 uuid[UUID_SIZE];
  1152	
  1153		if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
  1154			return -EFAULT;
  1155	
  1156		if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
  1157			return -EINVAL;
  1158	
  1159		lock_buffer(sbi->s_sbh);
  1160		memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
  1161		unlock_buffer(sbi->s_sbh);
  1162	
  1163		if (copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
  1164			return -EFAULT;
  1165		return 0;
  1166	}
  1167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
