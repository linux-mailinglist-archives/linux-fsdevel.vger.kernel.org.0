Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0856546EEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350683AbiFJVC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbiFJVC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:02:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC421008;
        Fri, 10 Jun 2022 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654894977; x=1686430977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ITqyNN6aMfLgWrZqGcYWjoDoxlzkxWNBkOIz9CdtswQ=;
  b=WykKd0jY4dJx2z7tstMKwRCvWaRs5dcgAPMhCphYJR9nZV85v3REbSiy
   gE0k5YcR+v7/wNm/pph4SzfYgUJyRvHgG2pEs9YWQ6aSt0Ip6quqJosxi
   I3pOgFIqXYpGJ+fE3I1BorHtQ6TlC7zBE3Yw3Y4fypIdm948edWkNdKwi
   WURk9j54gwnzFGs2K7KKM0hX/a84kEr8CzV5wcMNpYlYCzzxsWCP2fDMo
   OVCcsiHqIwqD7shTovx0s7eMHqHI1mdo4n+uYHslQeCtDtrjzh+yNZeRK
   eWWfzrHikKv5PbEj0QAmtIaivC67DYJj3ZHHfs7QHy79Hy2xYMtFZ2Tyt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="303128029"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="303128029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 14:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="725144484"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2022 14:02:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzlmN-000IHB-VP;
        Fri, 10 Jun 2022 21:02:51 +0000
Date:   Sat, 11 Jun 2022 05:02:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ia64@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add CABA tree to task_struct
Message-ID: <202206110409.b8UJYnuq-lkp@intel.com>
References: <20220610163214.49974-2-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610163214.49974-2-ptikhomirov@virtuozzo.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on kees/for-next/execve tip/sched/core linus/master v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220611-003433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220611/202206110409.b8UJYnuq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0875a2bed5ff95643c487dfcc28a550db06ea418
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220611-003433
        git checkout 0875a2bed5ff95643c487dfcc28a550db06ea418
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/proc/array.c: In function 'task_state':
>> fs/proc/array.c:157:15: warning: unused variable 'caba_pids' [-Wunused-variable]
     157 |         pid_t caba_pids[MAX_PID_NS_LEVEL] = {};
         |               ^~~~~~~~~
>> fs/proc/array.c:156:13: warning: unused variable 'caba_level' [-Wunused-variable]
     156 |         int caba_level = 0;
         |             ^~~~~~~~~~
>> fs/proc/array.c:155:21: warning: unused variable 'caba_pid' [-Wunused-variable]
     155 |         struct pid *caba_pid;
         |                     ^~~~~~~~
>> fs/proc/array.c:154:29: warning: unused variable 'caba' [-Wunused-variable]
     154 |         struct task_struct *caba;
         |                             ^~~~


vim +/caba_pids +157 fs/proc/array.c

   143	
   144	static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
   145					struct pid *pid, struct task_struct *p)
   146	{
   147		struct user_namespace *user_ns = seq_user_ns(m);
   148		struct group_info *group_info;
   149		int g, umask = -1;
   150		struct task_struct *tracer;
   151		const struct cred *cred;
   152		pid_t ppid, tpid = 0, tgid, ngid;
   153		unsigned int max_fds = 0;
 > 154		struct task_struct *caba;
 > 155		struct pid *caba_pid;
 > 156		int caba_level = 0;
 > 157		pid_t caba_pids[MAX_PID_NS_LEVEL] = {};
   158	
   159		rcu_read_lock();
   160		ppid = pid_alive(p) ?
   161			task_tgid_nr_ns(rcu_dereference(p->real_parent), ns) : 0;
   162	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
