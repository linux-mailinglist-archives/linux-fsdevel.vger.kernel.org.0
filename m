Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE502720D1A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjFCCFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCCFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:05:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1CCE50;
        Fri,  2 Jun 2023 19:05:47 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QY36X47MyzLqBs;
        Sat,  3 Jun 2023 10:02:44 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 10:05:44 +0800
Message-ID: <d9be3fbf-023c-ac55-5097-ea3f43a946b4@huawei.com>
Date:   Sat, 3 Jun 2023 10:05:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] Monthly ext4 report (May 2023)
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     syzbot <syzbot+list5ea887c46d22b2acf805@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>,
        yangerkun <yangerkun@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <000000000000834af205fce87c00@google.com>
 <df5e7e7d-875c-8e5d-1423-82ec58299b1b@huawei.com>
 <20230602210639.GA1154817@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230602210639.GA1154817@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/3 5:06, Theodore Ts'o wrote:
> On Thu, Jun 01, 2023 at 10:08:53AM +0800, Baokun Li wrote:
>> Patch "[PATCH v2] ext4: fix race condition between buffer write and
>> page_mkwrite​"
>> in maillist fixes issues <1>,<4>,<5>.
>>
>> Patch set "[PATCH v4 00/12] ext4: fix WARNING in
>> ext4_da_update_reserve_space"
>> in maillist fixes issues <3>.
> Thanks for noting that the fixes are applicable to the above reports.
> I've adjusted the commit descrptions to include the necessary
> Reported-by: lines, and they are in the ext4 dev tree.
>
> Cheers,
>
> 						- Ted
>
Thank you very much for your Applied!

There are many sources of syzkaller issues, and the patches I send out
to fix syzkaller issues add Reported-by to all but the ones that fix issues
reported by our internal syzbot.
However, there may be multiple syzbot reports for the same issue.
So I sorry for not adding the "Reported-by:" for the corresponding issue
above.

Please feel free to give me your feedback if the patches have any problems.
Thanks! 😀
-- 
With Best Regards,
Baokun Li
.
