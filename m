Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F558EE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiHJO24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJO2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:28:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426221E25;
        Wed, 10 Aug 2022 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660141733; x=1691677733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JLXzoyOvEjtagIA4zvZCeFvPNymZPUjJlpaPBPMJC7w=;
  b=cSed/nrGAax1E0M3hQWcB6EjVtFaxhZbZI0N+PYHCxWEQJrMr0kWyHpp
   /kyHvSn3W2VK4vjCjxwa8lzbSdzsADpz30pulbYR/igP+buGRU1nBGj/E
   0/lz1BATwDCCqx+xWd0M512eZA3ipCbZK6FaPlf/UsfErimUMxWEqWWL1
   3CCi0TGmj07iJY45xpkErHq4uzsOdu/c+tAgMgIPrxNbPj0NabRL+64P2
   I6ZfjmSZWZQYAemrJYJGv/5O1einoN2+iyPjgedE12TUZ8KJ0xxLfKdaT
   Zyle60SVyMTbIxoWYrfLPFT3uOfsnrGBiyIuXx38d/svSxFvcq0e73sPJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377385308"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="377385308"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 07:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="781246975"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2022 07:28:50 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLmhV-0000LO-2y;
        Wed, 10 Aug 2022 14:28:49 +0000
Date:   Wed, 10 Aug 2022 22:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
Message-ID: <202208102231.qSUdYAdb-lkp@intel.com>
References: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on pcmoore-audit/next linus/master v5.19 next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220810-012825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220810/202208102231.qSUdYAdb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a943676abc023c094f05b45f4d61936c567507a2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Guy-Briggs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220810-012825
        git checkout a943676abc023c094f05b45f4d61936c567507a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/notify/fanotify/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/notify/fanotify/fanotify_user.c:325:35: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                    group, fd, response, info_buf, count);
                                                   ^~~~~
   include/linux/printk.h:594:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +325 fs/notify/fanotify/fanotify_user.c

   312	
   313	static int process_access_response(struct fsnotify_group *group,
   314					   struct fanotify_response *response_struct,
   315					   const char __user *buf,
   316					   size_t count)
   317	{
   318		struct fanotify_perm_event *event;
   319		int fd = response_struct->fd;
   320		u32 response = response_struct->response;
   321		struct fanotify_response_info_header info_hdr;
   322		char *info_buf = NULL;
   323	
   324		pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%lu\n", __func__,
 > 325			 group, fd, response, info_buf, count);
   326		/*
   327		 * make sure the response is valid, if invalid we do nothing and either
   328		 * userspace can send a valid response or we will clean it up after the
   329		 * timeout
   330		 */
   331		if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
   332			return -EINVAL;
   333		switch (response & FANOTIFY_RESPONSE_ACCESS) {
   334		case FAN_ALLOW:
   335		case FAN_DENY:
   336			break;
   337		default:
   338			return -EINVAL;
   339		}
   340		if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
   341			return -EINVAL;
   342		if (fd < 0)
   343			return -EINVAL;
   344		if (response & FAN_INFO) {
   345			size_t c = count;
   346			const char __user *ib = buf;
   347	
   348			if (c <= 0)
   349				return -EINVAL;
   350			while (c >= sizeof(info_hdr)) {
   351				if (copy_from_user(&info_hdr, ib, sizeof(info_hdr)))
   352					return -EFAULT;
   353				if (info_hdr.pad != 0)
   354					return -EINVAL;
   355				if (c < info_hdr.len)
   356					return -EINVAL;
   357				switch (info_hdr.type) {
   358				case FAN_RESPONSE_INFO_AUDIT_RULE:
   359					break;
   360				case FAN_RESPONSE_INFO_NONE:
   361				default:
   362					return -EINVAL;
   363				}
   364				c -= info_hdr.len;
   365				ib += info_hdr.len;
   366			}
   367			if (c != 0)
   368				return -EINVAL;
   369			/* Simplistic check for now */
   370			if (count != sizeof(struct fanotify_response_info_audit_rule))
   371				return -EINVAL;
   372			info_buf = kmalloc(sizeof(struct fanotify_response_info_audit_rule),
   373					   GFP_KERNEL);
   374			if (!info_buf)
   375				return -ENOMEM;
   376			if (copy_from_user(info_buf, buf, count))
   377				return -EFAULT;
   378		}
   379		spin_lock(&group->notification_lock);
   380		list_for_each_entry(event, &group->fanotify_data.access_list,
   381				    fae.fse.list) {
   382			if (event->fd != fd)
   383				continue;
   384	
   385			list_del_init(&event->fae.fse.list);
   386			/* finish_permission_event() eats info_buf */
   387			finish_permission_event(group, event, response_struct,
   388						count, info_buf);
   389			wake_up(&group->fanotify_data.access_waitq);
   390			return 0;
   391		}
   392		spin_unlock(&group->notification_lock);
   393	
   394		return -ENOENT;
   395	}
   396	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
