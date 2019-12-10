Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9904F117CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 02:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLJBEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 20:04:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:6716 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfLJBEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:04:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 17:04:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="gz'50?scan'50,208,50";a="220101325"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2019 17:04:33 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ieTx3-000Bde-5d; Tue, 10 Dec 2019 09:04:33 +0800
Date:   Tue, 10 Dec 2019 09:04:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fs/proc/page.c: allow inspection of last section
 and fix end detection
Message-ID: <201912100809.P9SHh5Nz%lkp@intel.com>
References: <20191209174836.11063-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lgvcpxun4zjf7yls"
Content-Disposition: inline
In-Reply-To: <20191209174836.11063-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lgvcpxun4zjf7yls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on linux/master v5.5-rc1 next-20191209]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-fix-max_pfn-not-falling-on-section-boundary/20191210-071011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6794862a16ef41f753abd75c03a152836e4c8028
config: i386-defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:19:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/memblock.h:13,
                    from fs/proc/page.c:2:
   fs/proc/page.c: In function 'kpagecount_read':
>> fs/proc/page.c:32:55: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'PAGE_KERNEL_IO'?
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
   fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~
   fs/proc/page.c:32:55: note: each undeclared identifier is reported only once for each function it appears in
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
   fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~
   fs/proc/page.c: In function 'kpageflags_read':
   fs/proc/page.c:212:55: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'PAGE_KERNEL_IO'?
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                                          ^
   include/linux/kernel.h:62:46: note: in definition of macro '__round_mask'
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                 ^
   fs/proc/page.c:212:37: note: in expansion of macro 'round_up'
     const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
                                        ^~~~~~~~

vim +32 fs/proc/page.c

   > 2	#include <linux/memblock.h>
     3	#include <linux/compiler.h>
     4	#include <linux/fs.h>
     5	#include <linux/init.h>
     6	#include <linux/ksm.h>
     7	#include <linux/mm.h>
     8	#include <linux/mmzone.h>
     9	#include <linux/huge_mm.h>
    10	#include <linux/proc_fs.h>
    11	#include <linux/seq_file.h>
    12	#include <linux/hugetlb.h>
    13	#include <linux/memcontrol.h>
    14	#include <linux/mmu_notifier.h>
    15	#include <linux/page_idle.h>
    16	#include <linux/kernel-page-flags.h>
    17	#include <linux/uaccess.h>
    18	#include "internal.h"
    19	
    20	#define KPMSIZE sizeof(u64)
    21	#define KPMMASK (KPMSIZE - 1)
    22	#define KPMBITS (KPMSIZE * BITS_PER_BYTE)
    23	
    24	/* /proc/kpagecount - an array exposing page counts
    25	 *
    26	 * Each entry is a u64 representing the corresponding
    27	 * physical page count.
    28	 */
    29	static ssize_t kpagecount_read(struct file *file, char __user *buf,
    30				     size_t count, loff_t *ppos)
    31	{
  > 32		const unsigned long max_dump_pfn = round_up(max_pfn, PAGES_PER_SECTION);
    33		u64 __user *out = (u64 __user *)buf;
    34		struct page *ppage;
    35		unsigned long src = *ppos;
    36		unsigned long pfn;
    37		ssize_t ret = 0;
    38		u64 pcount;
    39	
    40		pfn = src / KPMSIZE;
    41		if (src & KPMMASK || count & KPMMASK)
    42			return -EINVAL;
    43		if (src >= max_dump_pfn * KPMSIZE)
    44			return 0;
    45		count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
    46	
    47		while (count > 0) {
    48			/*
    49			 * TODO: ZONE_DEVICE support requires to identify
    50			 * memmaps that were actually initialized.
    51			 */
    52			ppage = pfn_to_online_page(pfn);
    53	
    54			if (!ppage || PageSlab(ppage) || page_has_type(ppage))
    55				pcount = 0;
    56			else
    57				pcount = page_mapcount(ppage);
    58	
    59			if (put_user(pcount, out)) {
    60				ret = -EFAULT;
    61				break;
    62			}
    63	
    64			pfn++;
    65			out++;
    66			count -= KPMSIZE;
    67	
    68			cond_resched();
    69		}
    70	
    71		*ppos += (char __user *)out - buf;
    72		if (!ret)
    73			ret = (char __user *)out - buf;
    74		return ret;
    75	}
    76	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--lgvcpxun4zjf7yls
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lgvcpxun4zjf7yls--
