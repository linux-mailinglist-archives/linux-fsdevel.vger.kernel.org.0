Return-Path: <linux-fsdevel+bounces-3274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC047F22F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA046281F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962C35CAF;
	Tue, 21 Nov 2023 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="g95WT1DG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rf3eWgdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D566BC;
	Mon, 20 Nov 2023 17:12:47 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id DABF45C0AE5;
	Mon, 20 Nov 2023 20:12:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 20 Nov 2023 20:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700529165; x=1700615565; bh=hQ6LSIMI9JojpXHU1pL4rCJ9vV5P1fOwNTs
	de3nw9MM=; b=g95WT1DG5it1PGKDVe//gduLFqz48SodXtCLK2XiMbsyXBjLwBU
	6KGxhWNF/VshZ31mXXyE16+Syqq/DtuGaIoB1WY74B4lvB7LxsCe0DXEEFQfmIBJ
	Ld/4j7piKTEZnu/vQaTKSSwBSnVRA6TZk44GSubBHusZ6/cw+rFYdvRtW8ZF3gJA
	NkproMlJKMBq+Csv6fvB6n4HOTydGBUcouiLUlWNkeMSOwatn2lapc7afGSgAIiV
	HZAevrBkTRUVh72/5gYXTBBpDXsiD4rV3J3PBxlA6I6TwORv3RdbIlENoGixA2JT
	mRBb30Ry2ka6w+9ew6Z2ovbxz+ho5keAdcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700529165; x=1700615565; bh=hQ6LSIMI9JojpXHU1pL4rCJ9vV5P1fOwNTs
	de3nw9MM=; b=rf3eWgdRWucatQDu3IySA97TVfxtyhxagJ/+SgpwtB57/JSNvgJ
	cptXe7C5K7o+vkAGZfpNwO9keLtKUWhdRsMQAqTPCIa15ByUUfcm6hLIAyOJt6h5
	PZEX0cOqiLrfpgXB+UNMurtqYHuhzKtLpB0I7rGZRemX+PzIXkd85Ff625lghVBT
	W4mL42UcMZBkdODw73MGhXT/5qAte5UxWS1iD/0jj42O15I9nkQ/x3k6xaJ77Q9d
	RDmM3oPGDtwBHDnj+eHprfcnT0Yqywv6SO5d8UKs4jCA19g4gTglVG3GWwZEcXZi
	ow94udOyWe08VvFYOBXhTgvxcPiZ1SoAf1Q==
X-ME-Sender: <xms:DQRcZcwrvXKS6PmTnbimQfqdb0l_--UcMwpGRsLRXGTdfrqFYxUwGQ>
    <xme:DQRcZQQK61-yK0RaT9ROmQt3rW_0GCvnpRHPPm6vIKDzEbL0FjjC45kNNbx3DrFG7
    sro9d0iMbj2>
X-ME-Received: <xmr:DQRcZeUzI61p9yb5L-xRTwv2YhSq3Mp0ADxxMvSW4bpo9s0PeVTKdNFqsw3GoHlDAmkRkVoT_euqgkjjxI15j4HpH0F2FYHvJGKZ-qRnBasRXAtliOyU95hB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epueejtdffffeuheefgfdvfeekudffvdejveevudekveevkeehtdehgeekueejvdevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:DQRcZahCnAoDHpRZOguqTd26TqBjpbgR7mEq7u9drldjwR73wOhxEg>
    <xmx:DQRcZeAVj0fEKrQOed-DBWnmLeBhDyk8FYM1wmedgGRJk63pKPMfPw>
    <xmx:DQRcZbIs-vCX5ydFNPnhjAR-StdaseLaZcTmh8wlQD-8L9-yWrIVsw>
    <xmx:DQRcZS7gZsNuOksxxOeYOkAQL1QFamjF4sghDhi7LrAxaFZvFhyJ4A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 20:12:40 -0500 (EST)
Message-ID: <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
Date: Tue, 21 Nov 2023 09:12:37 +0800
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
From: Ian Kent <raven@themaw.net>
Subject: Re: proposed libc interface and man page for statmount(2)
In-Reply-To: <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/23 08:58, Ian Kent wrote:
> On 21/11/23 07:56, Ian Kent wrote:
>> On 20/11/23 20:34, Miklos Szeredi wrote:
>>> On Mon, Nov 20, 2023 at 01:16:24PM +0100, Florian Weimer wrote:
>>>> Is the ID something specific to the VFS layer itself, or does it come
>>>> from file systems?
>>> It comes from the VFS.
>>>
>>>
>>>> POSIX has a seekdir/telldir interface like that, I don't think file
>>>> system authors like it.  Some have added dedicated data structures for
>>>> it to implement somewhat predictable behavior in the face of 
>>>> concurrent
>>>> directory modification.  Would this interface suffer from similar
>>>> issues?
>>> The same issue was solved for /proc/$$/mountinfo using cursors.
>>
>> The mounts are now using an rb-tree, I think the the cursor solution can
>>
>> only work for a linear list, the case is very different.
>>
>>
>>>
>>> This patchset removes the need for cursors, since the new unique 
>>> mount ID can be
>>> used to locate the current position without having to worry about 
>>> deleted and
>>> added mounts.
>>
>> IIRC the problem with proc mounts traversals was because the lock was 
>> taken
>>
>> and dropped between reads so that mount entries could be deleted (not 
>> sure
>>
>> adding had quite the same problem) from the list in between reads.
>>
>>
>> Sounds like I'll need to look at the code but first though but an 
>> rb-tree
>>
>> can have mounts removed and new mounts inserted if the locks are dropped
>>
>> if the retrieval is slit between multiple calls.
>>
>>
>> So I'm struggling to see why this isn't the same problem and I don't 
>> think
>>
>> introducing cursors in this case would work (thankfully, lets do this 
>> again
>>
>> please).
>
> Mmm ... apologies for the poor description above.
>
> That last bit is definitely "lets 'not' do this again please!"

IMHO keeping it simpler is much better.


The interface where a buffer is passed and overflow returns an error so 
that one

can retry is far simpler and the in-kernel simplification of taking the 
lock over

the whole retrieval is far less problematic.


If there's anything that could be useful then it's keeping a count of 
the mounts

in a given namespace (I think we have such a count in nsproxy struct 
already) and

adding a way to get that for storage needs estimation.


Ian


