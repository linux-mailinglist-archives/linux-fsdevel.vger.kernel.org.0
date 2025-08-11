Return-Path: <linux-fsdevel+bounces-57431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C9B216DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8631C628243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3C2E285B;
	Mon, 11 Aug 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ftml.net header.i=@ftml.net header.b="JhTha1LX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ew2D1WR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B51F875A;
	Mon, 11 Aug 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946304; cv=none; b=Q3FIN0xAdp/Zs1WYlj8bae6z/87a1MsXTeuf3eVlUvtGvZ7F9KIJFxVKHGAqod9UlFPGSA7jcMI4Y3hS5ba5kF3ojCeXEA9KpBJiCizmW6GX+FWTtJZRMyNSBG+0Aie7XfcaxiaFdgu2TnWhtOanrLdtUVCioXu0IpyyBpKVpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946304; c=relaxed/simple;
	bh=jNHvp3MbY7uZE4NVlRnm7/n0OTvqpb44HoPh3Wvy5W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwCJ3erKQ2z078miiu+JHXbzH0/Qr2apjuLkHP8t90qXsLogdzr0+CEyHV2yY1sd/a57VAVvgGIEGk4z6WC57FcEC2ChW6GgLz30EhVj4+QAu+CaYZ53iN3i9OVBcxmGWy3IGViV6delDht0cRWITNxYJswv/1bQa7LwyIpGhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ftml.net; spf=pass smtp.mailfrom=ftml.net; dkim=pass (2048-bit key) header.d=ftml.net header.i=@ftml.net header.b=JhTha1LX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ew2D1WR3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ftml.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ftml.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 98D89EC01AD;
	Mon, 11 Aug 2025 17:05:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 11 Aug 2025 17:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754946300;
	 x=1755032700; bh=eI+uci7II5o7HIMNDnzqiBnyPIO3lognkiNHaLdRtqI=; b=
	JhTha1LXJLBJ9syMef5f+gTO0aHwgtXwzu1AUpQb84HWm7ZodLBP4cuE+fni8s25
	VC1JcXLLe2VG+P+hJ+cEzPfY9kLxwP6JMy/ngjJbwje0DTVj6cCOOKmEM3TWU8MH
	sXDq7rl01rW8ZDEzktPNilspRBPdXMW7mUGv/ImV0NDdW26RD9dmeXggaNS7OXzI
	/+yxtm4DkVd4J8OsSTUfzctZY++xNzOUn67Z/6R3APaj6ieohXpEDQ5IeMF9BjyO
	bKVRcy50Ypc8zvqwK8489xhU/Z/nAM0bjZ1avPQqe5lCuSzBRBOyHn+2Xmid1VoR
	nCn18TOWbo0zZgeaAyKCbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754946300; x=
	1755032700; bh=eI+uci7II5o7HIMNDnzqiBnyPIO3lognkiNHaLdRtqI=; b=e
	w2D1WR3UE7JHcrssXIdnpJKT4ZEMSQskHmwYALCeZYMykVZEUKoVy9zuzhIN4mUo
	3L2wAh0h2nUC8mZd6iWFHfe8Ym/U6tCS7FkmCujuFrt3iGWnZ2+85DfhsgxbO3/g
	U0mZx9BGxwbnNZGX7GgTMZ5aui+WHgYlGb47cnF+wOUG+1dEJU8Kt/W927xA03GH
	DcmM3oDzlfejNK8tFDtMGJIzKVZ6wvn9IyYMftZgccWuW85aeVKkR+dD0ly+EiIj
	lPQX9Ajjle3W7n+LfaaxPZoMiBQSvsicsWNb9p6wC8JAxsVG5L6WUkCB234Nz6r9
	nQMlkq2lUg6XriBt/7jWg==
X-ME-Sender: <xms:-1qaaK7YlgC7cgOx5wtWXpEahwA1hHS0X2ySRpC7WfbfNj6FjTrSBg>
    <xme:-1qaaKrmEe5iU93iCOFbGplMZQ2oDcSXBEnK3zRyGkFR59Wnrl9Rpm3jzq0C2RBj2
    e-sJQCedE-VhvDiKiE>
X-ME-Received: <xmr:-1qaaLPSR7ZefcM-UWaDTd7goyHKMppL9nDeGFSETar0-WdQSUQYNMfnlDSpri8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefmohhnshht
    rghnthhinhcuufhhvghlvghkhhhinhcuoehkrdhshhgvlhgvkhhhihhnsehfthhmlhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepiedvgeettdfgvedvueeigeetvdejueetudegteff
    hfejvdehtedvffduleehveegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgv
    khhhihhnsehfthhmlhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggv
    vhdprhgtphhtthhopegrughmihhnsegrqhhuihhnrghsrdhsuhdprhgtphhtthhopehlih
    hnuhigqdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhishhtqdgstggrtghhvghfshestggrrhhlthhhohhmphhsohhnrdhnvghtpd
    hrtghpthhtohepmhgrlhhtvgdrshgthhhrohgvuggvrhesthhngihiphdruggvpdhrtghp
    thhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:-1qaaC1dAyIz_K-sUIqXcJekYiWdh4NTsc5Gn9jnUhOEd2tH9qdYeg>
    <xmx:-1qaaKDPLXoZydI-L9saiI5TzXtNX5aXm48YyaWJJrKd7PoLAiMsbw>
    <xmx:-1qaaPJWC9evBpbXm15uTnkb_e0oaeE18u71zZqdq63565M7fVSItg>
    <xmx:-1qaaDknq9QDlHcwP37lp2b1KJZKJ5GS9zbNA3Mea5OT_0ufPInWXg>
    <xmx:_FqaaPKt7TP9bQ93z2zb_s_VCDBZWu6QLsWtAvAaxVZZIjjvnIaT_7jJ>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:04:57 -0400 (EDT)
Message-ID: <fd55b2ee-c54a-4eca-9406-92302ca61011@ftml.net>
Date: Tue, 12 Aug 2025 00:04:53 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de,
 torvalds@linux-foundation.org
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
Content-Language: en-US
From: Konstantin Shelekhin <k.shelekhin@ftml.net>
In-Reply-To: <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 17:26, Kent Overstreet wrote:

> Konstantin, please tell me what you're basing this on.

This, for example: - 
https://lore.kernel.org/all/9db17620-4b93-4c01-b7f8-ecab83b12d0f@kernel.dk/ 
- 
https://lore.kernel.org/all/20250308155011.1742461-1-kent.overstreet@linux.dev/ 
I've just lurked around lore for a couple of minutes.

> The claims I've been hearing have simply lacked any kind of specifics;
if there's people I'd pissed off for no reason, I would've been happy to
apologize, but I'm not aware of the incidences you're claiming - not
within a year or more; I have made real efforts to tone things down.

Both links are four months old.

> On the other hand, for the only incidences I can remotely refer to in
the past year and a half, there has been:
>
> - the mm developer who started outright swearing at me on IRC in a
> discussion about assertions

That is very unfortunate.

> - the block layer developer who went on a four email rant where he,
> charitably, misread the spec or the patchset or both; all this over a
> patch to simply bring a warning in line with the actual NVME and SCSI
> specs.

My team has contributed to NVMe and SCSI subsystems, so I have some
experience working with Jens, Martin and Christoph. Nobody on my team
had this level of drama, even when we were in disagreement about specs
or intended behavior.

> - and reference to an incident at LSF, but the only noteworthy event
>  that I can recall at the last LSF (a year and a half ago) was where a
>  filesystem developer chased a Rust developer out of the community.
>
> So: what am I supposed to make of all this?

That you're trying to excuse your communication issues with other people's
communication issues?

> To an outsider, I don't think any of this looks like a reasonable or
> measured response, or professional behaviour. The problems with toxic
> behaviour have been around long before I was prominent, and they're
> still in evidence.

Again, "Timmy also did that" is not a very good excuse for a grown up adult.

> It is not reasonable or professional to jump from professional criticism
> of code and work to personal attacks: it is our job to be critical of
> our own and each other's code, and while that may bring up strong
> feelings when we feel our work is attacked, that does not mean that it
> is appropriate to lash out.

This is _NOT_ about the code. That's the essence of your struggles. Forget
about the code, the code is not the issue here. Communication is.

> As a reminder, this all stems from a single patch, purely internal to
> fs/bcachefs/, that was a critical, data integrity hotfix.

But this does not matter. No matter how important your fix is.

> There has been a real pattern of hyper reactive, dramatic responses to
> bugfixes in the bcachefs pull requests, all the way up to full blown
> repeated threats of removing it from the kernel, and it's been toxic.

Play stupid games, win stupid prizes. Piss off a maintainer long enough,
he will refuse to work with you. Who would've thought, eh?

> And it's happening again, complete with full blown rants right off the
> bat in the private maintainer thread about not trusting my work (and I
> have provided data and comparisons with btrfs specifically to rebut
> that), all the way to "everyone hates you and you need therapy". That is
> not reasonable or constructive.

You seem to ignore what people keep telling you: _COMMUNICATION_ is the
problem, not the _CODE_. So arguments about how btrfs performs compared
to bcachefs do not matter.

Your result is not the issue, the journey with you is.


