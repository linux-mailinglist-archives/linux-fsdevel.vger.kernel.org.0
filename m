Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6E746E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGDKLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGDKK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:10:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E8FB;
        Tue,  4 Jul 2023 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688465458; x=1720001458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHrrDx8bBJniZaIxt6PHmJUfubmy9yZ+Qtw5G9Y30j0=;
  b=Sn07xz/PcmCkZydUjmXSXSQ0vB/bSjSCkeinM2i5SLGezfSmt/0oXpfK
   ibuMdpenbDdeVHVDS6i+ZpyOuwZSzzpVj0N84PiePvxcSZtYrrBi0o5zu
   Lc+TJBRTVL/t71K96Kf8gC6dtdHlKcMlmeWq4qnTESn7Zmf+glapghQTQ
   Fu4wS0LeGLi9SIvPJA7MA4cynJPLLOkyywaR2UAJi7rMU5Ts0FY/f+ndI
   0uccZauO3brPZsJa8WSEHzBwIkctDnIYC4gIUQCT7S0JILteMUb/JlQTw
   xsid5ozSPGT7cPZO/u9GSujvuUeexFY+i3uRGeMUaJHW/VGQWxmOU/zzw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426769639"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="426769639"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 03:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="965468731"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="965468731"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jul 2023 03:10:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGczh-000IBb-27;
        Tue, 04 Jul 2023 10:10:49 +0000
Date:   Tue, 4 Jul 2023 18:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v22 4/5] mm/pagemap: add documentation of PAGEMAP_SCAN
 IOCTL
Message-ID: <202307041808.b1eQDDHa-lkp@intel.com>
References: <20230628095426.1886064-5-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628095426.1886064-5-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master next-20230704]
[cannot apply to v6.4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230628-180259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230628095426.1886064-5-usama.anjum%40collabora.com
patch subject: [PATCH v22 4/5] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
reproduce: (https://download.01.org/0day-ci/archive/20230704/202307041808.b1eQDDHa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307041808.b1eQDDHa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/mm/pagemap.rst:238: WARNING: Unexpected indentation.
>> Documentation/admin-guide/mm/pagemap.rst:240: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +238 Documentation/admin-guide/mm/pagemap.rst

   233	
   234	The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get or optionally
   235	clear the info about page table entries. The following operations are supported
   236	in this IOCTL:
   237	- Get the information if the pages have been written to (``PAGE_IS_WRITTEN``),
 > 238	  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
   239	  (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
 > 240	- Find pages which have been written to and/or write protect the pages atomically
   241	  (atomic ``PM_SCAN_OP_GET + PM_SCAN_OP_WP``)
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
