Return-Path: <linux-fsdevel+bounces-5413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E280B5E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 19:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8792811C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5756199DA;
	Sat,  9 Dec 2023 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6Pl2IhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE14F2;
	Sat,  9 Dec 2023 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702146313; x=1733682313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0M0nXpWDhcnAg4+20gZZF8o8lfD/T3Wj0UyQZlZSoCU=;
  b=k6Pl2IhOwKJPLcQ4xKl16TLydrpCqae/2r/y60KYdZKfcNvUnfJR591P
   HbPkiFWwUgkHnlNhCnyUy+F0yZ3pTR3n6Xgv7YZMnUd2GcOEXZEsnSpA5
   zAxtkagjmCbPBcRMIqf8QKpAIl/4SiROVQusxW3xEx8jLZ7cQ4evzeLBp
   76fM+slZ++EqN19nN5ptUHeAEP+lxg6a4k0w1sIx04U2Jv+mOO3Dbl8Wf
   0uVg8HEU26RHIAQG4Wnk2wJQfxrpYENodUlWt5SyZnRrNxKaiwkxUmJA8
   7J5+c07SC/JC9fhtdOMsKiXnTisP3S3L3LPV4NOpkLwuM+CIOJmjo1Ajb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1592450"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1592450"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 10:25:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="722202683"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="722202683"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2023 10:25:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rC20c-000Fkz-0C;
	Sat, 09 Dec 2023 18:25:02 +0000
Date: Sun, 10 Dec 2023 02:24:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	ying.huang@intel.com, gregory.price@memverge.com, corbet@lwn.net,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com,
	vtavarespetr@micron.com, peterz@infradead.org, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com
Subject: Re: [PATCH v2 08/11] mm/mempolicy: add set_mempolicy2 syscall
Message-ID: <202312100245.Jgz5mPhJ-lkp@intel.com>
References: <20231209065931.3458-9-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209065931.3458-9-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc4]
[cannot apply to tip/x86/asm geert-m68k/for-next geert-m68k/for-linus next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231209-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231209065931.3458-9-gregory.price%40memverge.com
patch subject: [PATCH v2 08/11] mm/mempolicy: add set_mempolicy2 syscall
config: arm-lpc32xx_defconfig (https://download.01.org/0day-ci/archive/20231210/202312100245.Jgz5mPhJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100245.Jgz5mPhJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100245.Jgz5mPhJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/time/time.c:33:
>> include/linux/syscalls.h:825:43: warning: declaration of 'struct mpol_args' will not be visible outside of this function [-Wvisibility]
     825 | asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
         |                                           ^
   1 warning generated.
--
   In file included from kernel/time/hrtimer.c:30:
>> include/linux/syscalls.h:825:43: warning: declaration of 'struct mpol_args' will not be visible outside of this function [-Wvisibility]
     825 | asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
         |                                           ^
   kernel/time/hrtimer.c:1651:7: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1651 |         bool expires_in_hardirq;
         |              ^
   kernel/time/hrtimer.c:277:20: warning: unused function 'is_migration_base' [-Wunused-function]
     277 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
         |                    ^
   kernel/time/hrtimer.c:1876:20: warning: unused function '__hrtimer_peek_ahead_timers' [-Wunused-function]
    1876 | static inline void __hrtimer_peek_ahead_timers(void)
         |                    ^
   4 warnings generated.


vim +825 include/linux/syscalls.h

   794	
   795	/* CONFIG_MMU only */
   796	asmlinkage long sys_swapon(const char __user *specialfile, int swap_flags);
   797	asmlinkage long sys_swapoff(const char __user *specialfile);
   798	asmlinkage long sys_mprotect(unsigned long start, size_t len,
   799					unsigned long prot);
   800	asmlinkage long sys_msync(unsigned long start, size_t len, int flags);
   801	asmlinkage long sys_mlock(unsigned long start, size_t len);
   802	asmlinkage long sys_munlock(unsigned long start, size_t len);
   803	asmlinkage long sys_mlockall(int flags);
   804	asmlinkage long sys_munlockall(void);
   805	asmlinkage long sys_mincore(unsigned long start, size_t len,
   806					unsigned char __user * vec);
   807	asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
   808	asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
   809				size_t vlen, int behavior, unsigned int flags);
   810	asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
   811	asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
   812				unsigned long prot, unsigned long pgoff,
   813				unsigned long flags);
   814	asmlinkage long sys_mbind(unsigned long start, unsigned long len,
   815					unsigned long mode,
   816					const unsigned long __user *nmask,
   817					unsigned long maxnode,
   818					unsigned flags);
   819	asmlinkage long sys_get_mempolicy(int __user *policy,
   820					unsigned long __user *nmask,
   821					unsigned long maxnode,
   822					unsigned long addr, unsigned long flags);
   823	asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
   824					unsigned long maxnode);
 > 825	asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
   826					   unsigned long flags);
   827	asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
   828					const unsigned long __user *from,
   829					const unsigned long __user *to);
   830	asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
   831					const void __user * __user *pages,
   832					const int __user *nodes,
   833					int __user *status,
   834					int flags);
   835	asmlinkage long sys_rt_tgsigqueueinfo(pid_t tgid, pid_t  pid, int sig,
   836			siginfo_t __user *uinfo);
   837	asmlinkage long sys_perf_event_open(
   838			struct perf_event_attr __user *attr_uptr,
   839			pid_t pid, int cpu, int group_fd, unsigned long flags);
   840	asmlinkage long sys_accept4(int, struct sockaddr __user *, int __user *, int);
   841	asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
   842				     unsigned int vlen, unsigned flags,
   843				     struct __kernel_timespec __user *timeout);
   844	asmlinkage long sys_recvmmsg_time32(int fd, struct mmsghdr __user *msg,
   845				     unsigned int vlen, unsigned flags,
   846				     struct old_timespec32 __user *timeout);
   847	asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
   848					int options, struct rusage __user *ru);
   849	asmlinkage long sys_prlimit64(pid_t pid, unsigned int resource,
   850					const struct rlimit64 __user *new_rlim,
   851					struct rlimit64 __user *old_rlim);
   852	asmlinkage long sys_fanotify_init(unsigned int flags, unsigned int event_f_flags);
   853	asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
   854					  u64 mask, int fd,
   855					  const char  __user *pathname);
   856	asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
   857					      struct file_handle __user *handle,
   858					      int __user *mnt_id, int flag);
   859	asmlinkage long sys_open_by_handle_at(int mountdirfd,
   860					      struct file_handle __user *handle,
   861					      int flags);
   862	asmlinkage long sys_clock_adjtime(clockid_t which_clock,
   863					struct __kernel_timex __user *tx);
   864	asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
   865					struct old_timex32 __user *tx);
   866	asmlinkage long sys_syncfs(int fd);
   867	asmlinkage long sys_setns(int fd, int nstype);
   868	asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
   869	asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
   870				     unsigned int vlen, unsigned flags);
   871	asmlinkage long sys_process_vm_readv(pid_t pid,
   872					     const struct iovec __user *lvec,
   873					     unsigned long liovcnt,
   874					     const struct iovec __user *rvec,
   875					     unsigned long riovcnt,
   876					     unsigned long flags);
   877	asmlinkage long sys_process_vm_writev(pid_t pid,
   878					      const struct iovec __user *lvec,
   879					      unsigned long liovcnt,
   880					      const struct iovec __user *rvec,
   881					      unsigned long riovcnt,
   882					      unsigned long flags);
   883	asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
   884				 unsigned long idx1, unsigned long idx2);
   885	asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
   886	asmlinkage long sys_sched_setattr(pid_t pid,
   887						struct sched_attr __user *attr,
   888						unsigned int flags);
   889	asmlinkage long sys_sched_getattr(pid_t pid,
   890						struct sched_attr __user *attr,
   891						unsigned int size,
   892						unsigned int flags);
   893	asmlinkage long sys_renameat2(int olddfd, const char __user *oldname,
   894				      int newdfd, const char __user *newname,
   895				      unsigned int flags);
   896	asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
   897				    void __user *uargs);
   898	asmlinkage long sys_getrandom(char __user *buf, size_t count,
   899				      unsigned int flags);
   900	asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
   901	asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
   902	asmlinkage long sys_execveat(int dfd, const char __user *filename,
   903				const char __user *const __user *argv,
   904				const char __user *const __user *envp, int flags);
   905	asmlinkage long sys_userfaultfd(int flags);
   906	asmlinkage long sys_membarrier(int cmd, unsigned int flags, int cpu_id);
   907	asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
   908	asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
   909					    int fd_out, loff_t __user *off_out,
   910					    size_t len, unsigned int flags);
   911	asmlinkage long sys_preadv2(unsigned long fd, const struct iovec __user *vec,
   912				    unsigned long vlen, unsigned long pos_l, unsigned long pos_h,
   913				    rwf_t flags);
   914	asmlinkage long sys_pwritev2(unsigned long fd, const struct iovec __user *vec,
   915				    unsigned long vlen, unsigned long pos_l, unsigned long pos_h,
   916				    rwf_t flags);
   917	asmlinkage long sys_pkey_mprotect(unsigned long start, size_t len,
   918					  unsigned long prot, int pkey);
   919	asmlinkage long sys_pkey_alloc(unsigned long flags, unsigned long init_val);
   920	asmlinkage long sys_pkey_free(int pkey);
   921	asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
   922				  unsigned mask, struct statx __user *buffer);
   923	asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
   924				 int flags, uint32_t sig);
   925	asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
   926	asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
   927				       int to_dfd, const char __user *to_path,
   928				       unsigned int ms_flags);
   929	asmlinkage long sys_mount_setattr(int dfd, const char __user *path,
   930					  unsigned int flags,
   931					  struct mount_attr __user *uattr, size_t usize);
   932	asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
   933	asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
   934				     const void __user *value, int aux);
   935	asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int ms_flags);
   936	asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags);
   937	asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
   938					       siginfo_t __user *info,
   939					       unsigned int flags);
   940	asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
   941	asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
   942			size_t size, __u32 flags);
   943	asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
   944			const void __user *rule_attr, __u32 flags);
   945	asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
   946	asmlinkage long sys_memfd_secret(unsigned int flags);
   947	asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
   948						    unsigned long home_node,
   949						    unsigned long flags);
   950	asmlinkage long sys_cachestat(unsigned int fd,
   951			struct cachestat_range __user *cstat_range,
   952			struct cachestat __user *cstat, unsigned int flags);
   953	asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
   954	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

