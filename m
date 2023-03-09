Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE16B1B12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 07:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCIGDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 01:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCIGDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:03:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D972B1D;
        Wed,  8 Mar 2023 22:03:42 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PXJSf2GNZzSkRQ;
        Thu,  9 Mar 2023 14:00:34 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 14:03:39 +0800
Message-ID: <49f2c8df-0578-b99e-8687-d77047bd5a33@huawei.com>
Date:   Thu, 9 Mar 2023 14:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: memory-failure: Move memory failure sysctls to its
 own file
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
References: <20230309045924.52395-1-wangkefeng.wang@huawei.com>
 <20230309051439.GA4018963@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230309051439.GA4018963@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/3/9 13:14, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Mar 09, 2023 at 12:59:24PM +0800, Kefeng Wang wrote:
>> The sysctl_memory_failure_early_kill and memory_failure_recovery
>> are only used in memory-failure.c, move them to its own file.
> 
> Thank you for the patch.
> 
> Could you explain the benefit to move them?
> We seem to have many other parameters in kernel/sysctl.c which are used
> only in single places, so why do we handle these two differently?
> 

Actually, all of them need to be moved into theirs own file as required
by proc sysctl maintainer, see [1]

> Thanks,
> Naoya Horiguchi

[1] https://lore.kernel.org/all/20211123202347.818157-1-mcgrof@kernel.org/
