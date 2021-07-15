Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8A3C9CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbhGOKhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:37:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:4425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhGOKhj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:37:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="296162860"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="gz'50?scan'50,208,50";a="296162860"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 03:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="gz'50?scan'50,208,50";a="428746090"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2021 03:34:42 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3yhV-000Jaz-N0; Thu, 15 Jul 2021 10:34:41 +0000
Date:   Thu, 15 Jul 2021 18:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
Message-ID: <202107151842.CQ5VI5dw-lkp@intel.com>
References: <20210715033704.692967-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-32-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.14-rc1 next-20210715]
[cannot apply to hnaz-linux-mm/master xfs-linux/for-next tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Memory-folios/20210715-133101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8096acd7442e613fad0354fc8dfdb2003cceea0b
config: powerpc-randconfig-r033-20210715 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 0e49c54a8cbd3e779e5526a5888c683c01cc3c50)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/0day-ci/linux/commit/8e4044529261dffc386ab56b6d90e8511c820605
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Memory-folios/20210715-133101
        git checkout 8e4044529261dffc386ab56b6d90e8511c820605
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:16:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/netfs/read_helper.c:12:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:20:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/netfs/read_helper.c:12:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:24:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/netfs/read_helper.c:12:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:28:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/netfs/read_helper.c:12:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:32:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from fs/netfs/read_helper.c:17:
>> include/linux/netfs.h:43:2: error: implicit declaration of function 'folio_set_private_2_flag' [-Werror,-Wimplicit-function-declaration]
           folio_set_private_2_flag(folio);
           ^
   include/linux/netfs.h:43:2: note: did you mean 'folio_set_private_2'?
   include/linux/page-flags.h:445:1: note: 'folio_set_private_2' declared here
   PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
   ^
   include/linux/page-flags.h:362:2: note: expanded from macro 'PAGEFLAG'
           SETPAGEFLAG(uname, lname, policy)                               \
           ^
   include/linux/page-flags.h:320:6: note: expanded from macro 'SETPAGEFLAG'
   void folio_set_##lname(struct folio *folio)                             \
        ^
   <scratch space>:70:1: note: expanded from here
   folio_set_private_2
   ^
   12 warnings and 1 error generated.


vim +/folio_set_private_2_flag +43 include/linux/netfs.h

    31	
    32	/**
    33	 * folio_start_fscache - Start an fscache write on a folio.
    34	 * @folio: The folio.
    35	 *
    36	 * Call this function before writing a folio to a local cache.  Starting a
    37	 * second write before the first one finishes is not allowed.
    38	 */
    39	static inline void folio_start_fscache(struct folio *folio)
    40	{
    41		VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
    42		folio_get(folio);
  > 43		folio_set_private_2_flag(folio);
    44	}
    45	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zLf/A27cl9k6owEA

--fUYQa+Pmc3FrFX/N--
