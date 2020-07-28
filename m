Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C382230722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgG1KBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 06:01:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:58641 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgG1KBb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:01:31 -0400
IronPort-SDR: HK+lxVu/2p6ld/arFTyk63oi+OsRSmSWC1OGacF0iX4o1WLkbFx7CdcBrvbPuVXEGQBNlZ//YK
 emb3K/yZOwSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152433535"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="gz'50?scan'50,208,50";a="152433535"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:01:24 -0700
IronPort-SDR: EixsaEK9Wpf1QnLILzCVyED97W1tldsHXOeUq0ghHnT+JvkY8Ss94QLK+8WBZMMXDK2TbyE976
 J15swMlBxDcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="gz'50?scan'50,208,50";a="394284626"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2020 03:01:17 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0MQ5-000059-Gu; Tue, 28 Jul 2020 10:01:13 +0000
Date:   Tue, 28 Jul 2020 18:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xi Wang <xii@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xi Wang <xii@google.com>
Subject: Re: [PATCH] sched: Make select_idle_sibling search domain
 configurable
Message-ID: <202007281716.JUok2FkW%lkp@intel.com>
References: <20200728070131.1629670-1-xii@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20200728070131.1629670-1-xii@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xi,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/auto-latest linus/master v5.8-rc7]
[cannot apply to block/for-next cgroup/for-next next-20200727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xi-Wang/sched-Make-select_idle_sibling-search-domain-configurable/20200728-150328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 13efa616124f7eec7d6a58adeeef31864aa03879
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/kthread.c:20:
   include/linux/cpuset.h: In function 'cpuset_update_active_cpus':
>> include/linux/cpuset.h:177:2: error: too many arguments to function 'partition_sched_domains'
     177 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpuset.h:13,
                    from kernel/kthread.c:20:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/kthread.c:20:
   include/linux/cpuset.h: In function 'rebuild_sched_domains':
   include/linux/cpuset.h:263:2: error: too many arguments to function 'partition_sched_domains'
     263 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpuset.h:13,
                    from kernel/kthread.c:20:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/kthread.c:20:
   include/linux/cpuset.h: In function 'rebuild_sched_domains_force':
   include/linux/cpuset.h:268:2: error: too many arguments to function 'partition_sched_domains'
     268 |  partition_sched_domains(1, NULL, NULL, 1);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpuset.h:13,
                    from kernel/kthread.c:20:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/core.c:13:
   include/linux/cpuset.h: In function 'cpuset_update_active_cpus':
>> include/linux/cpuset.h:177:2: error: too many arguments to function 'partition_sched_domains'
     177 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/core.c:13:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/core.c:13:
   include/linux/cpuset.h: In function 'rebuild_sched_domains':
   include/linux/cpuset.h:263:2: error: too many arguments to function 'partition_sched_domains'
     263 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/core.c:13:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/core.c:13:
   include/linux/cpuset.h: In function 'rebuild_sched_domains_force':
   include/linux/cpuset.h:268:2: error: too many arguments to function 'partition_sched_domains'
     268 |  partition_sched_domains(1, NULL, NULL, 1);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/core.c:13:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: In function 'ttwu_stat':
   kernel/sched/core.c:2319:13: warning: variable 'rq' set but not used [-Wunused-but-set-variable]
    2319 |  struct rq *rq;
         |             ^~
--
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/fair.c:23:
   include/linux/cpuset.h: In function 'cpuset_update_active_cpus':
>> include/linux/cpuset.h:177:2: error: too many arguments to function 'partition_sched_domains'
     177 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/fair.c:23:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/fair.c:23:
   include/linux/cpuset.h: In function 'rebuild_sched_domains':
   include/linux/cpuset.h:263:2: error: too many arguments to function 'partition_sched_domains'
     263 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/fair.c:23:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/fair.c:23:
   include/linux/cpuset.h: In function 'rebuild_sched_domains_force':
   include/linux/cpuset.h:268:2: error: too many arguments to function 'partition_sched_domains'
     268 |  partition_sched_domains(1, NULL, NULL, 1);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/fair.c:23:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:5364:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5364 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11165:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11165 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11167:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11167 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11172:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11172 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11174:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11174 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/rt.c:6:
   include/linux/cpuset.h: In function 'cpuset_update_active_cpus':
>> include/linux/cpuset.h:177:2: error: too many arguments to function 'partition_sched_domains'
     177 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/rt.c:6:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/rt.c:6:
   include/linux/cpuset.h: In function 'rebuild_sched_domains':
   include/linux/cpuset.h:263:2: error: too many arguments to function 'partition_sched_domains'
     263 |  partition_sched_domains(1, NULL, NULL, 0);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/rt.c:6:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:44,
                    from kernel/sched/rt.c:6:
   include/linux/cpuset.h: In function 'rebuild_sched_domains_force':
   include/linux/cpuset.h:268:2: error: too many arguments to function 'partition_sched_domains'
     268 |  partition_sched_domains(1, NULL, NULL, 1);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/sched.h:31,
                    from kernel/sched/rt.c:6:
   include/linux/sched/topology.h:208:1: note: declared here
     208 | partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         | ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:253:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     253 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:255:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     255 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:668:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     668 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/partition_sched_domains +177 include/linux/cpuset.h

   174	
   175	static inline void cpuset_update_active_cpus(void)
   176	{
 > 177		partition_sched_domains(1, NULL, NULL, 0);
   178	}
   179	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--XsQoSWH+UP9D9v3l--
