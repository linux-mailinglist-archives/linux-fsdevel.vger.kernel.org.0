Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7406B7B51DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjJBL6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjJBL6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:58:02 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7AEC;
        Mon,  2 Oct 2023 04:57:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="122471633"
X-IronPort-AV: E=Sophos;i="6.03,194,1694703600"; 
   d="scan'208";a="122471633"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 20:57:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9CC12D424E;
        Mon,  2 Oct 2023 20:57:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C4BC1D88A1;
        Mon,  2 Oct 2023 20:57:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AC45E36B8;
        Mon,  2 Oct 2023 20:57:52 +0900 (JST)
Received: from [10.193.128.127] (unknown [10.193.128.127])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 0499B1A0006;
        Mon,  2 Oct 2023 19:57:50 +0800 (CST)
Message-ID: <83d057e5-ef5f-4b27-95c8-d7bf4902fa55@fujitsu.com>
Date:   Mon, 2 Oct 2023 19:57:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, djwong@kernel.org, mcgrof@kernel.org,
        chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
 <202310010955.feI4HCwZ-lkp@intel.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <202310010955.feI4HCwZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27910.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27910.006
X-TMASE-Result: 10--24.331000-10.000000
X-TMASE-MatchedRID: RsPxVIkBekyPvrMjLFD6eKzGfgakLdjaSIfLQ6k7huHHr4PSWTXSLMWl
        hj9iHeVpndDwnQ2pwPpOg1kzy/iWtmrs+r6+nS7O46cXaPycFZuR1LeQ+VpnJZskuXz9Gadkbyq
        cWT4FZRfg7nVyl/GdEkusQE+B0D7cVGsQtO2yiZ48+i/lP6Xo8coioCrSMgeKTmg3Ze6YIL1/o7
        4UQlCmAM8oZdJyMU3z59JoNf8FRHif9F+VqQj2HI61Z+HJnvsOmSLeIgEDej+u9yzHHu0ZiRVx7
        xedu5l6XICzc9HFHLudqC2fLtk9xL9ZdlL8eona0CzDI0K7cAwCwwGD+AF1Ue52OdZcC6tPvECL
        uM+h4RB+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/10/1 9:43, kernel test robot 写道:
> Hi Shiyang,
> 
> kernel test robot noticed the following build errors:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230928-183310/Shiyang-Ruan/xfs-fix-the-calculation-for-end-and-length/20230629-161913
> base:   the 2th patch of https://lore.kernel.org/r/20230629081651.253626-3-ruansy.fnst%40fujitsu.com
> patch link:    https://lore.kernel.org/r/20230928103227.250550-1-ruansy.fnst%40fujitsu.com
> patch subject: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231001/202310010955.feI4HCwZ-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310010955.feI4HCwZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310010955.feI4HCwZ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> fs/xfs/xfs_notify_failure.c:127:27: error: use of undeclared identifier 'FREEZE_HOLDER_KERNEL'
>             error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
>                                      ^
>     fs/xfs/xfs_notify_failure.c:143:26: error: use of undeclared identifier 'FREEZE_HOLDER_KERNEL'
>                     error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
>                                            ^
>>> fs/xfs/xfs_notify_failure.c:153:17: error: use of undeclared identifier 'FREEZE_HOLDER_USERSPACE'
>             thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>                            ^
>     3 errors generated.
> 

The two enums has been introduced since 880b9577855e ("fs: distinguish 
between user initiated freeze and kernel initiated freeze"), v6.6-rc1. 
I also compiled my patches based on v6.6-rc1 with your config file, it 
passed with no error.

So, which kernel version were you testing?


--
Thanks,
Ruan.

> 
> vim +/FREEZE_HOLDER_KERNEL +127 fs/xfs/xfs_notify_failure.c
> 
>     119	
>     120	static int
>     121	xfs_dax_notify_failure_freeze(
>     122		struct xfs_mount	*mp)
>     123	{
>     124		struct super_block	*sb = mp->m_super;
>     125		int			error;
>     126	
>   > 127		error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
>     128		if (error)
>     129			xfs_emerg(mp, "already frozen by kernel, err=%d", error);
>     130	
>     131		return error;
>     132	}
>     133	
>     134	static void
>     135	xfs_dax_notify_failure_thaw(
>     136		struct xfs_mount	*mp,
>     137		bool			kernel_frozen)
>     138	{
>     139		struct super_block	*sb = mp->m_super;
>     140		int			error;
>     141	
>     142		if (kernel_frozen) {
>     143			error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
>     144			if (error)
>     145				xfs_emerg(mp, "still frozen after notify failure, err=%d",
>     146					error);
>     147		}
>     148	
>     149		/*
>     150		 * Also thaw userspace call anyway because the device is about to be
>     151		 * removed immediately.
>     152		 */
>   > 153		thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>     154	}
>     155	
> 
