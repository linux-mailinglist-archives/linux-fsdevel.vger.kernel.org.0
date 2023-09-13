Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF4879F22A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjIMTfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjIMTfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DF891;
        Wed, 13 Sep 2023 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694633709; x=1726169709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKdDmwR0ImqwcCwZEvaS7Oi5BImbBc0gOTOmvoBXyPg=;
  b=OPyfkHEYEUeGhdNlbRgM63qM1r/alXclHMPSuc2w9ZwsxKGOrqJ54jXR
   dpx+Iz5H1TLjw0V+l7U0xCYtGYIW82t79Th1T1DYDb5HJgwirtpoKqRo7
   ZMDofrcY9PNYXJcllL9pdFkqvxeputxrHME+hyE62y2gF3aI2GLEljBN1
   CqaIR6e+2Uw9Hb2e6mhD0+NcEskKcGyTdZXGuKLudIq15mn4ARxJHU5m3
   AQxmP6XKCvSYT207bJIzB5LPa2OarYSHX0ZxtkL/aEWmAOCiUIzM4BlIu
   DOYXyZn9a7Ha2OirHJTUJOeS2d8qT/PokVPj1PGTsVauOU7S5ZWpXQe4Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="376102134"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="376102134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737650919"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="737650919"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2023 12:34:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgVdZ-0000Wr-1B;
        Wed, 13 Sep 2023 19:34:57 +0000
Date:   Thu, 14 Sep 2023 03:34:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Message-ID: <202309140322.cF62Kywb-lkp@intel.com>
References: <20230913173000.4016218-2-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913173000.4016218-2-souravpanda@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sourav,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourav-Panda/mm-report-per-page-metadata-information/20230914-013201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda%40google.com
patch subject: [PATCH v1 1/1] mm: report per-page metadata information
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230914/202309140322.cF62Kywb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140322.cF62Kywb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140322.cF62Kywb-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/mm_init.o: in function `free_area_init':
>> mm_init.c:(.init.text+0x842): undefined reference to `mod_node_early_perpage_metadata'
   ld: mm/page_alloc.o: in function `setup_per_cpu_pageset':
>> page_alloc.c:(.init.text+0x60): undefined reference to `writeout_early_perpage_metadata'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
