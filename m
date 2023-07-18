Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D5757166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGRBhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 21:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:37:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A91A2;
        Mon, 17 Jul 2023 18:37:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R4hQj3KbLz4f3s5x;
        Tue, 18 Jul 2023 09:37:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LPd7LVkcIDjOA--.31826S3;
        Tue, 18 Jul 2023 09:37:35 +0800 (CST)
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Donald Buczek <buczek@molgen.mpg.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-3-sergei.shtepa@veeam.com>
 <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
 <90f79cf3-86a2-02c0-1887-d3490f9848bb@veeam.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d929eaa7-61d6-c4c4-aabc-0124c3693e10@huaweicloud.com>
Date:   Tue, 18 Jul 2023 09:37:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <90f79cf3-86a2-02c0-1887-d3490f9848bb@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LPd7LVkcIDjOA--.31826S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfJFy3JF1ftryfCFWruFg_yoW8GF4Upr
        Z3Kw45Jr4DCF1Sk3ZrJa1xu345J3srCry0vr1UG3yrA3sxGr909rySk3ykua4j9rykArZ8
        Zr4Fq3W8J3Z3AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/07/17 22:39, Sergei Shtepa 写道:
> 
> 
> On 7/11/23 04:02, Yu Kuai wrote:
>> bdev_disk_changed() is not handled, where delete_partition() and
>> add_partition() will be called, this means blkfilter for partiton will
>> be removed after partition rescan. Am I missing something?
> 
> Yes, when the bdev_disk_changed() is called, all disk block devices
> are deleted and new ones are re-created. Therefore, the information
> about the attached filters will be lost. This is equivalent to
> removing the disk and adding it back.
> 
> For the blksnap module, partition rescan will mean the loss of the
> change trackers data. If a snapshot was created, then such
> a partition rescan will cause the snapshot to be corrupted.
> 

I haven't review blksnap code yet, but this sounds like a problem.

possible solutions I have in mind:

1. Store blkfilter for each partition from bdev_disk_changed() before
delete_partition(), and add blkfilter back after add_partition().

2. Store blkfilter from gendisk as a xarray, and protect it by
'open_mutex' like 'part_tbl', block_device can keep the pointer to
reference blkfilter so that performance from fast path is ok, and the
lifetime of blkfiter can be managed separately.

> There was an idea to do filtering at the disk level,
> but I abandoned it.
> .
> 
I think it's better to do filtering at the partition level as well.

Thanks,
Kuai

