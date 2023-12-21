Return-Path: <linux-fsdevel+bounces-6750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3281B9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0435282229
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF60360A4;
	Thu, 21 Dec 2023 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="klgQ2LGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYFdyRSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D01643D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 61EDF3200AD6;
	Thu, 21 Dec 2023 09:36:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 09:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703169401;
	 x=1703255801; bh=1DlmtSpClXUVMTiI/J4pF9c16AgmDN04rij9Y9KWBr0=; b=
	klgQ2LGrms50evEtXBCPZo1adLNbMW8AuZ3Q2+k5xF6g4o4RaShrVJl+dOQGBw76
	Y8RhlyllPYoN8tFXDKgUukAvBDDUAT1aPVmylby6d3+AdOSwyy6HKGwA6N8/F3Ur
	qkz7DnitJW8OUR/LJBRr0AyAMnp8pTaAoabM6iF3HdyyhwIX/q4vEovzNtob+ZiD
	rwCBJBpyJ8OYVFKnrHJ4Eeuqz5/lk+0qYAQEYf8NyWyp+FfsTzj1dCIdHI6zWgPM
	DG6UNRc4YjO+LM8a3ChzsN5xAkSvTW/3Xj8LbaD5frJulLifFzalniQJsv1JAVt5
	Rlcx8cgMzd2JE6cucF3BjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703169401; x=
	1703255801; bh=1DlmtSpClXUVMTiI/J4pF9c16AgmDN04rij9Y9KWBr0=; b=Y
	YFdyRSW0pNzMIHHPPlrjsXRESYdwwQqtWukuHQCCgeUFfs5NtDJFTO0TjdB3qhMO
	R/uoqEAdl1matbFxV7Bh9zyf2ZY3qGZtKuI7MzdJ6Kra2xnlyMBeINC0A28r6KEk
	I3RnQW+dAsLN1AVkseQDqEOif6xOSGzkOPIMUwOTO1EehAF3GtaBu88winRqGMLZ
	LKRtCwffQlmVsR30ojF+KSX2T98RPhV4nM5ga+UAzPylme7GVaqz8CGk5gmlleRK
	8TjtEt30PhFAUAroUAK5qyxDUNn8VXvM64vukRUhA8X+k/uX3CjOzCeLAuDxYRsu
	8UrU+F2gU+lq3084Tls1w==
X-ME-Sender: <xms:eU2EZbrelL2zUctIQ6oozdw-HryRkWoQdtOpBALHUZdTjW0uc94Bzg>
    <xme:eU2EZVoN7F_KvUM6h8LKx5Sybb3c49cDAS2hSzpO4W0IMyKphpN896Z3gZfcoKJSt
    k6Vx7l6lQa1ZRCU>
X-ME-Received: <xmr:eU2EZYPj2D1xXvUDq1_FSUvHtNqq7o_yjlQDQJEbdTN7Uk1-v-SHqG-3wHzRTIcv6VVxjkBGNZDOdzp5984l4ZKwhFjL6ffq3QjN_zMQjjk_-1qqTEZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:eU2EZe78Z80sqZlC6deNIf34ymUp1d00p8nFoRawP08Lb_TLlUhAcQ>
    <xmx:eU2EZa5JMK7o7qoScYl-TdctMY25916OXgS3zF9T2BsZzwY7hfLx-A>
    <xmx:eU2EZWhPEN6mGRNyka1mpXE6agyi9moulYRuGlCZxGlUQW-mQUShXg>
    <xmx:eU2EZRaiO_Lh0tam6VYV80hdVehaS27jaqZ4ymOkbMwu7pDlKRi8_Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 09:36:39 -0500 (EST)
Message-ID: <75ea0748-9455-4ac5-b68a-fdf6fab4217d@fastmail.fm>
Date: Thu, 21 Dec 2023 15:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>,
 linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>,
 Dharmendra Singh <dsingh@ddn.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm>
 <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm>
 <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm>
 <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
 <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm>
 <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
 <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm>
 <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
 <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm>
 <CAOQ4uxgy5mV4aP4YHJtoYeeLMzNfj0qYh7zTL32gO1TfJDvYYg@mail.gmail.com>
 <bde78295-e455-4315-b8c6-57b0d3b60c6c@fastmail.fm>
 <CAOQ4uxjmg0ixS58aacwuYKXhVMyh+O-PmOtgxQR1wd+Ab25r1w@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxjmg0ixS58aacwuYKXhVMyh+O-PmOtgxQR1wd+Ab25r1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> But why would you need to call fuse_file_io_mmap() for O_DIRECT?
>>> If a file was opened without FOPEN_DIRECT_IO, we already set inode to
>>> caching mode on open.
>>> Does your O_DIRECT patch to mmap solve an actual reproducible bug?
>>
>> Yeah it does, in my fuse-dio-v5 branch, which adds in shared locks for
>> O_DIRECT writes without FOPEN_DIRECT_IO.
>>
> 
> Ah. right, because open(O_DIRECT) does not enter io cache mode
> in your branch. I missed that.
> 
> But still, I think that a better fix for fuse_io_mode would be to treat
> mmap of O_DIRECT exactly the same as mmap of FOPEN_DIRECT_IO,
> including invalidate page cache and require FUSE_DIRECT_IO_ALLOW_MMAP.
> I know this could be a change of behavior of applications doing mmap()
> on an fd that was opened with O_DIRECT, but I doubt that such applications
> exist, even if this really works with upstream code.
> 
> Something like this (pushed to my fuse_io_mode branch)?
> 
> +static bool fuse_file_is_direct_io(struct file *file)
> +{
> +       struct fuse_file *ff = file->private_data;
> +
> +       return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DIRECT;
> +}
> +
>   /* Request access to submit new io to inode via open file */
>   static bool fuse_file_io_open(struct file *file, struct inode *inode)
>   {
> @@ -116,7 +121,7 @@ static bool fuse_file_io_open(struct file *file,
> struct inode *inode)
>                  return true;
> 
>          /* Set explicit FOPEN_CACHE_IO flag for file open in caching mode */
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO) && !(file->f_flags & O_DIRECT))
> +       if (!fuse_file_is_direct_io(file))
>                  ff->open_flags |= FOPEN_CACHE_IO;
> 
>          spin_lock(&fi->lock);
> @@ -2622,8 +2627,9 @@ static int fuse_file_mmap(struct file *file,
> struct vm_area_struct *vma)
>          if (FUSE_IS_DAX(file_inode(file)))
>                  return fuse_dax_mmap(file, vma);
> 
> -       if (ff->open_flags & FOPEN_DIRECT_IO) {
> -               /* Can't provide the coherency needed for MAP_SHARED
> +       if (fuse_file_is_direct_io(file)) {
> +               /*
> +                * Can't provide the coherency needed for MAP_SHARED
>                   * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
>                   */
> 

I cut off the rest of the discussion as this is from my point of view a 
rather major change.

I'm not sure about this. If an application opens with O_DIRECT and then 
does mmap - sure, weird options, but then none of the other network file 
systems requires a special setting for that? And none of the other file 
systems has pages invalidations? Why is it needed for fuse' O_DIRECT? 
The initial invalidation was for MAP_PRIVATE and FOPEN_DIRECT_IO, but 
now gets extended - I get really worried about this special fuse 
handling that none of the other file system has.

Also, NFS and smb/cifs do not have the same coherency guarantees, but 
still allow mmap on O_DIRECT?

And assuming an application does this on an existing fuse file system, 
the application would now need to ask the fuse file system developer to 
set this flag with a new kernel?

At a minimum I wouldn't like to have this without its own change log 
entry and with the risk that everything needs to be reverted, in case a 
regression is reported.


Thanks,
Bernd





