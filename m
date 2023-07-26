Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94142763B17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGZPav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjGZPat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:30:49 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449401FFC;
        Wed, 26 Jul 2023 08:30:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 14BC63200344;
        Wed, 26 Jul 2023 11:30:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 26 Jul 2023 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690385446; x=1690471846; bh=+FXui71M4KLr0BGEwEGbDcZQqLzS0w/dnD5
        SDEjctV4=; b=shZkvMNkyJ1lFMNg0Or5U9Tf8NaZrEfAxjUz0SGr0yvn3EA/bPG
        7HNnk4WzV8iDu3Wu54e7GwjQn8UXhbJamL4Q04h1/Ao/HIvUoJgh9ANhReL4C6TV
        Hx8p1gB5RJ+ZWpy3jSDNGwlMrWB2qCNxqFOtw8qpisBDVXh/eMHC1RhKNqjx3jh5
        GtlJbAc/FVdEFZnp964SsAOrM9pGcxfAls3Tr6h4SAgG8kM5PPWVeiyf16JGkQgA
        h5tT/B0i5mt8xlawvCkAnOUYWH6F58A/i46oiDA8asJgISvivIzEflqpe7Ycf2q6
        4+ozJkkOVeBEL2Q9v7ZIqbT27FNCPt8CQTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1690385446; x=
        1690471846; bh=+FXui71M4KLr0BGEwEGbDcZQqLzS0w/dnD5SDEjctV4=; b=e
        v+eCn2VtqzzwPzl31zhpIuEXwAArXP7mI2XJsg/p6sU5R+L3RNJCPOfussVEwrm9
        iGXai+zhYfOMKor+ItuHEMlrNcjB0xikc5YsrFX85/SF8U3BLDavfGc10C2SpkUn
        JCBR2sg6wYc0PjqrVL8Ywy98whIt6j7VJmQoftB/Wc240FXxX/mtT7L+DNglazD4
        sSKmuw+WIslH6pMv2MiW/dkoBaB+vVWKM64xT/ZkIKTtbdE7xXB4HPdR3CPJpzYx
        bx1WyHIwaF0RLW5zlZGoKNsTHqh2z7q8++gk9ZwlteyKQoj3EPte3Rzno2Kk+Pha
        I/6KRgKH6CXmf8YHIAfbw==
X-ME-Sender: <xms:JjzBZEAqHLvQBWcVRfHg20D0TEAA0z-BNFgxsKHQvtYKKd-NWYuUYg>
    <xme:JjzBZGiZ6bMiAd2tolhqJaRCH6u6MBglAYfJu-9RxnwGm9Gwwy-2czq-A6X-PsZct
    u9_rj6OdfhRNafn>
X-ME-Received: <xmr:JjzBZHkZig3cGiB4ht3DG1tSwi-JtBubMRTaO7VoqSZZy6pOTtO3xuHUTNkPQkdvwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdef
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpedtudeuueevgeek
    feehieeukedvudelieevteevuedtueffhfeuteeivedvhfduvdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:JjzBZKz6HoWWxXnGlZdsRtWYdnpefHkQWv_f_GXM0yjTsLhxPUAbyA>
    <xmx:JjzBZJQHO_4PvSoiwyFIK4_9US4wcfHZ8_pDr6zyu4rTGuYgNMTFTA>
    <xmx:JjzBZFbORx0hcgjCiD741VMKu0_BKojaH-NDHYY6PW9HFIjR3OeuUQ>
    <xmx:JjzBZEfzfzDiEyviqm2jC-V6OzjtXSJgJAD2129FVxUo6zLpLj4nJw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 11:30:45 -0400 (EDT)
Message-ID: <4470a31c-802e-51e2-75b0-362c05fecfb8@fastmail.fm>
Date:   Wed, 26 Jul 2023 17:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
To:     Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
Content-Language: en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/26/23 17:26, Jaco Kroon wrote:
> Hi,
> 
> On 2023/07/26 15:53, Bernd Schubert wrote:
>>
>>
>> On 7/26/23 12:59, Jaco Kroon wrote:
>>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>>> ---
>>>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>>>   fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>>>   2 files changed, 40 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>>> --- a/fs/fuse/Kconfig
>>> +++ b/fs/fuse/Kconfig
>>> @@ -18,6 +18,22 @@ config FUSE_FS
>>>         If you want to develop a userspace FS, or if you want to use
>>>         a filesystem based on FUSE, answer Y or M.
>>>   +config FUSE_READDIR_ORDER
>>> +    int
>>> +    range 0 5
>>> +    default 5
>>> +    help
>>> +        readdir performance varies greatly depending on the size of 
>>> the read.
>>> +        Larger buffers results in larger reads, thus fewer reads and 
>>> higher
>>> +        performance in return.
>>> +
>>> +        You may want to reduce this value on seriously constrained 
>>> memory
>>> +        systems where 128KiB (assuming 4KiB pages) cache pages is 
>>> not ideal.
>>> +
>>> +        This value reprents the order of the number of pages to 
>>> allocate (ie,
>>> +        the shift value).  A value of 0 is thus 1 page (4KiB) where 
>>> 5 is 32
>>> +        pages (128KiB).
>>> +
>>
>> I like the idea of a larger readdir size, but shouldn't that be a 
>> server/daemon/library decision which size to use, instead of kernel 
>> compile time? So should be part of FUSE_INIT negotiation?
> 
> Yes sure, but there still needs to be a default.  And one page at a time 
> doesn't cut it.
> 
> -- snip --
> 
>>>   -    page = alloc_page(GFP_KERNEL);
>>> +    page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
>>
>> I guess that should become folio alloc(), one way or the other. Now I 
>> think order 0 was chosen before to avoid risk of allocation failure. I 
>> guess it might work to try a large size and to fall back to 0 when 
>> that failed. Or fail back to the slower vmalloc.
> 
> If this varies then a bunch of other code will become somewhat more 
> complex, especially if one alloc succeeds, and then a follow-up succeeds.

Yeah, the better choice is kvmalloc/kvfree which handles it internally.

> 
> I'm not familiar with the differences between the different mechanisms 
> available for allocation.
> 
> -- snip --
> 
>> Thanks,
> My pleasure,
> Jaco
