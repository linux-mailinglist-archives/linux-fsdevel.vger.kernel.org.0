Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549035AA60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 04:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhDJCww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 22:52:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:30869 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDJCww (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:52:52 -0400
IronPort-SDR: LxRLrBfoOAGmm4+pCYIRaqeh77tjPo0bc5AKM+E5iZtuUo62l++NiFHG38XCOwr2/HUedLop41
 L08g7q39XY5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="181407347"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="gz'50?scan'50,208,50";a="181407347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 19:52:37 -0700
IronPort-SDR: cSw4XffCXRgeTZx/XfCv7u+o2QnNgqZA+cPAJvppDOBrcvWuj+Zy7Jjuc3V3dRgmuBq5txfW+H
 1jenTVyKHVUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="gz'50?scan'50,208,50";a="520488211"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2021 19:52:35 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lV3je-000HjI-GT; Sat, 10 Apr 2021 02:52:34 +0000
Date:   Sat, 10 Apr 2021 10:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 02/28] mm: Introduce struct folio
Message-ID: <202104101038.1fji2pdh-lkp@intel.com>
References: <20210409185105.188284-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20210409185105.188284-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20210409]
[also build test ERROR on v5.12-rc6]
[cannot apply to linux/master linus/master hnaz-linux-mm/master v5.12-rc6 v5.12-rc5 v5.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Memory-Folios/20210410-031353
base:    e99d8a8495175df8cb8b739f8cf9b0fc9d0cd3b5
config: mips-gpr_defconfig (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5658a201516d2ed74a34c328e3b55f552d4861d8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Memory-Folios/20210410-031353
        git checkout 5658a201516d2ed74a34c328e3b55f552d4861d8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:53,
                    from arch/mips/include/asm/div64.h:12,
                    from include/linux/math64.h:7,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from arch/mips/kernel/asm-offsets.c:12:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:274:1: note: in expansion of macro 'FOLIO_MATCH'
     274 | FOLIO_MATCH(lru, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:275:1: note: in expansion of macro 'FOLIO_MATCH'
     275 | FOLIO_MATCH(compound_head, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, index) == offsetof(struct folio, index)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:276:1: note: in expansion of macro 'FOLIO_MATCH'
     276 | FOLIO_MATCH(index, index);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, private) == offsetof(struct folio, private)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:277:1: note: in expansion of macro 'FOLIO_MATCH'
     277 | FOLIO_MATCH(private, private);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _mapcount) == offsetof(struct folio, _mapcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:278:1: note: in expansion of macro 'FOLIO_MATCH'
     278 | FOLIO_MATCH(_mapcount, _mapcount);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _refcount) == offsetof(struct folio, _refcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:279:1: note: in expansion of macro 'FOLIO_MATCH'
     279 | FOLIO_MATCH(_refcount, _refcount);
         | ^~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:93:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      93 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:109:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     109 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:137:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     137 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:180:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     180 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:219:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     219 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:254:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     254 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:347:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     347 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:53,
                    from arch/mips/include/asm/div64.h:12,
                    from include/linux/math64.h:7,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from arch/mips/kernel/asm-offsets.c:12:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:274:1: note: in expansion of macro 'FOLIO_MATCH'
     274 | FOLIO_MATCH(lru, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:275:1: note: in expansion of macro 'FOLIO_MATCH'
     275 | FOLIO_MATCH(compound_head, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, index) == offsetof(struct folio, index)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:276:1: note: in expansion of macro 'FOLIO_MATCH'
     276 | FOLIO_MATCH(index, index);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, private) == offsetof(struct folio, private)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:277:1: note: in expansion of macro 'FOLIO_MATCH'
     277 | FOLIO_MATCH(private, private);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _mapcount) == offsetof(struct folio, _mapcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:278:1: note: in expansion of macro 'FOLIO_MATCH'
     278 | FOLIO_MATCH(_mapcount, _mapcount);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _refcount) == offsetof(struct folio, _refcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:279:1: note: in expansion of macro 'FOLIO_MATCH'
     279 | FOLIO_MATCH(_refcount, _refcount);
         | ^~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:93:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      93 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:109:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     109 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:137:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     137 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:180:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     180 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:219:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     219 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:254:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     254 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:347:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     347 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:118: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1304: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   error: no override and no default toolchain set
   init/Kconfig:70:warning: 'RUSTC_VERSION': number is invalid
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:53,
                    from arch/mips/include/asm/div64.h:12,
                    from include/linux/math64.h:7,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from arch/mips/kernel/asm-offsets.c:12:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:274:1: note: in expansion of macro 'FOLIO_MATCH'
     274 | FOLIO_MATCH(lru, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:275:1: note: in expansion of macro 'FOLIO_MATCH'
     275 | FOLIO_MATCH(compound_head, lru);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, index) == offsetof(struct folio, index)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:276:1: note: in expansion of macro 'FOLIO_MATCH'
     276 | FOLIO_MATCH(index, index);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, private) == offsetof(struct folio, private)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:277:1: note: in expansion of macro 'FOLIO_MATCH'
     277 | FOLIO_MATCH(private, private);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _mapcount) == offsetof(struct folio, _mapcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:278:1: note: in expansion of macro 'FOLIO_MATCH'
     278 | FOLIO_MATCH(_mapcount, _mapcount);
         | ^~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _refcount) == offsetof(struct folio, _refcount)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:272:2: note: in expansion of macro 'static_assert'
     272 |  static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |  ^~~~~~~~~~~~~
   include/linux/mm_types.h:279:1: note: in expansion of macro 'FOLIO_MATCH'
     279 | FOLIO_MATCH(_refcount, _refcount);
         | ^~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:93:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      93 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:109:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     109 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:137:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     137 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:180:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     180 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:219:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     219 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:254:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     254 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:347:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     347 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:118: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1304: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07 @77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--x+6KMIRAuhnl3hBn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Q+Kf22OnY608kLX2TQeuRTtx+P8ASq99AY1qAQA=

--x+6KMIRAuhnl3hBn--
