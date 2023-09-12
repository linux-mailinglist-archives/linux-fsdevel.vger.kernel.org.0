Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DBE79C78D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjILHDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjILHD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:03:29 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3EE78;
        Tue, 12 Sep 2023 00:03:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RlF0j62zWz4f3khV;
        Tue, 12 Sep 2023 15:03:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAXpLQ5DQBllyMAAQ--.20392S2;
        Tue, 12 Sep 2023 15:03:21 +0800 (CST)
Subject: Re: [PATCH 3/3] fuse: move fuse_put_request a bit to remove forward
 declaration
To:     Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
 <20230904143018.5709-4-shikemeng@huaweicloud.com>
 <633750a9-bd94-df4b-0112-1e1e15a6b47b@fastmail.fm>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c06dc4c9-8f77-fb1e-cdb4-5ec397d2a345@huaweicloud.com>
Date:   Tue, 12 Sep 2023 15:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <633750a9-bd94-df4b-0112-1e1e15a6b47b@fastmail.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXpLQ5DQBllyMAAQ--.20392S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfZFWkJFyDCr18uF15Jwb_yoW5Ary8pF
        1kJFWjyryUJF1xJry7JryUXFy5Jw48J3WUJryxXFyUJF43Ar1j9ryDXryvgr1UArWxXr47
        Jr1jqrnrur15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 9/8/2023 6:55 AM, Bernd Schubert wrote:
> 
> 
> On 9/4/23 16:30, Kemeng Shi wrote:
>> Move fuse_put_request before fuse_get_req to remove forward declaration.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   fs/fuse/dev.c | 42 ++++++++++++++++++++----------------------
>>   1 file changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 4f49b1946635..deda8b036de7 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -101,7 +101,26 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
>>       }
>>   }
>>   -static void fuse_put_request(struct fuse_req *req);
>> +static void fuse_put_request(struct fuse_req *req)
>> +{
>> +    struct fuse_conn *fc = req->fm->fc;
>> +
>> +    if (refcount_dec_and_test(&req->count)) {
>> +        if (test_bit(FR_BACKGROUND, &req->flags)) {
>> +            /*
>> +             * We get here in the unlikely case that a background
>> +             * request was allocated but not sent
>> +             */
>> +            spin_lock(&fc->bg_lock);
>> +            if (!fc->blocked)
>> +                wake_up(&fc->blocked_waitq);
>> +            spin_unlock(&fc->bg_lock);
>> +        }
>> +
>> +        fuse_drop_waiting(fc);
>> +        fuse_request_free(req);
>> +    }
>> +}
>>     static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
>>   {
>> @@ -154,27 +173,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
>>       return ERR_PTR(err);
>>   }
>>   -static void fuse_put_request(struct fuse_req *req)
>> -{
>> -    struct fuse_conn *fc = req->fm->fc;
>> -
>> -    if (refcount_dec_and_test(&req->count)) {
>> -        if (test_bit(FR_BACKGROUND, &req->flags)) {
>> -            /*
>> -             * We get here in the unlikely case that a background
>> -             * request was allocated but not sent
>> -             */
>> -            spin_lock(&fc->bg_lock);
>> -            if (!fc->blocked)
>> -                wake_up(&fc->blocked_waitq);
>> -            spin_unlock(&fc->bg_lock);
>> -        }
>> -
>> -        fuse_drop_waiting(fc);
>> -        fuse_request_free(req);
>> -    }
>> -}
>> -
>>   unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
>>   {
>>       unsigned nbytes = 0;
> 
> Hmm yeah, but it makes it harder to get history with git annotate/blame?
> 
Thanks for the feedbak, I will drop this and fix typo in patch 1 in next
version.
> Thanks,
> Bernd
> 

