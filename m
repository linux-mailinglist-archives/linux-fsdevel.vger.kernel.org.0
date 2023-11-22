Return-Path: <linux-fsdevel+bounces-3451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4407F4C23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFF21C209D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00256B9A;
	Wed, 22 Nov 2023 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="H5YWLcXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKRRZfG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6BA9F;
	Wed, 22 Nov 2023 08:18:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 639495C025D;
	Wed, 22 Nov 2023 11:18:34 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Wed, 22 Nov 2023 11:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700669914; x=1700756314; bh=0N
	7LnLLSIxjD9++FeLj5Mk+TvcxPDSYsacxSthe5NaA=; b=H5YWLcXCNCxOMWjJ6f
	RWt5wIlZrc0ZUJrvy7wSUE5gy25wRlMdf0zYCNxEfZJftOyEx9m5HEakp5XCLInG
	zkesPYLKfpg6IlDay5uz5Fq5LiCvKJvr97Ul/ANsvOotdaYTfvRtsxIq2lPNVqDn
	K5ZvVcuvfNuRkJYiqpjn+ITBgM/rDrETr8PmG3Taw0e3RE9vib4ddEONipMOp9jr
	uJO8J6oA/GoxGNVS7I1vyB0qElbx8BjYbQHVngLeGOc77m2Ftu5YHy9g0anWl9Sc
	I1Ef/sTpsmRBQ60lPpUZR+LGTtp76pihBfpmT2Kvk/3gQim9ddUfyYjqiF53TJjv
	c8YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700669914; x=1700756314; bh=0N7LnLLSIxjD9
	++FeLj5Mk+TvcxPDSYsacxSthe5NaA=; b=nKRRZfG4EH5S6hBLP0zhxB+8BQJRS
	6zEeipyIocf97fNuq7jKY0mlFMWHa0wtH6GRNmSyGFJeM3yEbr2AFBnNMT/y6uJ+
	drM1yPEyFjUgEA0QUoP2PgMOD4GS3Ax6dSCnSqdKj2/wVY8jI4bPBX+MqALFp0Xk
	ZeNF6133McjJbWjAxqZTvbAVHhaEV+ACJgrkRscsXoy/DZX41J1aVQhraoj2rhBz
	dLTSUQSJT7tMqQQyjvCYTZJda8fdgK9se/RemEMl6DHgyzPKoYLWsHNeG7IZza2L
	wRhdVB8eabXisX23aKKBKcUAJo9ScKWIRUwMP7OAOgglNSa1APaIvZYVQ==
X-ME-Sender: <xms:2SleZUn1_RnoI8vd4K4BzPmBATfSR8suOdxsg_9yrF8v8V6-KP3vkQ>
    <xme:2SleZT0iw_CPPHOqRTSkf-Y7Y8fABz5E_6cVwAl9Gjytob0pW6HegNZv8i0iVup-6
    tqGg5PlBU87KyrP8J4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfkggr
    tghkucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfelfeehudfhleegheegjeevheeuieehvdfgueeuteetleeiieet
    heefhfeludeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepiigrtghksehofihlfhholhhiohdrohhrgh
X-ME-Proxy: <xmx:2SleZSq6dEGSeyWkbxhAQCWp999h7KVqDaLvKrgZ0Ovi8UBRU8hq5g>
    <xmx:2SleZQlskA0U79nmoQslkALPhptagEUhwnYAtb-typnrbVcbWDU86g>
    <xmx:2SleZS3aHSp0gv7ZD0DQ4wyMwD3vdPO34-0d9v_4e8UN5PvWO_fRsw>
    <xmx:2ileZfvWicwZfbfvKESNQl5LEoVQF5mfhDMKCtncta0B1dYi7TEipA>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 24293272007B; Wed, 22 Nov 2023 11:18:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a21bcea-ba93-4b3c-b99e-bb9f735c5755@app.fastmail.com>
In-Reply-To: <698dd63e-9cd8-2d22-c4ca-d8138ed97606@redhat.com>
References: 
 <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
 <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
 <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
 <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
 <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
 <c1a2c685-6985-4010-933e-a633be647b49@app.fastmail.com>
 <698dd63e-9cd8-2d22-c4ca-d8138ed97606@redhat.com>
Date: Wed, 22 Nov 2023 11:18:12 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Ian Kent" <ikent@redhat.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Ian Kent" <raven@themaw.net>
Cc: "Florian Weimer" <fweimer@redhat.com>,
 "GNU libc development" <libc-alpha@sourceware.org>,
 'linux-man' <linux-man@vger.kernel.org>,
 "Alejandro Colomar" <alx@kernel.org>,
 "Linux API" <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 "Karel Zak" <kzak@redhat.com>, "David Howells" <dhowells@redhat.com>,
 "Christian Brauner" <christian@brauner.io>,
 "Amir Goldstein" <amir73il@gmail.com>, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Content-Type: text/plain

On Tue, Nov 21, 2023, at 6:28 PM, Ian Kent wrote:
> On 22/11/23 04:42, Zack Weinberg wrote:
>> On Tue, Nov 21, 2023, at 2:42 PM, Miklos Szeredi wrote:
>>> handle = listmount_open(mnt_id, flags);
>>> for (;;) {
>>>      child_id = listmount_next(handle);
>>>      if (child_id == 0)
>>>          break;
>>>      /* do something with child_id */
>>> }
>>> listmount_close(handle)
>>
>> Why can't these be plain old open, read, and close? Starting from a pathname
>> in /proc or /sys. Doesn't allow lseek.
>
> I'm not sure how this would work, there aren't a series of paths in proc
> that represent mounts?

It would be a new one created for this purpose.

listmount_open(mnt_id, flags) ==
   open("/proc/mount_ids", O_RDONLY) +
   ioctl(fd, LISTMNT_QUERY_ID, mnt_id) +
   ioctl(fd, LISTMNT_QUERY_FLAGS, flags)

and then read(fd, buf, sizeof(buf)) gives you sizeof(buf)/sizeof(mntid_t)
mount IDs.

Or, if you prefer, keep the new listmount_open() system call but have it
return a file descriptor that acts like a pipe filled with all the child
mount IDs.  The main point of my suggestion is that listmount_next and
listmount_close can, and should (IMO), just be read() and close().

Note that I'm _not_ suggesting a text-based interface like most of /proc.
What you read is native-endian binary mount IDs.

> One is that open() is a fairly high overhead system call and it so it
> won't cope well with traversing a large volume of mounts.
...
> Second is that, because the mount table lives in a file (actually more
> than one with slightly different formats) it needs to be traversed every
> time one is looking for a mount which has been shown to be high overhead,

Does my clarified explanation address these concerns?

zw

