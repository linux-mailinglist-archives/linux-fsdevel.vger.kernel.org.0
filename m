Return-Path: <linux-fsdevel+bounces-48475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD7AAF9B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0294C5E46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5F225415;
	Thu,  8 May 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvg8W6fF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF7222568;
	Thu,  8 May 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706925; cv=none; b=ENq4ZPN9nAGj6QxjC8DoAx2BgDGC4uND3w/NZuYlj+Atg38LuUa4YA7tCzShep0zB/y5DUnGF9tDeA3PMgrVKhrqSxvSEydW6YeMTxkAcelflyKRLCLn9WPMIDwxkiAI8Q3MJf0BPtELQZNlxwGHQcBIaKlIeVuT5T9sT4E5daI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706925; c=relaxed/simple;
	bh=2B1VAFopbYwqp+cWfaNd09XKHhaCO5pZWfe0iB09SgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol/vA+3ZYfV7ZlluZ5pnzRGu5SLJZlWh8gnZTLlOVXILX2Qomb1nyoDXfROiQK4etJ2DfURMOXey1K0EgrMqYVQSv//lUQD+uWCN4soffuuSImVZg912VpiLsxMY6oFaaWUvSiOqS3AP5dKdeSoX2nIf2zDT1k8IQDreBuyboYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvg8W6fF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706923; x=1778242923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2B1VAFopbYwqp+cWfaNd09XKHhaCO5pZWfe0iB09SgM=;
  b=fvg8W6fFX0jCwofd3cAD9yDFMcGxUA6kK1Fov4/d9PhhksbjxEFLDKs1
   hqBJ0yxvVtcdqXQIeb+UolfnA+rB3BDAhLmebjnFv7F7Zl9hTTsvxFaBg
   t1i5x48yVFIIbmDHG/tl3bKwXDDVYVolyrHgIEUQRCzSI+fCKrnyUvHtM
   60LpBs/76HvWVR/1m9g8cfqrjNWOIXN7NjCvFTik2lINHzIUo854lsWQl
   qzBJk2bQy4sZvDvfXaJ+O4QtzuQQbwXPCEKLyxl/VMqOjRy+ikGUH70ZX
   3aMHqlXA2hcf0kFEQdDLHfRA9PhyGijE4/1sMQlp8KISL29wH7H/rLZAs
   Q==;
X-CSE-ConnectionGUID: taG/2HaDQx2mYpNdL15sIw==
X-CSE-MsgGUID: iCP6sg5HRq2qV1yxpLJC/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59883099"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59883099"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:22:02 -0700
X-CSE-ConnectionGUID: M/O0ahs2QSSbInJwpZqolg==
X-CSE-MsgGUID: 18OfEl75RnKfUN8GeVzMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="141492373"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 May 2025 05:21:56 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD0G9-000Ax1-2X;
	Thu, 08 May 2025 12:21:53 +0000
Date: Thu, 8 May 2025 20:21:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <202505082038.A5ejhbR4-lkp@intel.com>
References: <20250507110444.963779-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-3-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core akpm-mm/mm-everything linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250507-190740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250507110444.963779-3-bhupesh%40igalia.com
patch subject: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250508/202505082038.A5ejhbR4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505082038.A5ejhbR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505082038.A5ejhbR4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:119,
                    from include/trace/events/sched.h:856,
                    from kernel/sched/core.c:84:
   include/trace/events/sched.h: In function 'do_trace_event_raw_event_sched_switch':
>> include/trace/events/sched.h:245:24: error: 'struct trace_event_raw_sched_switch' has no member named 'comm'
     245 |                 __entry->comm[TASK_COMM_LEN - 1] = '\0';
         |                        ^~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/sched.h:224:1: note: in expansion of macro 'TRACE_EVENT'
     224 | TRACE_EVENT(sched_switch,
         | ^~~~~~~~~~~
   include/trace/events/sched.h:243:9: note: in expansion of macro 'TP_fast_assign'
     243 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:120,
                    from include/trace/events/sched.h:856,
                    from kernel/sched/core.c:84:
   include/trace/events/sched.h: In function 'do_perf_trace_sched_switch':
>> include/trace/events/sched.h:245:24: error: 'struct trace_event_raw_sched_switch' has no member named 'comm'
     245 |                 __entry->comm[TASK_COMM_LEN - 1] = '\0';
         |                        ^~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/sched.h:224:1: note: in expansion of macro 'TRACE_EVENT'
     224 | TRACE_EVENT(sched_switch,
         | ^~~~~~~~~~~
   include/trace/events/sched.h:243:9: note: in expansion of macro 'TP_fast_assign'
     243 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +245 include/trace/events/sched.h

   225	
   226		TP_PROTO(bool preempt,
   227			 struct task_struct *prev,
   228			 struct task_struct *next,
   229			 unsigned int prev_state),
   230	
   231		TP_ARGS(preempt, prev, next, prev_state),
   232	
   233		TP_STRUCT__entry(
   234			__array(	char,	prev_comm,	TASK_COMM_LEN	)
   235			__field(	pid_t,	prev_pid			)
   236			__field(	int,	prev_prio			)
   237			__field(	long,	prev_state			)
   238			__array(	char,	next_comm,	TASK_COMM_LEN	)
   239			__field(	pid_t,	next_pid			)
   240			__field(	int,	next_prio			)
   241		),
   242	
   243		TP_fast_assign(
   244			memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 > 245			__entry->comm[TASK_COMM_LEN - 1] = '\0';
   246			__entry->prev_pid	= prev->pid;
   247			__entry->prev_prio	= prev->prio;
   248			__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
   249			memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
   250			__entry->next_comm[TASK_COMM_LEN - 1] = '\0';
   251			__entry->next_pid	= next->pid;
   252			__entry->next_prio	= next->prio;
   253			/* XXX SCHED_DEADLINE */
   254		),
   255	
   256		TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
   257			__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
   258	
   259			(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
   260			  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
   261					{ TASK_INTERRUPTIBLE, "S" },
   262					{ TASK_UNINTERRUPTIBLE, "D" },
   263					{ __TASK_STOPPED, "T" },
   264					{ __TASK_TRACED, "t" },
   265					{ EXIT_DEAD, "X" },
   266					{ EXIT_ZOMBIE, "Z" },
   267					{ TASK_PARKED, "P" },
   268					{ TASK_DEAD, "I" }) :
   269			  "R",
   270	
   271			__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
   272			__entry->next_comm, __entry->next_pid, __entry->next_prio)
   273	);
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

