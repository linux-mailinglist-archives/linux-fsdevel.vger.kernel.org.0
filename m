Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370B775BDDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGUFop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 01:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGUFo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:44:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE52D57;
        Thu, 20 Jul 2023 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689918247; x=1721454247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jg5yy++fce0mUJ6LU5bI9B/pMq+29/OVacRUkDiLINc=;
  b=BStTaUiegGOS0xjs171YUrV2MI8JUIJnQYDk+gHfDyCSqWtoab5f/B5D
   lvUVmThhYetQT2uWTwUVPvCRLSCv2De7R3bO/DCwpeqmuabsTDcS1b7Gm
   gRhcRkvhD0OTxll4RYBQopliJ8YVvEKd/hYZEfQH7U2PYn2FRmpFt10u+
   oFT1E/Vj/o1g6073jeqE2LgJI7HFw4Kuq21YzyHsTIVYNGzitpaKC+sGn
   MfkI81T7EuIS06TfNuDwLng/7WVCoNepKvjzV1eaXoIkmyKiwmp41tarx
   QMr4WqcFWScU4XVbo/RwY74HhrUZui6BCLsnmQl35544LVAT7dbnhL0i8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="347245374"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="347245374"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898593070"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898593070"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 22:43:58 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMivl-0006vZ-30;
        Fri, 21 Jul 2023 05:43:57 +0000
Date:   Fri, 21 Jul 2023 13:43:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alex Sierra <alex.sierra@amd.com>,
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
Message-ID: <202307211337.5dwCMeHb-lkp@intel.com>
References: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
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
[also build test ERROR on linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/Re-fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230721-033050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux%40rere.qmqm.pl
patch subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: i386-randconfig-r022-20230720 (https://download.01.org/0day-ci/archive/20230721/202307211337.5dwCMeHb-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211337.5dwCMeHb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211337.5dwCMeHb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/task_mmu.c:1921:6: error: call to undeclared function 'userfaultfd_wp_async'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
               ^
>> fs/proc/task_mmu.c:2200:12: error: call to undeclared function 'uffd_wp_range'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           int err = uffd_wp_range(vma, addr, end - addr, true);
                     ^
   2 errors generated.


vim +/userfaultfd_wp_async +1921 fs/proc/task_mmu.c

  1913	
  1914	static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
  1915					  struct mm_walk *walk)
  1916	{
  1917		struct pagemap_scan_private *p = walk->private;
  1918		struct vm_area_struct *vma = walk->vma;
  1919		unsigned long vma_category = 0;
  1920	
> 1921		if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
  1922			vma_category |= PAGE_IS_WPASYNC;
  1923		else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
  1924			return -EPERM;
  1925	
  1926		if (vma->vm_flags & VM_PFNMAP)
  1927			return 1;
  1928	
  1929		if (!pagemap_scan_is_interesting_vma(vma_category, p))
  1930			return 1;
  1931	
  1932		p->cur_vma_category = vma_category;
  1933		return 0;
  1934	}
  1935	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
