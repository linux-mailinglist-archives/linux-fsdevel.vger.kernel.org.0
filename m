Return-Path: <linux-fsdevel+bounces-466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2097CB33B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 21:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DF328180C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 19:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACD34197;
	Mon, 16 Oct 2023 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="b6V8LqME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKHOtN8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F0339BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 19:16:41 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87796A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:16:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6C9D732009E4;
	Mon, 16 Oct 2023 15:16:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 16 Oct 2023 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1697483795; x=1697570195; bh=oZB1QpEQ1bHG8ALWRALfHV3ohJv2zwV044f
	ygV1GRHQ=; b=b6V8LqMEqhMXYUvU5s2CN5RjIsrv3Ja0LpwiV9p0I4acOpBxY/8
	4s8jiI8kKbo6JuteA5j4zBQfHsY7WXL8M7FQCcHtkdO62yvwELCXiv6CpUXHyZ7L
	5JqN4TY6XIqYJJgegxFpkGWB0OHgcrohaFHO7Nbv/A/JGCf2ElhnTI38k7Am82e7
	j3dfy9oTL2XciWU3Q2JR98If8Pnob57p6mR4LsuVOpWStVnWNIxgWEbRe4CxfwGG
	REEhyT3QPrEaQhITVeaVdwZkPDQX79H4YZ/JcWzDXCstRvahpe23AZq6jla/pDAd
	VXBieU5S7mcrx4rQqJynEUBKuSHfvjhKjaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697483795; x=1697570195; bh=oZB1QpEQ1bHG8ALWRALfHV3ohJv2zwV044f
	ygV1GRHQ=; b=FKHOtN8dqajgHYpII27BVPyanV/tBPCcVAOJZ5siKSWXI/OI12T
	HOqIUZhCX4ibf9Vq/VdJlOwA6Q1kPgZ+kLqJFsUA9KdIw5pcV8pcd5gkHGGBleLi
	/j2I9b1wWpL+8WXv8Cm/i80cLfDFypa3y+k9QdVOfz1M68zfojImt0IuFLx5Vftx
	in0G0TByMdSBgXCCPpVlQFjz/CvldZHwZftgwVnQq47TweRPbuR51eb44x8MBeCo
	T/BXh+uubNvJZX3ReGJY81rGGCmgAtombFe6ki/FkzabijQktOcnJlknDKNufb25
	2AUsXJofOZJCXfjYnpvUKsrqqaZfeSn6NPQ==
X-ME-Sender: <xms:E4wtZczqON5bkDcxv1wYMotSleCIjluPdp-7i2PK15u5UZAVcX6joA>
    <xme:E4wtZQRdNWWbvDEN27khGsGpjsQJtqcOna02em7ByulbV8HQ49nDc2T2UODKGp14X
    P7yxUyeGun8dyPt>
X-ME-Received: <xmr:E4wtZeWKWjhrqOAurQGcgFdWJt427rDGWXvLQYKBnpOHQQhIZvq9n5471CIOnnD8jdE82ndCGeIPUuLb_VOGpwV0EDDelWP_kfbVxQr8VlHDtud89H4l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefgueektdefuefgkeeuieekieeljeehffej
    heeludeifeetueefhfetueehhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:E4wtZahNVj3-4vyy0RSpTr6ECeVoInmMijiFEiGnjUopCFzjFT7_Lg>
    <xmx:E4wtZeDEpyqBRCUzl1jYdKQnsoCWyC3rhMEWuM3PkzTIrheTjHczJA>
    <xmx:E4wtZbKvtiMXuCQKvJ2u38XeXp_7l4knvRO9o7ciUe5cxgRv-t1sig>
    <xmx:E4wtZQ2bJm4HvjOkyEnYMuMwhev4rl9iLUZOYV-P-RL3dLQmWdkqmg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 15:16:34 -0400 (EDT)
Message-ID: <4b64a41c-6167-4c02-8bae-3021270ca519@fastmail.fm>
Date: Mon, 16 Oct 2023 21:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Rosenberg <drosen@google.com>,
 Paul Lawrence <paullawrence@google.com>,
 Alessio Balsini <balsini@android.com>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20230519125705.598234-1-amir73il@gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
 <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
 <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
 <CAOQ4uxg+8H5+iXDygA_8G+yZPpxkKOADVhNOPPfuuwo4wYmojQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxg+8H5+iXDygA_8G+yZPpxkKOADVhNOPPfuuwo4wYmojQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/16/23 12:30, Amir Goldstein wrote:
> On Tue, Oct 10, 2023 at 5:31 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Sun, 8 Oct 2023 at 19:53, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> Ok, posted your original suggestion for opt-in to fake path:
>>> https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73il@gmail.com/
>>>
>>> Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
>>> the fake (fuse) path is not known.
>>>
>>> We can set the fake path on the first FOPEN_PASSTHROUGH response,
>>> but then the whole concept of a backing id that is not bound to a
>>> single file/inode
>>> becomes a bit fuzzy.
>>>
>>> One solution is to allocate a backing_file container per fuse file on
>>> FOPEN_PASSTHROUGH response.
>>
>> Right.   How about the following idea:
>>
>>   - mapping request is done with an O_PATH fd.
>>   - fuse_open() always opens a backing file (just like overlayfs)
>>
>> The disadvantage is one more struct file (the third).  The advantage
>> is that the server doesn't have to care about open flags, hence the
>> mapping can always be per-inode.
>>
> 
> OK, this was pushed to the POC branches [2][3].
> 
> NOTE that in this version, backing ids are completely server managed.
> The passthrough_hp example keeps backing_id in the server's Inode
> object and closes the backing file when server's inode.nopen drops to 0.
> Even if OPEN/CREATE reply with backing_id failed to create/open the
> fuse inode, RELEASE should still be called with the server provided nodeid,
> so server should be able to close the backing file after a failed open/create.
> 
> I am ready to post v14 patches, but since they depend on vfs and overlayfs
> changes queued for 6.7, and since fuse passthrough is not a likely candidate
> for 6.7, I thought I will wait with posting, because you must be busy preparing
> for 6.7(?).
> 
> The remaining question about lsof-visibility of the backing files got me
> thinking and I wanted to consult with io_uring developers regarding using
> io_uring fixed files table for FUSE backing files [*].
> 
> [*] The term "FUSE backing files" is now VERY confusing since we
>       have two types of "FUSE backing files", so we desperately need
>       better names to describe those two types:
> 1. struct file, which is referred via backing_id in per FUSE sb map
> 2. struct backing_file, which is referred via fuse file ->private
>      (just like overlayfs backing files)
> 
> The concern is about the lsof-visibility of the first type, which the server
> can open as many as it wants without having any connection to number
> of fuse inodes and file objects in the kernel and server can close those
> fds in its process file table, making those open files invisible to users.
> 
> This looks and sounds a lot like io_uring fixed files, especially considering
> that the server could even pick the backing_id itself. So why do we need
> to reinvent this wheel?
> 
> Does io_uring expose the fixed files table via lsof or otherwise?
> 
> Bernd,
> 
> IIUC, your work on FUSE io_uring queue is only for kernel -> user
> requests. Is that correct?
> Is there also a plan to have a user -> kernel uring as well?

Right now I don't have support with the ring for user -> kernel 
notifications yet. Though we will make heavily use of a distributed lock 
manager (DLM) - that will need fast notifications and so better over a 
ring. In principle I could also use the existing ring and take some 
credits for the notifications, but it would make it harder to understand 
what is going on when something goes wrong.

> 
> I wouldn't mind if FUSE passthrough depended on FUSE io_uring
> queue, because essentially, I think that both features address problems
> from the same domain of FUSE performance issues. Do you agree?


The goal is definitely the same, just two different so far orthogonal ways.

I need to hurry up with the patch updates, got distracted by 
atomic-open. direct-io and ddn internal work...


Thanks,
Bernd

