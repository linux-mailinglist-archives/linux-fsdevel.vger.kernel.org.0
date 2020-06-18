Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C91FDB6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgFRBLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:11:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728745AbgFRBLg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F108A16537DADB85284;
        Thu, 18 Jun 2020 09:11:32 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.138) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 18 Jun 2020
 09:11:26 +0800
Subject: Re: [PATCH v2 0/2] loop: replace kill_bdev with invalidate_bdev
To:     <hch@infradead.org>, <axboe@kernel.dk>, <bvanassche@acm.org>,
        <jaegeuk@kernel.org>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <20200530114032.125678-1-zhengbin13@huawei.com>
 <0857bafa-f7ba-dea9-3d5c-7889646b5a37@huawei.com>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <99403447-5460-c143-fd87-425b54d409ef@huawei.com>
Date:   Thu, 18 Jun 2020 09:11:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0857bafa-f7ba-dea9-3d5c-7889646b5a37@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.138]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping

On 2020/6/8 10:39, Zhengbin (OSKernel) wrote:
> ping
>
> On 2020/5/30 19:40, Zheng Bin wrote:
>> v1->v2: modify comment, and make function 'kill_bdev' static
>>
>> Zheng Bin (2):
>>    loop: replace kill_bdev with invalidate_bdev
>>    block: make function 'kill_bdev' static
>>
>>   drivers/block/loop.c | 8 ++++----
>>   fs/block_dev.c       | 5 ++---
>>   include/linux/fs.h   | 2 --
>>   3 files changed, 6 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.21.3
>>
>>
>> .
>>

