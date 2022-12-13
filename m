Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227964AD74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLMCJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLMCJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:09:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A7C5E;
        Mon, 12 Dec 2022 18:09:30 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWMNZ08MGzRpyr;
        Tue, 13 Dec 2022 10:08:30 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 10:09:28 +0800
Subject: Re: [PATCH] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
To:     Jens Axboe <axboe@kernel.dk>, <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <tytso@mit.edu>
References: <20221210101042.2012931-1-linmiaohe@huawei.com>
 <167087572893.15871.14396720847219305165.b4-ty@kernel.dk>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f9fb0a76-3182-f609-a281-2bf46c959bb4@huawei.com>
Date:   Tue, 13 Dec 2022 10:09:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <167087572893.15871.14396720847219305165.b4-ty@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/12/13 4:08, Jens Axboe wrote:
> 
> On Sat, 10 Dec 2022 18:10:42 +0800, Miaohe Lin wrote:
>> EXPIRE_DIRTY_ATIME is not used anymore. Remove it.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
>       commit: 23e188a16423a6e65290abf39dd427ff047e6843
> 
> Best regards,

Many thanks both for quick respond in such busy days. :)

Thanks,
Miaohe Lin


