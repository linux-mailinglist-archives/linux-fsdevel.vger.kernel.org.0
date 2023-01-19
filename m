Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4AB672E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 02:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjASBXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 20:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASBVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:21:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE16D363;
        Wed, 18 Jan 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091050; x=1705627050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5YioTq1mi0FQzL5L6+ik6gE1Fz9rrGR1YKFWv3B5uk=;
  b=Ds3/zgRQfS/PhiZxJ/5djSQ9723dihPfUO8HXJ42m2REXbAbvCSd35b4
   4SxbXEazGvDLyCdkavXIpjn6bJEpwrq//j312RyxBPwk5V2Nmf1gpE5tP
   d+l29TcmS98BapN5h2GOzaa7JJIndtogyRsmT645QxZFW5b3mDQ4Mq61Q
   ZTjjGXUsAec2EmNFHrwGdPrtcp8fEW42/3xtBQmD1B/+aQW7VRuwi2/Ao
   Iva9amS/2CT+PZnP2ZuhE09e9KCV3ttSMiNfsV5kpnz9IMCtPJm0K/3ER
   wt+MV3Jcasd12wkEeMznMS3l1ly+TXOhP6lQgjfJv03ketuzuBLDAqs4j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323842330"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323842330"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723314432"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723314432"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 17:17:25 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIJYS-0000vw-12;
        Thu, 19 Jan 2023 01:17:24 +0000
Date:   Thu, 19 Jan 2023 09:16:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <202301190907.YBfaBhHB-lkp@intel.com>
References: <20230118201055.147228-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118201055.147228-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc4 next-20230118]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
patch link:    https://lore.kernel.org/r/20230118201055.147228-4-gregory.price%40memverge.com
patch subject: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230119/202301190907.YBfaBhHB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/bd6833b41ed48c444c09346f695efe229deec2e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
        git checkout bd6833b41ed48c444c09346f695efe229deec2e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/isofs/inode.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/inode.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/dir.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/dir.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/util.o: in function `syscall_user_dispatch_get_config':
   fs/isofs/util.c:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/util.o: in function `syscall_user_dispatch_set_config':
   fs/isofs/util.c:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/rock.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/rock.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/export.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/export.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/joliet.o: in function `syscall_user_dispatch_get_config':
   fs/isofs/joliet.c:49: multiple definition of `syscall_user_dispatch_get_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/isofs/joliet.o: in function `syscall_user_dispatch_set_config':
   fs/isofs/joliet.c:49: multiple definition of `syscall_user_dispatch_set_config'; fs/isofs/namei.o:include/linux/syscall_user_dispatch.h:49: first defined here
--
   ld: fs/autofs/inode.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/inode.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/root.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/root.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/symlink.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/symlink.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/waitq.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/waitq.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/expire.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/expire.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/dev-ioctl.o: in function `syscall_user_dispatch_get_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_get_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here
   ld: fs/autofs/dev-ioctl.o: in function `syscall_user_dispatch_set_config':
>> include/linux/syscall_user_dispatch.h:49: multiple definition of `syscall_user_dispatch_set_config'; fs/autofs/init.o:include/linux/syscall_user_dispatch.h:49: first defined here


vim +49 include/linux/syscall_user_dispatch.h

    44	
    45	int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
    46		void __user *data)
    47	{
    48		return -EINVAL;
  > 49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
