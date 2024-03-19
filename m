Return-Path: <linux-fsdevel+bounces-14828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9E8802D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8D91F228A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7891774A;
	Tue, 19 Mar 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="0u9/fpcI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrNIPM4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FC1118E;
	Tue, 19 Mar 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867590; cv=none; b=cbrqfawiaPDJOumImTYUGOhyDTd6Totzd5pLDLxWl1h2LFmrCASZB2ZZc2HuEg0roKn5U+qnskUaifWfASWYb5CsuUoQGQS/jC2auTeCEvPy9YIjdyufLl13Vb13FYqbdI3pAHB/l938aOH7Ib4BmUZHhtT1E63+LlI8mZNIfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867590; c=relaxed/simple;
	bh=TPYwpJrngVJym4yY5SzYj0P5kZ+FMMniYM2lAo+nnhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VO+ahk80UR8HHCy8r8La9dAtuzltYDny1OZdJ1muhMHrlMoFCvLZAG6JjwBu4HN53O5efHOWmlW5fF5izkglVozXTJ7xnK2OGi1hZhAs6d0S5amOwgnTW5emDwACBoKKid4DFmmh7ik3O9Z6t6pH3liOXYf3ANNTtqIzcb/eYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=0u9/fpcI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrNIPM4x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8750E1140101;
	Tue, 19 Mar 2024 12:59:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Mar 2024 12:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710867587;
	 x=1710953987; bh=cHdFUwNUaNtHseK/mzgvFDOdmo7eBJ0OS3s8iO/q7R0=; b=
	0u9/fpcIJQPoY0zpSCSJ6gTPGTGnlb3KOcQLJQwVoFNWumffgMIIO56GHh0ukM4I
	PWYbUjIJOaDdaZZ3BKwmOQIybUPlcppqssGdWvfDmEfRO1C+EhqIHG5qLORrYn1o
	qq6MWOx/cN4EvD9Wu/N9lFNoUoWXO1uo9Aa+Py8FP7yFheRD3pvRA4a6VyaWd+Rb
	yqy2xrgqf+UftdQXAjWZorzwEthFH1X4bUPGo5GhF13V1yLhgioycWUwQLGTQ1BP
	E4Jc5iJ4+9kAOv2HXWSWAp1Xxj+FuEJ9YkgfYRN2bwlUe96iq7tSRA01cR+2list
	hQl6u6AbGGgsmn8nPUK2xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710867587; x=
	1710953987; bh=cHdFUwNUaNtHseK/mzgvFDOdmo7eBJ0OS3s8iO/q7R0=; b=l
	rNIPM4xpEKf2RZpW1L6EY8hMPyl0jjOpe1MzAtqVxSww7hjUNwG+igvOnMrB2vKD
	uk5/6o9swhOhRdTEBhPQFfKaj2tVsMMNPM5/dnt4AMFILolNuIwVeOnWY2ciHnyf
	WN58rRHTp6Mo14sWlR8R0Yap+DaTkJMfaGFljXx5ENWroxZPgRr3/BmE6e0bNba7
	U2BXvYFY+eiV8fi8BFz5gTGNoHm4orSK7Gja3/QQsrhR0aTgZOUVC7b3Yuj2UBry
	8bn/qTnv6kojC+Hzm+5xruFjYzL6RIr66kh6rlkc/RP1JlEFJydP1JVI4wkb4yEL
	1eKgP3HUkQNAR3pU7X/Cg==
X-ME-Sender: <xms:gsT5ZcZAHXxbcYEsXh2kFe2XEGrKSbNqGQBdQc-OzhXhZ7TWuh1B9Q>
    <xme:gsT5ZXaUJNPxGEC-EGUIISLXOzYax5A6JWwRmGSgMLewfoFfXMLfjJvPstAyL2Oiy
    4ZRT7XKSrQL8SE0>
X-ME-Received: <xmr:gsT5ZW-SHey_qu8C_n65vo9NmpDxAoNNWHaiCuCOvvihVmXqK7X5lJfVjYvTCYCktg6McJZf_WNCST2JODi6EI6tUlu4y9gsfgZw7W-x_DDDaaeQ2BvN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:gsT5ZWp_Xp8g-XeIUTn3R3XwcTxPEI87lEYYuBopKtA1ZW2yuelMCA>
    <xmx:gsT5ZXpAsV-4kCS8ULBvaHC4sBvy5j1Au1FZfetCOl79nYNNGA7CyQ>
    <xmx:gsT5ZUSsxLu4tR4TgEBX3FnVK8rJNxhJI8Q-5dX6YQnrD8gAnJxrrg>
    <xmx:gsT5ZXoC0N7zIHK-a-_46_RtZYXB5rwZGTfRRa9OZt-BiFUrc2fU6g>
    <xmx:g8T5ZeelEAZbKzgWvJSrQWBb4nfdzh9IQCPESFVTj-2G0oAdFX45Qg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 12:59:44 -0400 (EDT)
Message-ID: <63e67db9-7425-4928-afb2-cbe7cc6232bb@fastmail.fm>
Date: Tue, 19 Mar 2024 17:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1668172.1709764777@warthog.procyon.org.uk>
 <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk>
 <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk>
 <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
 <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/24 17:40, Miklos Szeredi wrote:
> On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>>
>>> What particular usage case of invalidate_inode_pages2() are you thinking of?
>>
>> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
>> to clean up the cache.
>>
>> The server is free to discard writes resulting from this invalidation
>> and delay reads in the region until the invalidation finishes.  This
>> would no longer work with your change, since the mapping could
>> silently be reinstated between the writeback and the removal from the
>> cache due to the page being unlocked/relocked.
> 
> This would also matter if a distributed filesystem wanted to implement
> coherence even if there are mmaps.   I.e. a client could get exclusive
> access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
> clients and blocking reads.  With your change this would fail.
> 
> Again, this is purely theoretical, and without a way to differentiate
> between the read-only and write cases it has limited usefulness.
> Adding leases to fuse (which I plan to do) would make this much more
> useful.

Thanks Miklos! Fyi, we are actually planning to extend fuse
notifications from inode to page ranges.


Thanks,
Bernd

