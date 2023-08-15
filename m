Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92577D4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjHOVE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbjHOVE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:04:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2DE10EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 14:04:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CCCDA5C01B2;
        Tue, 15 Aug 2023 17:04:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 15 Aug 2023 17:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692133458; x=1692219858; bh=kdLxaVtma3EJMj/sdY5UuI4IkE9NFT7sxPN
        PZmKJFrI=; b=rp+4t2i+xOPBrgjM8yZ838bfapQwxDnbJ9yhKGUcFx5xyJwAhGu
        XHKe4w58HgpwCWcOecC3c3UCZWk3JObvIUXn4k2CXYVE+YJ/HRwWD1l2iqvGPrTd
        234mj6ITe6aDQx3q3L/Zx+MvyBQHkfWsVDno8mVxqhGt74b1eJbPQWwCZqk7v/uZ
        96/HmcDAIctP+rMbku3sHMUTAfUnqf/8fXT3zXjuTCMinGcFP5/VEIjbT/Xj/G0+
        HrF5amMXntngbuZl9WnRkryfjhLYEFGYqpyiVJRbud/HOtDGRpt9QnfmI7FY5rI8
        TIY/E0eHU+TgW0aeTHwZ2yz20FF9Fe14MGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692133458; x=1692219858; bh=kdLxaVtma3EJMj/sdY5UuI4IkE9NFT7sxPN
        PZmKJFrI=; b=XsTU80gWITTnNRquFurhIDi5665xkVh+9c9EpCSOUsyO9fX6nVR
        UQ7868Z7bX0brzb8GTHv5mSpFNKefiW8F+ZnKi5ZnHcarU/LCFjQKX7wrfmHnAv8
        4MEUIIXPrN57ueppPMEuNzz1ZHiNv8wF2Tojzo2k43FgVZOyhK6g0rGaXcMBgU76
        YON+v5Wn+y4rGq52yreUYb4HNkSBEmbOu6OKNK+6pfnTTNZ/eAXJo6W0/8dJmNFz
        bTCwULhRyrZtQKpP5HfucCjfqw+T7Yxjx1qYHjoCHsyGaZ0+4OaMmUqM3zxouvYM
        eE9MvF2a7R7Ty/JW4iSU9nLfg6VutaL8wNg==
X-ME-Sender: <xms:UujbZISYhCzzOJW8-_9Vm6CFYA8b6hZy9y47cPdih_LXw469tKdqfA>
    <xme:UujbZFykIW9ALVtiZEv4w0ezYzwhMchKz7NzfBc-SUoezl6BbWZMnANtA9PIfFEk2
    x9Ud9ANDfsi_-t6>
X-ME-Received: <xmr:UujbZF37Lc_2ZLHfD3N1F-qEADqKOWNpp5Hxeafxbxqpql5Ng_h0RaY3kuUsK12QyTm_28sspGC0yteoAiVcV6nbCHcQzbZVLnWfISSlW0xUkSUa0ALHoXZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtjedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:UujbZMAACSu2HvurydL8Q_4rakTcEXfTRNah6Ye0_Q6dTEwwrtfX2Q>
    <xmx:UujbZBiWxdbMWGpeStTjhiL0XhAAfOZAyJ6ojW9tYmtZIuH454bg5g>
    <xmx:UujbZIoUAabVFwf3RGCRoj-Lu3Tc5Y6tGrHMHsLZbma2mtJwzZe9NQ>
    <xmx:UujbZPaV7LAwK1WJorS1KVTgOE_p-LEcujg5hYJ59tPxKcU3ROU8kg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Aug 2023 17:04:16 -0400 (EDT)
Message-ID: <1cb76336-ebd9-0099-5fc4-2340df4ac33d@fastmail.fm>
Date:   Tue, 15 Aug 2023 23:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [fuse-devel] [PATCH 3/6] [RFC] Allow atomic_open() on positive
 dentry
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20230811183752.2506418-1-bschubert@ddn.com>
 <20230811183752.2506418-4-bschubert@ddn.com>
 <CAJfpegtsCPZ_c2J7o08kgT8z9UNkTJ0BD5R1yT2_fT+ZPH+Q_w@mail.gmail.com>
 <9a8170ea-fc4d-f8f9-9726-8cc46f545e0d@ddn.com>
 <CAJfpegsP6AnwdzMc6o4dFeLKkE_yaxL=-ejD+S7tqvuLpXBaRA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsP6AnwdzMc6o4dFeLKkE_yaxL=-ejD+S7tqvuLpXBaRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/15/23 21:33, Miklos Szeredi via fuse-devel wrote:
> On Tue, 15 Aug 2023 at 11:56, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 8/15/23 10:03, Miklos Szeredi wrote:
>>> On Fri, 11 Aug 2023 at 20:38, Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> From: Miklos Szeredi <miklos@szeredi.hu>
>>>>
>>>> atomic_open() will do an open-by-name or create-and-open
>>>> depending on the flags.
>>>>
>>>> If file was created, then the old positive dentry is obviously
>>>> stale, so it will be invalidated and a new one will be allocated.
>>>>
>>>> If not created, then check whether it's the same inode (same as in
>>>> ->d_revalidate()) and if not, invalidate & allocate new dentry.
>>>>
>>>> Changes from Miklos initial patch (by Bernd):
>>>> - LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
>>>>     calls into the file system when revalidate by atomic open is
>>>>     supported - this is to avoid that ->d_revalidate() would skip
>>>>     revalidate and set DCACHE_ATOMIC_OPEN, although vfs
>>>>     does not supported it in the given code path (for example
>>>>     when LOOKUP_RCU is set)).
>>>
>>> I don't get it.   We don't get so far as to set DCACHE_ATOMIC_OPEN if
>>> LOOKUP_RCU is set.
>>
>>
>> See lookup_fast, there are two calls to d_revalidate() that have
>> LOOKUP_ATOMIC_REVALIDATE and one in RCU mode that does not.
>> With the new flag LOOKUP_ATOMIC_REVALIDATE we tell ->revalidate()
>> that we are in code path that supports revalidating atomically.
>>
>> Sure, ror RCU we can/should always return -ECHILD in fuse_dentry_revalidate when
>> LOOKUP_RCU is set.  But then it is also easy to miss that - at a minimum we
>> need to document that DCACHE_ATOMIC_OPEN must not be set in RCU mode.
> 
> I wouldn't say "must not".  Setting DCACHE_ATOMIC_OPEN would result in
> ATOMIC_OPEN being used instead of plain OPEN.  This may be less
> optimal in cases when the dentry didn't need to be revalidated, but
> AFAICS it wouldn't result in a bug.

In open_last_lookups there is

BUG_ON(nd->flags & LOOKUP_RCU)

(which is why I had noticed in the first place the issue in RCU mode). 
In principle we could change the code to give up RCU mode after 
DCACHE_ATOMIC_OPEN, but the vfs functions certainly wouldn't get
simpler with that

> BTW I don't see DCACHE_ATOMIC_OPEN being cleared in this patchset,
> which just shows that it's quite safe ;)

Oh right, it might go a code path later that would have an issue. 
Actually Dharmendras version had removed the flag in 
_fuse_atomic_open(), but I thought we wouldn't need to unset it and had 
removed that part. Also better shouldn't be part of fuse to remove the 
flag, but in the vfs - here in this patch, which introduces the flag.

> 
> I'm not at all sure that DCACHE_ATOMIC_OPEN is the best mechanism for
> this job.  Returning a specific value from ->d_revalidate might be
> better.

Also fine with me, although it probably would bring back the 'hack' in 
lookup_fast(), as the caller does not get the return code from 
d_revalidate . Or we we add it in.
Going to send an updated version in the morning.


Thanks,
Bernd
