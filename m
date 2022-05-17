Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F5529ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 09:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiEQH1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiEQH1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 03:27:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F943EED;
        Tue, 17 May 2022 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652772441; x=1684308441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMiGsrSeghOS0yjMoEbRiyjbU0nqO5uR7AcrlNt3J5A=;
  b=ggq73x3T+oyIP0vmECDazyNkvoSAj52VnRNSaqI7GE5OJ0tD0qWJF9Pl
   UjmdDZ1LW7yfkNCjeTK5IlE0O24wjLad5DYfvqChjIbZlZqKB5Pkh6cHI
   R7LlVM4nwxYGjO4u7mQ/1XO6+2i7SlunR8kmIFQgbqOEvinNEiD9nChER
   s4fb/ieOFyZ/1i9Zg46ni9MPJBjMmHjFMe0Oa4Q7HGTFLuA7FMLHE5WHn
   uB1ic2L0AIZ0alc9hkUxVWhIhGqSK421SA+/WVDwOWC98i2YCvRp7C2It
   h/D1ECe0ntQNv3362US5cDKJlb+/IavI0BwSM2+0zLvEnXhvM/WVFSjKT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251607351"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="251607351"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="605228191"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 00:27:11 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqrbr-0000ij-AK;
        Tue, 17 May 2022 07:27:11 +0000
Date:   Tue, 17 May 2022 15:26:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <202205171508.anzweWlm-lkp@intel.com>
References: <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on pcmoore-audit/next linux/master linus/master v5.18-rc7 next-20220516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220517-044904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220517/202205171508.anzweWlm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d1fc23ae264424a2007ef5a3cfc1b4dbc8d82db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220517-044904
        git checkout 4d1fc23ae264424a2007ef5a3cfc1b4dbc8d82db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/notify/fanotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/sysctl.h:26,
                    from include/linux/fanotify.h:5,
                    from fs/notify/fanotify/fanotify_user.c:2:
   fs/notify/fanotify/fanotify_user.c: In function 'process_access_response':
>> fs/notify/fanotify/fanotify_user.c:325:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     325 |         pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:336:21: note: in definition of macro 'pr_fmt'
     336 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
     570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:325:9: note: in expansion of macro 'pr_debug'
     325 |         pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
         |         ^~~~~~~~
   fs/notify/fanotify/fanotify_user.c:325:65: note: format string is defined here
     325 |         pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
         |                                                               ~~^
         |                                                                 |
         |                                                                 long unsigned int
         |                                                               %u


vim +325 fs/notify/fanotify/fanotify_user.c

   316	
   317	static int process_access_response(struct fsnotify_group *group,
   318					   struct fanotify_response *response_struct,
   319					   size_t count)
   320	{
   321		struct fanotify_perm_event *event;
   322		int fd = response_struct->fd;
   323		u32 response = response_struct->response;
   324	
 > 325		pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
   326			 group, fd, response, response_struct->extra_info_type, count);
   327		if (fd < 0)
   328			return -EINVAL;
   329		/*
   330		 * make sure the response is valid, if invalid we do nothing and either
   331		 * userspace can send a valid response or we will clean it up after the
   332		 * timeout
   333		 */
   334		if (FAN_INVALID_RESPONSE_MASK(response))
   335			return -EINVAL;
   336		if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
   337			return -EINVAL;
   338		if (response & FAN_EXTRA) {
   339			if (count < offsetofend(struct fanotify_response, extra_info_type))
   340				return -EINVAL;
   341			switch (response_struct->extra_info_type) {
   342			case FAN_RESPONSE_INFO_NONE:
   343				break;
   344			case FAN_RESPONSE_INFO_AUDIT_RULE:
   345				if (count < offsetofend(struct fanotify_response, extra_info))
   346					return -EINVAL;
   347				break;
   348			default:
   349				return -EINVAL;
   350			}
   351		}
   352		spin_lock(&group->notification_lock);
   353		list_for_each_entry(event, &group->fanotify_data.access_list,
   354				    fae.fse.list) {
   355			if (event->fd != fd)
   356				continue;
   357	
   358			list_del_init(&event->fae.fse.list);
   359			finish_permission_event(group, event, response_struct);
   360			wake_up(&group->fanotify_data.access_waitq);
   361			return 0;
   362		}
   363		spin_unlock(&group->notification_lock);
   364	
   365		return -ENOENT;
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
