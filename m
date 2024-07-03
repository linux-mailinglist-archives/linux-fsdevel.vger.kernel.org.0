Return-Path: <linux-fsdevel+bounces-23028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01329261D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550E9283577
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CB17A5A8;
	Wed,  3 Jul 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Nc9K4YpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A29OwE26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40617A58B;
	Wed,  3 Jul 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013269; cv=none; b=NAtWa0r7+41/lod0J3GyxkeAg8KAbWOj1QjnEsicMevNHnRXdlowKi8o4d5kLDxeAerMtFCId5Xj/Rik0yOwSQiiinNzs4kEVWSn1CVyqT1avl1/ndPAWOILVrwVOOaKIuNLrcRSQCoYKw67XcZgNHJpk13Bsxa/OSoxcqVtea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013269; c=relaxed/simple;
	bh=7+VmwCVzDq6PXFQ11tmEPnhfZ7ihj+bBGwrOGKnxCSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXhMvuOaiPSJL6+Q8aCuSBvOeTTcu0cCADD6ewn+BnN7XIddd9mIQKE7utuCevybbNTW2FuajAm3jwO+U5b+GGaJFgkNV2+p4xP3PBCZrUgfuyIGtB0R1lX3jbpXkwn2JLzjRFGGt9ZYMCEOHmnUyAaha3rmERm5M1JqiFpGwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Nc9K4YpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A29OwE26; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E895E11401FA;
	Wed,  3 Jul 2024 09:27:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Jul 2024 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720013265;
	 x=1720099665; bh=zHsCkdbRs04MeYzE1MvM8IvQ6gKzRN5ln4russl7Bto=; b=
	Nc9K4YpLasjbur5Yp0FYWzHbCIVAC427TJKai7UrSLC5cwAA0Cuad7SUU74mmuxA
	3XqfVi35lnUPUn/sbUXZ3+VpfoCYltsA1t0dTstwenU7QKrIKdyLCdmJp44DYHZA
	TLhJkMvBg76Qao7PcrMbot9NB4GPvdITByzL31NfCoDcKrX/260lTi5U43F7Kxkh
	iUU0qi0M/KxlwP9N/hiX9vDVpNZoVhEcEv1m29o3Z3pcUHsu2KZC9+AYQoxGQJcD
	3xH3YBd/RjX9zQkA5UV88UuyX2Px5HTr9TFvAVzMBB73PAUw4WEa+2Yt/EymmpO+
	grLAb64Q7oGpdOEIb0xP3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720013265; x=
	1720099665; bh=zHsCkdbRs04MeYzE1MvM8IvQ6gKzRN5ln4russl7Bto=; b=A
	29OwE26qb2dT7DYMBz95DFAK9i6d0auZtEiIsCjnmV5PhAWb/o9lxpi4n7I3R06L
	Qu5/Fmev0hPbGiPOBdjHCnnTIh9nhzv7jP9jfRoDzqj8vPBI1zVyrk2pBZO7z712
	5gRlcnoO3hspHuJpXoSzY3mdLLo4OM97u/4Jm6+SRUreh4227gpZ5xxRchonpeNi
	0IQBtrojS/iQgEEHsbmTWEGQt39A+20uhlmEgTi4Tey38n6Vvvk80nhWVBpKTu+j
	9tsIycthcETGyM2+UlbP8jRUW2P74jQn28vBTY6Nl3Om6HRkHpmDHiUhMd9/ZiU0
	HjgjLSvErZh/9Zz5vr7Ug==
X-ME-Sender: <xms:0VGFZjUNwVCvSIE15GnlibTzJ63vNLzR5cDb5lVK_oFe1FZH37OEPQ>
    <xme:0VGFZrlZ4j44LKeMd91wibr4b5nXtyvTxy29TBtmhGDRgHVN7vbMubGPKHbuEEyXZ
    hSrwMPM-RYrgvEG>
X-ME-Received: <xmr:0VGFZvbB6D78O_-cnzbntBa3nE5v-S3eyb0YW7ObXEdez1TALte5DdlkLBahDUoTLrmb_9XtRtnHcKxnQsyLS3_ycjeX29gCwYRkK8WJbwL5FfTzx67G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:0VGFZuUFCU_TJmdhBB_1MiletzaS30GTXqtI3-0JJjWMl_Hf-pMLAw>
    <xmx:0VGFZtkEgwNAl0a0Buu3euD7J0i10sf44xY3u_U8S5dzNUirbz4Jpw>
    <xmx:0VGFZreiFlxkdLYINkgzvgm1FVEl5YGEL1vZplTwY-qe3onmPcoGAg>
    <xmx:0VGFZnFDJbEatO8P7cwCtPWmldJ8Yr9wzrhYqA-bn8BOTfQhVZCyMQ>
    <xmx:0VGFZrYpkIp0peuJ6DVlUv30paeBpC9Uw23oxo1qviPyqdwKsYcY5WOI>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 09:27:44 -0400 (EDT)
Message-ID: <315aef06-794d-478f-93a3-8a2da14ec18c@fastmail.fm>
Date: Wed, 3 Jul 2024 15:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Fuse Passthrough cache issues
To: Daniel Rosenberg <drosen@google.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-team@android.com
References: <20240703010215.2013266-1-drosen@google.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: fr, en-US
In-Reply-To: <20240703010215.2013266-1-drosen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/24 03:02, Daniel Rosenberg wrote:
> I've been attempting to recreate Android's usage of Fuse Passthrough with the
> version now merged in the kernel, and I've run into a couple issues. The first
> one was pretty straightforward, and I've included a patch, although I'm not
> convinced that it should be conditional, and it may need to do more to ensure
> that the cache is up to date.
> 
> If your fuse daemon is running with writeback cache enabled, writes with
> passthrough files will cause problems. Fuse will invalidate attributes on
> write, but because it's in writeback cache mode, it will ignore the requested
> attributes when the daemon provides them. The kernel is the source of truth in
> this case, and should update the cached values during the passthrough write.

Could you explain why you want to have the combination passthrough and
writeback cache?

I think Amirs intention was to have passthrough and cache writes
conflicting, see fuse_file_passthrough_open() and
fuse_file_cached_io_open().

Also in <libfuse>/example/passthrough_hp.cc in sfs_init():

    /* Passthrough and writeback cache are conflicting modes */



With that I wonder if either fc->writeback_cache should be ignored when
a file is opened in passthrough mode, or if fuse_file_io_open() should
ignore FOPEN_PASSTHROUGH when fc->writeback_cache is set. Either of both
would result in the opposite of what you are trying to achieve - which
is why I think it is important to understand what is your actual goal.

I think idea for conflicting file cached and passthrough modes is that
the backing inode can already provide a cache - why another one for fuse?


> 
> The other issue I ran into is the restriction on opening a file in passthrough
> and non passthrough modes. In Android, one of our main usecases for passthrough
> is location metadata redaction. Apps without the location permission get back
> nulled out data when they read image metadata location. If an app has that
> permission, it can open the file in passthrough mode, but otherwise the daemon
> opens the file in normal fuse mode where it can do the redaction.
> 
> Currently in passthrough, this behavior is explicitly blocked. What's needed to
> allow this? The page caches can contain different data, but in this case that's
> a feature, not a bug. They could theoretically be backed by entirely different
> things, although that would be fairly confusing. I would think the main thing
> we'd need would be to invalidate areas of the cache when writing in passthrough
> mode to give the daemon the opportunity to react to what's there now, and also
> something in the other direction. Might make more sense as something the daemon
> can opt into.
> 
> Any thoughts on these issues? And does the proposed fix make sense to you?
> 
> 
> 
> Daniel Rosenberg (1):
>   fuse: Keep attributes consistent with Passthrough
> 
>  fs/fuse/passthrough.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08


Thanks,
Bernd

