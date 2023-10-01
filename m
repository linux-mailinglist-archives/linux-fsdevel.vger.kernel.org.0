Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC47B44E5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 03:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjJABoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjJABoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 21:44:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FCD3;
        Sat, 30 Sep 2023 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696124656; x=1727660656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rufpvWuPso4MC3Gr1PDC2UlAGt/OUfuMBlXcYFtgG94=;
  b=WJSnLtJNF3HZBoxwJUxKjHcg/+oP7H3QmtiyeDz0cnA4iv0Pzt37GZEK
   r20aOZehGW+jw6nKm37R4SroKb2m+HIwtqcaAJNoS/iUo6rG027h/n+NU
   HRObmaQb325qCzkUfJm5QdLrYNj5Ld54hqn3LCzsc7B9t1sb/bRUkfqEp
   iW4DnySI+t5IbzLBv8I0Tj2yw5n3b0rQud+M80HClF7y3AXcNQPd+GXa8
   qqBRXcednC6kyrqpIL43aHkIglR07iN0GdvOXtvyFAMfrJeTTkiIHt4TH
   7KsIP20ea4xhVI/AOVbYYmmwVqx+AX0FLuqJS3gXfNVUmG7DfZkJNSOGD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="362749427"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="362749427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 18:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="726926433"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="726926433"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Sep 2023 18:44:12 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmlVA-0004eZ-2u;
        Sun, 01 Oct 2023 01:44:09 +0000
Date:   Sun, 1 Oct 2023 09:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, djwong@kernel.org, mcgrof@kernel.org,
        chandanbabu@kernel.org
Subject: Re: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
Message-ID: <202310010955.feI4HCwZ-lkp@intel.com>
References: <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

kernel test robot noticed the following build errors:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230928-183310/Shiyang-Ruan/xfs-fix-the-calculation-for-end-and-length/20230629-161913
base:   the 2th patch of https://lore.kernel.org/r/20230629081651.253626-3-ruansy.fnst%40fujitsu.com
patch link:    https://lore.kernel.org/r/20230928103227.250550-1-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231001/202310010955.feI4HCwZ-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310010955.feI4HCwZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310010955.feI4HCwZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_notify_failure.c:127:27: error: use of undeclared identifier 'FREEZE_HOLDER_KERNEL'
           error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
                                    ^
   fs/xfs/xfs_notify_failure.c:143:26: error: use of undeclared identifier 'FREEZE_HOLDER_KERNEL'
                   error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
                                          ^
>> fs/xfs/xfs_notify_failure.c:153:17: error: use of undeclared identifier 'FREEZE_HOLDER_USERSPACE'
           thaw_super(sb, FREEZE_HOLDER_USERSPACE);
                          ^
   3 errors generated.


vim +/FREEZE_HOLDER_KERNEL +127 fs/xfs/xfs_notify_failure.c

   119	
   120	static int
   121	xfs_dax_notify_failure_freeze(
   122		struct xfs_mount	*mp)
   123	{
   124		struct super_block	*sb = mp->m_super;
   125		int			error;
   126	
 > 127		error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
   128		if (error)
   129			xfs_emerg(mp, "already frozen by kernel, err=%d", error);
   130	
   131		return error;
   132	}
   133	
   134	static void
   135	xfs_dax_notify_failure_thaw(
   136		struct xfs_mount	*mp,
   137		bool			kernel_frozen)
   138	{
   139		struct super_block	*sb = mp->m_super;
   140		int			error;
   141	
   142		if (kernel_frozen) {
   143			error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
   144			if (error)
   145				xfs_emerg(mp, "still frozen after notify failure, err=%d",
   146					error);
   147		}
   148	
   149		/*
   150		 * Also thaw userspace call anyway because the device is about to be
   151		 * removed immediately.
   152		 */
 > 153		thaw_super(sb, FREEZE_HOLDER_USERSPACE);
   154	}
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
