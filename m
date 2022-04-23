Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D57A50C763
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 06:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiDWE3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 00:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiDWE3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 00:29:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B704E6441;
        Fri, 22 Apr 2022 21:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650688007; x=1682224007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ml0TS+9I0iNoLYUgBGKFcxsSut//WkkULNAjxgIoNc=;
  b=NRzrpDqJYIzLgQcX8yKOKl0uRU2m2DmZaJMOgPxlbIlz2+x+P8BWCaHm
   oP4ZYa444DUAMdSLItTYHyK0EVBeeKdMOOTQAFzYNZ/JUMoIrDrwsRyNl
   gKF0sc46aew04DRLmC+CLftbTlsKttT+r32D8ZBa27+PPp6zqo+xbnIf8
   Eh9p/wmG7RmdhPKDtkVmxU4giB75yrLcEvpZhiso0wgMfDsmjrjPelW85
   Zp1LYkuiNI0d9SYqjfjqur8INEEXjpJWNHMLEJCPQ38zMsG5+JN5OeDaw
   c4IYab1KHvWElyq1C7TOH0sI41TQBUK+FD+aqQg1NGUT1TT9W0dxCvfNW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325299705"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="325299705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="703818105"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2022 21:26:43 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni7M3-000Azh-6w;
        Sat, 23 Apr 2022 04:26:43 +0000
Date:   Sat, 23 Apr 2022 12:26:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Junwen Wu <wudaemon@163.com>, akpm@linux-foundation.org,
        keescook@chromium.org, adobriyan@gmail.com, fweimer@redhat.com,
        ddiss@suse.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Message-ID: <202204231250.LYIILAXn-lkp@intel.com>
References: <20220423023104.153004-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Junwen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on kees/for-next/pstore linus/master linux/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Junwen-Wu/proc-limit-schedstate-node-write-operation/20220423-103457
base:   https://github.com/hnaz/linux-mm master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220423/202204231250.LYIILAXn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e7bc039b7c0aa4e9a5bb3ae2340769a451f795db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Junwen-Wu/proc-limit-schedstate-node-write-operation/20220423-103457
        git checkout e7bc039b7c0aa4e9a5bb3ae2340769a451f795db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/proc/base.c: In function 'sched_write':
>> fs/proc/base.c:1468:13: warning: 'strcmp' of a string of length 5 and an array of size 5 evaluates to nonzero [-Wstring-compare]
    1468 |         if (strcmp(ubuf, "reset") == 0) {
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/strcmp +1468 fs/proc/base.c

  1454	
  1455	static ssize_t
  1456	sched_write(struct file *file, const char __user *buf,
  1457		    size_t count, loff_t *offset)
  1458	{
  1459		struct inode *inode = file_inode(file);
  1460		struct task_struct *p;
  1461		char ubuf[5];
  1462	
  1463		memset(ubuf, 0, sizeof(ubuf));
  1464		if (count > 5)
  1465			count = 0;
  1466		if (copy_from_user(ubuf, buf, count))
  1467			return -EFAULT;
> 1468		if (strcmp(ubuf, "reset") == 0) {
  1469			p = get_proc_task(inode);
  1470			if (!p)
  1471				return -ESRCH;
  1472			proc_sched_set_task(p);
  1473	
  1474			put_task_struct(p);
  1475		}
  1476	
  1477		return count;
  1478	}
  1479	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
