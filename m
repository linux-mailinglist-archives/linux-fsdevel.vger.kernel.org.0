Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B55374A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 23:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEEViT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 17:38:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:32052 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhEEViT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 17:38:19 -0400
IronPort-SDR: FDeTJqTLLdlr03uGdv1fJGoUx+ZHEY4tCH96PRhXw3eBy7GThPYe5k37XQWUDbdKTdEx61aCKu
 4M4BI2YWFSlg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="196285354"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="gz'50?scan'50,208,50";a="196285354"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 14:37:22 -0700
IronPort-SDR: OWwCfNXURh4EnyaAFBcvr7bEGK9UOPzKtNIEk4p6QEppVt9FEp5biIDpqXuy+l52Tt7kW6oPX1
 V+6kir2fxoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="gz'50?scan'50,208,50";a="434021510"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2021 14:37:20 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lePCp-000AB6-Gi; Wed, 05 May 2021 21:37:19 +0000
Date:   Thu, 6 May 2021 05:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 92/96] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <202105060511.863ZVBcq-lkp@intel.com>
References: <20210505150628.111735-93-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20210505150628.111735-93-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20210505]
[cannot apply to hnaz-linux-mm/master xfs-linux/for-next tip/perf/core shaggy/jfs-next block/for-next linus/master asm-generic/master v5.12 v5.12-rc8 v5.12-rc7 v5.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Memory-folios/20210506-014108
base:    29955e0289b3255c5f609a7564a0f0bb4ae35c7a
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0780b0addad735d2cceb3680d49f54f8618e1334
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Memory-folios/20210506-014108
        git checkout 0780b0addad735d2cceb3680d49f54f8618e1334
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/swap.h:9,
                    from fs/iomap/buffered-io.c:16:
   include/linux/memcontrol.h: In function 'folio_uncharge_cgroup':
   include/linux/memcontrol.h:1213:42: error: parameter name omitted
    1213 | static inline void folio_uncharge_cgroup(struct folio *)
         |                                          ^~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function '__iomap_write_end':
>> fs/iomap/buffered-io.c:645:2: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_dcache_page'? [-Werror=implicit-function-declaration]
     645 |  flush_dcache_folio(folio);
         |  ^~~~~~~~~~~~~~~~~~
         |  flush_dcache_page
   cc1: some warnings being treated as errors


vim +645 fs/iomap/buffered-io.c

   640	
   641	static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
   642			size_t copied, struct folio *folio)
   643	{
   644		struct iomap_page *iop = to_iomap_page(folio);
 > 645		flush_dcache_folio(folio);
   646	
   647		/*
   648		 * The blocks that were entirely written will now be uptodate, so we
   649		 * don't have to worry about a readpage reading them and overwriting a
   650		 * partial write.  However if we have encountered a short write and only
   651		 * partially written into a block, it will not be marked uptodate, so a
   652		 * readpage might come in and destroy our partial write.
   653		 *
   654		 * Do the simplest thing, and just treat any short write to a non
   655		 * uptodate page as a zero-length write, and force the caller to redo
   656		 * the whole thing.
   657		 */
   658		if (unlikely(copied < len && !folio_uptodate(folio)))
   659			return 0;
   660		iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
   661		filemap_dirty_folio(inode->i_mapping, folio);
   662		return copied;
   663	}
   664	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--NzB8fVQJ5HfG6fxh--
