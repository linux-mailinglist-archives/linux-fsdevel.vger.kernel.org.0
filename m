Return-Path: <linux-fsdevel+bounces-56853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FAB1C9D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F331418C2EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8623F424;
	Wed,  6 Aug 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="lsjzpaKY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koUAOysW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4195BA34;
	Wed,  6 Aug 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497995; cv=none; b=csKrzi+jPM2/QmPQArkTgAyl8NlaNjcJcBx/gXsF91unHYE0KZfWV+jH8eF5va/fSU878ueoTO7pd8c5X9drQKsB5Jj/oipHD/9rn5GCpM5plBTrygxr0YOEhbVeYHcnQS7maDYLkShaxCn//ylAf96X5QWjnstLTFoTssUA/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497995; c=relaxed/simple;
	bh=p22iSra6pPk9rZyXaiGFdxqlysBZmEFk4yfaTHjFbms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YU1kcNuFVPoqV/Zjp9jD1Y7OHYWnALTQNcj+YMut1cliWaXtrlVYN8d09yrgjgIv8w5P8q78lxSwLv2A2g7MOumLFu8KxYefkmvYOOCuspclIKkUUBxPyiqhWHvIQQvGGGhoDP9JIYvK8N8dcyrwLGUYeJ4zo0RR8Ebdr4GxjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=lsjzpaKY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koUAOysW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B113F7A00DA;
	Wed,  6 Aug 2025 12:33:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 06 Aug 2025 12:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754497992;
	 x=1754584392; bh=DwBbfZ7n6uMpEpuqhUsM16dt4Ep86NWy8lRX/aFku3Q=; b=
	lsjzpaKY2GMtUTuTYUNREIiQ/I1SwDaEVTroWkkHmmK5Rj/rkomPNBTzVn6JdyEl
	fzq85rXnBTWrdIP0sXUCKCXFbzwKgSZYD7ru9rFGwnxZmbZwhToRprJJp81xAd1t
	e9fv4ySw5pfRRA1qtNrFxxiukXGfgst6FT8w35Wy2y/8EUkvEKyfOJiruWtirPQ1
	7XLBA+GLK5VVtldj1ql0yOphhZqpPBu8pW3OYJTjSw/7nsfEbbAOiH8qT40gT2m+
	ehq/E+wwmbRVGpqs0m9bH4phIksFgy7HO5LahlO/L443bULoBe4MBTdnMS/al3RO
	NA3l8ay8d4jesbStjMmirw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754497992; x=
	1754584392; bh=DwBbfZ7n6uMpEpuqhUsM16dt4Ep86NWy8lRX/aFku3Q=; b=k
	oUAOysWgC/CMAbsjtH1NlHFlR7wVt5YS72VJgsoKK4fr//PIde3NgDaumFxwLYw7
	y+zUrCc/19qRsh3wHsBtZp/Y3V30Fse5luyfSwXFOOpLiiCmwFE45XK3leD7MCyv
	n5MRDhennsoB2hykjKog5PALTXEIR1Lb0TjdEqk1m5w/cMSsHX2Bafz5APFCywBc
	c4qN/6TaZczlNfGbWINkcXbZ7YWvUTeOOnVA9hVMWrOy3M5dHZm4Z+9cjppsPY0j
	ZXTA/W4/3bcUWIDJKac9904ZAHldwdl4x/iOZ+mYTIFSrhKWr4ZgsdnZvh9C0gBi
	DqYrWL7yuetvO3HQYXFPg==
X-ME-Sender: <xms:yIOTaGWPV1SDHBmR8ov82vq11huPc7vlDnQIXC7prfJ2fBN6dIraCQ>
    <xme:yIOTaNP7uNy0cl5EO5IVEwun7CfYvTfs4ZEe-q3wDu5-BDZbGMe3ThrKdlFzj3fqs
    vUa_aKjFKzSXesn8gU>
X-ME-Received: <xmr:yIOTaAaBKF85-IUcH7iVQsU9X0HIBIjqtk7YyPFlRhcEiocP6nKqBj6Jd88VGR_0-HDJCilUz0OwN47PjtDL5YRodg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcu
    ufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeu
    lefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhgrrhhmihhtrhhosehpohhsthgvohdrnh
    gvthdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    hrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yIOTaM9PudYp1Ah5K3IUPTMVPI4W3LsEuTjjkdFIfIdOVLEGxgllOg>
    <xmx:yIOTaBTcOnfd0Xwal1tzV7tKOy-nQDsnbt45tatLa1gXFyUyzXEPQQ>
    <xmx:yIOTaGfl31P4ovNgGEkhP8Rxcne3kiI6eK0OX4Wx3D4_cvf979Oz5w>
    <xmx:yIOTaDQ42Ns7uJeKqAL-vAjuBiljJ3uXbpnlArRQbB0LZQuLXzqnng>
    <xmx:yIOTaOGyap62e-yiHlFxVcTOr81TSwti2i_ga36mECYU_Kb_uFkBOGy3>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 12:33:11 -0400 (EDT)
Message-ID: <cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>
Date: Wed, 6 Aug 2025 11:33:11 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Eric Sandeen <sandeen@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com> <8734a53cpx.fsf@posteo.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <8734a53cpx.fsf@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 12:22 PM, Charalampos Mitrodimas wrote:
> Eric Sandeen <sandeen@redhat.com> writes:
> 
>> On 8/4/25 12:22 PM, Eric Sandeen wrote:
>>> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
>>>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>>>> mounted. This is a regression introduced during the conversion to the
>>>> new mount API.
>>>>
>>>> When the mount API conversion was done, the line that sets
>>>> sb->s_fs_info to the parsed options was removed. This causes
>>>> debugfs_apply_options() to operate on a NULL pointer.
>>>>
>>>> As an example, with the bug the "mode" mount option is ignored:
>>>>
>>>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>>>   $ mount | grep debugfs_test
>>>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>>>   $ ls -ld /tmp/debugfs_test
>>>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
>>>
>>> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
>>>
>>> e4d32142d1de tracing: Fix tracefs mount options
>>>
>>> Let me look at this; tracefs & debugfs are quite similar, so perhaps
>>> keeping the fix consistent would make sense as well but I'll dig
>>> into it a bit more.
>>
>> So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
>> this issue.
>>
>> However, I think we might be playing whack-a-mole here (fixing one fs at a time,
>> when the problem is systemic) among filesystems that use get_tree_single()
>> and have configurable options. For example, pstore:
>>
>> # umount /sys/fs/pstore 
>>
>> # mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
>> # mount | grep pstore
>> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
>>
>> # mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
>> # mount | grep pstore
>> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
>> #
>>
>> I think gadgetfs most likely has the same problem but I'm not yet sure
>> how to test that.
>>
>> I have no real objection to merging your patch, though I like the
>> consistency of following e4d32142d1de a bit more. But I think we should
>> find a graceful solution so that any filesystem using get_tree_single
>> can avoid this pitfall, if possible.
> 
> Hi, thanks for the review, and yes you're right.
> 
> Maybe a potential systemic fix would be to make get_tree_single() always
> call fc->ops->reconfigure() after vfs_get_super() when reusing an
> existing superblock, fixing all affected filesystems at once.

Yep, I'm looking into that. mount_single used to do this, and IIRC we discussed
it before but for some reason opted not to. It seems a bit trickier than I first
expected, but I might just be dense. ;)

-Eric

