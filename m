Return-Path: <linux-fsdevel+bounces-830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE47D104A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2C282334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2AC1A72E;
	Fri, 20 Oct 2023 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="PpYuKcxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2ODgfmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184D1A70E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:09:43 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90DBE;
	Fri, 20 Oct 2023 06:09:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 991F45C0ACE;
	Fri, 20 Oct 2023 09:09:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 20 Oct 2023 09:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1697807381; x=1697893781; bh=H9rjDKi86egy+CCMRQXTpLLy3mneqPSVJpZ
	0V0aMB0U=; b=PpYuKcxuV5/b9Dm0fNrNjLqu/+9aNEJ2L3jN7yvAaHzQLKwGkv8
	5RQffEtTT8vxlyYSw7eP7+3KdRxE5nrvajVnq7bN3M1xNK/5q1vG+vloYKb3BVKc
	nNkJDuszSN7/Mb3uUI867osCmN3Y7GAve9ZLVS235ihtRV6zZmVn7zwGT6oSaOUM
	9KPJ5EFl5SQ1xqMo97yjpqAkTIW/fnJY6txMtIVZpJqES7EgCivhuK5oN9SsErM+
	eNWZ3jl2GYc/oIsCtCow1FYiyD32kY4A6d+57qmOyrYS90MFrcwCKWSLaFII7P8y
	t0CuXoZRHyaVTmMF1Yc0+bN7/sNK8QUcwVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697807381; x=1697893781; bh=H9rjDKi86egy+CCMRQXTpLLy3mneqPSVJpZ
	0V0aMB0U=; b=R2ODgfmrxMoUKcsW5mCxmmxN5E/hV/wqa5/bE0QMHV1+TiYGFgc
	caGjErhizrHXg5YVmMteojh7wgESXzGq2XgDwe/vAmKBdJx5tth5db7xNhJ8FHbH
	gDjDq/M8YPDkoGMsGP5rNme4iuIVgmHDlh7UzvtDmwoRaxPKNX4vLTOKNd10Fg/O
	5rUTdIONjl93uvkCQ+C94HR/5E+xKgWb2BAzsUJyEn65w4Z7LUZoKgFk82Hojms1
	AVwNj3XJhS7knhXNEtJQZ9TnaBC4vvusIS03hY20+I313aPnExWzFMqS0mVoZ1BF
	uWI/B5URD1ieK0b37XI/fTUkPh6ulFk9xQQ==
X-ME-Sender: <xms:FXwyZf71TFLG7l9Dc16IiJlcpvHWjl88xVdzWo7_-Sdv3Q4w-t4EOQ>
    <xme:FXwyZU4N5YF11Ah556Zcwozs632ohpnwOwqLkOkkqSiYY-GcHrEq7Q5iqbgx9YVns
    psLEgElsKDH>
X-ME-Received: <xmr:FXwyZWcWw_eKyB0TVjI68rJn0IjGkPn9wvLaaE7y7NFoVlxdJYnw4yoqxD0Nt9Pwolxx0F9wL1F9ZZl0DOk4HslPgkGeF_rZPsurNayF0Q_TcZUagBjlFEtf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:FXwyZQKACAL5-D3QHVTVx5h-cNTJoYN8g9N5E7WG1MyQaoJSdohD3Q>
    <xmx:FXwyZTIRvHo2_EifTeMKJ0gyeX5_r8nnD9Qryv22RFUBUV4ABajd5g>
    <xmx:FXwyZZzahPAD921in94LmGibQVwAJ01f1YL5U7qiQ8GtRQ3jItaIOA>
    <xmx:FXwyZQqHBP_KeJK4vXBtDRWTFOWXxKaOOADS-re6klkDxAR1BVrLVQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 09:09:37 -0400 (EDT)
Message-ID: <11ba98f2-2e59-d64b-1a1a-fd32fd8ba358@themaw.net>
Date: Fri, 20 Oct 2023 21:09:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: autofs: add autofs_parse_fd()
Content-Language: en-US
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
From: Ian Kent <raven@themaw.net>
In-Reply-To: <f1cddf6e-2103-4786-84ff-12c305341d7c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/23 19:23, Arnd Bergmann wrote:
> On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
>> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
>>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
>>>>> it as compat mode boot testing. Recently it started to failed to get login
>>>>> prompt.
>>>>>
>>>>> We have not seen any kernel crash logs.
>>>>>
>>>>> Anders, bisection is pointing to first bad commit,
>>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>>> I tried to find something in that commit that would be different
>>>> in compat mode, but don't see anything at all -- this appears
>>>> to be just a simple refactoring of the code, unlike the commits
>>>> that immediately follow it and that do change the mount
>>>> interface.
>>>>
>>>> Unfortunately this makes it impossible to just revert the commit
>>>> on top of linux-next. Can you double-check your bisection by
>>>> testing 546694b8f658 and the commit before it again?
>>> I tried these two patches again:
>>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
>>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
>>>
>> One difference that I notice between those two patches is that we no
>> long call autofs_prepare_pipe().  We just call autofs_check_pipe().
> Indeed, so some of the f_flags end up being different. I assumed
> this was done intentionally, but it might be worth checking if
> the patch below makes any difference when the flags get put
> back the way they were. This is probably not the correct fix, but
> may help figure out what is going on. It should apply to anything
> from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
> linux-next:
>
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>          pr_debug("pipe fd = %d, pgrp = %u\n",
>                   sbi->pipefd, pid_nr(sbi->oz_pgrp));
>   
> +        /* We want a packet pipe */
> +        sbi->pipe->f_flags |= O_DIRECT;
> +        /* We don't expect -EAGAIN */
> +        sbi->pipe->f_flags &= ~O_NONBLOCK;
> +


That makes sense, we do want a packet pipe and that does also mean

we don't want a non-blocking pipe, it will be interesting to see

if that makes a difference. It's been a long time since Linus

implemented that packet pipe and I can't remember now what the

case was that lead to it.


Ian

>          sbi->flags &= ~AUTOFS_SBI_CATATONIC;
>   
>          /*

