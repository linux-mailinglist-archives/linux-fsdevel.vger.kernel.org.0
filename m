Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B976BBEEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 22:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjCOVV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjCOVVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8835A02A4;
        Wed, 15 Mar 2023 14:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FFFE61E6E;
        Wed, 15 Mar 2023 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03EC433EF;
        Wed, 15 Mar 2023 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678915283;
        bh=+r8g2IkyoB0Jg/yBPsVxCgq59FdXhHEpS5HuzNqPCyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxwGNMYE7cqR7tg6g9uZLgugiWhhI3rx1IScWtPGrA94pW48dn3fbWSYnpkZXlKHT
         7q/vSCMOKSp1VEgDsDdX/fnWT4NulUHIrVegBWARuhsI6mXLfAfNc3s6ATcj7HK8uE
         eIwOHmxKyWaOfFtj6/MLpbubf6PKWyOg9gqZS37Dgfp+WrT/qkPja/ESy3uIDZySiE
         W3kjtl+B1bJFGc6Km6jINYlh9ypJZaoKEYDMeHWP8FE+XzGU0LaBpbQH78gvIxMHoD
         swQYoXCu/SwUiAVLnqHn2ss5Ds7/EqHwmBSlKPlOrGyoOvwty3gMILnzZ/kE8IQsHL
         aTDWJTUK73OAw==
Date:   Wed, 15 Mar 2023 14:21:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Message-ID: <20230315212122.GH11376@frogsfrogsfrogs>
References: <20230315084938.2544737-5-david@fromorbit.com>
 <202303160421.bnmiVRCM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303160421.bnmiVRCM-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:14:04AM +0800, kernel test robot wrote:
> Hi Dave,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.3-rc2 next-20230315]
> [cannot apply to dennis-percpu/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
> patch link:    https://lore.kernel.org/r/20230315084938.2544737-5-david%40fromorbit.com
> patch subject: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
> config: riscv-randconfig-r042-20230313 (https://download.01.org/0day-ci/archive/20230316/202303160421.bnmiVRCM-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
>         git checkout 8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/xfs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303160421.bnmiVRCM-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> fs/xfs/xfs_super.c:1079:9: error: call to undeclared function 'percpu_counter_sum_all'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                   percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
>                   ^
>    fs/xfs/xfs_super.c:1079:9: note: did you mean 'percpu_counter_sum'?
>    include/linux/percpu_counter.h:193:19: note: 'percpu_counter_sum' declared here
>    static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
>                      ^
>    1 error generated.
> 
> 
> vim +/percpu_counter_sum_all +1079 fs/xfs/xfs_super.c
> 
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1070  
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1071  static void
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1072  xfs_destroy_percpu_counters(
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1073  	struct xfs_mount	*mp)
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1074  {
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1075  	percpu_counter_destroy(&mp->m_icount);
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1076  	percpu_counter_destroy(&mp->m_ifree);
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1077  	percpu_counter_destroy(&mp->m_fdblocks);
> 75c8c50fa16a23 Dave Chinner    2021-08-18  1078  	ASSERT(xfs_is_shutdown(mp) ||
> c35278f526edf1 Ye Bin          2023-03-14 @1079  	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);

Ah, yes, ChatGPT-4 hired someone via Mechanical Turk to log in to my
kernel.org account, answer the CAPTCHA, and push Ye's patch into
for-next.

(No it didn't.  Is your bot merging random patches from the XFS list and
whining when the result doesn't build?  WTH is going on here??)

--D

> 8757c38f2cf6e5 Ian Kent        2019-11-04  1080  	percpu_counter_destroy(&mp->m_delalloc_blks);
> 2229276c528326 Darrick J. Wong 2022-04-12  1081  	percpu_counter_destroy(&mp->m_frextents);
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1082  }
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1083  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
