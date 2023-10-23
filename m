Return-Path: <linux-fsdevel+bounces-893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4E7D27B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 02:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEFF2814C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F8A32;
	Mon, 23 Oct 2023 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="WVKo7cvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWGx/VLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471327E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 00:49:01 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA37EE;
	Sun, 22 Oct 2023 17:48:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 10B2A5C023A;
	Sun, 22 Oct 2023 20:48:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 22 Oct 2023 20:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698022138; x=1698108538; bh=FBzhOk1/MoLTpPe2mqzKOYM+gO3ovGaCBaJ
	jCIQKups=; b=WVKo7cvTpb78V5zwABknuMAOGhhEkMF7+2tDi3O19sXGj6kGGD3
	OIId9D3ZjIA1SYYUE4L4yoChKcTOosEzULTFdJH3HsqEndJZtW7BdIIgRSzO2xAR
	cf3WyVOh6pT8HlC621Z16KFGObEccJsGxH88GHtoMIYWe+5rJaRQLnWWL6U1b3gh
	0nd4UGaS2zazfC4gQF22iZRpspDsWVmN2hrYv/gQGk6ACBQ2iFfA41gvDQ5GSTJd
	w1ZeqOdprfIb1w2WbA5yt4TPAHwj6uU2hEJ4ZQLoPN387AOnvNk3kFc/MV7zc77I
	Ze6494508QGmfsyHC09/MpvlfEpWUp0ziog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698022138; x=1698108538; bh=FBzhOk1/MoLTpPe2mqzKOYM+gO3ovGaCBaJ
	jCIQKups=; b=WWGx/VLx1wlsti84Lv7DUJUGP5PV/JV5xlPp9DHFK4IAjp96CVD
	KNPrlIQe2DfCMv2OhfExGy5Hxl190N8wyOtqbAf9/G4SgQ1kF6q9YbZDKXghj/yG
	2qhvBh3InrXLZllHXM+NHWLnh4OMhfgo9WAuLS3GGIFwMzFvi7s9tg16WQPfQmJa
	QQEA729E/WWP8uThNI5GRM/EEbNbRSNIT7O/IDPgq9l0SX1sjqBTSSwxzZLhbXO0
	X1KJf4dUE2MNC2YOJSHhzZ6FHBm0hVuxB+BlcVjbZZCLas3AQ7l4jdifxs+Ka9lY
	jHi7wS4GleB+K/er3K9WSWcz7HZjVGeeEmw==
X-ME-Sender: <xms:-cI1ZR4cetO7qgvDHFP3WPsxL3LaDkh9WzVcG_scPgIx3w10bb76PQ>
    <xme:-cI1Ze4I3_e-PU2q681-szlCSSiAGHGoCQ6tIdckFamyDKXiMfJ0XjFNEjzyR7sOm
    QEN-zRIRCk0>
X-ME-Received: <xmr:-cI1ZYf5xIJISie6MP6hRsCH3LuVm47p5DIL2SyZUBtQDyWZbTp7kKRZ4gh9ZQeqBu-9jYCZxsYYnxc4f_BK4kbUF46529UzyUwxzsaZrJv-Pb6l6Z5JSUZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhvfevfhfujggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekueffkefhffetjeeikeevtdfhgefhgeetfedvgeevveejgeffleelffekveejtdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:-cI1ZaL0ZAWpC0hup45FCz6RnuKLyiLjUO43efaoxXzptTYqpacqRA>
    <xmx:-cI1ZVJ5YT0AX0XYY8AUIEnZUS_mZfE2xlq_hwasm7nAFr02zvQOxQ>
    <xmx:-cI1ZTzw_iljQw22xyqNva7PKftPnwL3QTEw0ii_1S0nvEoBySmBxA>
    <xmx:-sI1Zaqq9OsvlU3NflbwcJUWXWmK-yG8a_RIGX0I8jrtKXfzhIG2bg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Oct 2023 20:48:53 -0400 (EDT)
Message-ID: <9217caeb-0d7e-b101-33f0-859da175a6ef@themaw.net>
Date: Mon, 23 Oct 2023 08:48:50 +0800
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
Content-Language: en-US
Subject: Re: autofs: add autofs_parse_fd()
In-Reply-To: <11ba98f2-2e59-d64b-1a1a-fd32fd8ba358@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/10/23 21:09, Ian Kent wrote:
> On 20/10/23 19:23, Arnd Bergmann wrote:
>> On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
>>> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
>>>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit 
>>>>>> rootfs we call
>>>>>> it as compat mode boot testing. Recently it started to failed to 
>>>>>> get login
>>>>>> prompt.
>>>>>>
>>>>>> We have not seen any kernel crash logs.
>>>>>>
>>>>>> Anders, bisection is pointing to first bad commit,
>>>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>>>
>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>>>> I tried to find something in that commit that would be different
>>>>> in compat mode, but don't see anything at all -- this appears
>>>>> to be just a simple refactoring of the code, unlike the commits
>>>>> that immediately follow it and that do change the mount
>>>>> interface.
>>>>>
>>>>> Unfortunately this makes it impossible to just revert the commit
>>>>> on top of linux-next. Can you double-check your bisection by
>>>>> testing 546694b8f658 and the commit before it again?
>>>> I tried these two patches again:
>>>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
>>>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
>>>>
>>> One difference that I notice between those two patches is that we no
>>> long call autofs_prepare_pipe().  We just call autofs_check_pipe().
>> Indeed, so some of the f_flags end up being different. I assumed
>> this was done intentionally, but it might be worth checking if
>> the patch below makes any difference when the flags get put
>> back the way they were. This is probably not the correct fix, but
>> may help figure out what is going on. It should apply to anything
>> from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
>> linux-next:
>>
>> --- a/fs/autofs/inode.c
>> +++ b/fs/autofs/inode.c
>> @@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block 
>> *s, struct fs_context *fc)
>>          pr_debug("pipe fd = %d, pgrp = %u\n",
>>                   sbi->pipefd, pid_nr(sbi->oz_pgrp));
>>   +        /* We want a packet pipe */
>> +        sbi->pipe->f_flags |= O_DIRECT;
>> +        /* We don't expect -EAGAIN */
>> +        sbi->pipe->f_flags &= ~O_NONBLOCK;
>> +
>
>
> That makes sense, we do want a packet pipe and that does also mean
>
> we don't want a non-blocking pipe, it will be interesting to see
>
> if that makes a difference. It's been a long time since Linus
>
> implemented that packet pipe and I can't remember now what the
>
> case was that lead to it.

After thinking about this over the weekend I'm pretty sure my mistake

is dropping the call to autofs_prepare_pipe() without adding the tail

end of it into autofs_parse_fd().


To explain a bit of history which I'll include in the fix description.

During autofs v5 development I decided to stay with the existing usage

instead of changing to a packed structure for autofs <=> user space

communications which turned out to be a mistake on my part.


Problems arose and they were fixed by allowing for the 64 bit to 32 bit

size difference in the automount(8) code.


Along the way systemd started to use autofs and eventually encountered

this problem too. systemd refused to compensate for the length difference

insisting it be fixed in the kernel. Fortunately Linus implemented the

packetized pipe which resolved the problem in a straight forward and

simple way.


So I pretty sure that the cause of the problem is the inadvertent dropping

of the flags setting in autofs_fill_super() that Arnd spotted although I

don't think putting it in autofs_fill_super() is the right thing to do.


I'll produce a patch today which includes most of this explanation for

future travelers ...


>
>
> Ian
>
>>          sbi->flags &= ~AUTOFS_SBI_CATATONIC;
>>            /*

