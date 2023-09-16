Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591BF7A2D64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjIPCTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 22:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjIPCTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:19:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B531BF2;
        Fri, 15 Sep 2023 19:19:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 78D0132002FB;
        Fri, 15 Sep 2023 22:19:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Sep 2023 22:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694830752; x=1694917152; bh=dczvAIbYbztKI9psgMdrTQAOAqQnIvtCypR
        JKfR2cKQ=; b=CZEdpjTuZlQ0iPdoZFIPXx7Cl1P79HLCyQkGlqXSInAk2td5bk0
        viG/ZNH1onVP5rV5wuGtovHaEkZyhUvyndY0CbXBUxL0i8gDI4SWBqmWlgUHR/tv
        dxiNm1KrQoX32cScG1d44ssxTuL11xbCxuC3n8+O1DuzEoqFdqhk4BXE8EktP9Ve
        xMKb/hXnujcCkqBMKukW3k+CnHF14LsA4teZLsEJyZaHYUnsN1KYdDfSohyI85bu
        C9JtRU3NiTtwCMTi9uNIR5SObSrEK69cRTa7/4dbwbcjHnuhwnnP3B4QR5nQ5qUU
        QgVowKpmZsh4Nus1g/yUI+pEJHCudRD7Lnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694830752; x=1694917152; bh=dczvAIbYbztKI9psgMdrTQAOAqQnIvtCypR
        JKfR2cKQ=; b=a0J0xLTNceVYiEUX4d0ul+CYxgHpq5vjFRiN2wF2X9I6oS5Jxqr
        FyAm+lkrwbNm0ccm1XxuRagVLJ/MRAsKYpavBg1WP/AiPJWSFtxWTRVPIyY3+WrV
        ZQYlovfJOPRGDu9WkPUui9shKdUq2+6QLIcqzOQkFaW2WTtIRXPXsZv1XvzXxnEr
        6h2hM4eXpSKRJ+CtpMaNyY+/IBdWk4ULX5D1yB9QrBDhwjS5/2frV5f5isgFOJkS
        OoCIjAI/B4QYG+5FqrCELx25dL9L/lvM9zq/Gg1K+fjOOXqsOK/cEQ3I+JtOpIh5
        x+luKYhtCzMOAeYCh9RI/HRwtcxZ5luGyHA==
X-ME-Sender: <xms:oBAFZbW-uVubx3qTOXLOjdU8v5vgUvdfO5eiyE0yuddfyIVNHDdmJg>
    <xme:oBAFZTntPvyxOx-sqE5zM_yPLVEPjXNz0Har04g8qQpN_p1nS8M196J0ExUpGvfDv
    Z9clFM_Z4Gr>
X-ME-Received: <xmr:oBAFZXaP2AXcO25rsMbCAW02QZkHypWXmZipruFibu8Rs9nVowC2Dfsa3qKBl_69BpqixDZGD-rlen4PfyyCToUiIlNX-cxjCajZrJeyHhpK7761T5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:oBAFZWWFxOfIxI1hWXvxK47W7hBn7BZojSODYM7ctjJzgj_vePOMFg>
    <xmx:oBAFZVlO5Qlg_sNTkMPzdBA8DGn_8uOaXjusILeGgia6pnvAqFdRmQ>
    <xmx:oBAFZTfu-CPfjI2SSAdr0LiiyIqjkikUcDjgdzP0JILObRVRBB8QPA>
    <xmx:oBAFZWjJydA6INuWWB_fhoiJEpCWqekY7mGq4164RuAupPbOuPvcXA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Sep 2023 22:19:07 -0400 (EDT)
Message-ID: <9fd2f8da-17b0-e918-adef-4043678efaa2@themaw.net>
Date:   Sat, 16 Sep 2023 10:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] quering mount attributes
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <CAOQ4uxiuc0VNVaF98SE0axE3Mw6wMJJ1t36cmbcM5vwYLqtWSw@mail.gmail.com>
 <904a8d17-b6df-e294-fcf6-6f95459e1ffa@themaw.net>
 <CAOQ4uxgHxVqtvb51Z27Sgft-U=oYtXeiv+3HJbara4zdRC-FZg@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOQ4uxgHxVqtvb51Z27Sgft-U=oYtXeiv+3HJbara4zdRC-FZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/9/23 11:06, Amir Goldstein wrote:
> On Fri, Sep 15, 2023 at 4:20 AM Ian Kent <raven@themaw.net> wrote:
>> On 14/9/23 14:47, Amir Goldstein wrote:
>>> On Wed, Sep 13, 2023 at 6:22 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>>>> Implement the mount querying syscalls agreed on at LSF/MM 2023.  This is an
>>>> RFC with just x86_64 syscalls.
>>>>
>>>> Excepting notification this should allow full replacement for
>>>> parsing /proc/self/mountinfo.
>>> Since you mentioned notifications, I will add that the plan discussed
>>> in LFSMM was, once we have an API to query mount stats and children,
>>> implement fanotify events for:
>>> mount [mntuid] was un/mounted at [parent mntuid],[dirfid+name]
>>>
>>> As with other fanotify events, the self mntuid and dirfid+name
>>> information can be omitted and without it, multiple un/mount events
>>> from the same parent mntuid will be merged, allowing userspace
>>> to listmnt() periodically only mntuid whose child mounts have changed,
>>> with little risk of event queue overflow.
>>>
>>> The possible monitoring scopes would be the entire mount namespace
>>> of the monitoring program or watching a single mount for change in
>>> its children mounts. The latter is similar to inotify directory children watch,
>>> where the watches needs to be set recursively, with all the weight on
>>> userspace to avoid races.
>> It's been my belief that the existing notification mechanisms don't
>> quite fully satisfy the needs of users of these calls (aka. the need
>> I found when implementing David's original calls into systemd).
>>
>> Specifically the ability to process a batch of notifications at once.
>>
>> Admittedly the notifications mechanism that David originally implemented
>> didn't fully implement what I found I needed but it did provide for a
>> settable queue length and getting a batch of notifications at a time.
>>
>> Am I mistaken in my belief?
>>
> I am not sure I understand the question.
>
> fanotify has an event queue (16K events by default), but it can
> also use unlimited size.
> With a limited size queue, event queue overflow generates an
> overflow event.
>
> event listeners can read a batch of events, depending on
> the size of the buffer that they provide.

So it sounds like I can get a bunch of events at once with fanotify.

I'll have to look at the code again ...


Ian

>
> when multiple events with same information are queued,
> for example "something was un/mounted over parent mntuid 100"
> fanotify will merged those all those events in the queue and the
> event listeners will get only one such event in the batch.
>
>> Don't misunderstand me, it would be great for the existing notification
>> mechanisms to support these system calls, I just have a specific use case
>> in mind that I think is important, at least to me.
>>
> Please explain the use case and your belief about existing fanotify
> limitations. I did not understand it.
>
> Thanks,
> Amir.
