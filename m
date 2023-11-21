Return-Path: <linux-fsdevel+bounces-3275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D147F231B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03B61F25392
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933A7469;
	Tue, 21 Nov 2023 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="fwwlqwjJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAHuVFE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C379CA2;
	Mon, 20 Nov 2023 17:33:46 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A54CD5C14AE;
	Mon, 20 Nov 2023 20:33:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Nov 2023 20:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700530423; x=1700616823; bh=R8SiaLMulONYSs7gpNiz/SIhkos3i9d3i6m
	xfRPyilU=; b=fwwlqwjJcZvWK43sMcTfBsEtIn7Oi6hyJAtEsIDiEReSAtHgWyv
	z8MAo+ey07qHQzjF5TPbU1PpN2UuKaGMMbI+zkSsQ3ebZIW3HtUETLIzQNUypuzX
	uN41JtTqupfYEtOF/Q88PRwh7Vp3qlu6dVsVdkjRTX4No/ctvEufBBOKZOypesz1
	z8HSHyBuW9ny1MnA5gSFsVZWySTD0kJw+0DsuB0Ts9C/2JODj3CZUve/e6Y68fGU
	19X+duwCtA3TiMvKSySMsT2hq7eIaTHTrSAD0DqD+sdJAvljZsXlJ800MeNb+8JG
	G/QMdygkn1rnrpD6qYQxJfeeaQna5QnIKyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700530423; x=1700616823; bh=R8SiaLMulONYSs7gpNiz/SIhkos3i9d3i6m
	xfRPyilU=; b=oAHuVFE16KCWNKxT43dcCLNPA90ggCPOQrp7pqviNBOshIRjUal
	5gs9jL/ciUKqVBgQonnxAT6tQSK4dA02WNjcFaxUoNbeJhYkHbXGOtwpSIEmEVgg
	ncEV7kuNTTd4Zgr+Vya2E1DEA1vJpsu3CjPRN2UuJU1LaQLViK2TPayUNcHIjGAb
	or0G7PxlGqOZkIPFtWj0Ks5UkmA01jL4FI3Dnwvo4KTidkSroEk5i11YHT4O/6Pr
	mCby9g33nIxyeMPAfRVfty+VXo7n6ULJktHcslgXKHOOdOrbHlJeAp4cxOQKyUo1
	Ttdb00G+QSXbpoy42U5D7Z6GZdo6L5KE71A==
X-ME-Sender: <xms:9whcZeJMUN4c5zbHV6-ZwBmmvMcp4XT8Pl3rS89AJntg5egs8E3M1w>
    <xme:9whcZWLkkfHreW8lLgyDyr49SMATh2XnvfsKmOHcaQ1V8eN77FaaqZSEasf_WWbtw
    qeoHQpJdqGd>
X-ME-Received: <xmr:9whcZeuhBmz5g978xaMvRJWai3AdMZypVhg7IUzuc7t_LOyHhkTboxDBWbsBu-YP0mH4qla4s3jcTPBz4_Mmj6hoo6wI86JDGFjKJ-yc3wZaAyL3WoVcTMPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epueejtdffffeuheefgfdvfeekudffvdejveevudekveevkeehtdehgeekueejvdevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:9whcZTZ_00dROH52eLHhmf91O8btLTmoKOgGTMXFPW5woMmSrxl--g>
    <xmx:9whcZVZyY--mucY0bXIIFsJI2syrCo6M1bqgTj9iLeT6dhlUosT3Eg>
    <xmx:9whcZfCOP8JGHvdtHMQR-unGIB4-4iZ-TnfW2TC1r1hWtB6rxBJYVQ>
    <xmx:9whcZSRGgy5pckhtQBIctrxXupGmSaMTxO2x9VCrPxM1oxtB0x3IzA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 20:33:38 -0500 (EST)
Message-ID: <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
Date: Tue, 21 Nov 2023 09:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
 <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
From: Ian Kent <raven@themaw.net>
Subject: Re: proposed libc interface and man page for statmount(2)
In-Reply-To: <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/23 09:12, Ian Kent wrote:
> On 21/11/23 08:58, Ian Kent wrote:
>> On 21/11/23 07:56, Ian Kent wrote:
>>> On 20/11/23 20:34, Miklos Szeredi wrote:
>>>> On Mon, Nov 20, 2023 at 01:16:24PM +0100, Florian Weimer wrote:
>>>>> Is the ID something specific to the VFS layer itself, or does it come
>>>>> from file systems?
>>>> It comes from the VFS.
>>>>
>>>>
>>>>> POSIX has a seekdir/telldir interface like that, I don't think file
>>>>> system authors like it.  Some have added dedicated data structures 
>>>>> for
>>>>> it to implement somewhat predictable behavior in the face of 
>>>>> concurrent
>>>>> directory modification.  Would this interface suffer from similar
>>>>> issues?
>>>> The same issue was solved for /proc/$$/mountinfo using cursors.
>>>
>>> The mounts are now using an rb-tree, I think the the cursor solution 
>>> can
>>>
>>> only work for a linear list, the case is very different.
>>>
>>>
>>>>
>>>> This patchset removes the need for cursors, since the new unique 
>>>> mount ID can be
>>>> used to locate the current position without having to worry about 
>>>> deleted and
>>>> added mounts.
>>>
>>> IIRC the problem with proc mounts traversals was because the lock 
>>> was taken
>>>
>>> and dropped between reads so that mount entries could be deleted 
>>> (not sure
>>>
>>> adding had quite the same problem) from the list in between reads.
>>>
>>>
>>> Sounds like I'll need to look at the code but first though but an 
>>> rb-tree
>>>
>>> can have mounts removed and new mounts inserted if the locks are 
>>> dropped
>>>
>>> if the retrieval is slit between multiple calls.
>>>
>>>
>>> So I'm struggling to see why this isn't the same problem and I don't 
>>> think
>>>
>>> introducing cursors in this case would work (thankfully, lets do 
>>> this again
>>>
>>> please).
>>
>> Mmm ... apologies for the poor description above.
>>
>> That last bit is definitely "lets 'not' do this again please!"
>
> IMHO keeping it simpler is much better.
>
>
> The interface where a buffer is passed and overflow returns an error 
> so that one
>
> can retry is far simpler and the in-kernel simplification of taking 
> the lock over
>
> the whole retrieval is far less problematic.
>
>
> If there's anything that could be useful then it's keeping a count of 
> the mounts
>
> in a given namespace (I think we have such a count in nsproxy struct 
> already) and
>
> adding a way to get that for storage needs estimation.

I've completely lost what we are talking about.


I think it was the introduction of listmount() earlier so my comment does

apply to that but it's getting just mount ids so the allocation isn't huge

even for a large number of mounts so I don't think there's a need for

complexity.


Then statmount() is retrieving the info for a single mount id, that's quite

specific info. and not that hard to estimate the needed allocation so the

error return and retry does seem like the most sensible thing.


The fact is that getting a list of mount ids and then working through them

meant you would be working with an outdated mounts list almost all the time.

That's nothing new for what this is used for and is sufficiently functional.


There are times when you do need a specific mount, such as SIGCHLD 
processing,

but then we are working with a specific mount id so it's not a problem.


>
>
> Ian
>
>

