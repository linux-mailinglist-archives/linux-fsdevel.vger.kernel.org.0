Return-Path: <linux-fsdevel+bounces-904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872287D2B74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AEBB20DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1A101F3;
	Mon, 23 Oct 2023 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="TVTYvBMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvj+733t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FF1860
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 07:35:35 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD3C5;
	Mon, 23 Oct 2023 00:35:34 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id D14D83200973;
	Mon, 23 Oct 2023 03:35:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 03:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698046532; x=1698132932; bh=d9amFDYz1sl2Iw6yhNUKRAnYTQtpJelLSp1
	Dm00CDPs=; b=TVTYvBMlNM4+fgbnJ7BWdOJA4mRcfzAVuAe7ZNzCMUtj18rXjno
	EaawTlGh8yP95b0hOO6u7J/XkcuFnG7xdlu/EbXRbzsoj1myTl5qdoXCztmuiNuz
	eSW1dr+3kS9PaMsTrGqHh4C9QDSBssXLx+4josIghBoXMlQH2rXaaO5P6Y18QGyN
	SbZO5Ya0rvzuA/zq/PF1QC2m1HHGgIYU+3z9BWC4jwfI4m2ou+a0y09BTRlG7EDt
	+FhvKXT9w+wpGaDNCwcpcb1Jhz661AKDsXnOvjOlzjsv1MovuWQGktw23Ghfgytu
	X4QWvmBaPa/pkOSdm4m9hdvdqfkE8VlWotw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698046532; x=1698132932; bh=d9amFDYz1sl2Iw6yhNUKRAnYTQtpJelLSp1
	Dm00CDPs=; b=cvj+733ts4j523wzds2wIrWGXz43l1yy21zW3D6XXrDFFhWaI5h
	ckZ6SZkPetQuDQvs9ip/0zeM6McvjKL2entMt4RK4A/g611DxKeFINWrLJ8JVwLM
	k91ZrYCEQtNErofVqnDUG4Psydm8ekc+HmUNIfn5xvy08EuBW13NaK9V4ZSonsI5
	sBi1MrDD/ulxRY9uN+y9t9mKDxWNTClfPRyiKDspAdDFEw/7V4DLnTwBtLqa0Axz
	arzG9mtvAh45RKDHdLe/P86oKXkwE2KCpR9t5xboJVujCmHbA12GciRWkyKIdrEb
	Wb1I0ZewIibf8MI24mU54KpbwYzoq+vgG3Q==
X-ME-Sender: <xms:RCI2ZUpAE93LBFe_kECP3UN6XdJiGuaEjv1C0R3VobABSsERAO2rxg>
    <xme:RCI2Zar3IiXngOU4WwZXE7cqWLL3kUJQmoagj38oKNRI_EguK6-BE8ygINRpkEcnK
    KZ6TN3RTjrs>
X-ME-Received: <xmr:RCI2ZZOHfu5gkdES3orAOzrVkOPyZnQNBjUyrpSS40F0zCAE0BTpDr4S5OTqk_SAAQccU9b2dECkpvN9TT4YHNY03Uc0mjAJjAmxlUe2YYdElKi-QbyOS7cB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffvvehfufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epkeeuffekhfffteejieekvedthfeghfegteefvdegveevjeegffelleffkeevjedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:RCI2Zb43FfRIvySds3CjuihpwQSxdxpV89XAmlOkug8f8yiRPR1QKw>
    <xmx:RCI2ZT40iWBCHS7m0ZkC8m1oqfmL1DGZgYWh6j2Pd6f9ufKJVW3ocQ>
    <xmx:RCI2ZbiOac3mh8F9dmVoSTs3uv7GKUoiX0_1WZ6euH65rQ7yr7izbg>
    <xmx:RCI2ZWbAQZ_XQxgKJdUuOC65NVja4Cqp8RWm1Z-AydO_fbpT8JzJtg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:35:28 -0400 (EDT)
Message-ID: <a5dfbe4f-b6fc-e282-2a3c-3e487493336c@themaw.net>
Date: Mon, 23 Oct 2023 15:35:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Content-Language: en-US
Subject: Re: autofs: add autofs_parse_fd()
In-Reply-To: <9217caeb-0d7e-b101-33f0-859da175a6ef@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/23 08:48, Ian Kent wrote:
> On 20/10/23 21:09, Ian Kent wrote:
>> On 20/10/23 19:23, Arnd Bergmann wrote:
>>> On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
>>>> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
>>>>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit 
>>>>>>> rootfs we call
>>>>>>> it as compat mode boot testing. Recently it started to failed to 
>>>>>>> get login
>>>>>>> prompt.
>>>>>>>
>>>>>>> We have not seen any kernel crash logs.
>>>>>>>
>>>>>>> Anders, bisection is pointing to first bad commit,
>>>>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>>>>
>>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>>>>> I tried to find something in that commit that would be different
>>>>>> in compat mode, but don't see anything at all -- this appears
>>>>>> to be just a simple refactoring of the code, unlike the commits
>>>>>> that immediately follow it and that do change the mount
>>>>>> interface.
>>>>>>
>>>>>> Unfortunately this makes it impossible to just revert the commit
>>>>>> on top of linux-next. Can you double-check your bisection by
>>>>>> testing 546694b8f658 and the commit before it again?
>>>>> I tried these two patches again:
>>>>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
>>>>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
>>>>>
>>>> One difference that I notice between those two patches is that we no
>>>> long call autofs_prepare_pipe().  We just call autofs_check_pipe().
>>> Indeed, so some of the f_flags end up being different. I assumed
>>> this was done intentionally, but it might be worth checking if
>>> the patch below makes any difference when the flags get put
>>> back the way they were. This is probably not the correct fix, but
>>> may help figure out what is going on. It should apply to anything
>>> from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
>>> linux-next:
>>>
>>> --- a/fs/autofs/inode.c
>>> +++ b/fs/autofs/inode.c
>>> @@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block 
>>> *s, struct fs_context *fc)
>>>          pr_debug("pipe fd = %d, pgrp = %u\n",
>>>                   sbi->pipefd, pid_nr(sbi->oz_pgrp));
>>>   +        /* We want a packet pipe */
>>> +        sbi->pipe->f_flags |= O_DIRECT;
>>> +        /* We don't expect -EAGAIN */
>>> +        sbi->pipe->f_flags &= ~O_NONBLOCK;
>>> +
>>
>>
>> That makes sense, we do want a packet pipe and that does also mean
>>
>> we don't want a non-blocking pipe, it will be interesting to see
>>
>> if that makes a difference. It's been a long time since Linus
>>
>> implemented that packet pipe and I can't remember now what the
>>
>> case was that lead to it.
>
> After thinking about this over the weekend I'm pretty sure my mistake
>
> is dropping the call to autofs_prepare_pipe() without adding the tail
>
> end of it into autofs_parse_fd().
>
>
> To explain a bit of history which I'll include in the fix description.
>
> During autofs v5 development I decided to stay with the existing usage
>
> instead of changing to a packed structure for autofs <=> user space
>
> communications which turned out to be a mistake on my part.
>
>
> Problems arose and they were fixed by allowing for the 64 bit to 32 bit
>
> size difference in the automount(8) code.
>
>
> Along the way systemd started to use autofs and eventually encountered
>
> this problem too. systemd refused to compensate for the length difference
>
> insisting it be fixed in the kernel. Fortunately Linus implemented the
>
> packetized pipe which resolved the problem in a straight forward and
>
> simple way.
>
>
> So I pretty sure that the cause of the problem is the inadvertent 
> dropping
>
> of the flags setting in autofs_fill_super() that Arnd spotted although I
>
> don't think putting it in autofs_fill_super() is the right thing to do.
>
>
> I'll produce a patch today which includes most of this explanation for
>
> future travelers ...

So I have a patch.


I'm of two minds whether to try and use the instructions to reproduce this

or not because of experiences I have had with other similar testing 
automation

systems that claim to provide a reproducer and end up a huge waste of 
time and

are significantly frustrating.


Can someone please perform a test for me once I provide the patch?


Ian

>
>
>>
>>
>> Ian
>>
>>>          sbi->flags &= ~AUTOFS_SBI_CATATONIC;
>>>            /*

