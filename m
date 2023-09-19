Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269FC7A6485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjISNM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISNMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:12:25 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574EF0;
        Tue, 19 Sep 2023 06:12:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C9C45C01BE;
        Tue, 19 Sep 2023 09:12:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 Sep 2023 09:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695129136; x=1695215536; bh=35U7SZxly5E4C5II0R3QwFIGHLkcF+Joifa
        Lm/DjmW8=; b=SZuY9XIYk8UoYI0cncKefuLo+3a8kidBwLfYvWl/HMWy4sDKpey
        5lybXHs4E+8uqsMuhnLl53Ms7goP5REEXf7GB3jlkqf8mWqkiDdhMnRELphtCf/E
        y8VCX4qmyfdn7jynjeh9/E9wZ6/wdiodDiguGzIWupbXsyQg38yPic+DD+VqFzcS
        bVOEQ8sY54KmuMJKnpl+QKGpYDXvA+vraZf42r9DlljLSav05OO/s9VOzDLsNyxQ
        wM4TWSwUx5d8CpIIUIlVnP577X9wcPhzGBhu+CYLKS+4BgUeGZDRC5J2WIOsvdOJ
        B4AWJd0MNH/CRZjR1FMptpEoi8j0x2yefxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695129136; x=
        1695215536; bh=35U7SZxly5E4C5II0R3QwFIGHLkcF+JoifaLm/DjmW8=; b=h
        leu/2n2IqBV76jXcXUaryUgHgVvO2eQIsDZmcMckNMClWVc+rhh4Frle33aRBbkW
        9dOrGPNkT0almLn2hpK3SJljCulNBKP1biwByfGoWT6sRpmiupocQfVLmF5YprFm
        yybIQaUimxhWJXfxy0nbIw3+6tgDzz8vhYZ20bb9ZPRD2+QoyrqXS9cNDHZF8Xi6
        4GB0uIe3EppIoBnqWbM/dSNJO3dr4bCKvkIB0RURW+MU71HQXm1dJwl3NVVJsJty
        UnM3+Bo4FWfrIpENHxqFGLZ6CINqSWMhqltm/2YGCDwn889yn78eCbVSKZJbdCmu
        mZUojfE0by3yTgcQf20jA==
X-ME-Sender: <xms:MJ4JZYJQgV4QQTYxak_epWfKOKwKblnygXCXIWHtApxUFofYKu-89Q>
    <xme:MJ4JZYIvMqc8Yo5MU8KnKfw8eIF3k1gL3EFNpTIT3tsMsLpMwvc7eemNK2kiHm6bH
    W1RdKnv8JmWBerK>
X-ME-Received: <xmr:MJ4JZYteRcaRSZsCHc9IgLH42dUhMuomtwp9hkJiWXftE0YQjzAvyjq-Xrwsfm1dP7WAfuz4VEnoV6LlFppNmml3DjVM1MzAGMK8WrmkNP9iN0uAGwac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefgleefffejffeugeeivedvleevffeihfeuleev
    leeutdefieeftddttdeghfelgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:MJ4JZVaPgbV5OEXezqOc7hscMxEQ5BS6nbURXVjIAaWlqp9Qm4cKLA>
    <xmx:MJ4JZfYPfaLLMswEdVloUctbwQyxQddHRJTp8SkZw0_PRH-kECtdYQ>
    <xmx:MJ4JZRBsRRe23KF462il6y78m9hO5zllA8TTwzeMLscRaTW6MT0O_g>
    <xmx:MJ4JZenlYXTfTMg1TTDRiPVMIujiifw4YdtWlwIUbSgOHKKyhdUiGg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 09:12:15 -0400 (EDT)
Message-ID: <73e673d6-ecb8-dec9-bdc0-6dde9c4e76cb@fastmail.fm>
Date:   Tue, 19 Sep 2023 15:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fuse: remove unneeded lock which protecting update of
 congestion_threshold
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914154553.71939-1-shikemeng@huaweicloud.com>
 <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
 <177d891e-9258-68bb-72aa-4d4126403b7e@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <177d891e-9258-68bb-72aa-4d4126403b7e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/19/23 08:11, Kemeng Shi wrote:
> 
> 
> on 9/16/2023 7:06 PM, Bernd Schubert wrote:
>>
>>
>> On 9/14/23 17:45, Kemeng Shi wrote:
>>> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
>>> congestion_threshold is used and lock in
>>> fuse_conn_congestion_threshold_write is not needed anymore.
>>> 1. Access to supe_block is removed along with removing of bdi congestion.
>>> Then down_read(&fc->killsb) which protecting access to super_block is no
>>> needed.
>>> 2. Compare num_background and congestion_threshold without holding
>>> bg_lock. Then there is no need to hold bg_lock to update
>>> congestion_threshold.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>    fs/fuse/control.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
>>> index 247ef4f76761..c5d7bf80efed 100644
>>> --- a/fs/fuse/control.c
>>> +++ b/fs/fuse/control.c
>>> @@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>>>        if (!fc)
>>>            goto out;
>>>    -    down_read(&fc->killsb);
>>> -    spin_lock(&fc->bg_lock);
>>>        fc->congestion_threshold = val;
>>> -    spin_unlock(&fc->bg_lock);
>>> -    up_read(&fc->killsb);
>>>        fuse_conn_put(fc);
>>>    out:
>>>        return ret;
>>
>> Yeah, I don't see readers holding any of these locks.
>> I just wonder if it wouldn't be better to use WRITE_ONCE to ensure a single atomic operation to store the value.
> Sure, WRITE_ONCE looks better. I wonder if we should use READ_ONCE from reader.
> Would like to get any advice. Thanks!

I'm not entirely sure either, but I _think_ the compiler is free to 
store a 32 bit value  with multiple operations (like 2 x 16 bit). In 
that case a competing reading thread might read garbage...
Although I don't see this documented here
https://www.kernel.org/doc/Documentation/memory-barriers.txt
Though documented there is that the compile is free to optimize out the 
storage at all, see
"(*) Similarly, the compiler is within its rights to omit a store entirely"


Regarding READ_ONCE, I don't have a strong opinion, if the compiler 
makes some optimizations and the value would be wrong for a few cycles, 
would that matter for that variable? Unless the compiler would be really 
creative and the variable would get never updated... For sure READ_ONCE 
would be safer, but I don't know if it is needed
SSee section
"The compiler is within its rights to omit a load entirely if it know"
in the document above.

Thanks,
Bernd




