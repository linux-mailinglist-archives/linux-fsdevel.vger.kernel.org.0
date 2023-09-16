Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B17A2D48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 04:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjIPCEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjIPCE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:04:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003761BF8;
        Fri, 15 Sep 2023 19:04:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9CF963200033;
        Fri, 15 Sep 2023 22:04:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Sep 2023 22:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694829855; x=1694916255; bh=8Kg+lAI8pFsQQI2etrCoUrb1+gWu1sUllPz
        gKR5k09o=; b=SuVc/0ts6Ul7xJOs8036PRSlF82N+bplhuR1e35KxF/9IvnU10i
        rNbRjInhcSxhse74iqxyKotCnyKhQmUbV5stu8N9mjck5s9HmZk2fQCYymQag5Uc
        mzYBtkyixLoHuIrQp/Swd6IBsaiLqp5AELLr9UsTlWQWir+rxcukiXJZYv/WNOxs
        07zv1B9w32U8LzQRa5itjEewK5NqhlnLQztdzOJ30qfTDlvI6W51MsZy+OXl0+MA
        0knZZbpw/NsqJQFs0llORBjY6PNKDq20kpBG4bC/k7vgFSxIJGe0jjhc5bkyUbek
        zZU1Fqn0+qsx7x8wRBjxNhyU+nIRr8X+wJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694829855; x=1694916255; bh=8Kg+lAI8pFsQQI2etrCoUrb1+gWu1sUllPz
        gKR5k09o=; b=K7L56ZfVvUxGWwLnFpGaiKV4bRo6KV83F4YxPeOjc7uLqOG8AZy
        iTkCcucZKC/LAhHAAOUJGPRfxxkuVw0vUBAL1+po6cMNvDbfMqZBB/h17CZOUzE1
        kIZxWi21MbQmiDJ6DTnBPp97lkwgIORCMLWkZ18ziiO8OphS7zqW5rxIdK83kbtb
        ti9w9L8pAQHnFYf2wxUFV2MykZDw6xLygboYJ4KI28iquz1hhDivVIKKWLQ6+Cw9
        LgZwFEBVFCoq0zs3wXhln3Q6gzL2lB82V13ha32btWrrxh5Taag0efnW6ReQZxI+
        Ohi9naGLBYibHrZMnTpY05BLU70tQ6KJd2w==
X-ME-Sender: <xms:Hg0FZeD15PdFU6jZUAb64n0RLChzVUkL6c9DQg4OeQXtjbHmB2uc3w>
    <xme:Hg0FZYgM2nOjavACr5yR1iqTwIA16bpA438rgFewUzpEqHSqxpeUrTP-u2y2Eax75
    _tcS0V9fvDW>
X-ME-Received: <xmr:Hg0FZRne2a9cqXCQ3Y5Kg5o5a867LSie6Hlwm7F7yKAnSOlowyJzdFZId4IEVWcZuduPQE97RWivoRUR8soqpibEEnrjIGrVGL-7qy5_kvyo6ahFpTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:Hg0FZcxyPU-BgGu2b-e90DL-FuBHyWkGTQ8E1bqUd8ppQHoDup_S1A>
    <xmx:Hg0FZTTtoOoIoZWu8158PfSbUduu64nEjpjw5svznNa4yFa1T7FH9A>
    <xmx:Hg0FZXZTeMA_xWiMJXgMnP6jva6at-74JQh1i6tBm7x2LueJngHzVw>
    <xmx:Hw0FZY_eBDvcjra1qZY6avpk-8X-ru799Sj0pywfLBO3Pa4p-d3hdg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Sep 2023 22:04:09 -0400 (EDT)
Message-ID: <cecbccf7-5591-7eac-f3b7-d8fef3b6ad5f@themaw.net>
Date:   Sat, 16 Sep 2023 10:04:07 +0800
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

Yes, it's not obvious, I'll try and explain it more clearly.


I did some work to enable systemd to use the original fsinfo() call

and the notifications system David had written.


My use case was perhaps unrealistic but I have seen real world reports

with similar symptoms and autofs usage can behave like this usage at

times as well so it's not entirely manufactured. The use case is basically

when there are a large number of mounts occurring for a sustained amount

of time.


Anyway, systemd processes get notified when there is mount activity and

it then reads the mount table to update it state. I observed there are

usually 3 separate systemd processes monitoring mount table changes and,

under the above load, they use around 80-85% of a CPU each.


Thing is systemd is actually pretty good at processing notifications so

when there is sustained mount activity and the fsinfo() call was used the

load changes from processing the table to processing notifications. The

load goes down to a bit over 40% for each process.


But if you can batch those notifications, like introduce a high water

mark (yes I know this is not at all simple and I'm by no means suggesting

this is all that needs to be done), to get a bunch of these notifications

at once the throughput increases quite a bit. In my initial testing adding

a delay of 10 or 20 milliseconds before fetching the queue of notifications

and processing them saw a reduction of CPU usage to around 8% per process.


What I'm saying is I've found that system calls to get the information

directly isn't all that's needed to improve the scalability.


Ian

