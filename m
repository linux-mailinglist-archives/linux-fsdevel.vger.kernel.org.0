Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADC57980C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiGSK7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiGSK7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:59:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93338402DE;
        Tue, 19 Jul 2022 03:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658228391; x=1689764391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bSmUzbv50MoCMtRypEXtfh6RjAfCJIPeIp2ZKzXLmPw=;
  b=NuXsTLBh+99g5BaRITW96wzxIdEHJESN09WwY6pDWD3hHM6gX/Zui4R8
   7yaRwsFCQiXpOmCsNvX1Z7a5Q3TEhdtHVnh/G5qA/8QXIgzZeZUQUnL5j
   hV+/a7/ZjRYuXtGour4YqTpLaDjqz711TN/cT0XQOt0HwZNjanJpQeAcg
   pv62uY2GGDDbrQtem0lFtCWyVN7EUIRNVeelXV+IFLSIMnEoSLXzcMkPx
   Vbbh3hs9+lhMhyWGmvxExKqpPkS9XlX2LDLPi3/zFkE45hQwNIevx8mO2
   geetoTE1OW9EEscEHB3bzRi+xBzPlr4jwGbzlOh6V5YsQ7yTTLotJNMIS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350424566"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="350424566"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 03:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="724219420"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 03:59:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDkxA-0005a6-Vg;
        Tue, 19 Jul 2022 10:59:48 +0000
Date:   Tue, 19 Jul 2022 18:59:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>
Subject: Re: [PATCH v3] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <202207191835.R8aDmooK-lkp@intel.com>
References: <20220719065551.154132-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719065551.154132-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeremy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v5.19-rc7 next-20220718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Bongio/Add-ioctls-to-get-set-the-ext4-superblock-uuid/20220719-145724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220719/202207191835.R8aDmooK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d53b0a271606a7f5c7b0f1a1f3fec9a34e771205
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeremy-Bongio/Add-ioctls-to-get-set-the-ext4-superblock-uuid/20220719-145724
        git checkout d53b0a271606a7f5c7b0f1a1f3fec9a34e771205
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ext4/ioctl.c: In function 'ext4_ioctl_getuuid':
>> fs/ext4/ioctl.c:1149:13: warning: unused variable 'ret' [-Wunused-variable]
    1149 |         int ret = 0;
         |             ^~~


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
