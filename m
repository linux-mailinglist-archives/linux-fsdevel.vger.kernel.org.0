Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7BB728A44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbjFHVbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFHVbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:31:34 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D730CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 14:31:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 15C4332004CE;
        Thu,  8 Jun 2023 17:31:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 08 Jun 2023 17:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686259890; x=1686346290; bh=HZB6vXAy27kfDuA46dmNu3kCkW1aO+HBkg3
        FJaY1AgM=; b=q5cVJwLZWIzv+Zo17C3Ju6t2vWpqYary8wS37XPzTM/iT+XcOty
        PdBoGb8Nd+TyO3gq+wEEcFI8qzgY6DiwJ/wQlgr38YdaEub0hofQP+bfjEc+nu99
        /RzPEuCdUE05EgFZodIstcvGUiERxvEGxgWgIP4JNa2YQ3xFMxQ0nS4U7QFXDx8N
        dDeAMJAfeKEVY5Tzc90mlWtWGM66Ii+551Ce/xTsFf1y+TFP/luL8j28NDf1G0cg
        KXeqbfH6S1A3J1CV1rh9OeQOidK7jWz8GeP/CpEgTaYZiqrT+M/Syxcoey97Sd4C
        mjBATsvnolDmSV8eChzGis7s846soKPyTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686259890; x=1686346290; bh=HZB6vXAy27kfDuA46dmNu3kCkW1aO+HBkg3
        FJaY1AgM=; b=R1Xo/WwN1GLwQf5fVcMsmkbGJGSCEYDhy+PNFrSwzSjsbI6FCYS
        dC4EQl0MixAk2kEBoz3v5B0B929fj/InZjab+bIlmZe40YJJ8xr5iokLJkgTb7o4
        28YzqKSEOysr6Z+4rI1Lteu2IEh9V5HJstcVe+1+6xqTCTYK/E//k36AGiKcJuA6
        3LiXHBQrNT2opTYmfXz3GQPnx/KxO4ShY397mXIdJKFsYhj54gngPE7g0I8xkUZe
        OrlZrveBspp9k5I03uCytSz0mHlWDkQ2UYRTUB6pIpq8kFUWHWcM3/Gu0JcrnsX5
        /Y+WZ3XUDKYS2DDSYD8crCe2zZUfzh8QVSw==
X-ME-Sender: <xms:skiCZPh4eiRJYOY9lMYd1cYrXTGoxKAIzKgq_ERVm6rtNpLJKzB14g>
    <xme:skiCZMBtam0EV67870wsu8eVb43hd0tJ6ASV4_9c8r2cwHhdQgIqv23-u-DUgXzqh
    IuBRv2BirZdy4-T>
X-ME-Received: <xmr:skiCZPGSS9nxc8z2NKphzkEvd8yfas8QR_zMMpLKqMzPkUoSwD3HGcp_Swtr6tfdrRFIbhqeBoP6jNx3ezt0a7mRuHl_pT6zPwBQdWATrNRyArKykmm_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefg
    vdefgfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:skiCZMSCQSQsX4vXOS2dwOmkoN3N3qRgfK9qySTiecTbGAARctF5nQ>
    <xmx:skiCZMyJVAzbANh3GwAFjbLJW4l3K-ojQppnFE-na-34DYYEs36lKA>
    <xmx:skiCZC6QwqTaSRD7hXD_GDXs3_DlkPsRfJky7opXYTHvBC5zOE8UGg>
    <xmx:skiCZI-N72JYrPPVqRNe1uLsQOeEmkX86wCPBuwHSpDW6YqaF73eiw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 17:31:29 -0400 (EDT)
Message-ID: <2ac5a016-505c-125a-a431-8d7547347a65@fastmail.fm>
Date:   Thu, 8 Jun 2023 23:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 00/13] fuse uring communication
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
 <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
 <02f19f49-47f8-b1c5-224d-d7233b62bf32@fastmail.fm>
 <CAOQ4uxiDLV2y_HeUy1M-WWrNGdjn-drUxcoNczJBYRKOLXkkUQ@mail.gmail.com>
 <CAJfpegtL3NXPNgK1kuJR8kLu3WkVC_ErBPRfToLEiA_0=w3=hA@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtL3NXPNgK1kuJR8kLu3WkVC_ErBPRfToLEiA_0=w3=hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/7/23 16:20, Miklos Szeredi wrote:
> On Thu, 23 Mar 2023 at 12:55, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Thu, Mar 23, 2023 at 1:18 PM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
> 
>>> there were several zufs threads, but I don't remember discussions about
>>> cache line - maybe I had missed it. I can try to read through the old
>>> threads, in case you don't have it.
>>
>> Miklos talked about it somewhere...
> 
> It was a private exchange between Amir and me:
> 
>      On Tue, 25 Feb 2020 at 20:33, Miklos Szeredi <miklos@szeredi.hu> wrote
>      > On Tue, Feb 25, 2020 at 6:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>      [...]
>      > > BTW, out of curiosity, what was the purpose of the example of
>      > > "use shared memory instead of threads"?
>      >
>      > In the threaded case there's a shared piece of memory in the kernel
>      > (mm->cpu_bitmap) that is updated on each context switch (i.e. each
>      > time a request is processed by one of the server threads).  If this is
>      > a big NUMA system then cacheline pingpong on this bitmap can be a real
>      > performance hit.
>      >
>      > Using shared memory means that the address space is not shared, hence
>      > each server "thread" will have a separate "mm" structure, hence no
>      > cacheline pingpong.
>      >
>      > It would be nice if the underlying problem with shared address space
>      > could be solved in a scalable way instead of having to resort to this
>      > hack, but it's not a trivial thing to do.  If you look at the
>      > scheduler code, there's already a workaround for this issue in the
>      > kernel threads case, but that doesn't work for user threads.

Ah, thank you! I can quote this mail here then for the next version.

Thanks,
Bernd

PS: I get currently distracted by other work, I hope I can get back to 
fuse by tomorrow.
