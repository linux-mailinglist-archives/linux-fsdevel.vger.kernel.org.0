Return-Path: <linux-fsdevel+bounces-3273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB437F22AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E421C21650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9B185F;
	Tue, 21 Nov 2023 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="v1yEOt4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A28uO3lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDD91;
	Mon, 20 Nov 2023 16:58:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 925595C08FE;
	Mon, 20 Nov 2023 19:58:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 Nov 2023 19:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700528334; x=1700614734; bh=V+uiXlKPvNiSTddVjBYykRHs2cpkUMtUO9f
	attfUkdY=; b=v1yEOt4gnlEQrivyQwP3ZY95Ms11uhGl1TurWuaSnyAmzdPCQUM
	DkZDOXX3ERnlKhrTkigZfd35v1PiYv3q6+cY4VsqkyV+lt0c+e8kw1yo50o1XwRt
	t3v8XrZppNt7cALQd/uiq/N84sR/+AbH0LrPl4wM6ZBiVuA9Bl/6sWep8uWnFijj
	BJCe73UHw0O0IX6FP976puwDAnIip/kRjbeQCqv+HWnR6L1z7JO4IWAHEYGcUhuU
	CZurn2fxJZVDKwGE9VaLubsX8GoR/cIskAE7X9jWwSG7mMFJGj4VMnX9jKHv+KvH
	i4sdy/7fMirYbiW+Y4k7JJ/jGjrssSI4P1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700528334; x=1700614734; bh=V+uiXlKPvNiSTddVjBYykRHs2cpkUMtUO9f
	attfUkdY=; b=A28uO3ltBUV/O2YSABG7oN9i5ukIwzLRoX4n8JxbRCDi+ogVdS1
	jZ8K/aI6LOoQQpXpJBGzt8t6W+vztioh8P92xivcz/ex6glmlzXMeB0NK3BbTZyp
	PlylwKjLWMC0LXecW4PzMvSjiQOct8UzI6rigN7Hy9HL76OKgDipoND1g8qGrDIp
	qrnzNliK2CxqpzrxxMT0CbIIcLRWCnozrKd4O/K5fk87KtkZdUH+rMYd/fz5/yFN
	AF6E+O9A0UsfEGUDAfRA0embYQbGhF3ss2zYx4oPPpwUOa1ROP6Aqpicvbp2p8D6
	JOH/Q5Mr4b9VGDjNYmC8RYDQsEN/sq2iqhA==
X-ME-Sender: <xms:zgBcZUSAW0zyQFEpnO_8lhED1scIY1B_ZsRcQR8JMZGdb9pjh0vV_A>
    <xme:zgBcZRzR2DYw-hktv59IlWIBPI6xsN3me0kmQwcUkhVqM6bXPi3n3vg0DXOPQYxsh
    u00V1k6wIWd>
X-ME-Received: <xmr:zgBcZR2JYCuFCnkgizmtpldGu7B3T_S87p2gvAvvv6YyHmrwAOFtrdBtMtGov3zsUgHAnHRLaHm2R-y6tqes6aL0anSrx0keyvbSdqU57UAQAMSyuV9qVn1b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:zgBcZYDb6QS0jvb4PH_mMgfhaiHvD73L74InZHVsU9IqOr8pvvdflg>
    <xmx:zgBcZdg5C8ki3U2EDpkRCqsNLQu49heLXiaGZovAykdP93-BOtJaVA>
    <xmx:zgBcZUpNxtMEnoG5U6cMQFu7ttmzSE9orjCrTDfosDn_cAyU_NlkQw>
    <xmx:zgBcZSbyk-g-1F-fnFJAlH7GlF9ZQ9ABczU_SgDpgwHfy8PbCzSLoA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 19:58:48 -0500 (EST)
Message-ID: <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
Date: Tue, 21 Nov 2023 08:58:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposed libc interface and man page for statmount(2)
Content-Language: en-US
To: Ian Kent <ikent@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>,
 Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
 <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/23 07:56, Ian Kent wrote:
> On 20/11/23 20:34, Miklos Szeredi wrote:
>> On Mon, Nov 20, 2023 at 01:16:24PM +0100, Florian Weimer wrote:
>>> Is the ID something specific to the VFS layer itself, or does it come
>>> from file systems?
>> It comes from the VFS.
>>
>>
>>> POSIX has a seekdir/telldir interface like that, I don't think file
>>> system authors like it.  Some have added dedicated data structures for
>>> it to implement somewhat predictable behavior in the face of concurrent
>>> directory modification.  Would this interface suffer from similar
>>> issues?
>> The same issue was solved for /proc/$$/mountinfo using cursors.
>
> The mounts are now using an rb-tree, I think the the cursor solution can
>
> only work for a linear list, the case is very different.
>
>
>>
>> This patchset removes the need for cursors, since the new unique 
>> mount ID can be
>> used to locate the current position without having to worry about 
>> deleted and
>> added mounts.
>
> IIRC the problem with proc mounts traversals was because the lock was 
> taken
>
> and dropped between reads so that mount entries could be deleted (not 
> sure
>
> adding had quite the same problem) from the list in between reads.
>
>
> Sounds like I'll need to look at the code but first though but an rb-tree
>
> can have mounts removed and new mounts inserted if the locks are dropped
>
> if the retrieval is slit between multiple calls.
>
>
> So I'm struggling to see why this isn't the same problem and I don't 
> think
>
> introducing cursors in this case would work (thankfully, lets do this 
> again
>
> please).

Mmm ... apologies for the poor description above.

That last bit is definitely "lets 'not' do this again please!"


Ian


