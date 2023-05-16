Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A337044B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjEPFad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEPFac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 01:30:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A63588;
        Mon, 15 May 2023 22:30:28 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL4TV43NBzqSJN;
        Tue, 16 May 2023 13:26:06 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 13:30:25 +0800
Message-ID: <9e19c7a6-58fe-0238-49a5-574f92dd64d9@huawei.com>
Date:   Tue, 16 May 2023 13:30:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 04/12] mm: page_alloc: collect mem statistic into
 show_mem.c
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20230508071200.123962-5-wangkefeng.wang@huawei.com>
 <202305110807.YVsoVagW-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202305110807.YVsoVagW-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/11 8:04, kernel test robot wrote:
> Hi Kefeng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-page_alloc-move-mirrored_kernelcore-into-mm_init-c/20230508-145724
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230508071200.123962-5-wangkefeng.wang%40huawei.com
> patch subject: [PATCH 04/12] mm: page_alloc: collect mem statistic into show_mem.c
> config: loongarch-randconfig-s051-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110807.YVsoVagW-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-39-gce1a6720-dirty
>          # https://github.com/intel-lab-lkp/linux/commit/be69df472e4d9a6b09a17b854d3aeb9722fc2675
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Kefeng-Wang/mm-page_alloc-move-mirrored_kernelcore-into-mm_init-c/20230508-145724
>          git checkout be69df472e4d9a6b09a17b854d3aeb9722fc2675
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305110807.YVsoVagW-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     mm/show_mem.c:336:17: sparse:     expected void *ptr
>     mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     mm/show_mem.c:336:17: sparse:     expected void *ptr
>     mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     mm/show_mem.c:336:17: sparse:     expected void *ptr
>     mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     mm/show_mem.c:336:17: sparse:     expected void *ptr
>     mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
> 
> vim +336 mm/show_mem.c
> 

Thanks, I won't make any change about __show_free_areas（） function,
and it better not to fix it, at least not in this patch, the patch is 
only to move some functions. The sparse warning is caused by
K(this_cpu_read(zone->per_cpu_pageset->count)), maybe change it to
__this_cpu_read()?




> 
