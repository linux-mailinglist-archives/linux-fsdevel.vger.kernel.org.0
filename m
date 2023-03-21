Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146966C2ACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCUGya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 02:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUGy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:54:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D324BED;
        Mon, 20 Mar 2023 23:54:27 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pgj4r57s6z9vSk;
        Tue, 21 Mar 2023 14:54:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 14:54:25 +0800
Message-ID: <31dca81f-9ed9-e82e-b304-15e23a412dc7@huawei.com>
Date:   Tue, 21 Mar 2023 14:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3] mm: memory-failure: Move memory failure sysctls to its
 own file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20230320074010.50875-1-wangkefeng.wang@huawei.com>
 <ZBie370lvwNbKZLH@bombadil.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZBie370lvwNbKZLH@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/21 1:58, Luis Chamberlain wrote:
> On Mon, Mar 20, 2023 at 03:40:10PM +0800, Kefeng Wang wrote:
>> The sysctl_memory_failure_early_kill and memory_failure_recovery
>> are only used in memory-failure.c, move them to its own file.
>>
>> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Thanks, queued up onto sysctl-next.
> 
Thanks.

> If you have time, feel free to help move each of the rest of kernel/sysctl.c
> vm_table to be split into their own respective files as you did with the last
> one.

I could let some freshman to do this jobs :)

> 
>    Luis

