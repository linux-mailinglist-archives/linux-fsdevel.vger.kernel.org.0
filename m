Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55B5B2B49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 03:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIIBCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIIBCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:02:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A5E9158;
        Thu,  8 Sep 2022 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662685367; x=1694221367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8H0+71JYH2Oq82RNclvj3h7bCS74rR+edZ/MDVCjJ3Q=;
  b=fve+zVbdfcZlm9egCkDmWL/Gw9r3eBiLzpKPISZc6Xdy9SdWvDL2+Unh
   Kd8DvvEjkgq3d3BjRSUnoIo5n2qBnHzgwcJ9+T/polmCjtKgFzvGDIwcT
   wDZIzGV0H4DFOwWSqRZdV6dGKaq8vVIXe5Y+QClkjde/+MLYWLvbByZkN
   bna8thtXAAKAwX2fMgIWSVQ0k0PzLAwhVL+x+rd1Trwa6imzy0aggEvZd
   EBK4ezNfWMF+CrsLQTHuRwojPOJ+eUEv0EyWpFAnZmWm87Cn5E9KFDU4V
   IAgTmo0FipxLiudK5fOziQzVlTFstZud0uBIjZDLmhGzIgetkYDhVFy4I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298168651"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298168651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740881026"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 18:02:39 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWSPm-0000Wb-1x;
        Fri, 09 Sep 2022 01:02:38 +0000
Date:   Fri, 9 Sep 2022 09:02:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ia64@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH v3 1/2] Add CABA tree to task_struct
Message-ID: <202209090830.H0tKErRt-lkp@intel.com>
References: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on kees/for-next/execve tip/sched/core linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
config: microblaze-randconfig-s053-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090830.H0tKErRt-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/17a897a33137d4f49f99c8be8d619f6f711fccdb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
        git checkout 17a897a33137d4f49f99c8be8d619f6f711fccdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu * @@
   kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *
   kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1648:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:36: sparse:     expected void const *
   kernel/fork.c:1648:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2077:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2077:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2077:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2081:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2081:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2081:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2403:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *register [addressable] [toplevel] current @@
   kernel/fork.c:2403:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2403:32: sparse:     got struct task_struct *register [addressable] [toplevel] current
>> kernel/fork.c:2407:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *caba @@     got struct task_struct *register [addressable] [toplevel] current @@
   kernel/fork.c:2407:17: sparse:     expected struct task_struct [noderef] __rcu *caba
   kernel/fork.c:2407:17: sparse:     got struct task_struct *register [addressable] [toplevel] current
   kernel/fork.c:2413:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2413:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2413:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2460:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2460:54: sparse:     expected struct list_head *head
   kernel/fork.c:2460:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2461:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2461:51: sparse:     expected struct list_head *head
   kernel/fork.c:2461:51: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2482:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2482:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2482:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2503:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2503:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2503:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2530:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2530:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2530:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2559:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2559:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2559:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2561:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2561:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2561:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2997:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2997:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2997:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3078:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3078:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3078:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1742:9: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2122:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/microblaze/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2458:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2459:59: sparse: sparse: dereference of noderef expression

vim +2407 kernel/fork.c

  2355	
  2356		/*
  2357		 * Ensure that the cgroup subsystem policies allow the new process to be
  2358		 * forked. It should be noted that the new process's css_set can be changed
  2359		 * between here and cgroup_post_fork() if an organisation operation is in
  2360		 * progress.
  2361		 */
  2362		retval = cgroup_can_fork(p, args);
  2363		if (retval)
  2364			goto bad_fork_put_pidfd;
  2365	
  2366		/*
  2367		 * Now that the cgroups are pinned, re-clone the parent cgroup and put
  2368		 * the new task on the correct runqueue. All this *before* the task
  2369		 * becomes visible.
  2370		 *
  2371		 * This isn't part of ->can_fork() because while the re-cloning is
  2372		 * cgroup specific, it unconditionally needs to place the task on a
  2373		 * runqueue.
  2374		 */
  2375		sched_cgroup_fork(p, args);
  2376	
  2377		/*
  2378		 * From this point on we must avoid any synchronous user-space
  2379		 * communication until we take the tasklist-lock. In particular, we do
  2380		 * not want user-space to be able to predict the process start-time by
  2381		 * stalling fork(2) after we recorded the start_time but before it is
  2382		 * visible to the system.
  2383		 */
  2384	
  2385		p->start_time = ktime_get_ns();
  2386		p->start_boottime = ktime_get_boottime_ns();
  2387	
  2388		/*
  2389		 * Make it visible to the rest of the system, but dont wake it up yet.
  2390		 * Need tasklist lock for parent etc handling!
  2391		 */
  2392		write_lock_irq(&tasklist_lock);
  2393	
  2394		/* CLONE_PARENT re-uses the old parent */
  2395		if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
  2396			p->real_parent = current->real_parent;
  2397			p->parent_exec_id = current->parent_exec_id;
  2398			if (clone_flags & CLONE_THREAD)
  2399				p->exit_signal = -1;
  2400			else
  2401				p->exit_signal = current->group_leader->exit_signal;
  2402		} else {
  2403			p->real_parent = current;
  2404			p->parent_exec_id = current->self_exec_id;
  2405			p->exit_signal = args->exit_signal;
  2406		}
> 2407		p->caba = current;
  2408	
  2409		klp_copy_process(p);
  2410	
  2411		sched_core_fork(p);
  2412	
  2413		spin_lock(&current->sighand->siglock);
  2414	
  2415		/*
  2416		 * Copy seccomp details explicitly here, in case they were changed
  2417		 * before holding sighand lock.
  2418		 */
  2419		copy_seccomp(p);
  2420	
  2421		rv_task_fork(p);
  2422	
  2423		rseq_fork(p, clone_flags);
  2424	
  2425		/* Don't start children in a dying pid namespace */
  2426		if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
  2427			retval = -ENOMEM;
  2428			goto bad_fork_cancel_cgroup;
  2429		}
  2430	
  2431		/* Let kill terminate clone/fork in the middle */
  2432		if (fatal_signal_pending(current)) {
  2433			retval = -EINTR;
  2434			goto bad_fork_cancel_cgroup;
  2435		}
  2436	
  2437		init_task_pid_links(p);
  2438		if (likely(p->pid)) {
  2439			ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
  2440	
  2441			init_task_pid(p, PIDTYPE_PID, pid);
  2442			if (thread_group_leader(p)) {
  2443				init_task_pid(p, PIDTYPE_TGID, pid);
  2444				init_task_pid(p, PIDTYPE_PGID, task_pgrp(current));
  2445				init_task_pid(p, PIDTYPE_SID, task_session(current));
  2446	
  2447				if (is_child_reaper(pid)) {
  2448					ns_of_pid(pid)->child_reaper = p;
  2449					p->signal->flags |= SIGNAL_UNKILLABLE;
  2450				}
  2451				p->signal->shared_pending.signal = delayed.signal;
  2452				p->signal->tty = tty_kref_get(current->signal->tty);
  2453				/*
  2454				 * Inherit has_child_subreaper flag under the same
  2455				 * tasklist_lock with adding child to the process tree
  2456				 * for propagate_has_child_subreaper optimization.
  2457				 */
  2458				p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
  2459								 p->real_parent->signal->is_child_subreaper;
  2460				list_add_tail(&p->sibling, &p->real_parent->children);
  2461				list_add_tail(&p->cabd, &p->caba->cabds);
  2462				list_add_tail_rcu(&p->tasks, &init_task.tasks);
  2463				attach_pid(p, PIDTYPE_TGID);
  2464				attach_pid(p, PIDTYPE_PGID);
  2465				attach_pid(p, PIDTYPE_SID);
  2466				__this_cpu_inc(process_counts);
  2467			} else {
  2468				current->signal->nr_threads++;
  2469				atomic_inc(&current->signal->live);
  2470				refcount_inc(&current->signal->sigcnt);
  2471				task_join_group_stop(p);
  2472				list_add_tail_rcu(&p->thread_group,
  2473						  &p->group_leader->thread_group);
  2474				list_add_tail_rcu(&p->thread_node,
  2475						  &p->signal->thread_head);
  2476			}
  2477			attach_pid(p, PIDTYPE_PID);
  2478			nr_threads++;
  2479		}
  2480		total_forks++;
  2481		hlist_del_init(&delayed.node);
  2482		spin_unlock(&current->sighand->siglock);
  2483		syscall_tracepoint_update(p);
  2484		write_unlock_irq(&tasklist_lock);
  2485	
  2486		if (pidfile)
  2487			fd_install(pidfd, pidfile);
  2488	
  2489		proc_fork_connector(p);
  2490		sched_post_fork(p);
  2491		cgroup_post_fork(p, args);
  2492		perf_event_fork(p);
  2493	
  2494		trace_task_newtask(p, clone_flags);
  2495		uprobe_copy_process(p, clone_flags);
  2496	
  2497		copy_oom_score_adj(clone_flags, p);
  2498	
  2499		return p;
  2500	
  2501	bad_fork_cancel_cgroup:
  2502		sched_core_free(p);
  2503		spin_unlock(&current->sighand->siglock);
  2504		write_unlock_irq(&tasklist_lock);
  2505		cgroup_cancel_fork(p, args);
  2506	bad_fork_put_pidfd:
  2507		if (clone_flags & CLONE_PIDFD) {
  2508			fput(pidfile);
  2509			put_unused_fd(pidfd);
  2510		}
  2511	bad_fork_free_pid:
  2512		if (pid != &init_struct_pid)
  2513			free_pid(pid);
  2514	bad_fork_cleanup_thread:
  2515		exit_thread(p);
  2516	bad_fork_cleanup_io:
  2517		if (p->io_context)
  2518			exit_io_context(p);
  2519	bad_fork_cleanup_namespaces:
  2520		exit_task_namespaces(p);
  2521	bad_fork_cleanup_mm:
  2522		if (p->mm) {
  2523			mm_clear_owner(p->mm, p);
  2524			mmput(p->mm);
  2525		}
  2526	bad_fork_cleanup_signal:
  2527		if (!(clone_flags & CLONE_THREAD))
  2528			free_signal_struct(p->signal);
  2529	bad_fork_cleanup_sighand:
  2530		__cleanup_sighand(p->sighand);
  2531	bad_fork_cleanup_fs:
  2532		exit_fs(p); /* blocking */
  2533	bad_fork_cleanup_files:
  2534		exit_files(p); /* blocking */
  2535	bad_fork_cleanup_semundo:
  2536		exit_sem(p);
  2537	bad_fork_cleanup_security:
  2538		security_task_free(p);
  2539	bad_fork_cleanup_audit:
  2540		audit_free(p);
  2541	bad_fork_cleanup_perf:
  2542		perf_event_free_task(p);
  2543	bad_fork_cleanup_policy:
  2544		lockdep_free_task(p);
  2545	#ifdef CONFIG_NUMA
  2546		mpol_put(p->mempolicy);
  2547	#endif
  2548	bad_fork_cleanup_delayacct:
  2549		delayacct_tsk_free(p);
  2550	bad_fork_cleanup_count:
  2551		dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
  2552		exit_creds(p);
  2553	bad_fork_free:
  2554		WRITE_ONCE(p->__state, TASK_DEAD);
  2555		exit_task_stack_account(p);
  2556		put_task_stack(p);
  2557		delayed_free_task(p);
  2558	fork_out:
  2559		spin_lock_irq(&current->sighand->siglock);
  2560		hlist_del_init(&delayed.node);
  2561		spin_unlock_irq(&current->sighand->siglock);
  2562		return ERR_PTR(retval);
  2563	}
  2564	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
