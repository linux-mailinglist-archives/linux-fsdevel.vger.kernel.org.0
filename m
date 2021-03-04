Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114B32D7FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 17:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhCDQnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 11:43:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:25196 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233943AbhCDQnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:43:25 -0500
IronPort-SDR: vVwL6b/DEwpfQjPt6oZZZSxfGHFMKOgalOQjZkTVedhPhhnaY4P+jJRK2HEfOD8Tkb+JPLufGK
 lH2F+AQ0TT5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187503962"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="gz'50?scan'50,208,50";a="187503962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 08:42:41 -0800
IronPort-SDR: aBhIoE5oZWuurj+cmFUgR6zBr9y/05/kzVKQhViRWf2oDUjubXEZpqnSJNYEp3E/4Z56H8qfV4
 IhrQb3WzZC9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="gz'50?scan'50,208,50";a="507452250"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 08:42:38 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHr3d-0002Hb-Oa; Thu, 04 Mar 2021 16:42:37 +0000
Date:   Fri, 5 Mar 2021 00:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] quota: wire up quotactl_path
Message-ID: <202103050000.rySeDG1R-lkp@intel.com>
References: <20210304123541.30749-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20210304123541.30749-3-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sascha,

I love your patch! Perhaps something to improve:

[auto build test WARNING on m68k/for-next]
[also build test WARNING on hp-parisc/for-next powerpc/next s390/features sparc/master linus/master v5.12-rc1]
[cannot apply to arm64/for-next/core tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sascha-Hauer/quota-Add-mountpath-based-quota-support/20210304-204157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: x86_64-randconfig-m001-20210304 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/4c5e71a8aad3e3e1f2eb339eec24d563d0d6acbe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sascha-Hauer/quota-Add-mountpath-based-quota-support/20210304-204157
        git checkout 4c5e71a8aad3e3e1f2eb339eec24d563d0d6acbe
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:69:1: note: in expansion of macro 'COND_SYSCALL'
      69 | COND_SYSCALL(epoll_pwait);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_epoll_pwait2' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:71:1: note: in expansion of macro 'COND_SYSCALL'
      71 | COND_SYSCALL(epoll_pwait2);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_inotify_init1' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:77:1: note: in expansion of macro 'COND_SYSCALL'
      77 | COND_SYSCALL(inotify_init1);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_inotify_add_watch' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:78:1: note: in expansion of macro 'COND_SYSCALL'
      78 | COND_SYSCALL(inotify_add_watch);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_inotify_rm_watch' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:79:1: note: in expansion of macro 'COND_SYSCALL'
      79 | COND_SYSCALL(inotify_rm_watch);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_ioprio_set' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:84:1: note: in expansion of macro 'COND_SYSCALL'
      84 | COND_SYSCALL(ioprio_set);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_ioprio_get' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:85:1: note: in expansion of macro 'COND_SYSCALL'
      85 | COND_SYSCALL(ioprio_get);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_flock' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:88:1: note: in expansion of macro 'COND_SYSCALL'
      88 | COND_SYSCALL(flock);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_quotactl' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:101:1: note: in expansion of macro 'COND_SYSCALL'
     101 | COND_SYSCALL(quotactl);
         | ^~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_quotactl_path' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:102:1: note: in expansion of macro 'COND_SYSCALL'
     102 | COND_SYSCALL(quotactl_path);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_signalfd4' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:113:1: note: in expansion of macro 'COND_SYSCALL'
     113 | COND_SYSCALL(signalfd4);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_timerfd_create' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:123:1: note: in expansion of macro 'COND_SYSCALL'
     123 | COND_SYSCALL(timerfd_create);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_timerfd_settime' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:124:1: note: in expansion of macro 'COND_SYSCALL'
     124 | COND_SYSCALL(timerfd_settime);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_timerfd_settime32' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:125:1: note: in expansion of macro 'COND_SYSCALL'
     125 | COND_SYSCALL(timerfd_settime32);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_timerfd_gettime' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:126:1: note: in expansion of macro 'COND_SYSCALL'
     126 | COND_SYSCALL(timerfd_gettime);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_timerfd_gettime32' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:127:1: note: in expansion of macro 'COND_SYSCALL'
     127 | COND_SYSCALL(timerfd_gettime32);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_acct' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:132:1: note: in expansion of macro 'COND_SYSCALL'
     132 | COND_SYSCALL(acct);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_capget' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)


vim +/__x64_sys_quotactl_path +83 arch/x86/include/asm/syscall_wrapper.h

cc42c045af1ff4de Brian Gerst       2020-03-13  13  
25c619e59b395a8c Brian Gerst       2020-03-13  14  /*
25c619e59b395a8c Brian Gerst       2020-03-13  15   * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
25c619e59b395a8c Brian Gerst       2020-03-13  16   * struct pt_regs *regs as the only argument of the syscall stub(s) named as:
25c619e59b395a8c Brian Gerst       2020-03-13  17   * __x64_sys_*()         - 64-bit native syscall
25c619e59b395a8c Brian Gerst       2020-03-13  18   * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
25c619e59b395a8c Brian Gerst       2020-03-13  19   * __ia32_compat_sys_*() - 32-bit compat syscall
25c619e59b395a8c Brian Gerst       2020-03-13  20   * __x32_compat_sys_*()  - 64-bit X32 compat syscall
25c619e59b395a8c Brian Gerst       2020-03-13  21   *
25c619e59b395a8c Brian Gerst       2020-03-13  22   * The registers are decoded according to the ABI:
25c619e59b395a8c Brian Gerst       2020-03-13  23   * 64-bit: RDI, RSI, RDX, R10, R8, R9
25c619e59b395a8c Brian Gerst       2020-03-13  24   * 32-bit: EBX, ECX, EDX, ESI, EDI, EBP
25c619e59b395a8c Brian Gerst       2020-03-13  25   *
25c619e59b395a8c Brian Gerst       2020-03-13  26   * The stub then passes the decoded arguments to the __se_sys_*() wrapper to
25c619e59b395a8c Brian Gerst       2020-03-13  27   * perform sign-extension (omitted for zero-argument syscalls).  Finally the
25c619e59b395a8c Brian Gerst       2020-03-13  28   * arguments are passed to the __do_sys_*() function which is the actual
25c619e59b395a8c Brian Gerst       2020-03-13  29   * syscall.  These wrappers are marked as inline so the compiler can optimize
25c619e59b395a8c Brian Gerst       2020-03-13  30   * the functions where appropriate.
25c619e59b395a8c Brian Gerst       2020-03-13  31   *
25c619e59b395a8c Brian Gerst       2020-03-13  32   * Example assembly (slightly re-ordered for better readability):
25c619e59b395a8c Brian Gerst       2020-03-13  33   *
25c619e59b395a8c Brian Gerst       2020-03-13  34   * <__x64_sys_recv>:		<-- syscall with 4 parameters
25c619e59b395a8c Brian Gerst       2020-03-13  35   *	callq	<__fentry__>
25c619e59b395a8c Brian Gerst       2020-03-13  36   *
25c619e59b395a8c Brian Gerst       2020-03-13  37   *	mov	0x70(%rdi),%rdi	<-- decode regs->di
25c619e59b395a8c Brian Gerst       2020-03-13  38   *	mov	0x68(%rdi),%rsi	<-- decode regs->si
25c619e59b395a8c Brian Gerst       2020-03-13  39   *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
25c619e59b395a8c Brian Gerst       2020-03-13  40   *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
25c619e59b395a8c Brian Gerst       2020-03-13  41   *
25c619e59b395a8c Brian Gerst       2020-03-13  42   *	xor	%r9d,%r9d	<-- clear %r9
25c619e59b395a8c Brian Gerst       2020-03-13  43   *	xor	%r8d,%r8d	<-- clear %r8
25c619e59b395a8c Brian Gerst       2020-03-13  44   *
25c619e59b395a8c Brian Gerst       2020-03-13  45   *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
25c619e59b395a8c Brian Gerst       2020-03-13  46   *				    which takes 6 arguments
25c619e59b395a8c Brian Gerst       2020-03-13  47   *
25c619e59b395a8c Brian Gerst       2020-03-13  48   *	cltq			<-- extend return value to 64-bit
25c619e59b395a8c Brian Gerst       2020-03-13  49   *	retq			<-- return
25c619e59b395a8c Brian Gerst       2020-03-13  50   *
25c619e59b395a8c Brian Gerst       2020-03-13  51   * This approach avoids leaking random user-provided register content down
25c619e59b395a8c Brian Gerst       2020-03-13  52   * the call chain.
25c619e59b395a8c Brian Gerst       2020-03-13  53   */
25c619e59b395a8c Brian Gerst       2020-03-13  54  
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  55  /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  56  #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  57  	__MAP(x,__SC_ARGS						\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  58  		,,regs->di,,regs->si,,regs->dx				\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  59  		,,regs->r10,,regs->r8,,regs->r9)			\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  60  
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  61  /* Mapping of registers to parameters for syscalls on i386 */
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  62  #define SC_IA32_REGS_TO_ARGS(x, ...)					\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  63  	__MAP(x,__SC_ARGS						\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  64  	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  65  	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  66  	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
ebeb8c82ffaf9443 Dominik Brodowski 2018-04-05  67  
d2b5de495ee9838b Brian Gerst       2020-03-13  68  #define __SYS_STUB0(abi, name)						\
0f78ff17112d8b34 Brian Gerst       2020-03-13  69  	long __##abi##_##name(const struct pt_regs *regs);		\
d2b5de495ee9838b Brian Gerst       2020-03-13  70  	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
0f78ff17112d8b34 Brian Gerst       2020-03-13  71  	long __##abi##_##name(const struct pt_regs *regs)		\
d2b5de495ee9838b Brian Gerst       2020-03-13  72  		__alias(__do_##name);
d2b5de495ee9838b Brian Gerst       2020-03-13  73  
4399e0cf494f739a Brian Gerst       2020-03-13  74  #define __SYS_STUBx(abi, name, ...)					\
0f78ff17112d8b34 Brian Gerst       2020-03-13  75  	long __##abi##_##name(const struct pt_regs *regs);		\
4399e0cf494f739a Brian Gerst       2020-03-13  76  	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
0f78ff17112d8b34 Brian Gerst       2020-03-13  77  	long __##abi##_##name(const struct pt_regs *regs)		\
4399e0cf494f739a Brian Gerst       2020-03-13  78  	{								\
4399e0cf494f739a Brian Gerst       2020-03-13  79  		return __se_##name(__VA_ARGS__);			\
4399e0cf494f739a Brian Gerst       2020-03-13  80  	}
4399e0cf494f739a Brian Gerst       2020-03-13  81  
6cc8d2b286d9e716 Brian Gerst       2020-03-13  82  #define __COND_SYSCALL(abi, name)					\
0f78ff17112d8b34 Brian Gerst       2020-03-13 @83  	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
6cc8d2b286d9e716 Brian Gerst       2020-03-13  84  	{								\
6cc8d2b286d9e716 Brian Gerst       2020-03-13  85  		return sys_ni_syscall();				\
6cc8d2b286d9e716 Brian Gerst       2020-03-13  86  	}
6cc8d2b286d9e716 Brian Gerst       2020-03-13  87  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--liOOAslEiF7prFVr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9uOBeIU70A2L5Zc5iJ3VN2P/AyUCyh8OJgIA

--liOOAslEiF7prFVr--
