Return-Path: <linux-fsdevel+bounces-6753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D258381BA33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113D81C235C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46A405CA;
	Thu, 21 Dec 2023 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="iA+jzuxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ys3htVnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0F360A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4E0C33200A64;
	Thu, 21 Dec 2023 10:08:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 10:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1703171293;
	 x=1703257693; bh=8sXDWigkhHUBZDT2EcINFGURkJUJrHyze3hK/ZDsA80=; b=
	iA+jzuxHjWkyJSs3IJVwtqgv52xYV6kVw2v8GUEtZscI09EIQEia1vqs90zqCk4u
	g54LYP4zW2phFE4fmWiS6mmNEEY0Zpyb4sTYEPkuODXOgycdKLqK7qr32xaxyVzx
	m12Zs5wdhIkQOS4LlPej4iUElokQCKa/JMDZw939iTKK195/Jce/4tnITCADm39i
	SETkV3cqWor0fRDanGq90YmA76Vv+qwqvpPKrypK1FbgAvw3VWEgxQv+ScHMcWU4
	fEVizkcbx8HRqXLJpBeduOLLiTmsvw7ywgK5YaMO0g3peEB8t29K1nm/eMaSoul+
	LDJLZgdjp4kTpXKmo7CtUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703171293; x=
	1703257693; bh=8sXDWigkhHUBZDT2EcINFGURkJUJrHyze3hK/ZDsA80=; b=Y
	s3htVntxkJdByXxVUfolPO36rfzAYthsOw80D0kag6rBAckrwwvMtnPgIMWiDN77
	89W7DwubMLB46+C0x423+2unzkXBBsnFXEUKxY2ty5rnjRKga+0kHRLcPQcgdaAO
	Wnrp/CMQyVF33gNl1MaKIqXqxhpHDBOBzYV9/YEONpSlLP5P38gkX6GQ/Eq1ZXyq
	qUkxLplyFpD/Miuj+j+R7p1CwDVLN791uuY/SnGyxzdoOwW85tbrEAFpHfu7DSnD
	5c05GeJmHecSaRD89vml1fVIzUa2mOu8kSlvFAYWlyhUIryf4U3CBzHciU9yV9Yw
	JsPzsA+PlR8ISpMLosZUQ==
X-ME-Sender: <xms:21SEZZIiGuEmrJuiJmiYobrWuj5TynKT-bPbrY6XAq0Qdfhrq1hrCw>
    <xme:21SEZVIAvhUYCaz-ql8BeUQDSPHf1HdevUC_3x3nnaQQshJtxhNmM398XxZbD82Uy
    KZoEgWRANWPoFV->
X-ME-Received: <xmr:21SEZRsnKFVBAZ8uV9ZJrG0Qv0nR5Sq9dPBd_2rpPBDiD8uhpl49Focc2N40z-AutCscr_PQy83Hbn6RmE3mpOy6l5Q2BWs3E_FXoxAA_pi6McCfmStx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:21SEZaZUAhHkCwWDb-u04Aw6OUoG4_NI2aU7t1St2BJXqA74CuI6Qw>
    <xmx:21SEZQbzVo9x0GrS3DmztM0Yeb7viQ9keN-CleoKoKjgf8se8Fs0aQ>
    <xmx:21SEZeB5y-QykXctLN_6gfUZd3LVAUoBjcaEBV84zJa6DEB3f0_SKg>
    <xmx:3VSEZQ5D0NgDQbTEzaunToMDbzels_Wynns7KrDhpSXGndz0MDdvtw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 10:08:10 -0500 (EST)
Message-ID: <cdddbd7c-7d11-49bd-b1de-bd2808535d19@fastmail.fm>
Date: Thu, 21 Dec 2023 16:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US, de-DE, fr
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxjmg0ixS58aacwuYKXhVMyh+O-PmOtgxQR1wd+Ab25r1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/21/23 12:14, Amir Goldstein wrote:
> I think that between you and I, fuse_io_mode is getting very close to
> converging, so queuing it for 6.8 really depends on Miklos' availability
> during the following week.
> 
> I suggest that you incorporate my review comments from github
> and/or use the patches that I pushed to my fuse_io_mode branch
> and post the io mode patches for review on the list as soon as
> possible. I could do that, but I trust that you are testing dio much
> better than I am.

Sure, will do that, but I will back out 
FOPEN_DIRECT_IO/O_DIRECT-are-the-same in fuse_file_mmap. I don't think 
it is needed without parallel mmap and I think it deserves its own 
discussion first.

> 
>>   From my point my dio-v5 branch is also ready, it relies on these
>> patches. Not sure how to post it with the dependency.
> 
> Basically, you just post the io mode patch set and then you
> post the dio patches with a reference to the io mode patches
> that they depend on.
> 
>> I also have no issue to wait for 6.9, for now I'm going to take these
>> patches to our fuse module for ubuntu and rhel9 kernels (quite heavily
>> patched, as it needs to live aside the kernel included module - symbol
>> renames, etc).
>>
> 
> Feels to me like the dio patches are a bit heavier to review than just the
> io mode patches, so not likely to be ready for 6.8, but it's not up to me.
> I can only say that my review of io mode patches is done and that I have
> tested them, while my own ability to review fuse-dio patches for the 6.8
> timeframe is limited.

I'm first going to post the fuse_io_mode branch, no need to add in more 
distraction. Once Miklos has reviewed (and merged that), I can 
immediately post the dio branch.


Thanks,
Bernd

