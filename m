Return-Path: <linux-fsdevel+bounces-50993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B1AD1992
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAFB167D90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E062820A4;
	Mon,  9 Jun 2025 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="FgvQOX0S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfGuOVVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383B28030D;
	Mon,  9 Jun 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456524; cv=none; b=A+57WBkxsjvcUpoVRUVFeDoVbSS8iOH39U/gMHw9dLXy838L5gJmjLg1z2CWpXBG7K5nOyLb6hZlx18UXIlosHwbsGMuLt8jfJVn9R3F+f9Xx9AdS+/8dF128Dc2TDHR4kSlHVLysNdz4pLCUUUZfS/S375YelDEoAdiKdrTK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456524; c=relaxed/simple;
	bh=Kq3FV9iptETXrme4JGWRHJSwuOei6uZwyUiHPKjDJlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv2qoBzLtY5thf7jmPlOcQW+VGbwioOyhGWMXmyRQHCC8UNGpjYQLEPUmg8VIb7kgLNwG+kcE7C196aVPZD6eT9ELFM+2ica7dYgtvmTVkg5FNZ4N09T2yC38l+sCfMw0lXEO/e03Q1Zaxpkk+IAig+dfUyKrMkE2/be8QRULOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=FgvQOX0S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfGuOVVq; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 272B41D406F0;
	Mon,  9 Jun 2025 04:08:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 04:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749456519;
	 x=1749463719; bh=7ENdChkKgKNI9Bj63mK2Sh0VQmIZu8fz9OgqfYcb2LE=; b=
	FgvQOX0SXVeFhGEyWSP5j/YhoCwZoylqorpQ+trljlK9ymL5XMFLXgN3gNMRsqfa
	MUwfQlcakRj3TmUSZktJeNQ4mqGqlZ9HX1T1+IGPTpfWbImefK0g6gYDVC1WLar4
	a7OaaZ8xq36W10U2iiMZX5nx5IFCJ0W3WbQT3IREWaXIBpgTyrdf5i4nKArzWeEd
	Ww/zLmgwTVbx6fgsDwhIY8gGlCRQywlh7muSLG+jPe9695ELwehyH1kkkFNzok2c
	Kr+BJ75LLO2SWV9DtsAa2Tik5QFDhNbuWoKBUxqi6Yc/8SsdJrmgPxc2RrEKA7I9
	zrMoTlqzMDC24lyrEiFfpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749456519; x=
	1749463719; bh=7ENdChkKgKNI9Bj63mK2Sh0VQmIZu8fz9OgqfYcb2LE=; b=B
	fGuOVVqmMW0cvVH6oAv3lPT/F+loL+yDqVv03f+DZj8hnrVjgfAw91EKNGhhFSB8
	GiQ4AMpsPPCDa3nbJ2NfLZ0LmmrG4hw1sZgpdO6xnSCWMzUot+qDwatlgYmN/jBy
	QDJ4pXsUSLppAfcwui+/YusPrqHtjBzvyKAXKwDrzrPPRHBnDZHtYPXUlGrY536z
	nZrnf32FDiqq+zYPYPI5GAwv0mpnWYun22wEDzCPosw1SiIqphoO1SiJMgBxDmKS
	H0zOUWgE+271kU17xe1koUXY8jmYIwLmdrEXs8qMsv54sgkAOoVFmYLR1ZYLcBE5
	TZHwJRZj9AenSXKXBv7mg==
X-ME-Sender: <xms:h5ZGaHUS6VkH2iVFTc8E9kgPNk6C5JxWgWYBKDIzmOemixR6lBu41A>
    <xme:h5ZGaPkVpHDW6Sz2oepgtrp9oAuZh81ZTOd51x9ys9TXYZSRBEy9NyIl9PFfmxoTh
    yu0h9H3fV29pS7xxWc>
X-ME-Received: <xmr:h5ZGaDZph4h706P4Fsg2T5fwZmgOlApvz1EbpIudP20oRTttSgoR2urkV5ZATBNQUSS6Bkeag-OTucPZ7reDILpx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeltdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeei
    gfeltdehgeeghffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedvvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepvhhirhhoseiivghn
    ihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgt
    phhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:h5ZGaCW82eBbK-bukAY6jCQSwAe7sOEJjKUwvl2BC9HptXBn5LkdsQ>
    <xmx:h5ZGaBkeHiBoV9cfPqYq-gBJCAdujZTgLkmdnYb21ibcgkBSCWZU6g>
    <xmx:h5ZGaPfiz6miyOnVHhlODwDyw7VWcEHhfnknfpyElHRNkvLrgBBIsg>
    <xmx:h5ZGaLEev_OE9OmfucnS7s_c0m3BPrP5H5Z7qDFkjWyuDILIWY451A>
    <xmx:h5ZGaOWHKxUII7DII2q6ALhcOQWfvPSiGlAIlPAuWLYccusj2sj6TsL->
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 04:08:36 -0400 (EDT)
Message-ID: <97cdb6c5-0b46-4442-b19f-9980e33450c0@maowtm.org>
Date: Mon, 9 Jun 2025 09:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 0/5] bpf path iterator
To: Song Liu <song@kernel.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 amir73il@gmail.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, gnoack@google.com, jack@suse.cz,
 jlayton@kernel.org, josef@toxicpanda.com, kernel-team@meta.com,
 kpsingh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 martin.lau@linux.dev, mattbobrowski@google.com, repnop@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
 <CAPhsuW7n_+u-M7bnUwX4Go0D+jj7oZZVopE1Bj5S_nHM1+8PZg@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW7n_+u-M7bnUwX4Go0D+jj7oZZVopE1Bj5S_nHM1+8PZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/9/25 07:23, Song Liu wrote:
> On Sun, Jun 8, 2025 at 10:34 AM Tingmao Wang <m@maowtm.org> wrote:
> [...]
>> Hi Song, Christian, Al and others,
>>
>> Previously I proposed in [1] to add ability to do a reference-less parent
>> walk for Landlock.  However, as Christian pointed out and I do agree in
>> hindsight, it is not a good idea to do things like this in non-VFS code.
>>
>> However, I still think this is valuable to consider given the performance
>> improvement, and after some discussion with Mickaël, I would like to
>> propose extending Song's helper to support such usage.  While I recognize
>> that this patch series is already in its v3, and I do not want to delay it
>> by too much, putting this proposal out now is still better than after this
>> has merged, so that we may consider signature changes.
>>
>> I've created a proof-of-concept and did some brief testing.  The
>> performance improvement attained here is the same as in [1] (with a "git
>> status" workload, median landlock overhead 35% -> 28%, median time in
>> landlock decreases by 26.6%).
>>
>> If this idea is accepted, I'm happy to work on it further, split out this
>> patch, update the comments and do more testing etc, potentially in
>> collaboration with Song.
>>
>> An alternative to this is perhaps to add a new helper
>> path_walk_parent_rcu, also living in namei.c, that will be used directly
>> by Landlock.  I'm happy to do it either way, but with some experimentation
>> I personally think that the code in this patch is still clean enough, and
>> can avoid some duplication.
>>
>> Patch title: path_walk_parent: support reference-less walk
>>
>> A later commit will update the BPF path iterator to use this.
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
> [...]
>>
>> -bool path_walk_parent(struct path *path, const struct path *root);
>> +struct parent_iterator {
>> +       struct path path;
>> +       struct path root;
>> +       bool rcu;
>> +       /* expected seq of path->dentry */
>> +       unsigned next_seq;
>> +       unsigned m_seq, r_seq;
> 
> Most of parent_iterator is not really used by reference walk.
> So it is probably just separate the two APIs?

I don't mind either way, but I feel like it might be nice to just have one
style of APIs (i.e. an iterator with start / end / next vs just one
function), even though this is not totally necessary for the ref-taking
walk.  After all, the BPF use case is iterator-based.  This also means
that the code at the user's side (mostly thinking of Landlock here) is
slightly simpler.

But I've not experimented with the other way.  I'm open to both, and I'm
happy to send a patch later for a separate API (in that case that would
not depend on this and I might just start a new series).

Would like to hear what VFS folks thinks of this first tho, and whether
there's any preference in one or two APIs.

> 
> Also, is it ok to make m_seq and r_seq available out of fs/?

The struct is not intended to be used directly by code outside.  Not sure
what is the standard way to do this but we can make it private by e.g.
putting the seq values in another struct, if needed.  Alternatively I
think we can hide the entire struct behind an opaque pointer by doing the
allocation ourselves.

> 
>> +};
>> +
>> +#define PATH_WALK_PARENT_UPDATED               0
>> +#define PATH_WALK_PARENT_ALREADY_ROOT  -1
>> +#define PATH_WALK_PARENT_RETRY                 -2
>> +
>> +void path_walk_parent_start(struct parent_iterator *pit,
>> +                           const struct path *path, const struct path *root,
>> +                           bool ref_less);
>> +int path_walk_parent(struct parent_iterator *pit, struct path *next_parent);
>> +int path_walk_parent_end(struct parent_iterator *pit);
> 
> I think it is better to make this rcu walk a separate set of APIs.
> IOW, we will have:
> 
> int path_walk_parent(struct path *path, struct path *root);
> 
> and
> 
> void path_walk_parent_rcu_start(struct parent_iterator *pit,
>                            const struct path *path, const struct path *root);
> int path_walk_parent_rcu_next(struct parent_iterator *pit, struct path
> *next_parent);
> int path_walk_parent_rcu_end(struct parent_iterator *pit);

(replied above)

> 
> Thanks,
> Song
> 
> [...]


