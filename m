Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078375DCD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGVOGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVOGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:06:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6262128;
        Sat, 22 Jul 2023 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690034778; x=1721570778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FWL7GsEsXsuIIlGHXCF3NbLBRp3WyWjS7z52lOLt9cM=;
  b=OT4PZ+2jHe78K1AYSdq3Jkajh5ZApXrkn2BkG+Clx3E5NwQH/i7PqQYD
   2ol/Ht49/6GDANF4XQAG3cCWCAT48YdT7sLwd2FsStbhUA6gIM8H3Whxq
   h467fM90JimmHUjPiZwENSWp6QeqlBdlS7eiZiczB9BcYRE4Kuue9Anfv
   L+4W26hKBiJ+YWHRWmEY8RoSeA+WGouOsQRUAwh7tjj6flW1VWbQv42BD
   crjNEp6q6HG59K7FF8HTu0IPjYOHaK4TWrae9grlooE5Clz6YZ9gav357
   uDjySsmY3iiMN2ftc2hID1r38GZkoAd2eWO0lpe4YeiD5mXh71/+g4Wku
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="367223915"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="367223915"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 07:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="760279985"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="760279985"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2023 07:06:10 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNDFJ-0008M5-0z;
        Sat, 22 Jul 2023 14:06:09 +0000
Date:   Sat, 22 Jul 2023 22:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>, Greg KH <greg@kroah.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <202307222141.3RAiL0jR-lkp@intel.com>
References: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230722-082500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ZLshsAj5PbsEAHhP%40qmqm.qmqm.pl
patch subject: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230722/202307222141.3RAiL0jR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307222141.3RAiL0jR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307222141.3RAiL0jR-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_test_walk':
   fs/proc/task_mmu.c:1921:13: error: implicit declaration of function 'userfaultfd_wp_async'; did you mean 'userfaultfd_wp'? [-Werror=implicit-function-declaration]
    1921 |         if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
         |             ^~~~~~~~~~~~~~~~~~~~
         |             userfaultfd_wp
   fs/proc/task_mmu.c: In function 'pagemap_scan_thp_entry':
>> fs/proc/task_mmu.c:2047:20: error: 'addr' undeclared (first use in this function)
    2047 |         if (end != addr + HPAGE_SIZE) {
         |                    ^~~~
   fs/proc/task_mmu.c:2047:20: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/addr +2047 fs/proc/task_mmu.c

  2017	
  2018	static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
  2019					  unsigned long end, struct mm_walk *walk)
  2020	{
  2021	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  2022		struct pagemap_scan_private *p = walk->private;
  2023		struct vm_area_struct *vma = walk->vma;
  2024		unsigned long categories;
  2025		spinlock_t *ptl;
  2026		int ret = 0;
  2027	
  2028		ptl = pmd_trans_huge_lock(pmd, vma);
  2029		if (!ptl)
  2030			return -ENOENT;
  2031	
  2032		categories = p->cur_vma_category | pagemap_thp_category(*pmd);
  2033	
  2034		ret = pagemap_scan_output(categories, p, start, &end);
  2035		if (start == end)
  2036			goto out_unlock;
  2037	
  2038		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
  2039			goto out_unlock;
  2040		if (~categories & PAGE_IS_WRITTEN)
  2041			goto out_unlock;
  2042	
  2043		/*
  2044		 * Break huge page into small pages if the WP operation
  2045		 * need to be performed is on a portion of the huge page.
  2046		 */
> 2047		if (end != addr + HPAGE_SIZE) {
  2048			spin_unlock(ptl);
  2049			split_huge_pmd(vma, pmd, start);
  2050			pagemap_scan_backout_range(p, start, end);
  2051			return -ENOENT;
  2052		}
  2053	
  2054		make_uffd_wp_pmd(vma, start, pmd);
  2055		flush_tlb_range(vma, start, end);
  2056	out_unlock:
  2057		spin_unlock(ptl);
  2058		return ret;
  2059	#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
  2060		return -ENOENT;
  2061	#endif
  2062	}
  2063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
