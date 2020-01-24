Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDB148E8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 20:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgAXTOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 14:14:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:8774 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387683AbgAXTOC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:14:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 11:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="gz'50?scan'50,208,50";a="222697473"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2020 11:13:31 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iv4OY-000Dg9-It; Sat, 25 Jan 2020 03:13:30 +0800
Date:   Sat, 25 Jan 2020 03:12:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 06/12] arm64: elf: Enable BTI at exec based on ELF
 program properties
Message-ID: <202001250302.Pb0vnMSr%lkp@intel.com>
References: <20200122212144.6409-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="p4zwf2lu76yf5343"
Content-Disposition: inline
In-Reply-To: <20200122212144.6409-7-broonie@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--p4zwf2lu76yf5343
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on asm-generic/master]
[also build test ERROR on kvmarm/next linus/master v5.5-rc7]
[cannot apply to arm64/for-next/core arm-perf/for-next/perf next-20200124]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Mark-Brown/arm64-ARMv8-5-A-Branch-Target-Identification-support/20200124-203746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/module.h:18:0,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:11,
                    from include/linux/perf_event.h:49,
                    from include/kvm/arm_pmu.h:10,
                    from arch/arm64/include/asm/kvm_host.h:37,
                    from include/linux/kvm_host.h:36,
                    from arch/arm64/kernel/asm-offsets.c:14:
>> include/linux/elf.h:79:19: error: redefinition of 'arch_parse_elf_property'
    static inline int arch_parse_elf_property(u32 type, const void *data,
                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/elf.h:6:0,
                    from include/linux/module.h:18,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:11,
                    from include/linux/perf_event.h:49,
                    from include/kvm/arm_pmu.h:10,
                    from arch/arm64/include/asm/kvm_host.h:37,
                    from include/linux/kvm_host.h:36,
                    from arch/arm64/kernel/asm-offsets.c:14:
   arch/arm64/include/asm/elf.h:241:19: note: previous definition of 'arch_parse_elf_property' was here
    static inline int arch_parse_elf_property(u32 type, const void *data,
                      ^~~~~~~~~~~~~~~~~~~~~~~
   make[2]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2
   115 real  3 user  4 sys  7.44% cpu 	make prepare

vim +/arch_parse_elf_property +79 include/linux/elf.h

efb25e29b815dd Dave Martin 2020-01-22  77  
efb25e29b815dd Dave Martin 2020-01-22  78  #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
efb25e29b815dd Dave Martin 2020-01-22 @79  static inline int arch_parse_elf_property(u32 type, const void *data,
efb25e29b815dd Dave Martin 2020-01-22  80  					  size_t datasz, bool compat,
efb25e29b815dd Dave Martin 2020-01-22  81  					  struct arch_elf_state *arch)
efb25e29b815dd Dave Martin 2020-01-22  82  {
efb25e29b815dd Dave Martin 2020-01-22  83  	return 0;
efb25e29b815dd Dave Martin 2020-01-22  84  }
efb25e29b815dd Dave Martin 2020-01-22  85  #else
efb25e29b815dd Dave Martin 2020-01-22  86  extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
efb25e29b815dd Dave Martin 2020-01-22  87  				   bool compat, struct arch_elf_state *arch);
efb25e29b815dd Dave Martin 2020-01-22  88  #endif
efb25e29b815dd Dave Martin 2020-01-22  89  

:::::: The code at line 79 was first introduced by commit
:::::: efb25e29b815ddf0dd1bbe3728659da08c80fa14 ELF: Add ELF program property parsing support

:::::: TO: Dave Martin <Dave.Martin@arm.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--p4zwf2lu76yf5343
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZVy4K63iGuOK2XXgjd1ZIOxi+A8QQPF73ngAAA==

--p4zwf2lu76yf5343--
