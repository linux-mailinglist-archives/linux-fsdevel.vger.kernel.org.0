Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305123BA13D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGBNcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 09:32:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6037 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGBNcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:32:00 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GGbQB3yHBzXngB;
        Fri,  2 Jul 2021 21:24:02 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 2 Jul 2021 21:29:24 +0800
Subject: Re: [mainline] [arm64] Internal error: Oops -
 percpu_counter_add_batch
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
CC:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, <lkft-triage@lists.linaro.org>,
        <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
 <CA+G9fYszTVESKbiORBj=bvZX3qco474yYhWDV3ccveScqt41YA@mail.gmail.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <1e6fd4f1-dfab-6bf5-e5ea-e4a51f1006f0@huawei.com>
Date:   Fri, 2 Jul 2021 21:29:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CA+G9fYszTVESKbiORBj=bvZX3qco474yYhWDV3ccveScqt41YA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/2 20:38, Naresh Kamboju wrote:
> On Fri, 2 Jul 2021 at 13:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> Results from Linaro’s test farm.
>> Regression found on arm64 on Linux mainline tree.
> 
> Regression found on arm64, arm and i386 on Linux mainline tree.
> But x86_64 tests PASS.
> 
>>
>> The following kernel crash was noticed while running LTP fs_fill test case on
>> arm64 devices Linus ' mainline tree (this is not yet tagged / released).
>>
>> This regression  / crash is easy to reproduce.
>>
>> fs_fill.c:53: TINFO: Unlinking mntpoint/thread6/file2
>> fs_fill.c:87: TPASS: Got 6 ENOSPC runtime 3847ms
>> [ 1140.055715] Unable to handle kernel paging request at virtual
>> address ffff76a8a6b59000
> 
> ref;
> https://lore.kernel.org/regressions/CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com/T/#u
> 
> - Naresh
> .
> 

Thanks for the report, I'm not test this patch on arm64 and powerpc,
and sorry about not catching this problem, I will fix it soon.

Yi.
