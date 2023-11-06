Return-Path: <linux-fsdevel+bounces-2198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619F7E31AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 00:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95641C209BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85B2FE2B;
	Mon,  6 Nov 2023 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="PyL1Jfvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFt5nt/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909ADF6B;
	Mon,  6 Nov 2023 23:54:32 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C492;
	Mon,  6 Nov 2023 15:54:31 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 200DC5C02C6;
	Mon,  6 Nov 2023 18:54:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Nov 2023 18:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1699314868; x=1699401268; bh=HjuTB2ZqQlpPXSscXp7JtGyUNag93Pd3K89
	gUaElrPo=; b=PyL1JfvmQ/875enNsiwOsImOIQXperWC2yEcpljNcOJx+IRw/Y1
	84yCz72SDaBz+5U7Cj5CRwGzIfpCPUifcsvf1/BqQnHZcpAbrh1zOdqHWi5QmiE0
	l8V5mvuKbbOktjNHdHbnCzMJNam9aqKKglFj1SBTB3sRIHJAtYGzbLeThVv135L0
	QndK0FDu88DYtJXmWTayoE5pC9LuuaiREaPSmBSSGCPejbu4a3OXl3aJwGmvrKiW
	aYe9yJ/LLuc5YAp9zv/IZcZkYqS/3IPkWMCb4rvOntTHPQ/axCeArGl3rbKuj7Gr
	T2I5JSVlcH077uZ6cH9+ejZjWGj3DnhvbNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699314868; x=1699401268; bh=HjuTB2ZqQlpPXSscXp7JtGyUNag93Pd3K89
	gUaElrPo=; b=TFt5nt/J39u226/EEwpygyAGnpRQddFZFDThMRPbeukSHon1934
	eh+S5S9Sa4K1VpoyckmUOr7kZEBP31ivrOEGI3NTT8XA2WP48eU29SYzi+eS1boN
	zbOiB6f31i7ooAFqEhF8LaFXBh5lHLgwPbEC38KPRSMTV8pIQMFPHkHbhGDDOmmc
	vjqkUIJ7WKw5VePksFHI/38HSyw0RcJF09z1srUGTK0vp7y1g940mc3SprQK/LT4
	lP/ofXtyhyZPkrDozB3lrE12bEvaL+r2dkRIKqk9+D1TTj0nUj00kfaSaYBe3fLI
	hxLjg9XRc6h3XCO3j7kU8Sd093trsONCM8w==
X-ME-Sender: <xms:s3xJZTSuBpvI0O1JC34EeeOgSQ5I7dECzAHPvDamMPt3pp9_fo5pGg>
    <xme:s3xJZUwAQfpUdzbPUq2-ba9V3FnsLJjb_KPl0FEUWYcvtauSBhXdZWAMi_MaSqE2B
    Zbpk-CFriRu>
X-ME-Received: <xmr:s3xJZY3AYRmvZpxihu5ql8_5aww_EFA9159cDl6Mu7bTeHEtCFnYR7YFbDD7kvryuIenibJNmYU_tgzww7Ecu4HdOWwXI7XueTpPx1a4JV7wugk_us6CZ0S5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    eptdekveelhfeuudetjedufedvtdfgveehgedugeelvedvhfejiedtudduiefgteelnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:s3xJZTAWfa50lbE6RN6VmRRCm0qXuYaAkBvNoN8T8SOzLoRtRC0QDQ>
    <xmx:s3xJZchWtf0LL_uK7tUj47ZxWxE_w4T3qu68WX6slj4S02XQs8KGIA>
    <xmx:s3xJZXo_dOOXr5MIoIKLRXU_7IH84hFoffFeL7OBsCLou4jRMY1xZQ>
    <xmx:tHxJZdZCHtlVJjMXHINnkZaOgijP_-f5q73D5MGnndrmDEeU_WO_DA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 18:54:22 -0500 (EST)
Message-ID: <c9131c2f-da31-22ac-e99a-773e4282f627@themaw.net>
Date: Tue, 7 Nov 2023 07:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
 <20231106121053.egamth3hr7zcfzji@ws.net.home>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v4 0/6] querying mount attributes
In-Reply-To: <20231106121053.egamth3hr7zcfzji@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/23 20:10, Karel Zak wrote:
> On Wed, Nov 01, 2023 at 07:52:45PM +0800, Ian Kent wrote:
>> On 25/10/23 22:01, Miklos Szeredi wrote:
>> Looks ok to me,covers the primary cases I needed when I worked
>> on using fsinfo() in systemd.
> Our work on systemd was about two areas: get mount info (stat/listmount()
> now) from the kernel, and get the mount ID from notification.
>
> There was watch_queue.h with WATCH_TYPE_MOUNT_NOTIFY and struct
> mount_notification->auxiliary_mount (aka mount ID) and event subtype
> to get the change status (new mount, umount, etc.)
>
> For example David's:
>   https://patchwork.kernel.org/project/linux-security-module/patch/155991711016.15579.4449417925184028666.stgit@warthog.procyon.org.uk/
>
> Do we have any replacement for this?

Not yet.


I tried to mention it early on but I don't think my description

conveyed what's actually needed.


>
>> Karel, is there anything missing you would need for adding
>> libmount support?
> Miklos's statmount() and listmount() API is excellent from my point of
> view. It looks pretty straightforward to use, and with the unique
> mount ID, it's safe too. It will be ideal for things like umount(8)
> (and recursive umount, etc.).

Thanks Karel, that's what I was hoping.


>
> For complex scenarios (systemd), we need to get from the kernel the
> unique ID's after any change in the mount table to save resources and
> call statmount() only for the affected mount node. Parse mountinfo
> sucks, call for(listmount(-1)) { statmount() } sucks too :-)

I have been looking at the notifications side of things.


I too need that functionality for the systemd work I was doing on

this. There was a need for event rate management too to get the

most out of the mount query improvements which I really only

realized about the time the work stopped. So for me there's

some new work needed as well.


I'm not sure yet which way to go as the watch queue implementation

that was merged is just the framework and is a bit different from

what we were using so I'm not sure if I can port specific extensions

of David's notifications work to it. I'm only just now getting to a

point where I can spend enough time on it to work this out.


Ian


