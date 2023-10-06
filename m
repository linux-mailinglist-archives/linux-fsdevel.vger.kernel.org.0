Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354107BBD80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJFRPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:15:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790E4C6;
        Fri,  6 Oct 2023 10:15:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D8B9F5C01D8;
        Fri,  6 Oct 2023 13:15:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 06 Oct 2023 13:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696612512; x=1696698912; bh=SEZk9JQJsMY88IuXY/N5m7tU0TlzvX7hRUx
        wDrAVido=; b=XaFkaHhKOXylhrP/XHG/ShLqwrosJDQJc16Ue8Z1p9Wr8ojFsS8
        9aE45xpaxKkyYhkwl3iky/Uh8a9n940HuM0efTypYhuxvtxmKGYwtbZ8m/kZtXvV
        uQ74EYVKXOjsm5iqc+9dpVvkjvifvS5foCiLw41FyT6pFkg05RjBA/TnubwkDMp0
        ys9Cx825befSbVavMwx5MMn3AffVrVaRUKXUQp/M5VtnJTKI6hXfAn+yFlatgM3a
        3V2PU4lhBqTtfWOWX943hga4YTI01dE2nNC/Em2Z6ORuiwiqCu7V11MSLD1bf1nX
        VqezyKtTy3J3TCDAOyk4V6bQLB1VMm1rplw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696612512; x=
        1696698912; bh=SEZk9JQJsMY88IuXY/N5m7tU0TlzvX7hRUxwDrAVido=; b=X
        ArobKkaAQTMk4UUdjeQ0VU0yPQXfjxIogKI0Z+/xwzd07HP7EdzX0HjXcMtJmmxk
        8DykLeqBdDj5bBbbMjWQDIrcYiUYZwyy1PHst/FsHQDdwbaet3+mx/5APt6/Ipwq
        f79A33wbki+RQWn8jo9MqG5jA9Q6exm/+K/ZQzSzTXi2eflk4RTOnkEGZsgRWUiN
        fwjxLTCPSCcz4ffFIoRcrV2SU57uyp7EfZmeJSJM2SkKM91w57iypE//1NRvzlvN
        poYOZAH0r3N+sYqI5KSUVLKZaYPYz0NpzlCVu5RMv09ETjXY5UtMDJsSnFdxsKDd
        D6YNDnC11n1vPhL6STT0w==
X-ME-Sender: <xms:oEAgZdOYPpxAfHRcM2xrtGasq9Fr1LBAv90kUxWH_tqNUAheO7XbXw>
    <xme:oEAgZf-_bugBfrfGw7IdAvdcNR-5ylj9Vi92p4ah5noHZOAxLZPI_J8oJl9BqVZXU
    pQ45xDJI4vh0xJW>
X-ME-Received: <xmr:oEAgZcQxG5AKycEtc2U1FQKRpLw96-ZuX1_aS1a82UyoSs_D0AH65wBzUpRu6bDyZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeefkeehueduleeggffgjeejvdeltddvfedvffdu
    tddtkeffgfelffdthfdugefhkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:oEAgZZu03ediQg4OXx8n3FJps0JqnhFzCW3TKKb4NFdxBLvu_zS6vw>
    <xmx:oEAgZVfs0A5MVjq2l6QupK1E7JC9WrDJVxeyXVakw5ihRf8bUPN76w>
    <xmx:oEAgZV1nZdZ4iG6rpPeC8_veMs9ymxvG2oP4q92VsUtWVqvDmQt3BA>
    <xmx:oEAgZWqNFppq9wXzGduATlRw5Cae1XRCFdPdq4RI2qXd5LkNwyuczw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Oct 2023 13:15:11 -0400 (EDT)
Message-ID: <edbf55d3-58a7-4a59-afea-757c6f1c1e69@fastmail.fm>
Date:   Fri, 6 Oct 2023 19:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: remove unneeded lock which protecting update of
 congestion_threshold
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914154553.71939-1-shikemeng@huaweicloud.com>
 <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
 <177d891e-9258-68bb-72aa-4d4126403b7e@huaweicloud.com>
 <73e673d6-ecb8-dec9-bdc0-6dde9c4e76cb@fastmail.fm>
 <a66f94b8-4330-4e0d-589c-a031a5b3802c@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <a66f94b8-4330-4e0d-589c-a031a5b3802c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/27/23 05:04, Kemeng Shi wrote:
> 
> 
> on 9/19/2023 9:12 PM, Bernd Schubert wrote:
>>
>>
>> On 9/19/23 08:11, Kemeng Shi wrote:
>>>
>>>
>>> on 9/16/2023 7:06 PM, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 9/14/23 17:45, Kemeng Shi wrote:
>>>>> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
>>>>> congestion_threshold is used and lock in
>>>>> fuse_conn_congestion_threshold_write is not needed anymore.
>>>>> 1. Access to supe_block is removed along with removing of bdi congestion.
>>>>> Then down_read(&fc->killsb) which protecting access to super_block is no
>>>>> needed.
>>>>> 2. Compare num_background and congestion_threshold without holding
>>>>> bg_lock. Then there is no need to hold bg_lock to update
>>>>> congestion_threshold.
>>>>>
>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> ---
>>>>>     fs/fuse/control.c | 4 ----
>>>>>     1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
>>>>> index 247ef4f76761..c5d7bf80efed 100644
>>>>> --- a/fs/fuse/control.c
>>>>> +++ b/fs/fuse/control.c
>>>>> @@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>>>>>         if (!fc)
>>>>>             goto out;
>>>>>     -    down_read(&fc->killsb);
>>>>> -    spin_lock(&fc->bg_lock);
>>>>>         fc->congestion_threshold = val;
>>>>> -    spin_unlock(&fc->bg_lock);
>>>>> -    up_read(&fc->killsb);
>>>>>         fuse_conn_put(fc);
>>>>>     out:
>>>>>         return ret;
>>>>
>>>> Yeah, I don't see readers holding any of these locks.
>>>> I just wonder if it wouldn't be better to use WRITE_ONCE to ensure a single atomic operation to store the value.
>>> Sure, WRITE_ONCE looks better. I wonder if we should use READ_ONCE from reader.
>>> Would like to get any advice. Thanks!
>>
> Sorry for the dealy - it toke me some time to go through the barrier documents.
>> I'm not entirely sure either, but I _think_ the compiler is free to store a 32 bit value  with multiple operations (like 2 x 16 bit). In that case a competing reading thread might read garbage...
>> Although I don't see this documented here
>> https://www.kernel.org/doc/Documentation/memory-barriers.txt
> I found this is documented in section
> "(*) For aligned memory locations whose size allows them to be accessed..."
> Then WRITE_ONCE is absolutely needed now as you menthioned before.
>> Though documented there is that the compile is free to optimize out the storage at all, see
>> "(*) Similarly, the compiler is within its rights to omit a store entirely"
>>
>>
>> Regarding READ_ONCE, I don't have a strong opinion, if the compiler makes some optimizations and the value would be wrong for a few cycles, would that matter for that variable? Unless the compiler would be really creative and the variable would get never updated... For sure READ_ONCE would be safer, but I don't know if it is needed
>> SSee section
>> "The compiler is within its rights to omit a load entirely if it know"
>> in the document above.
> I go through all examples of optimizations in document and congestion_threshold
> has no same trouble descripted in document.
> For specifc case you menthioned that "The compiler is within its rights to omit
> a load entirely if it know". The compiler will keep the first load and only omit
> successive loads from same variable in loop. As there is no repeat loading from
> congestion_threshold in loop, congestion_threshold is out of this trouble.
> Anyway, congestion_threshold is more like a hint and the worst case is that it is
> stale for a few cycles. I prefer to keep reading congestion_threshold without
> READ_ONCE and will do it in next version if it's fine to you. Thanks!

Sounds good to me, thanks for reading the document carefully!


Bernd
