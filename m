Return-Path: <linux-fsdevel+bounces-4253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38E7FE35F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC91B20FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD547A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="hxMTv5v4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D84h9p23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99641D67
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:46:06 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 61AAD5C019D;
	Wed, 29 Nov 2023 15:46:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 15:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701290763; x=1701377163; bh=ggWcIRidBgPzI2loCGTssv7w49TyGbGKxbj
	01ZMHTug=; b=hxMTv5v4DTSgN22QPOsvGhmYLirFQz4HTUATCUEZvfSc7XVQqQ3
	1uGnD6QCxMhWfIA92f58YIaOnIqv1TsWM455ZKZ1+uInsEM1JxBoI4D3dY3V4EHY
	Nf66sWatQIviYDtov8k/ST861JdYTUkmp75Xo7ey6MQj8FTfubazxn8Nn3SX4A78
	dboTbTl/vt7Ce0VfGprSB4wvsHG18dzkxVlF+3bmA6H0pc3336b2V/azcUtf5TaG
	gw7rf4Q+6LBKQix5MpVVyjq2lP0w99r7tyf+jpQj1xPe0J3gpcjX7IdK7tKhdkmz
	iIvJbIJ3bv/CT3MamlIkvxuBs6fT1fHdrpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701290763; x=1701377163; bh=ggWcIRidBgPzI2loCGTssv7w49TyGbGKxbj
	01ZMHTug=; b=D84h9p23Jl4KTU9dRXZhC0OMJqF9T6MKeDUEEUu31ZuoQ6gzIPE
	qfnvfcpdpsMSx94jxPgHTj2Cwdmdi5YrQDKo5t3ts3UcNde7kZo8ZeMSpTXqqd76
	AnqGi6kwtC+jWmOwZ4ZbgnhigD1widkiLD3iheQbcnNbleYLQWPQdenRR6eBcMUP
	IgVTxmqC9K2yj70f9Q+31JUAzjr30+Cy45MI4JXKDGh2ggDeT2UBZG1Ftg4WBBJy
	f4hUejuFz5rOkU+TwVIMd9lfJEek2ja5Izg7mhVwNNLdvplQJ59QOmxJW9TQreU/
	n+x/WMgW/5VWTmSBU/0V4qUPsmLMQyfiOSA==
X-ME-Sender: <xms:CqNnZdjJZeZ4s0sigO3M_qMs90cPVKvHJI9Ba2wdMscL2naSTsAFpA>
    <xme:CqNnZSAdxTc46RfBw4bp7RU01vPBm_p61NX2Szwb06mLJ4kOISZtbJ_lbOPA9LggY
    cHSZuLPsqNIUYfL>
X-ME-Received: <xmr:CqNnZdF--GdnQe2deIEPenP8jkjl9O7-eaU_9w8wtuiJPOPwA2YPw60dDqbwI42S4uYuyXYgfincVL2cMbvD0u71eWTjAR_GJk82OiSoP_N-zdId7xQT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeeg
    veelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:CqNnZSQxTfIW3ien_AXA-gFtWHA__Hm_-F1z3kLIa5UObKfVYkuz3A>
    <xmx:CqNnZawIeEZNmUm6XFGp8blQRzHzqyhr20lpToTwRIaVO37tF08OCA>
    <xmx:CqNnZY7VXICgaQx4LEQ7ANi9hj9kILV6WbDs2yJ4yMOgzkx5qsTbtw>
    <xmx:C6NnZVwvMNiQ4HKtHXTsKvkJmwhiJiBKKcABDm-085ERLzoK4YDvnQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 15:46:01 -0500 (EST)
Message-ID: <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm>
Date: Wed, 29 Nov 2023 21:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Rosenberg <drosen@google.com>,
 Paul Lawrence <paullawrence@google.com>,
 Alessio Balsini <balsini@android.com>, Christian Brauner
 <brauner@kernel.org>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/29/23 18:39, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 6:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> direct I/O read()/write() is never a problem.
>>>
>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
>>> when the inode is in passthrough mode, also uses fuse_passthrough_mmap()?
>>
>> I think it should.
>>
>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
>>> is denied?
>>
>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>>
> 
> I don't have a use case. That's why I was wondering if we should
> support it at all, but will try to make it work.

What is actually the use case for FOPEN_DIRECT_IO and passthrough? 
Avoiding double page cache?

> 
>>> A bit more challenging, because we will need to track unmounts, or at
>>> least track
>>> "was_cached_mmaped" state per file, but doable.
>>
>> Tracking unmaps via fuse_vma_close() should not be difficult.
>>
> 
> OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
> always prevents an inode from being "neutral".
> 


Thanks,
Bernd

