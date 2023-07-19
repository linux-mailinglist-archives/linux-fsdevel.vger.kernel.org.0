Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BFA7592F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGSK2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 06:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGSK1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:27:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6635A0;
        Wed, 19 Jul 2023 03:27:12 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5X571QjyzVjhv;
        Wed, 19 Jul 2023 18:25:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 18:26:38 +0800
Message-ID: <9093cbf3-a0be-b1e7-cc6d-0d47ab3035a5@huawei.com>
Date:   Wed, 19 Jul 2023 18:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 4/4] perf/core: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <selinux@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-5-wangkefeng.wang@huawei.com>
 <20230719092915.GA3529602@hirez.programming.kicks-ass.net>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230719092915.GA3529602@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/19 17:29, Peter Zijlstra wrote:
> On Wed, Jul 19, 2023 at 03:51:14PM +0800, Kefeng Wang wrote:
>> Use the helpers to simplify code, also kill unneeded goto cpy_name.
> 
> Grrr.. why am I only getting 4/4 ?
> 
> I'm going to write a bot that auto NAKs all partial series :/
Sorry, I should add all to cc list, here is all patches linke[1]

[1] 
https://lore.kernel.org/linux-mm/20230719075127.47736-1-wangkefeng.wang@huawei.com/ 


Thanks.
> 
