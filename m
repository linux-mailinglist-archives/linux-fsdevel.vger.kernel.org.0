Return-Path: <linux-fsdevel+bounces-965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC97D42A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF608B20DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84F241E7;
	Mon, 23 Oct 2023 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="WQYsw/i9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ngQdFqQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70697224E7;
	Mon, 23 Oct 2023 22:24:32 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63627BC;
	Mon, 23 Oct 2023 15:24:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0E2035C038B;
	Mon, 23 Oct 2023 18:24:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Oct 2023 18:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698099868; x=1698186268; bh=DQ1oEKixkzeNQdS8WT8YM8d2fPyTvXJ7mH7
	o5ICCQX8=; b=WQYsw/i93/NXdnTcDjqLcXE/CwRWdo6Erxs82JyFuS3qBV27yb5
	evLbD6PRVhjROmAXc5wPwVttUQOVMlDpr8S4oyvC/jlclLt/5UYz1rDNG3EpfrJw
	sBC1Eu1kIJvIpmxwtCGd+K1CwyzKz5098UPtxpCgtdhD4TvjozoregDwnhDo5KbV
	FBsD7V6Q4IAvu4jZc0B/nIBni0DjIIw6siCW3yPDRDlhs3fGS4u6lpTH5kLi5QHC
	Oa36iyfDrYlCLUKiV5nOtC238vM5CHD8Wqo9vsXRM7AwhGru2CcOqdsZvkIX0XSa
	/Ow32rdaOmylMU5dwUsj+ZDLM9qHx5ghwbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698099868; x=1698186268; bh=DQ1oEKixkzeNQdS8WT8YM8d2fPyTvXJ7mH7
	o5ICCQX8=; b=ngQdFqQ601DzjSAFMnRWltajrABxEepDBmnnnhz5x30qUxKa6mv
	NS4hbZ5ZvdicPtj8Jp1n/UuEbAno2QnlZgEyN/UoJdPUlNloZ9Ce3DUOzrQv/4ge
	bt700eHhsWIfYVBfLdBIG9OwapIX8rEWJ826peIdwQv6V8cYEA6YzLgxmbE88jcE
	aDmq9xbaz/96mf5YxhzQSO5CtZc78v+n+DDIaNMI77JkYF+QCs4JSI/IJEdl0qz8
	42wSbBDUrGsPolA2mBe+f11xtWJ7dsOffM4liUR+Q11Vwrp1nop3z9JBVHhzIcwg
	c9sMlY/wgpxzdDJnyPpQr+1kTfIMm5GUMSg==
X-ME-Sender: <xms:m_I2ZTVvV1qZ9JT94oXBGxmthgfsObXB6ip831Mh-nrqsVFlNFOMOQ>
    <xme:m_I2ZbkT9sc4YvFAnaIwVsbnOtT2aRLBivsWqLLVoES8XtMOVnt_Uowae-rDc3cQC
    y4dm8IcSIqi>
X-ME-Received: <xmr:m_I2Zfbzas2074WCiVerKVo2MNRomkOnNjrtf7DRJGV8MYCiBIim06wbSlCyurWarwwwRhizebuU7q2BTmejhfKIyEwQcVQzv93_JR6lhdbU1zL2JOay0Hw5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeejgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:m_I2ZeVPZA1DKX8-xEcPNt_fXtazuUUS43meXL6yTy_RGDyt7K5OWA>
    <xmx:m_I2ZdmG3UxKWXfHSf_g-ptlht22TaW7z4Duao_0X98TN4b97HEj6A>
    <xmx:m_I2Zbf8a8DTfivJBgDS4hA3bSYPfOFOeqF88ZPEY6qDWH6ZKEFfJQ>
    <xmx:nPI2ZTX-3_OteRk3xjybXInDoUMx6j4szWTQSNRP9OsfbRJo4NiaUQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 18:24:22 -0400 (EDT)
Message-ID: <c1f0f6c1-4795-9861-5f53-0fb3e4d3aa18@themaw.net>
Date: Tue, 24 Oct 2023 06:24:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: autofs: add autofs_parse_fd()
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 Bill O'Donnell <bodonnel@redhat.com>, Christian Brauner <brauner@kernel.org>
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
 <432f1c1c-2f77-4b1b-b3f8-28330fd6bac3@kadam.mountain>
 <f1cddf6e-2103-4786-84ff-12c305341d7c@app.fastmail.com>
 <11ba98f2-2e59-d64b-1a1a-fd32fd8ba358@themaw.net>
 <9217caeb-0d7e-b101-33f0-859da175a6ef@themaw.net>
 <a5dfbe4f-b6fc-e282-2a3c-3e487493336c@themaw.net>
 <CADYN=9JS5QO5pmcFPJXY2TJB7TKg30k867SJ9BwPcgY-Wvm61A@mail.gmail.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
In-Reply-To: <CADYN=9JS5QO5pmcFPJXY2TJB7TKg30k867SJ9BwPcgY-Wvm61A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/23 21:57, Anders Roxell wrote:
> On Mon, 23 Oct 2023 at 09:35, Ian Kent <raven@themaw.net> wrote:
>> On 23/10/23 08:48, Ian Kent wrote:
>>> On 20/10/23 21:09, Ian Kent wrote:
>>>> On 20/10/23 19:23, Arnd Bergmann wrote:
>>>>> On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
>>>>>> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
>>>>>>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>>>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit
>>>>>>>>> rootfs we call
>>>>>>>>> it as compat mode boot testing. Recently it started to failed to
>>>>>>>>> get login
>>>>>>>>> prompt.
>>>>>>>>>
>>>>>>>>> We have not seen any kernel crash logs.
>>>>>>>>>
>>>>>>>>> Anders, bisection is pointing to first bad commit,
>>>>>>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>>>>>>
>>>>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>>>>>>> I tried to find something in that commit that would be different
>>>>>>>> in compat mode, but don't see anything at all -- this appears
>>>>>>>> to be just a simple refactoring of the code, unlike the commits
>>>>>>>> that immediately follow it and that do change the mount
>>>>>>>> interface.
>>>>>>>>
>>>>>>>> Unfortunately this makes it impossible to just revert the commit
>>>>>>>> on top of linux-next. Can you double-check your bisection by
>>>>>>>> testing 546694b8f658 and the commit before it again?
>>>>>>> I tried these two patches again:
>>>>>>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
>>>>>>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
>>>>>>>
>>>>>> One difference that I notice between those two patches is that we no
>>>>>> long call autofs_prepare_pipe().  We just call autofs_check_pipe().
>>>>> Indeed, so some of the f_flags end up being different. I assumed
>>>>> this was done intentionally, but it might be worth checking if
>>>>> the patch below makes any difference when the flags get put
>>>>> back the way they were. This is probably not the correct fix, but
>>>>> may help figure out what is going on. It should apply to anything
>>>>> from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
>>>>> linux-next:
>>>>>
>>>>> --- a/fs/autofs/inode.c
>>>>> +++ b/fs/autofs/inode.c
>>>>> @@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block
>>>>> *s, struct fs_context *fc)
>>>>>           pr_debug("pipe fd = %d, pgrp = %u\n",
>>>>>                    sbi->pipefd, pid_nr(sbi->oz_pgrp));
>>>>>    +        /* We want a packet pipe */
>>>>> +        sbi->pipe->f_flags |= O_DIRECT;
>>>>> +        /* We don't expect -EAGAIN */
>>>>> +        sbi->pipe->f_flags &= ~O_NONBLOCK;
>>>>> +
>>>>
>>>> That makes sense, we do want a packet pipe and that does also mean
>>>>
>>>> we don't want a non-blocking pipe, it will be interesting to see
>>>>
>>>> if that makes a difference. It's been a long time since Linus
>>>>
>>>> implemented that packet pipe and I can't remember now what the
>>>>
>>>> case was that lead to it.
>>> After thinking about this over the weekend I'm pretty sure my mistake
>>>
>>> is dropping the call to autofs_prepare_pipe() without adding the tail
>>>
>>> end of it into autofs_parse_fd().
>>>
>>>
>>> To explain a bit of history which I'll include in the fix description.
>>>
>>> During autofs v5 development I decided to stay with the existing usage
>>>
>>> instead of changing to a packed structure for autofs <=> user space
>>>
>>> communications which turned out to be a mistake on my part.
>>>
>>>
>>> Problems arose and they were fixed by allowing for the 64 bit to 32 bit
>>>
>>> size difference in the automount(8) code.
>>>
>>>
>>> Along the way systemd started to use autofs and eventually encountered
>>>
>>> this problem too. systemd refused to compensate for the length difference
>>>
>>> insisting it be fixed in the kernel. Fortunately Linus implemented the
>>>
>>> packetized pipe which resolved the problem in a straight forward and
>>>
>>> simple way.
>>>
>>>
>>> So I pretty sure that the cause of the problem is the inadvertent
>>> dropping
>>>
>>> of the flags setting in autofs_fill_super() that Arnd spotted although I
>>>
>>> don't think putting it in autofs_fill_super() is the right thing to do.
>>>
>>>
>>> I'll produce a patch today which includes most of this explanation for
>>>
>>> future travelers ...
>> So I have a patch.
>>
>>
>> I'm of two minds whether to try and use the instructions to reproduce this
>>
>> or not because of experiences I have had with other similar testing
>> automation
>>
>> systems that claim to provide a reproducer and end up a huge waste of
>> time and
>>
>> are significantly frustrating.
>>
>>
>> Can someone please perform a test for me once I provide the patch?
> Just tested it, and it passed our tests. Added a tested by flag in your patch.
>
> Thanks for the prompt fix.

That's great to hear Anders, thanks for doing the testing, ;)


Ian


