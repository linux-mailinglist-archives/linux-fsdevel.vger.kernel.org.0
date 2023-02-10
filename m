Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C466691BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBJJmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBJJma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:42:30 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578A2DE4A;
        Fri, 10 Feb 2023 01:42:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C6EEE3200077;
        Fri, 10 Feb 2023 04:42:24 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Fri, 10 Feb 2023 04:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676022144; x=
        1676108544; bh=csaH5JqKW2ltQ68oF2bGv2SKpBtE8d9nzCpkPamxqns=; b=N
        j48S9SJK4v9ijnY4RyecfXH8GwfC69HIDCSDIEBsgE4vh8ZO0hvHqr7l4EF3F4BP
        y4SBZ4R4IoaLw8c3Aoc4xJODXesbUpwlwHEqXdyHl/QdFCMMo5IV1JXDje5DjeCj
        BQLTqy63tau/JVJG5qgJeILlG05ufXusAfAfGtjOiMloQ4y4OZITY90UsafwOWEL
        zbsK1QSRTF4JpO9gYmsPaIeAp/LDSmxPvARh1BTJlKksHcljxzKUivu89Hp9vu3X
        O3KXvckf41Ut1rK8tm6DsV3WV/2VFOUwNffWkHehmdIktv96PZPsCsjhF+YuGncO
        8bobGh8G8eVFwFy1F1LAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676022144; x=
        1676108544; bh=csaH5JqKW2ltQ68oF2bGv2SKpBtE8d9nzCpkPamxqns=; b=H
        EmizJ/DjNAJv6esw9RjOwrqu1EsAXFODal+zizsIJPQwWGoGRQn23j6ZVyXep0hn
        ksrf4UxzNwMgjTZn7hJf6PaGyAw8la7ueb3v1qpn9t859NwYUSv3OB+d9/XVGHCG
        4nuN18AR3Zg+7bsKCqqNfKuCyrFaTU4aAMGZIj8STackkdJrcXCm0rFt2BF8S1t1
        XtWfH9FIrLqANZU4V5C3Asxw3K9FrxQqQ+hHNNnKahBhQkh5qmXlNy4shXN9CxaL
        tKFrp3Cw34tz5mPCcZwXMBtOCjmdFEUiKwRZ5gqfTlQdw3XJsUZvY+XTrnYpGjDh
        K84hCMQAO2VoUe9m/hmKg==
X-ME-Sender: <xms:gBHmY0oblqeEz92CNx6nYYqH8YqIEBDa8otFHqLWHpaoJ6FS9kjknA>
    <xme:gBHmY6o2nNN9ATKXLAQ3UmiTBjVZhuyRo0gQQjz-yywQBNS9TrDzNHSgj3LMRf-wg
    jyORhvp6n4DS-sU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfp
    ihhkohhlrghushcutfgrthhhfdcuoehnihhkohhlrghushesrhgrthhhrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejffdttedtieekheehhfduhfevvddugfelveehjefhteevlefh
    feefheehhffgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehnihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:gBHmY5NauDoe0skY_IrmoKeNBshxCrYQr8MYZciukA1Jkgpg1tBJkQ>
    <xmx:gBHmY74ORuBlLSLvbU_SIm7IsP7DJ4S-iCF08wVWdzUJji4j7ksnkQ>
    <xmx:gBHmYz6_fgaQTnxx6cvHJ_IOLt8maqBjZm1Q0fpNngBbPVRLw8qTqQ>
    <xmx:gBHmYwydKxxH5ZXqcI4kl4tWFERRuycflqWmYdaKzFHD4o2OBVDCCw>
Feedback-ID: i53a843ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 343C6272007A; Fri, 10 Feb 2023 04:42:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
In-Reply-To: <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com>
References: <20221122021536.1629178-1-drosen@google.com>
 <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
 <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm>
 <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
 <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com>
Date:   Fri, 10 Feb 2023 09:41:30 +0000
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Bernd Schubert" <bernd.schubert@fastmail.fm>,
        "Daniel Rosenberg" <drosen@google.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        "Vivek Goyal" <vgoyal@redhat.com>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Feb 2023, at 09:38, Miklos Szeredi wrote:
> On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wrote:
>
>> > Thanks a lot Amir, I'm going to send out an invitation tomorrow. Ma=
ybe
>> > Nikolaus as libfuse maintainer could also attend?
>> >
>>
>> Since this summit is about kernel filesystem development, I am not su=
re
>> on-prem attendance will be the best option for Nikolaus as we do have
>> a quota for
>> on-prem attendees, but we should have an option for connecting specif=
ic
>> attendees remotely for specific sessions, so that could be great.
>
> Not sure.  I think including non-kernel people might be beneficial to
> the whole fs development community.  Not saying LSF is the best place,
> but it's certainly a possibility.
>
> Nikolaus, I don't even know where you're located.  Do you think it
> would make sense for you to attend?

Hi folks,

I'm located in London.=20

I've never been at LHS, so it's hard for me to tell if I'd be useful the=
re or not. If there's interest, then I would make an effort to attend.=20

Are we talking about the event in Vancouver on May 8th?

Best,
-Nikolaus
--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

