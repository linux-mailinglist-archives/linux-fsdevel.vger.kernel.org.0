Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92985EECB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 06:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiI2EWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 00:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2EWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:22:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB612870E;
        Wed, 28 Sep 2022 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664425328; x=1695961328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y17JjZrPpcCOG/tmKMeZ9E0Hle7ucfwp2RcoN3IQDTU=;
  b=EUpWj8UTI5mKEMffB92zMtXlrXgW7RjyjkdFWczFUL7LiH7gM6MsBOrE
   Pg+QieiWLvcNQGI2wxg4P44x6c3rY7kR471MHCL9UOTkdKH7YvgPzxKe5
   ytZ0vlL2yZeo9rvH/JHDCF5SevH+ZzkLm0PUUte/5EuQH8cw+p+OdmS2/
   EAiUuwhcTrO/rdfhr/0kn2TYSKszRi/sMgfeBUmH/DkIKEhVwgxChqGuV
   LloCZuiIdgnmKsYii5qNIYD/YJ2uAselB4CgN7HlWq5mz/QETn+E3PhVr
   Al1VhCjRzO8Gry9rBFK2aHzmHYQn6UQEfI7IChERika82qrx0ogZZVY+E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="388070734"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="388070734"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867225460"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867225460"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2022 21:22:01 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odl3g-0000ZU-32;
        Thu, 29 Sep 2022 04:22:00 +0000
Date:   Thu, 29 Sep 2022 12:21:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 02/26] bpf: verifier: Allow single packet invalidation
Message-ID: <202209291248.Ue1yhIlr-lkp@intel.com>
References: <20220926231822.994383-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hphjGsDt8duBQ1ky"
Content-Disposition: inline
In-Reply-To: <20220926231822.994383-3-drosen@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hphjGsDt8duBQ1ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bf682942cd26ce9cd5e87f73ae099b383041e782]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Rosenberg/FUSE-BPF-A-Stacked-Filesystem-Extension-for-FUSE/20220927-095052
base:   bf682942cd26ce9cd5e87f73ae099b383041e782
config: powerpc-randconfig-r006-20220925
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2be5946421bc5b6135b701f5362e0b591836ecc1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Rosenberg/FUSE-BPF-A-Stacked-Filesystem-Extension-for-FUSE/20220927-095052
        git checkout 2be5946421bc5b6135b701f5362e0b591836ecc1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:13:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:15:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:17:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:19:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   kernel/bpf/core.c:1623:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1623:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
   kernel/bpf/core.c:2062:6: warning: no previous prototype for function 'bpf_patch_call_args' [-Wmissing-prototypes]
   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
        ^
   kernel/bpf/core.c:2062:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
   ^
   static 
>> kernel/bpf/core.c:2688:13: warning: no previous prototype for function 'bpf_helper_changes_one_pkt_data' [-Wmissing-prototypes]
   bool __weak bpf_helper_changes_one_pkt_data(void *func)
               ^
   kernel/bpf/core.c:2688:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool __weak bpf_helper_changes_one_pkt_data(void *func)
   ^
   static 
   9 warnings generated.


vim +/bpf_helper_changes_one_pkt_data +2688 kernel/bpf/core.c

  2687	
> 2688	bool __weak bpf_helper_changes_one_pkt_data(void *func)
  2689	{
  2690		return false;
  2691	}
  2692	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--hphjGsDt8duBQ1ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 6.0.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=160000
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_KERNEL_GZIP=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
# CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
# CONFIG_BUG is not set
# CONFIG_ELF_CORE is not set
CONFIG_BASE_FULL=y
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
CONFIG_AIO=y
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_PPC32=y
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_PPC_BOOK3S_32 is not set
CONFIG_PPC_85xx=y
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
CONFIG_E500MC_CPU=y
# CONFIG_TOOLCHAIN_DEFAULT_CPU is not set
CONFIG_TARGET_CPU_BOOL=y
CONFIG_TARGET_CPU="e500mc"
CONFIG_E500=y
CONFIG_PPC_E500MC=y
CONFIG_PPC_FPU_REGS=y
CONFIG_PPC_FPU=y
CONFIG_FSL_EMB_PERFMON=y
CONFIG_FSL_EMB_PERF_EVENT=y
CONFIG_FSL_EMB_PERF_EVENT_E500=y
CONFIG_BOOKE=y
CONFIG_BOOKE_OR_40x=y
CONFIG_FSL_BOOKE=y
CONFIG_PPC_FSL_BOOK3E=y
# CONFIG_PHYS_64BIT is not set
CONFIG_PPC_KUEP=y
CONFIG_PPC_KUAP=y
# CONFIG_PPC_KUAP_DEBUG is not set
CONFIG_PPC_MMU_NOHASH=y
CONFIG_PPC_BOOK3E_MMU=y
CONFIG_PMU_SYSFS=y
# CONFIG_SMP is not set
CONFIG_NR_CPUS=1
CONFIG_PPC_DOORBELL=y
# end of Processor support

CONFIG_VDSO32=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_32BIT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MAX=17
CONFIG_ARCH_MMAP_RND_BITS_MIN=11
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=17
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=11
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_PPC=y
CONFIG_PPC_BARRIER_NOSPEC=y
CONFIG_EARLY_PRINTK=y
CONFIG_PANIC_TIMEOUT=180
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_HAS_ADD_PAGES=y
# CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT is not set
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_PPC_ADV_DEBUG_REGS=y
CONFIG_PPC_ADV_DEBUG_IACS=2
CONFIG_PPC_ADV_DEBUG_DACS=2
CONFIG_PPC_ADV_DEBUG_DVCS=0
CONFIG_PGTABLE_LEVELS=2

#
# Platform support
#
CONFIG_SCOM_DEBUGFS=y
# CONFIG_FSL_SOC_BOOKE is not set
CONFIG_KVM_GUEST=y
CONFIG_EPAPR_PARAVIRT=y
CONFIG_PPC_SMP_MUXED_IPI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPUIdle driver
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y

#
# POWERPC CPU Idle Drivers
#
# end of POWERPC CPU Idle Drivers
# end of CPU Idle
# end of CPUIdle driver

# CONFIG_GEN_RTC is not set
# end of Platform support

#
# Kernel options
#
CONFIG_HIGHMEM=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_MATH_EMULATION is not set
CONFIG_KEXEC=y
# CONFIG_RELOCATABLE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_PPC_4K_PAGES=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PPC_PAGE_SHIFT=12
CONFIG_THREAD_SHIFT=13
# CONFIG_DATA_SHIFT_BOOL is not set
CONFIG_DATA_SHIFT=24
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_CMDLINE=""
CONFIG_EXTRA_TARGETS=""
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_OF=y
# end of Kernel options

#
# Bus options
#
CONFIG_FSL_LBC=y
# end of Bus options

CONFIG_NONSTATIC_KERNEL=y

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_LOWMEM_SIZE_BOOL=y
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_LOWMEM_CAM_NUM_BOOL is not set
CONFIG_LOWMEM_CAM_NUM=9
CONFIG_DYNAMIC_MEMSTART=y
CONFIG_PAGE_OFFSET_BOOL=y
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0xc0000000
CONFIG_PHYSICAL_START_BOOL=y
CONFIG_PHYSICAL_START=0x00000000
CONFIG_PHYSICAL_ALIGN=0x04000000
CONFIG_TASK_SIZE_BOOL=y
CONFIG_TASK_SIZE=0xc0000000
# end of Advanced setup

CONFIG_VIRTUALIZATION=y
# CONFIG_KVM_E500MC is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_PAGE_SIZE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WEAK_RELEASE_ACQUIRE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=11
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_HAVE_ARCH_NVRAM_OPS=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=m
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_KUNIT_TEST=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_FLATMEM=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
# CONFIG_DAMON_VADDR is not set
# CONFIG_DAMON_PADDR is not set
# CONFIG_DAMON_SYSFS is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=m
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set
CONFIG_ATM=y
# CONFIG_ATM_LANE is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=m
# CONFIG_IPDDP is not set
# CONFIG_X25 is not set
CONFIG_LAPB=m
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_QRTR is not set
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m
# CONFIG_BT is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
# CONFIG_MAC80211_RC_MINSTREL is not set
CONFIG_MAC80211_RC_DEFAULT=""

#
# Some wireless drivers require a rate control algorithm
#
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
CONFIG_MAC80211_VERBOSE_DEBUG=y
CONFIG_MAC80211_MLME_DEBUG=y
CONFIG_MAC80211_STA_DEBUG=y
# CONFIG_MAC80211_HT_DEBUG is not set
# CONFIG_MAC80211_OCB_DEBUG is not set
# CONFIG_MAC80211_IBSS_DEBUG is not set
# CONFIG_MAC80211_PS_DEBUG is not set
CONFIG_MAC80211_MPL_DEBUG=y
# CONFIG_MAC80211_MPATH_DEBUG is not set
CONFIG_MAC80211_MHWMP_DEBUG=y
# CONFIG_MAC80211_MESH_SYNC_DEBUG is not set
CONFIG_MAC80211_MESH_CSA_DEBUG=y
CONFIG_MAC80211_MESH_PS_DEBUG=y
CONFIG_MAC80211_TDLS_DEBUG=y
# CONFIG_MAC80211_DEBUG_COUNTERS is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=y
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=y

#
# Device Drivers
#
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set

#
# PC-card bridges
#

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_FSL_MC_BUS=y
CONFIG_FSL_MC_UAPI_SUPPORT=y
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_POWER_DOMAIN=m
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_QCOM_SCM=m
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_OF_DMA_DEFAULT_COHERENT=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_CDROM=m
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=m
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HI6421V600_IRQ is not set
CONFIG_QCOM_COINCELL=m
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
CONFIG_SRAM=y
CONFIG_XILINX_SDFEC=m
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
# CONFIG_ECHO is not set
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=m
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_MULTIPATH_HST=m
# CONFIG_DM_MULTIPATH_IOA is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_DUST is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_SBP_TARGET=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_SBP2=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_WINDFARM=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
CONFIG_NET_TEAM=m
# CONFIG_NET_TEAM_MODE_BROADCAST is not set
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
# CONFIG_NET_TEAM_MODE_LOADBALANCE is not set
CONFIG_MACVLAN=m
CONFIG_MACSEC=m
# CONFIG_NETCONSOLE is not set
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=y
CONFIG_MHI_NET=m
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_CAIF_DRIVERS is not set
# CONFIG_ETHERNET is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
CONFIG_MESON_GXL_PHY=y
CONFIG_ADIN_PHY=m
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=y
# CONFIG_BCM63XX_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
CONFIG_MAXLINEAR_GPHY=m
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=m
CONFIG_MOTORCOMM_PHY=m
# CONFIG_NATIONAL_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=y
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
# CONFIG_DP83822_PHY is not set
CONFIG_DP83TC811_PHY=y
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=y
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_AT91 is not set
# CONFIG_CAN_CAN327 is not set
CONFIG_CAN_FLEXCAN=m
CONFIG_CAN_GRCAN=m
CONFIG_CAN_SLCAN=m
# CONFIG_CAN_SUN4I is not set
CONFIG_CAN_XILINXCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PLATFORM=m
CONFIG_CAN_MSCAN=m
CONFIG_CAN_RCAR=m
CONFIG_CAN_RCAR_CANFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_SUN4I=y
CONFIG_MDIO_XGENE=m
CONFIG_MDIO_ASPEED=m
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_BCM_IPROC is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_MOXART=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_MESON_G12A=m
CONFIG_MDIO_BUS_MUX_BCM6368=m
CONFIG_MDIO_BUS_MUX_BCM_IPROC=m
CONFIG_MDIO_BUS_MUX_GPIO=m
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=m
CONFIG_MDIO_BUS_MUX_MMIOREG=y

#
# PCS device drivers
#
# CONFIG_PCS_RZN1_MIIC is not set
# end of PCS device drivers

CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=m
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
CONFIG_ATH_DEBUG=y
# CONFIG_ATH_TRACEPOINTS is not set
CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS=y
CONFIG_ATH_REG_DYNAMIC_USER_CERT_TESTING=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_DFS_DEBUGFS=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
# CONFIG_ATH9K_STATION_STATISTICS is not set
# CONFIG_ATH9K_TX99 is not set
CONFIG_ATH9K_DFS_CERTIFIED=y
# CONFIG_ATH9K_DYNACK is not set
# CONFIG_ATH9K_WOW is not set
CONFIG_ATH9K_CHANNEL_CONTEXT=y
# CONFIG_ATH9K_PCOEM is not set
# CONFIG_ATH9K_COMMON_SPECTRAL is not set
CONFIG_ATH6KL=m
CONFIG_ATH6KL_DEBUG=y
# CONFIG_ATH6KL_TRACING is not set
CONFIG_ATH6KL_REGDOMAIN=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_SNOC=m
# CONFIG_ATH10K_DEBUG is not set
# CONFIG_ATH10K_DEBUGFS is not set
CONFIG_ATH10K_TRACING=y
CONFIG_ATH10K_DFS_CERTIFIED=y
CONFIG_WCN36XX=m
CONFIG_WCN36XX_DEBUGFS=y
CONFIG_ATH11K=m
# CONFIG_ATH11K_DEBUG is not set
CONFIG_ATH11K_DEBUGFS=y
# CONFIG_ATH11K_TRACING is not set
# CONFIG_ATH11K_SPECTRAL is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_P54_COMMON=m
CONFIG_P54_LEDS=y
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
CONFIG_LIBERTAS_THINFIRM=m
CONFIG_LIBERTAS_THINFIRM_DEBUG=y
CONFIG_MWIFIEX=m
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_VIRT_WIFI=m
CONFIG_WAN=y
# CONFIG_HDLC is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=m
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=m
CONFIG_MHI_WWAN_CTRL=m
CONFIG_MHI_WWAN_MBIM=m
# CONFIG_QCOM_BAM_DMUX is not set
# end of Wireless WAN

CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=m
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_CLPS711X=m
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
# CONFIG_KEYBOARD_EP93XX is not set
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
# CONFIG_KEYBOARD_IMX is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_PMIC8XXX=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_ST_KEYSCAN=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_SH_KEYSC=m
CONFIG_KEYBOARD_STMPE=m
CONFIG_KEYBOARD_OMAP4=m
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MT6779 is not set
CONFIG_KEYBOARD_MTK_PMIC=m
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATC260X_ONKEY is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=m
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PM8941_PWRKEY=m
CONFIG_INPUT_PM8XXX_VIBRATOR=m
# CONFIG_INPUT_PMIC8XXX_PWRKEY is not set
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=m
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=m
# CONFIG_INPUT_ADXL34X_I2C is not set
# CONFIG_INPUT_IQS269A is not set
CONFIG_INPUT_IQS626A=m
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
# CONFIG_INPUT_HISI_POWERKEY is not set
CONFIG_INPUT_SC27XX_VIBRA=m
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m
CONFIG_SERIO_XILINX_XPS_PS2=m
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=m
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_BCM2835AUX=y
CONFIG_SERIAL_8250_FSL=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_EM=y
# CONFIG_SERIAL_8250_IOC3 is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_OMAP=y
# CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP is not set
CONFIG_SERIAL_8250_LPC18XX=y
# CONFIG_SERIAL_8250_MT6577 is not set
# CONFIG_SERIAL_8250_UNIPHIER is not set
# CONFIG_SERIAL_8250_INGENIC is not set
CONFIG_SERIAL_8250_PXA=y
CONFIG_SERIAL_8250_TEGRA=y
CONFIG_SERIAL_8250_BCM7271=m
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=y
# CONFIG_SERIAL_AMBA_PL010_CONSOLE is not set
# CONFIG_SERIAL_ATMEL is not set
CONFIG_SERIAL_MESON=m
# CONFIG_SERIAL_MESON_CONSOLE is not set
CONFIG_SERIAL_CLPS711X=m
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
CONFIG_SERIAL_SAMSUNG_CONSOLE=y
# CONFIG_SERIAL_TEGRA is not set
CONFIG_SERIAL_IMX=y
# CONFIG_SERIAL_IMX_CONSOLE is not set
CONFIG_SERIAL_IMX_EARLYCON=y
# CONFIG_SERIAL_UARTLITE is not set
# CONFIG_SERIAL_SH_SCI is not set
CONFIG_SERIAL_HS_LPC32XX=m
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_CPM is not set
CONFIG_SERIAL_MSM=m
CONFIG_SERIAL_QCOM_GENI=m
# CONFIG_SERIAL_QCOM_GENI_CONSOLE is not set
# CONFIG_SERIAL_VT8500 is not set
# CONFIG_SERIAL_OMAP is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_MXS_AUART=m
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_MPS2_UART_CONSOLE=y
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_FSL_LINFLEXUART=m
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_ST_ASC=m
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_SERIAL_MVEBU_UART is not set
# CONFIG_SERIAL_OWL is not set
# CONFIG_SERIAL_RDA is not set
CONFIG_SERIAL_MILBEAUT_USIO=m
CONFIG_SERIAL_MILBEAUT_USIO_PORTS=4
# CONFIG_SERIAL_LITEUART is not set
# CONFIG_SERIAL_SUNPLUS is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
# CONFIG_N_GSM is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_UDBG=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMI_KCS_BMC=m
CONFIG_ASPEED_KCS_IPMI_BMC=m
CONFIG_NPCM7XX_KCS_IPMI_BMC=m
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=m
# CONFIG_IPMI_KCS_BMC_SERIO is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
# CONFIG_HW_RANDOM is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#
# CONFIG_I2C_HIX5HD2 is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=m
# CONFIG_I2C_ASPEED is not set
CONFIG_I2C_AT91=y
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=y
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=m
# CONFIG_I2C_BCM_IPROC is not set
# CONFIG_I2C_BCM_KONA is not set
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=m
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DAVINCI=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DIGICOLOR=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=m
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=m
# CONFIG_I2C_HISI is not set
CONFIG_I2C_IMG=y
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=m
# CONFIG_I2C_JZ4780 is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_LPC2K=y
CONFIG_I2C_MESON=y
# CONFIG_I2C_MICROCHIP_CORE is not set
CONFIG_I2C_MPC=m
CONFIG_I2C_MT65XX=y
CONFIG_I2C_MT7621=m
CONFIG_I2C_MV64XXX=m
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=m
CONFIG_I2C_OWL=y
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_QCOM_CCI=m
CONFIG_I2C_QCOM_GENI=m
CONFIG_I2C_QUP=m
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_SPRD=m
# CONFIG_I2C_ST is not set
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=y
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_SYNQUACER=m
# CONFIG_I2C_TEGRA_BPMP is not set
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
CONFIG_I2C_VERSATILE=m
CONFIG_I2C_WMT=y
# CONFIG_I2C_XILINX is not set
CONFIG_I2C_XLP9XX=m
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_I2C_FSI is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=m
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_SPMI_HISI3670=m
CONFIG_SPMI_MSM_PMIC_ARB=m
# CONFIG_SPMI_MTK_PMIF is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AS3722=m
CONFIG_PINCTRL_AT91PIO4=y
CONFIG_PINCTRL_AXP209=m
# CONFIG_PINCTRL_BM1880 is not set
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_DA9062=m
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_INGENIC=y
CONFIG_PINCTRL_LPC18XX=y
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_PISTACHIO=y
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_ROCKCHIP is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_STARFIVE is not set
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_OWL=y
CONFIG_PINCTRL_S500=y
CONFIG_PINCTRL_S700=y
# CONFIG_PINCTRL_S900 is not set
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
CONFIG_PINCTRL_ASPEED_G5=y
CONFIG_PINCTRL_ASPEED_G6=y
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
CONFIG_PINCTRL_BCM6362=y
# CONFIG_PINCTRL_BCM6368 is not set
CONFIG_PINCTRL_BCM63268=y
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
CONFIG_PINCTRL_NS=y
# CONFIG_PINCTRL_NSP_GPIO is not set
CONFIG_PINCTRL_NS2_MUX=y
CONFIG_PINCTRL_NSP_MUX=y
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
CONFIG_PINCTRL_MT7623=y
CONFIG_PINCTRL_MT7629=y
# CONFIG_PINCTRL_MT8135 is not set
CONFIG_PINCTRL_MT8127=y
# CONFIG_PINCTRL_MT2712 is not set
CONFIG_PINCTRL_MT6765=y
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
CONFIG_PINCTRL_MT8167=y
CONFIG_PINCTRL_MT8173=y
CONFIG_PINCTRL_MT8183=y
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=m
# CONFIG_PINCTRL_MSM is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=m
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
CONFIG_PINCTRL_PFC_R8A77951=y
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
CONFIG_PINCTRL_RZA2=y
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
CONFIG_PINCTRL_PFC_R8A7745=y
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
CONFIG_PINCTRL_PFC_SH7785=y
# CONFIG_PINCTRL_PFC_SH7786 is not set
CONFIG_PINCTRL_PFC_SH73A0=y
CONFIG_PINCTRL_PFC_SH7723=y
CONFIG_PINCTRL_PFC_SH7724=y
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
CONFIG_PINCTRL_STM32=y
# CONFIG_PINCTRL_STM32F429 is not set
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
CONFIG_PINCTRL_STM32F769=y
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
CONFIG_PINCTRL_STM32MP157=y
CONFIG_PINCTRL_TI_IODELAY=m
CONFIG_PINCTRL_UNIPHIER=y
CONFIG_PINCTRL_UNIPHIER_LD4=y
CONFIG_PINCTRL_UNIPHIER_PRO4=y
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
CONFIG_PINCTRL_UNIPHIER_PRO5=y
CONFIG_PINCTRL_UNIPHIER_PXS2=y
CONFIG_PINCTRL_UNIPHIER_LD6B=y
CONFIG_PINCTRL_UNIPHIER_LD11=y
# CONFIG_PINCTRL_UNIPHIER_LD20 is not set
CONFIG_PINCTRL_UNIPHIER_PXS3=y
# CONFIG_PINCTRL_UNIPHIER_NX1 is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_ASPEED=m
CONFIG_GPIO_ASPEED_SGPIO=y
CONFIG_GPIO_ATH79=m
CONFIG_GPIO_RASPBERRYPI_EXP=m
CONFIG_GPIO_BCM_KONA=y
CONFIG_GPIO_BCM_XGS_IPROC=m
CONFIG_GPIO_BRCMSTB=m
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_CLPS711X=m
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EIC_SPRD=y
CONFIG_GPIO_EM=m
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_IOP=m
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_LPC18XX=m
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MPC8XXX is not set
CONFIG_GPIO_MT7621=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
CONFIG_GPIO_PMIC_EIC_SPRD=m
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=m
CONFIG_GPIO_RDA=y
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SNPS_CREG is not set
CONFIG_GPIO_SPRD=m
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=m
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=y
CONFIG_GPIO_UNIPHIER=y
# CONFIG_GPIO_VISCONTI is not set
# CONFIG_GPIO_WCD934X is not set
CONFIG_GPIO_XGENE_SB=m
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_XLP=m
CONFIG_GPIO_AMD_FCH=m
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD71815=m
CONFIG_GPIO_BD71828=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_MXC=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_QCOM_SMBB=y
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_ACER_A500 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_SPARX5=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_GSC=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NSA320 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OCC_P9_SBE is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=m
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LM25066_REGULATOR is not set
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
CONFIG_SENSORS_MP2975=m
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=m
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=m
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_RASPBERRYPI_HWMON=m
CONFIG_SENSORS_SL28CPLD=y
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_WM831X=m
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_SL28CPLD_WATCHDOG=y
# CONFIG_ARMADA_37XX_WATCHDOG is not set
CONFIG_ASM9260_WATCHDOG=y
# CONFIG_AT91RM9200_WATCHDOG is not set
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_FTWDT010_WATCHDOG=m
# CONFIG_S3C2410_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_EP93XX_WATCHDOG=y
# CONFIG_OMAP_WATCHDOG is not set
# CONFIG_PNX4008_WATCHDOG is not set
CONFIG_DAVINCI_WATCHDOG=m
CONFIG_K3_RTI_WATCHDOG=m
CONFIG_RN5T618_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=y
CONFIG_NPCM7XX_WATCHDOG=m
CONFIG_STMP3XXX_RTC_WATCHDOG=m
# CONFIG_TS4800_WATCHDOG is not set
CONFIG_TS72XX_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_MAX77620_WATCHDOG=m
# CONFIG_IMX2_WDT is not set
CONFIG_IMX7ULP_WDT=y
CONFIG_RETU_WATCHDOG=m
CONFIG_MOXART_WDT=y
CONFIG_ST_LPC_WATCHDOG=m
CONFIG_TEGRA_WATCHDOG=y
CONFIG_QCOM_WDT=y
# CONFIG_MESON_GXBB_WATCHDOG is not set
# CONFIG_MESON_WATCHDOG is not set
# CONFIG_MEDIATEK_WATCHDOG is not set
# CONFIG_DIGICOLOR_WATCHDOG is not set
CONFIG_LPC18XX_WATCHDOG=m
CONFIG_RENESAS_WDT=m
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
CONFIG_ASPEED_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=m
CONFIG_UNIPHIER_WATCHDOG=m
CONFIG_RTD119X_WATCHDOG=y
# CONFIG_REALTEK_OTTO_WDT is not set
CONFIG_SPRD_WATCHDOG=m
CONFIG_PM8916_WATCHDOG=m
# CONFIG_VISCONTI_WATCHDOG is not set
CONFIG_MSC313E_WATCHDOG=y
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
CONFIG_SC520_WDT=y
# CONFIG_KEMPLD_WDT is not set
CONFIG_BCM47XX_WDT=y
CONFIG_BCM2835_WDT=y
CONFIG_BCM_KONA_WDT=y
CONFIG_BCM_KONA_WDT_DEBUG=y
# CONFIG_BCM7038_WDT is not set
CONFIG_IMGPDC_WDT=m
CONFIG_MPC5200_WDT=y
# CONFIG_BOOKE_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_UML_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=m
CONFIG_MFD_ATMEL_FLEXCOM=m
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC_DEV is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
CONFIG_MFD_ASIC3=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_ENE_KB3930=m
CONFIG_MFD_EXYNOS_LPASS=m
CONFIG_MFD_GATEWORKS_GSC=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=y
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_MFD_HI6421_SPMI is not set
CONFIG_MFD_HI655X_PMIC=m
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=m
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_PM8XXX=m
CONFIG_MFD_SPMI_PMIC=m
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STW481X=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=y
# CONFIG_MFD_STM32_TIMERS is not set
CONFIG_MFD_STPMIC1=m
CONFIG_MFD_STMFX=m
CONFIG_MFD_WCD934X=m
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
# CONFIG_MFD_KHADAS_MCU is not set
CONFIG_MFD_ACER_A500_EC=y
CONFIG_MFD_QCOM_PM8008=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_AS3722 is not set
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=m
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA9055=m
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9121=m
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=m
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_HI655X is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LOCHNAGAR is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6380=m
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PF8X00=m
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_RPMH=m
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SC2731 is not set
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
# CONFIG_REGULATOR_STPMIC1 is not set
# CONFIG_REGULATOR_TI_ABB is not set
CONFIG_REGULATOR_STW481X_VMMC=y
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65910=m
# CONFIG_REGULATOR_TPS68470 is not set
CONFIG_REGULATOR_UNIPHIER=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_GPIO_TX=m
CONFIG_IR_HIX5HD2=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MESON=m
CONFIG_IR_MESON_TX=m
CONFIG_IR_MTK=m
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_PWM_TX=m
# CONFIG_IR_RX51 is not set
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SUNXI=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_ST is not set
# CONFIG_IR_IMG is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
CONFIG_CEC_PIN_ERROR_INJ=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
CONFIG_CEC_CROS_EC=y
CONFIG_CEC_MESON_AO=y
CONFIG_CEC_MESON_G12A_AO=y
CONFIG_CEC_GPIO=y
CONFIG_CEC_SAMSUNG_S5P=y
# CONFIG_CEC_STI is not set
CONFIG_CEC_STM32=y
# CONFIG_CEC_TEGRA is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_H264=y
CONFIG_V4L2_VP9=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#
# CONFIG_VIDEO_IMX_MIPI_CSIS is not set

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#
CONFIG_VIDEO_RCAR_DRIF=y

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=m
CONFIG_VIDEO_VICODEC=y
CONFIG_VIDEO_VIMC=m
CONFIG_DVB_TEST_DRIVERS=y
CONFIG_DVB_VIDTV=y

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEO_V4L2_TPG=m
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=m
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=m
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
CONFIG_VIDEO_IMX319=y
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_IMX412=m
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M032=y
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=m
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=m
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=m
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=m
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV5648=y
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=y
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=m
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV8865 is not set
CONFIG_VIDEO_OV9282=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV9734=m
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=m
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=m
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_CCS=m
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_M5MOLS=m
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_AK7375=m
CONFIG_VIDEO_DW9714=y
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV748X=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_ISL7998X is not set
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=m
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=m
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=m
# CONFIG_MEDIA_TUNER_TDA827X is not set
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
# CONFIG_MEDIA_TUNER_XC2028 is not set
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_XC5000 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
CONFIG_DVB_MXL5XX=m
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=m
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_MN88472 is not set
# CONFIG_DVB_MN88473 is not set
CONFIG_DVB_SI2165=y
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=m
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=m
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=y
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=m
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=m
# CONFIG_DVB_RTL2832 is not set
CONFIG_DVB_S5H1432=y
CONFIG_DVB_SI2168=m
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=m
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_TDA1004X is not set
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_ZL10353 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_LGDT3305=m
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_AF9033=m
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_ATBM8830=m
# CONFIG_DVB_HELENE is not set
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=m
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_M88RS2000 is not set
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_IMX_IPUV3_CORE=m
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KUNIT_TEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_BUDDY=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_HDLCD is not set
CONFIG_DRM_MALI_DISPLAY=y
CONFIG_DRM_KOMEDA=y
# end of ARM devices

CONFIG_DRM_KMB_DISPLAY=m
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_EXYNOS is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_MIPI_DSI is not set
# CONFIG_DRM_SUN4I is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=m
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_NOVATEK_NT35510=m
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=m
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
# CONFIG_DRM_CHRONTEL_CH7033 is not set
CONFIG_DRM_CROS_EC_ANX7688=m
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_FSL_LDB is not set
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=m
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=m
CONFIG_DRM_LONTIUM_LT9611UXC=y
# CONFIG_DRM_ITE_IT66121 is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=m
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_SIMPLE_BRIDGE=m
CONFIG_DRM_THINE_THC63LVD1024=y
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_DLPC3433 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI83 is not set
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=m
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=m
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# CONFIG_DRM_IMX8QM_LDB is not set
# CONFIG_DRM_IMX8QXP_LDB is not set
# CONFIG_DRM_IMX8QXP_PIXEL_COMBINER is not set
# CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI is not set
# end of Display Interface Bridges

CONFIG_DRM_IMX=m
CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
CONFIG_DRM_IMX_TVE=m
CONFIG_DRM_IMX_LDB=m
# CONFIG_DRM_IMX_HDMI is not set
# CONFIG_DRM_INGENIC is not set
CONFIG_DRM_V3D=m
# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
# CONFIG_DRM_IMX_LCDIF is not set
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_PL111 is not set
CONFIG_DRM_TVE200=y
CONFIG_DRM_LIMA=m
CONFIG_DRM_ASPEED_GFX=y
# CONFIG_DRM_MCDE is not set
CONFIG_DRM_TIDSS=m
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_SPRD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
CONFIG_FB_OMAP_LCD_H3=y
CONFIG_MMP_DISP=m
CONFIG_MMP_DISP_CONTROLLER=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_KTD253=m
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_VIVALDI=m
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_ARIEL=m
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_TURRIS_OMNIA=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_S3C24XX=m
CONFIG_LEDS_COBALT_QUBE=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_NETXBIG=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_PM8058=m
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_IP30=m
CONFIG_LEDS_ACER_A500=m
# CONFIG_LEDS_BCM63138 is not set
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=m

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AL_MC is not set
# CONFIG_EDAC_XGENE is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_BRCMSTB=m
CONFIG_RTC_DRV_AS3722=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX77686=m
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS65910=y
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=m
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=m
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set
# CONFIG_RTC_DRV_NTXEC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
CONFIG_RTC_DRV_MESON=m
CONFIG_RTC_DRV_MESON_VRTC=y
CONFIG_RTC_DRV_OMAP=m
CONFIG_RTC_DRV_S3C=m
CONFIG_RTC_DRV_EP93XX=m
CONFIG_RTC_DRV_AT91RM9200=m
# CONFIG_RTC_DRV_AT91SAM9 is not set
# CONFIG_RTC_DRV_RZN1 is not set
# CONFIG_RTC_DRV_GENERIC is not set
CONFIG_RTC_DRV_VT8500=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=m
CONFIG_RTC_DRV_ARMADA38X=m
CONFIG_RTC_DRV_CADENCE=m
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_STMP=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_JZ4740=m
CONFIG_RTC_DRV_LPC24XX=m
# CONFIG_RTC_DRV_LPC32XX is not set
CONFIG_RTC_DRV_PM8XXX=y
# CONFIG_RTC_DRV_TEGRA is not set
CONFIG_RTC_DRV_MXC=m
CONFIG_RTC_DRV_MXC_V2=y
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MOXART=m
CONFIG_RTC_DRV_MT2712=m
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_MT7622=y
CONFIG_RTC_DRV_XGENE=m
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=m
CONFIG_RTC_DRV_RTD119X=y
# CONFIG_RTC_DRV_ASPEED is not set
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_RTC_DRV_MSC313 is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PLATFORM=m
CONFIG_VFIO_AMBA=m
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=m
CONFIG_VFIO_PLATFORM_AMDXGBE_RESET=m
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=m
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_FSL_MC=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_SSV_DNP is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=y
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=m
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
# CONFIG_COMEDI_FL512 is not set
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=m
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
CONFIG_COMEDI_TESTS_NI_ROUTES=y
CONFIG_STAGING=y
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
# CONFIG_RTLLIB_CRYPTO_WEP is not set
CONFIG_OCTEON_ETHERNET=y
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_HANTRO=y
CONFIG_VIDEO_HANTRO_IMX8M=y
# CONFIG_VIDEO_HANTRO_SAMA5D4 is not set
CONFIG_VIDEO_HANTRO_ROCKCHIP=y
CONFIG_VIDEO_HANTRO_SUNXI=y
# CONFIG_VIDEO_IMX_MEDIA is not set
# CONFIG_VIDEO_MAX96712 is not set
CONFIG_VIDEO_MESON_VDEC=m
CONFIG_VIDEO_OMAP4=m
CONFIG_VIDEO_ROCKCHIP_VDEC=m
# CONFIG_VIDEO_SUNXI is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_MOST_COMPONENTS is not set
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_HID=m
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=y
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
# CONFIG_GREYBUS_I2C is not set
CONFIG_GREYBUS_PWM=m
# CONFIG_GREYBUS_UART is not set
CONFIG_GREYBUS_ARCHE=y
CONFIG_BCM_VIDEOCORE=m
# CONFIG_BCM2835_VCHIQ is not set
# CONFIG_VIDEO_BCM2835 is not set
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_GOLDFISH is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_KUNIT=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=m
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_TPS68470 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=y
CONFIG_CLK_LS1028A_PLLDIG=m
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_MMP2_AUDIO=m
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
# CONFIG_CLK_OWL_S700 is not set
CONFIG_CLK_OWL_S900=y
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
# CONFIG_CLK_BT1_CCU_DIV is not set
CONFIG_CLK_BCM2711_DVP=m
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
CONFIG_CLK_RASPBERRYPI=m
CONFIG_COMMON_CLK_HI3516CV300=m
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
CONFIG_COMMON_CLK_HI3660=y
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=m
CONFIG_CLK_IMX8MM=m
CONFIG_CLK_IMX8MN=m
CONFIG_CLK_IMX8MP=m
CONFIG_CLK_IMX8MQ=m
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
CONFIG_INGENIC_CGU_JZ4725B=y
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=m
CONFIG_TI_SYSCON_CLK=m

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
# CONFIG_COMMON_CLK_MT2701_MMSYS is not set
# CONFIG_COMMON_CLK_MT2701_IMGSYS is not set
CONFIG_COMMON_CLK_MT2701_VDECSYS=y
# CONFIG_COMMON_CLK_MT2701_HIFSYS is not set
CONFIG_COMMON_CLK_MT2701_ETHSYS=y
# CONFIG_COMMON_CLK_MT2701_BDPSYS is not set
# CONFIG_COMMON_CLK_MT2701_AUDSYS is not set
CONFIG_COMMON_CLK_MT2701_G3DSYS=y
CONFIG_COMMON_CLK_MT2712=y
# CONFIG_COMMON_CLK_MT2712_BDPSYS is not set
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
# CONFIG_COMMON_CLK_MT2712_MMSYS is not set
CONFIG_COMMON_CLK_MT2712_VDECSYS=y
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
# CONFIG_COMMON_CLK_MT6765_AUDIOSYS is not set
# CONFIG_COMMON_CLK_MT6765_CAMSYS is not set
# CONFIG_COMMON_CLK_MT6765_GCESYS is not set
CONFIG_COMMON_CLK_MT6765_MMSYS=y
CONFIG_COMMON_CLK_MT6765_IMGSYS=y
# CONFIG_COMMON_CLK_MT6765_VCODECSYS is not set
# CONFIG_COMMON_CLK_MT6765_MFGSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1BSYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI2ASYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI2BSYS is not set
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=y
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6779_IPESYS is not set
# CONFIG_COMMON_CLK_MT6779_CAMSYS is not set
CONFIG_COMMON_CLK_MT6779_VDECSYS=y
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
# CONFIG_COMMON_CLK_MT6779_MFGCFG is not set
# CONFIG_COMMON_CLK_MT6779_AUDSYS is not set
# CONFIG_COMMON_CLK_MT6797 is not set
CONFIG_COMMON_CLK_MT7622=y
# CONFIG_COMMON_CLK_MT7622_ETHSYS is not set
CONFIG_COMMON_CLK_MT7622_HIFSYS=y
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
CONFIG_COMMON_CLK_MT7629=y
CONFIG_COMMON_CLK_MT7629_ETHSYS=y
# CONFIG_COMMON_CLK_MT7629_HIFSYS is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
CONFIG_COMMON_CLK_MT8167_AUDSYS=y
# CONFIG_COMMON_CLK_MT8167_IMGSYS is not set
CONFIG_COMMON_CLK_MT8167_MFGCFG=y
CONFIG_COMMON_CLK_MT8167_MMSYS=y
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
CONFIG_COMMON_CLK_MT8192_MMSYS=y
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
# CONFIG_COMMON_CLK_MT8192_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_COMMON_CLK_PISTACHIO=y
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_S3C2410_COMMON_CLK is not set
# CONFIG_S3C2412_COMMON_CLK is not set
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
CONFIG_CLK_INTEL_SOCFPGA32=y
# CONFIG_CLK_INTEL_SOCFPGA64 is not set
CONFIG_SPRD_COMMON_CLK=m
CONFIG_SPRD_SC9860_CLK=m
CONFIG_SPRD_SC9863A_CLK=m
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_TI_ADPLL=y
CONFIG_CLK_UNIPHIER=y
# CONFIG_COMMON_CLK_VISCONTI is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
CONFIG_HWSPINLOCK=y
# CONFIG_HWSPINLOCK_OMAP is not set
# CONFIG_HWSPINLOCK_QCOM is not set
CONFIG_HWSPINLOCK_SPRD=m
# CONFIG_HWSPINLOCK_STM32 is not set
# CONFIG_HWSPINLOCK_SUN6I is not set
CONFIG_HSEM_U8500=m

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_OMAP_DM_TIMER is not set
CONFIG_DW_APB_TIMER=y
# CONFIG_FTTMR010_TIMER is not set
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
CONFIG_RDA_TIMER=y
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_TEGRA186_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_CADENCE_TTC_TIMER=y
CONFIG_ASM9260_TIMER=y
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
# CONFIG_MXS_TIMER is not set
CONFIG_NSPIRE_TIMER=y
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_STM32_LP=y
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
CONFIG_FSL_FTM_TIMER=y
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
CONFIG_SPRD_TIMER=y
# CONFIG_CLKSRC_JCORE_PIT is not set
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
CONFIG_EM_TIMER_STI=y
# CONFIG_CLKSRC_PXA is not set
CONFIG_TIMER_IMX_SYS_CTR=y
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=m
CONFIG_MESON_CLK_MEASURE=m
# CONFIG_MESON_GX_SOCINFO is not set
# CONFIG_MESON_GX_PM_DOMAINS is not set
# CONFIG_MESON_EE_PM_DOMAINS is not set
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_PMGR_PWRSTATE is not set
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=m
CONFIG_ASPEED_LPC_SNOOP=y
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
CONFIG_SOC_BCM63XX=y
CONFIG_SOC_BRCMSTB=y
# CONFIG_BCM63XX_POWER is not set
CONFIG_BCM_PMB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_FSL_GUTS=y
CONFIG_FSL_MC_DPIO=y
# CONFIG_DPAA2_CONSOLE is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_IMX_GPCV2_PM_DOMAINS is not set
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=m
CONFIG_IXP4XX_NPE=m
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=m
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
# CONFIG_MTK_MMSYS is not set
# CONFIG_MTK_SVS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_COMMAND_DB=m
CONFIG_QCOM_GENI_SE=m
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_QMI_HELPERS=m
CONFIG_QCOM_RPMH=m
CONFIG_QCOM_RPMHPD=m
# CONFIG_QCOM_SMEM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=m
CONFIG_ROCKCHIP_PM_DOMAINS=y
# CONFIG_ROCKCHIP_DTPM is not set
# CONFIG_SOC_SAMSUNG is not set
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
CONFIG_ARM_IMX_BUS_DEVFREQ=m
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_EXTCON_USBC_TUSB320=m
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL is not set
CONFIG_PWM_ATMEL_TCB=y
# CONFIG_PWM_BCM_IPROC is not set
CONFIG_PWM_BCM_KONA=m
CONFIG_PWM_BCM2835=y
# CONFIG_PWM_BERLIN is not set
CONFIG_PWM_BRCMSTB=m
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_EP93XX=m
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_HIBVT=m
CONFIG_PWM_IMG=y
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
CONFIG_PWM_IMX_TPM=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_JZ4740 is not set
CONFIG_PWM_KEEMBAY=y
# CONFIG_PWM_LPC18XX_SCT is not set
CONFIG_PWM_LPC32XX=m
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_NTXEC is not set
CONFIG_PWM_OMAP_DMTIMER=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_PXA=y
CONFIG_PWM_RASPBERRYPI_POE=m
# CONFIG_PWM_RCAR is not set
CONFIG_PWM_RENESAS_TPU=m
CONFIG_PWM_ROCKCHIP=m
CONFIG_PWM_SAMSUNG=y
CONFIG_PWM_SIFIVE=y
CONFIG_PWM_SL28CPLD=y
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=m
CONFIG_PWM_STI=y
# CONFIG_PWM_STM32 is not set
CONFIG_PWM_STM32_LP=m
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_SUN4I=m
# CONFIG_PWM_SUNPLUS is not set
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
CONFIG_PWM_VISCONTI=m
# CONFIG_PWM_VT8500 is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
CONFIG_JCORE_AIC=y
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
# CONFIG_RENESAS_RZG2L_IRQC is not set
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
CONFIG_IRQ_UNIPHIER_AIDET=y
# CONFIG_MESON_IRQ_GPIO is not set
CONFIG_IMX_IRQSTEER=y
CONFIG_IMX_INTMUX=y
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_MST_IRQ=y
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
CONFIG_RESET_ATH79=y
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=m
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_K210=y
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
CONFIG_RESET_MCHP_SPARX5=y
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=m
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=m
# CONFIG_RESET_QCOM_PDC is not set
# CONFIG_RESET_RASPBERRYPI is not set
CONFIG_RESET_RZG2L_USBPHY_CTRL=m
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
# CONFIG_RESET_TN48M_CPLD is not set
CONFIG_RESET_UNIPHIER=m
CONFIG_RESET_UNIPHIER_GLUE=y
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=y
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_CAN_TRANSCEIVER=m
CONFIG_PHY_SUN6I_MIPI_DPHY=y
CONFIG_PHY_SUN50I_USB3=y
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
CONFIG_PHY_MESON_G12A_USB2=y
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
CONFIG_PHY_CYGNUS_PCIE=m
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_BCM_NS_USB2=m
CONFIG_PHY_BCM_NS_USB3=y
# CONFIG_PHY_NS2_PCIE is not set
CONFIG_PHY_NS2_USB_DRD=y
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_FSL_IMX8MQ_USB=m
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
# CONFIG_PHY_HI3670_PCIE is not set
CONFIG_PHY_HISTB_COMBPHY=m
CONFIG_PHY_HISI_INNO_USB2=y
CONFIG_PHY_LANTIQ_VRX200_PCIE=y
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
CONFIG_ARMADA375_USBCLUSTER_PHY=y
# CONFIG_PHY_BERLIN_SATA is not set
CONFIG_PHY_BERLIN_USB=m
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_PXA_USB=y
CONFIG_PHY_MMP3_USB=m
CONFIG_PHY_MMP3_HSIC=m
# CONFIG_PHY_MTK_PCIE is not set
CONFIG_PHY_MTK_TPHY=y
CONFIG_PHY_MTK_UFS=y
CONFIG_PHY_MTK_XSPHY=y
CONFIG_PHY_MTK_HDMI=m
CONFIG_PHY_MTK_MIPI_DSI=y
# CONFIG_PHY_MTK_DP is not set
CONFIG_PHY_SPARX5_SERDES=m
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_ATH79_USB is not set
# CONFIG_PHY_QCOM_EDP is not set
CONFIG_PHY_QCOM_IPQ4019_USB=m
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
CONFIG_PHY_QCOM_QUSB2=y
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
CONFIG_PHY_QCOM_USB_HS_28NM=m
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
# CONFIG_PHY_MT7621_PCI is not set
CONFIG_PHY_RALINK_USB=m
CONFIG_PHY_RCAR_GEN3_USB3=m
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=m
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=m
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
CONFIG_PHY_EXYNOS_PCIE=y
# CONFIG_PHY_SAMSUNG_UFS is not set
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_S5PV210_USB2=y
CONFIG_PHY_UNIPHIER_USB2=y
CONFIG_PHY_UNIPHIER_USB3=y
# CONFIG_PHY_UNIPHIER_PCIE is not set
CONFIG_PHY_UNIPHIER_AHCI=m
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
# CONFIG_PHY_STIH407_USB is not set
CONFIG_PHY_STM32_USBPHYC=m
CONFIG_PHY_TEGRA194_P2U=m
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
CONFIG_PHY_J721E_WIZ=m
CONFIG_OMAP_CONTROL_PHY=m
CONFIG_TI_PIPE3=m
CONFIG_PHY_INTEL_KEEMBAY_EMMC=m
CONFIG_PHY_INTEL_KEEMBAY_USB=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=m
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_DTPM=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
CONFIG_ARM_DMC620_PMU=y
# end of Performance monitor support

CONFIG_RAS=y

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=y
CONFIG_JZ4780_EFUSE=m
CONFIG_NVMEM_LPC18XX_EEPROM=y
# CONFIG_NVMEM_LPC18XX_OTP is not set
CONFIG_NVMEM_MXS_OCOTP=m
CONFIG_MTK_EFUSE=y
# CONFIG_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=m
# CONFIG_NVMEM_STM32_ROMEM is not set
CONFIG_UNIPHIER_EFUSE=y
# CONFIG_NVMEM_VF610_OCOTP is not set
CONFIG_MESON_MX_EFUSE=y
CONFIG_NVMEM_SNVS_LPGPR=m
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=m
CONFIG_NVMEM_BRCM_NVRAM=y
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_APPLE_EFUSES is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_FPGA_MGR_SOCFPGA=m
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ZYNQ_FPGA=y
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FPGA_MGR_ZYNQMP_FPGA=y
CONFIG_FPGA_MGR_VERSAL_FPGA=m
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_AST_CF=m
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=y
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
# CONFIG_RANDSTRUCT_NONE is not set
CONFIG_RANDSTRUCT_FULL=y
CONFIG_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MD5_PPC=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_PPC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=m
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_STMP_DEVICE=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=m
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
CONFIG_KGDB_HONOUR_BLOCKLIST=y
CONFIG_KGDB_TESTS=y
# CONFIG_KGDB_TESTS_ON_BOOT is not set
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_VMALLOC=y
CONFIG_KASAN_KUNIT_TEST=y
CONFIG_KASAN_MODULE_TEST=m
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_SCF_TORTURE_TEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_KPROBE_EVENTS is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
# CONFIG_RING_BUFFER_RECORD_RECURSION is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_RING_BUFFER_STARTUP_TEST=y
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
CONFIG_PREEMPTIRQ_DELAY_TEST=m
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# powerpc Debugging
#
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
CONFIG_JUMP_LABEL_FEATURE_CHECKS=y
CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=y
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
CONFIG_DEBUGGER=y
# CONFIG_BDI_SWITCH is not set
# CONFIG_PPC_EARLY_DEBUG is not set
CONFIG_KASAN_SHADOW_OFFSET=0xe0000000
# end of powerpc Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--hphjGsDt8duBQ1ky--
