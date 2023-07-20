Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478575B963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTVNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTVNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:13:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C361E52;
        Thu, 20 Jul 2023 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689887614; x=1721423614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F1bYz3hgit6KaUoqzvThCzYOIRPkgaYh6xO1/Oye1q0=;
  b=YRzK0Rp+7yKvH7ejEkrigFZCCAu5EEchsRPT1XUwNi878zGaco1zqfJZ
   pAoFEaAyndS8QQqLgqoqyg2e0TUn8iUbFYYsZDAmNrtlQ7yu6nP+lZIa8
   QdQDE7aJcmpwWgEEc85N/Q9Pik45P/MN5Cw6GyhYlXR7lM/2L9N6BGqoU
   nkqoY1FbviqjwxhwG5vL9tFltfVswcGWlQ5aFlMXQ1FeVFz+mH132mAQv
   yRamRusw0W3QzM2VYkrl4ux1OjQePrc++byNufGrTAW78eCMgCNQ5Bnab
   JmHnzZVchWNrO8qTIvn4J+1WPC+v3AbNJ+24jUu0Hqz08wkAACSaLC7m2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366900223"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="366900223"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 14:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727852971"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="727852971"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 14:13:26 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMaxV-0006WF-1t;
        Thu, 20 Jul 2023 21:13:17 +0000
Date:   Fri, 21 Jul 2023 05:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
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
Subject: Re: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <202307210528.2qgK1vwi-lkp@intel.com>
References: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/Re-fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230721-033050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux%40rere.qmqm.pl
patch subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230721/202307210528.2qgK1vwi-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210528.2qgK1vwi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210528.2qgK1vwi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_test_walk':
   fs/proc/task_mmu.c:1921:13: error: implicit declaration of function 'userfaultfd_wp_async'; did you mean 'userfaultfd_wp'? [-Werror=implicit-function-declaration]
    1921 |         if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
         |             ^~~~~~~~~~~~~~~~~~~~
         |             userfaultfd_wp
   fs/proc/task_mmu.c: In function 'pagemap_scan_init_bounce_buffer':
>> fs/proc/task_mmu.c:2290:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2290 |         p->vec_out = (void __user *)p->arg.vec;
         |                      ^
   fs/proc/task_mmu.c: At top level:
   fs/proc/task_mmu.c:1967:13: warning: 'pagemap_scan_backout_range' defined but not used [-Wunused-function]
    1967 | static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2290 fs/proc/task_mmu.c

  2264	
  2265	static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
  2266	{
  2267		if (!p->arg.vec_len) {
  2268			/*
  2269			 * An arbitrary non-page-aligned sentinel value for
  2270			 * pagemap_scan_push_range().
  2271			 */
  2272			p->cur_buf.start = p->cur_buf.end = ULLONG_MAX;
  2273			return 0;
  2274		}
  2275	
  2276		/*
  2277		 * Allocate a smaller buffer to get output from inside the page
  2278		 * walk functions and walk the range in PAGEMAP_WALK_SIZE chunks.
  2279		 * The last range is always stored in p.cur_buf to allow coalescing
  2280		 * consecutive ranges that have the same categories returned across
  2281		 * walk_page_range() calls.
  2282		 */
  2283		p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
  2284				       p->arg.vec_len - 1);
  2285		p->vec_buf = kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
  2286					   GFP_KERNEL);
  2287		if (!p->vec_buf)
  2288			return -ENOMEM;
  2289	
> 2290		p->vec_out = (void __user *)p->arg.vec;
  2291	
  2292		return 0;
  2293	}
  2294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
