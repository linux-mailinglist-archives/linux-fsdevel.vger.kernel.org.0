Return-Path: <linux-fsdevel+bounces-43313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABFA540FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E0016AC6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 03:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12D18DF89;
	Thu,  6 Mar 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RhWqiidL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2JHio1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718E71750;
	Thu,  6 Mar 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230317; cv=none; b=lbm/XMVzYJjh2WDld8Sob93vo9pliQFxh+kf8onv1w7cOAaCBp/gyP86Fd+iPSyw4+bc7UXeeHS+UVTUzo/AXQtTd6Xv9dhmICpD/AQrVBWaWOc1dNugS1+PqaLT7nJ8+N+pzcbE8sQ+tg94Qv7lpCc3TNNNxqHX1vhfnz8ypF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230317; c=relaxed/simple;
	bh=Pxwyzri2GM2yUHUgbYv3Xp1eV72YcYuVv2N42169ACM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7b9C6dRQKvpr7mmqle6JNbbmS1CtAGTivX2f7tGjw9KVGBqb9ra0wm/NP/e1stuP/fDY9HctPUmJXc1LqA5ot7PbR9J3Zmx4ZBhfBD5q3krjwkBtd2+pD7+YjuWskYtk3QhsNcwGBv4yGdKZOJCai7zfQ9YhfJpuArv287lVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RhWqiidL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2JHio1A; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 282FC201CA0;
	Wed,  5 Mar 2025 22:05:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 05 Mar 2025 22:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741230314;
	 x=1741233914; bh=RV6FGVU5EOhEOsaf3C+TNkQPc3d03MQkNh9/s6KmRAE=; b=
	RhWqiidLc3gF08m6v3BILp4u0ieOBjpHpxoWQimzo7ohCj2HVHm0znYzZlbsug8H
	doXU8xcrfnxWr1GNvmEgz5ZVryMEt90JyhUY97sV0cb7c8HWXccPXB/cYAt2gToZ
	MM8SlJFcCHcR4u5Keculyek8yDyNq3Aj3Vkd4xKBlZzpOCiQvcO46btRQRDMQTCT
	9D+u9Fs9EN5son27tLFc9Rt0rKPFFEqG5gGUni8M7J9Jc6Z5z7mVeLng3DptFFhf
	vLMhjKyn9rX8SzGZ2rb+1s33Vqf36bX8brtpgBUkBhauScdKc1kuMFdPbYN5Xf8Y
	fRhX4T2t82L7epNcvFsNsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741230314; x=
	1741233914; bh=RV6FGVU5EOhEOsaf3C+TNkQPc3d03MQkNh9/s6KmRAE=; b=b
	2JHio1AFI0Z4nKJFT1VgUB4eEFjssulSQqbSnOnNPk3O6JjBe70ty8B8YRTYbd4V
	dyjSRAJGu9+uIc2nVRVHyAHFKP0trwV3AlNPFrgFeTqW2IvInMC688YMKaSEk12h
	+WPBJJzdhhIykkdvmlHjz8qhFJAc+FYVDJx1zTcgl/UrOlbUp9qENeDGD1207Uoa
	hc4QItHNRqCcaL0Z6b7PMlun1YFHvyh9KRSvDSLbUxWalnpEY6x/FreSFr0TJOTp
	/r9NaJLIVZ3bHU0xZyuucZmI0S/UChVsX1hpKCWhzE/aKPr2iZ6hK3rxQcf7lJO6
	AIYcoFOhgeGEpfG+NsixQ==
X-ME-Sender: <xms:6RDJZ7hJZlsyOa6wwd9nkpdYsGPL9MNCeCQo44ZvYgla1ik1Uj_nig>
    <xme:6RDJZ4DPXp4FeiKsnyvtCm1z3LgugFMXoaLPxK6DKs02q6hrlH9YKbZZexfZFivix
    89fMcKnUDz_iIPZlMQ>
X-ME-Received: <xmr:6RDJZ7GxK949goqpO6J9jdQji878udN7ed-oxYBdZzKb7yhFkGuodys9GDh48BHUWzmyr9FtVzOpZAhMfx3deNX4UVJfPrw8oaLDGq5K-Tdr3pfp5WTy9WHQ9eI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepudekvefhgeevvdevieehvddvgefhgeelgfdugeeftedv
    keeigfeltdehgeeghffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgvphhnohhpsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:6RDJZ4QaT2xkkR60vUK8Kdq3pR5VQmPsjDR8j25tClMSL4CxkSOMcQ>
    <xmx:6RDJZ4ymdFUY6kfOm6uQoNqKO2FaYvt-dID7GN1MRqPquvbcqrIKow>
    <xmx:6RDJZ-5NQ6KyJ-Bc3NeO65x5OgGibVrtuIHZnAfOd2PCxmg0xAIqqw>
    <xmx:6RDJZ9yTsTx2x79eUf52Yhj4zckIXaU799LKuWnkBQUK6iEU55YPJQ>
    <xmx:6hDJZ3rEJqf_ld5PzwHfRRBIpnYOMcAD0edfJUv97Qh43LXUAHPt_rBL>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 22:05:11 -0500 (EST)
Message-ID: <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
Date: Thu, 6 Mar 2025 03:05:10 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
Content-Language: en-US, en-GB
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250304.eichiDu9iu4r@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 19:49, Mickaël Salaün wrote:
> On Tue, Mar 04, 2025 at 01:13:01AM +0000, Tingmao Wang wrote:
[...]
>> +	/**
>> +	 * @cookie: Opaque identifier to be included in the response.
>> +	 */
>> +	__u32 cookie;
> 
> I guess we could use a __u64 index counter per layer instead.  That
> would also help to order requests if they are treated by different
> supervisor threads.

I don't immediately see a use for ordering requests (if we get more than 
one event at once, they are coming from different threads anyway so 
there can't be any dependencies between them, and the supervisor threads 
can use timestamps), but I think making it a __u64 is probably a good 
idea regardless, as it means we don't have to do some sort of ID 
allocation, and can just increment an atomic.

>> +};
>> +
>> +struct landlock_supervise_event {
>> +	struct landlock_supervise_event_hdr hdr;
>> +	__u64 access_request;
>> +	__kernel_pid_t accessor;
>> +	union {
>> +		struct {
>> +			/**
>> +			 * @fd1: An open file descriptor for the file (open,
>> +			 * delete, execute, link, readdir, rename, truncate),
>> +			 * or the parent directory (for create operations
>> +			 * targeting its child) being accessed.  Must be
>> +			 * closed by the reader.
>> +			 *
>> +			 * If this points to a parent directory, @destname
>> +			 * will contain the target filename. If @destname is
>> +			 * empty, this points to the target file.
>> +			 */
>> +			int fd1;
>> +			/**
>> +			 * @fd2: For link or rename requests, a second file
>> +			 * descriptor for the target parent directory.  Must
>> +			 * be closed by the reader.  @destname contains the
>> +			 * destination filename.  This field is -1 if not
>> +			 * used.
>> +			 */
>> +			int fd2;
> 
> Can we just use one FD but identify the requested access instead and
> send one event for each, like for the audit patch series?

I haven't managed to read or test out the audit patch yet (I will do), 
but I think having the ability to specifically tell whether the child is 
trying to move / rename / create a hard link of an existing file, and 
what it's trying to use as destination, might be useful (either for 
security, or purely for UX)?

For example, imagine something trying to link or move ~/.ssh/id_ecdsa to 
/tmp/innocent-tmp-file then read the latter. The supervisor can warn the 
user on the initial link attempt, and the shenanigan will probably be 
stopped there (although still, being able to say "[program] wants to 
link ~/.ssh/id_ecdsa to /tmp/innocent-tmp-file" seems better than just 
"[program] wants to create a link for ~/.ssh/id_ecdsa"), but even if 
somehow this ends up allowed, later on for the read request it could say 
something like

	[program] wants to read /tmp/innocent-tmp-file
	    (previously moved from ~/.ssh/id_ecdsa)

Maybe this is a bit silly, but there might be other use cases for 
knowing the exact details of a rename/link request, either for 
at-the-time decision making, or tracking stuff for future requests?

I will try out the audit patch to see how things like these appears in 
the log before commenting further on this. Maybe there is a way to 
achieve this while still simplifying the event structure?

> 
>> +			/**
>> +			 * @destname: A filename for a file creation target.
>> +			 *
>> +			 * If either of fd1 or fd2 points to a parent
>> +			 * directory rather than the target file, this is the
>> +			 * NULL-terminated name of the file that will be
>> +			 * newly created.
>> +			 *
>> +			 * Counting the NULL terminator, this field will
>> +			 * contain one or more NULL padding at the end so
>> +			 * that the length of the whole struct
>> +			 * landlock_supervise_event is a multiple of 8 bytes.
>> +			 *
>> +			 * This is a variable length member, and the length
>> +			 * including the terminating NULL(s) can be derived
>> +			 * from hdr.length - offsetof(struct
>> +			 * landlock_supervise_event, destname).
>> +			 */
>> +			char destname[];
> 
> I'd prefer to avoid sending file names for now.  I don't think it's
> necessary, and that could encourage supervisors to filter access
> according to names.
>

This is also motivated by the potential UX I'm thinking of. For example, 
if a newly installed application tries to create ~/.app-name, it will be 
much more reassuring and convenient to the user if we can show something 
like

	[program] wants to mkdir ~/.app-name. Allow this and future
	access to the new directory?

rather than just "[program] wants to mkdir under ~". (The "Allow this 
and future access to the new directory" bit is made possible by the 
supervisor knowing the name of the file/directory being created, and can 
remember them / write them out to a persistent profile etc)

Note that this is just the filename under the dir represented by fd - 
this isn't a path or anything that can be subject to symlink-related 
attacks, etc.  If a program calls e.g.
mkdirat or openat (dfd -> "/some/", pathname="dir/stuff", O_CREAT)
my understanding is that fd1 will point to /some/dir, and destname would 
be "stuff"

Actually, in case your question is "why not send a fd to represent the 
newly created file, instead of sending the name" -- I'm not sure whether 
you can open even an O_PATH fd to a non-existent file.

>> +		};
>> +		struct {
>> +			__u16 port;
>> +		};
>> +	};
>> +};
>> +
> 
> [...]


