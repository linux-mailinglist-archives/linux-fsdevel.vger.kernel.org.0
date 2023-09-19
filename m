Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C148E7A59CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 08:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjISGM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 02:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISGM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:12:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C76FB;
        Mon, 18 Sep 2023 23:12:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqWXZ15MZz4f3jXV;
        Tue, 19 Sep 2023 14:12:14 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBXXAGwOwllq4hUAw--.63932S2;
        Tue, 19 Sep 2023 14:12:18 +0800 (CST)
Subject: Re: [PATCH] fuse: remove unneeded lock which protecting update of
 congestion_threshold
To:     Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914154553.71939-1-shikemeng@huaweicloud.com>
 <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <177d891e-9258-68bb-72aa-4d4126403b7e@huaweicloud.com>
Date:   Tue, 19 Sep 2023 14:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXXAGwOwllq4hUAw--.63932S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5KF45uFy5urWxAry3CFg_yoW8WFWfpr
        WktryjkFZxXwn5Wr47JF4UX34rK397G3W5JrnYgF15Xay3Xw109a4avFW0gFWUAr4xXw1q
        qF4jgryfZFZYyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 9/16/2023 7:06 PM, Bernd Schubert wrote:
> 
> 
> On 9/14/23 17:45, Kemeng Shi wrote:
>> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
>> congestion_threshold is used and lock in
>> fuse_conn_congestion_threshold_write is not needed anymore.
>> 1. Access to supe_block is removed along with removing of bdi congestion.
>> Then down_read(&fc->killsb) which protecting access to super_block is no
>> needed.
>> 2. Compare num_background and congestion_threshold without holding
>> bg_lock. Then there is no need to hold bg_lock to update
>> congestion_threshold.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   fs/fuse/control.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
>> index 247ef4f76761..c5d7bf80efed 100644
>> --- a/fs/fuse/control.c
>> +++ b/fs/fuse/control.c
>> @@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>>       if (!fc)
>>           goto out;
>>   -    down_read(&fc->killsb);
>> -    spin_lock(&fc->bg_lock);
>>       fc->congestion_threshold = val;
>> -    spin_unlock(&fc->bg_lock);
>> -    up_read(&fc->killsb);
>>       fuse_conn_put(fc);
>>   out:
>>       return ret;
> 
> Yeah, I don't see readers holding any of these locks.
> I just wonder if it wouldn't be better to use WRITE_ONCE to ensure a single atomic operation to store the value.
Sure, WRITE_ONCE looks better. I wonder if we should use READ_ONCE from reader.
Would like to get any advice. Thanks!
> 
> 
> Thanks,
> Bernd
> 

