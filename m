Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6947896DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjHZNI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjHZNIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 09:08:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE31BF2;
        Sat, 26 Aug 2023 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693055282; x=1724591282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h5qAIYNCKZ5pVgkeXhd5+JVPUHjrWuo3wDX5RG0ObUo=;
  b=kY4aETQ4GKPj0/AGrYxTTvbGK+WxxCMxXIPQaI6Rnb+sDT+sPE2T7Cxm
   pmBVYEaxP+5x1l0e+LKXmzhwPqydIVWKPNbbSf6XAq/tE9Whs4zud+MNr
   M/LoVQ7zbF9QcUzFCjzDjtUj4hn/AueNXl3q4hpk3ETkGwbajmx0aCai4
   SAwzgp3cFhFYiQoPm/O9yV+bIM25XyLoAu5HY9WzbfuHUDzdr6ZL7U5km
   AfPHKhb9WheN6jC9mdE1TdbFfvUjl+NEM6NYWHODqNWZt4NAZOiIcyjEd
   kjQ2aQKgoqw1SVjbyH4kGGOEqUdwIaZTSbjsYOVmbBCWxwCZd831QHuU/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="374844340"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="374844340"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 06:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="852281523"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="852281523"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2023 06:07:54 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZt17-0004jJ-2M;
        Sat, 26 Aug 2023 13:07:53 +0000
Date:   Sat, 26 Aug 2023 21:07:14 +0800
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
Message-ID: <202308262125.VHTuZ7uV-lkp@intel.com>
References: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc7 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/Re-fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230721-033050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux%40rere.qmqm.pl
patch subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: i386-randconfig-i004-20230720 (https://download.01.org/0day-ci/archive/20230826/202308262125.VHTuZ7uV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308262125.VHTuZ7uV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308262125.VHTuZ7uV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_test_walk':
   fs/proc/task_mmu.c:1921:13: error: implicit declaration of function 'userfaultfd_wp_async'; did you mean 'userfaultfd_wp'? [-Werror=implicit-function-declaration]
    1921 |         if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
         |             ^~~~~~~~~~~~~~~~~~~~
         |             userfaultfd_wp
   fs/proc/task_mmu.c: In function 'pagemap_scan_init_bounce_buffer':
   fs/proc/task_mmu.c:2290:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2290 |         p->vec_out = (void __user *)p->arg.vec;
         |                      ^
   fs/proc/task_mmu.c: At top level:
>> fs/proc/task_mmu.c:1967:13: warning: 'pagemap_scan_backout_range' defined but not used [-Wunused-function]
    1967 | static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pagemap_scan_backout_range +1967 fs/proc/task_mmu.c

  1966	
> 1967	static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
  1968					       unsigned long addr, unsigned long end)
  1969	{
  1970		struct page_region *cur_buf = &p->cur_buf;
  1971	
  1972		if (cur_buf->start != addr) {
  1973			cur_buf->end = addr;
  1974		} else {
  1975			cur_buf->start = cur_buf->end = 0;
  1976		}
  1977	
  1978		p->end_addr = 0;
  1979	}
  1980	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
