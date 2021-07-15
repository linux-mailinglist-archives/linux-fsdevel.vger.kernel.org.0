Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDE3C9C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbhGOJyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:54:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:28691 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhGOJyh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:54:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210562436"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="gz'50?scan'50,208,50";a="210562436"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 02:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="gz'50?scan'50,208,50";a="466511996"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2021 02:51:41 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3y1s-000JZX-I6; Thu, 15 Jul 2021 09:51:40 +0000
Date:   Thu, 15 Jul 2021 17:51:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
Message-ID: <202107151736.FcPr80d7-lkp@intel.com>
References: <20210715033704.692967-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-32-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--RnlQjJ0d97Da+TV1
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
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8e4044529261dffc386ab56b6d90e8511c820605
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Memory-folios/20210715-133101
        git checkout 8e4044529261dffc386ab56b6d90e8511c820605
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/fscache.h:22,
                    from fs/nfs/fscache.h:14,
                    from fs/nfs/client.c:48:
   include/linux/netfs.h: In function 'folio_start_fscache':
>> include/linux/netfs.h:43:2: error: implicit declaration of function 'folio_set_private_2_flag'; did you mean 'folio_set_private_2'? [-Werror=implicit-function-declaration]
      43 |  folio_set_private_2_flag(folio);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
         |  folio_set_private_2
   cc1: some warnings being treated as errors


vim +43 include/linux/netfs.h

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

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
I3YGOnZAC41XcK1SfHDuoB1l/wMnQNJgDpsAAA==

--RnlQjJ0d97Da+TV1--
