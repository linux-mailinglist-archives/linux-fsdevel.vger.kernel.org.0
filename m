Return-Path: <linux-fsdevel+bounces-2202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7B7E3260
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65B4280E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 00:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5E17C7;
	Tue,  7 Nov 2023 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="v9rKkBwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmup3Y5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744701371;
	Tue,  7 Nov 2023 00:47:40 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533AD73;
	Mon,  6 Nov 2023 16:47:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A7395C01D7;
	Mon,  6 Nov 2023 19:47:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 Nov 2023 19:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1699318058; x=1699404458; bh=Gw31p/x43vdxiXCzPMnjFbRQKL2XYHOsIr+
	oWsxF2fE=; b=v9rKkBwnmH7u2D6mnOMCHaBPLBJuhu9S05QWFAghJ//bAemz5mX
	u+Sgb0+89MKBk88i1MvG6ljOtiSO9x1laCK255CqLbTulXp5XZ6FRjjYqxItQO1d
	5XwS5X/PUpqavceoga483BlhWEYYjpT82LS1DgErRTDP7OiCewsbhlFzE1hGZJ1+
	bzGqHwMIJtYudPo3ZKCW0nWPKbwgIAsKdXArlTNKISMJHxMFFmzus1BvagsW9e/8
	VBTvYXAyPeDCBEQd+2tasxzFcKENGcTgsrjOy4x2F0ONprB6UcZiQ0JWS08jgkoO
	xIY1VeGPD8ROAfWOZYNIMiVYjnGhyZuba7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699318058; x=1699404458; bh=Gw31p/x43vdxiXCzPMnjFbRQKL2XYHOsIr+
	oWsxF2fE=; b=jmup3Y5HBcICiD1KQbIbvzVxrdjy9eaXo+HcZ84ibyxib+YguY7
	ULBSRIKZW6U7/Gv8FUFkNllD56PosjlJtlmGFzVmn0d7y9FXAgomrdhW4RJHy/+o
	8USkFc6msw5HHv98/GEwTZXdjGFibLV1eYar0eQo3jpZ9+rVnDyBvBh0iGRYMW1n
	1Gi22//9pVSh5XIOFcGYKjH+Zr7xaDtmDuANVp4Cxif0dKllzUpu7TeEPuqDngFO
	3y/DSNOVYswZey1uzVsBRIXlZpPWeJLa3NFrYnT+9NEpVROD5Pf+sBMQhczGyvxu
	iNtF2+6iejteUkdCAzRVXLcNb5TBHxe9DsA==
X-ME-Sender: <xms:KYlJZSn2GMl7lZoOytKsohSBpZd4CoU_j7Kiij0BrS9fvMwADn7FpA>
    <xme:KYlJZZ3Bi9BBC8BMQG9xsK6DO0M6a-GUv58JRVqXAPqNggfW0sPUNa3GEb0hwlFHP
    ZAV0JIj1m7N>
X-ME-Received: <xmr:KYlJZQrWkPVg9-zRZh4JD1CMQjof8rM54mLpdo_Cu83ts6h0plR0e4H5kxxeakytFC6EPhAqEEXCtG4DbKmlhxQ77AxamF1XcuZVNLWVkI4vKVoNbn_aUU-a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epteeghedvkeejveejuedvtdekuedtueehtdegjeeugefhleetjeevkedutdeifeefnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:KYlJZWmKE_EgFpNkaecPme3J6_woVt_PJFByzbx7sXNvNbp9CV0IPA>
    <xmx:KYlJZQ0JvBbpYyNyqIbkeP3KL7uZTglrrYglujg2brgeocWoziNIZA>
    <xmx:KYlJZdskFL3TGnhj3uPwOOHB2b0kMfKCb4g68ft9_eN12wzP0662BQ>
    <xmx:KolJZWPArFE97B2nyzH5ql1dCANx0HEKVzghE75YW9--K5O8wUX_qg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 19:47:32 -0500 (EST)
Message-ID: <8f14da98-f2f5-b9ba-8d24-1b22eaa3c0d6@themaw.net>
Date: Tue, 7 Nov 2023 08:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Matthew House <mattlloydhouse@gmail.com>, Florian Weimer
 <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
 <20231106121053.egamth3hr7zcfzji@ws.net.home>
 <CAOQ4uxgn--PshKxMDmM4YoDQ8x3+a0NwCv+Bppjq-3w9V+Sxpg@mail.gmail.com>
From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v4 0/6] querying mount attributes
In-Reply-To: <CAOQ4uxgn--PshKxMDmM4YoDQ8x3+a0NwCv+Bppjq-3w9V+Sxpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/23 21:33, Amir Goldstein wrote:
> On Mon, Nov 6, 2023 at 2:11 PM Karel Zak <kzak@redhat.com> wrote:
>> On Wed, Nov 01, 2023 at 07:52:45PM +0800, Ian Kent wrote:
>>> On 25/10/23 22:01, Miklos Szeredi wrote:
>>> Looks ok to me,covers the primary cases I needed when I worked
>>> on using fsinfo() in systemd.
>> Our work on systemd was about two areas: get mount info (stat/listmount()
>> now) from the kernel, and get the mount ID from notification.
>>
>> There was watch_queue.h with WATCH_TYPE_MOUNT_NOTIFY and struct
>> mount_notification->auxiliary_mount (aka mount ID) and event subtype
>> to get the change status (new mount, umount, etc.)
>>
>> For example David's:
>>   https://patchwork.kernel.org/project/linux-security-module/patch/155991711016.15579.4449417925184028666.stgit@warthog.procyon.org.uk/
>>
>> Do we have any replacement for this?
>>
> The plan is to extend fanotify for mount namespace change notifications.
>
> Here is a simple POC for FAN_UNMOUNT notification:
>
> https://lore.kernel.org/linux-fsdevel/20230414182903.1852019-1-amir73il@gmail.com/
>
> I was waiting for Miklos' patches to land, so that we can report
> mnt_id_unique (of mount and its parent mount) in the events.
>
> The plan is to start with setting a mark on a vfsmount to get
> FAN_MOUNT/FAN_UNMOUNT notifications for changes to direct
> children of that mount.

I'll have a look at what I needed when I was working to implement

this in systemd. Without looking at the code I can say I was

handling mount, umount and I think remount events so that's probably

a minimum.


As I mentioned earlier I found I also need event rate management

which was a new requirement at the time.


>
> This part, I was planning to do myself. I cannot say for sure when
> I will be able to get to it, but it should be a rather simple patch.
>
> If anybody else would like to volunteer for the task, I will be
> happy to assist.

I would like to help with this but I'm not familiar with fanotify

so I'll need to spend a bit of time on that. I am just about in

a position to do that now.


I'll also be looking at the watch queue framework that did get merged

back then, I'm not sure how that will turn out.


>
> Not sure if we are going to need special notifications for mount
> move and mount beneath?

Yes that will be an interesting question, I have noticed Christians'

work on mount beneath.


We need to provide the ability to monitor mount tables as is done by

using the proc mount lists to start with and I'm pretty sure that

includes at least mount, umount and moves perhaps more but I'll check

what I was using.


>
> Not sure if we are going to need notifications on mount attribute
> changes?

Also an interesting question, we will see in time I guess.


You would think that the mount/umount/move events would get what's

needed because (assuming mount move maps to remount) mount, umount

and remount should cover cases were mounted mount attributes change.


>
> We may later also implement a mark on a mount namespace
> to get events on all mount namespace changes.

Monitoring the proc mount tables essentially provides lists of mounts

that are present in a mount namespace (as seen by the given process)

so this is going to be needed sooner rather than later if we hope to

realize improvements from our new system calls.


Ian


