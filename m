Return-Path: <linux-fsdevel+bounces-39127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA006A10367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F390A1888EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FA28EC6A;
	Tue, 14 Jan 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="JySATTbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FN6Z09QI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BC28EC99
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848535; cv=none; b=gC1KRbZTZNjAzbCrXvjbZII7NQC8aG+yS4U7Zjccxlz3TKNTS+LiVJQIjQPSTh9QMghyemDsHr0ahjemsVUVzGm1iVRegxne58A3IVU1cUjRXZjumTE3TDyM6eoS2/AKp2oOpfngdqswFMyWvtsaL4z9EVsoQmbUq979U2wDyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848535; c=relaxed/simple;
	bh=qCUgS8qdZ+pjW9UVWIv7iAyGms4xcmZtyAVY1xY+Cd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDnetRiAmRHJZylHCYcdUwKjhcyLWrHjoiSEg+XTbDwuoE6z5e4G8Ob0z1wtnHNAzPsEY25v8N7cOa2HrwVVEPxnPTFhgmaYaLDB6Gu8wcO+d/hsa2boKI81T66szkiORDrZAdKxfBeImircclTe5LPeO131BqjvHcmDtBbabnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=JySATTbi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FN6Z09QI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 374D1138029F;
	Tue, 14 Jan 2025 04:55:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jan 2025 04:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736848532;
	 x=1736934932; bh=FblF1gilDfB30WisurSiVEGTVjD2Xuv0/ZbLsE62fuo=; b=
	JySATTbi4+tOxonoTT873C+U9rGJSpSyjYj2r2rxRRGNv8D8ae7CM5vblKzdt1M4
	v6EVCjY6EZniRta7Z/u0Zbb9f5FBwjVe5AT+83T1xopC+XhSuZStpzWams00O/LI
	T8lla33F9JGJm0Na+BQQEY6HFe+/UraX9eQPySHGqvJw4XpGX4JJRw6oyHQ+DXgR
	KXaiFY8hultaKZlaIpK3cW+fDhpvB6+kj1TaPnkLn0SOrEZg0PJvPGDxSuj6wss+
	g0VtrIZi435dmXCjnAJKY1dqLp+wrw/fOwx3WhPgJuJSCq2apqvUto3AvyVoIHtQ
	Je9H/W66HMCHEm18oB42jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736848532; x=
	1736934932; bh=FblF1gilDfB30WisurSiVEGTVjD2Xuv0/ZbLsE62fuo=; b=F
	N6Z09QIeZqIAudVIetGjHQytXBm64AG7usosZCansy/ij/vaoK/wH1rIJk1WZ9/b
	U61yiVW/+O9vygNeXKRLxW7ynAcBTjkYs4uTzaC6uBCBMuOxaDeJjXijVtCr5Uyu
	EtNgg+bUggg7eHwywjKoRcheGULR3F3nlZShYfsaFmCqoWfTdqckmXX2yfZtIH7w
	pPPcMB/432bIBb8lSjhVJo08sR71lgf2dVsOGHwSicFY06t3sQDqsEcLHlTjE1Hk
	XgDFZXMzcR7nFR+uUe3rw/wrh06gVvyK8iC0V1trTA4gmjutbgOMZq8pMc9oxIDY
	s3oBk1nJWv5fV5OCnHRqg==
X-ME-Sender: <xms:kzSGZ4ddxEv0riTQRgJR3s8otwXtFfO8xZG7oMQ6_ilrPFt7b6U_4Q>
    <xme:kzSGZ6M4DUFAiE9gSuHzCsmpj6eFpsKlbpL3w-mGJ342ikXptpGGbDvK1Wbz8Gcgm
    Jn_zahQ53wgs8VF>
X-ME-Received: <xmr:kzSGZ5jnJxt_M7fQlqI28IUHnx1AFoY1fM3cEj_CCdq8EUGgsqORHwULETFfYU8s1UCuftrb911YLHGPexw0HESRsslLUh0sV4xrSniV4Ol62Na-2bui>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgusehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidr
    uggvvhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprh
    gtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflh
    gvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepjhhoshgvfhes
    thhogihitghprghnuggrrdgtohhm
X-ME-Proxy: <xmx:kzSGZ9-XE__Da_3xth2H6GAuN6Zpq1rAHFnrg57CmUJ2JWQN8sMXRQ>
    <xmx:kzSGZ0vIodUyIQvWyrU6riO1Sydej38bOhM2nq8eO9w9ohTejUMfxQ>
    <xmx:kzSGZ0FG4H90fP9zr7WUutLtqoyoov6_7rR2GOC-uOXeMXEyqfrTuw>
    <xmx:kzSGZzPhJYZL2ceRu2p3o8BOj9YJtq2BmQt9GyQ8TRhIvw_GqvEXNA>
    <xmx:lDSGZ0HjM5s6FCLJng5kLyl9uIxpiX5QZUfJiMPygbhkYzmNZiCLuCIf>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 04:55:29 -0500 (EST)
Message-ID: <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
Date: Tue, 14 Jan 2025 10:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Miklos Szeredi <miklos@szeredi.hu>, Jeff Layton <jlayton@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong
 <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
 <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 10:40, Miklos Szeredi wrote:
> On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
>> Maybe an explicit callback from the migration code to the filesystem
>> would work. I.e. move the complexity of dealing with migration for
>> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
>> not sure how this would actually look, as I'm unfamiliar with the
>> details of page migration, but I guess it shouldn't be too difficult
>> to implement for fuse at least.
> 
> Thinking a bit...
> 
> 1) reading pages
> 
> Pages are allocated (PG_locked set, PG_uptodate cleared) and passed to
> ->readpages(), which may make the pages uptodate asynchronously.  If a
> page is unlocked but not set uptodate, then caller is supposed to
> retry the reading, at least that's how I interpret
> filemap_get_pages().   This means that it's fine to migrate the page
> before it's actually filled with data, since the caller will retry.
> 
> It also means that it would be sufficient to allocate the page itself
> just before filling it in, if there was a mechanism to keep track of
> these "not yet filled" pages.  But that probably off topic.

With /dev/fuse buffer copies should be easy - just allocate the page
on buffer copy, control is in libfuse. With splice you really need
a page state.

> 
> 2) writing pages
> 
> When the page isn't actually being copied, the writeback could be
> cancelled and the page redirtied.  At which point it's fine to migrate
> it.  The problem is with pages that are spliced from /dev/fuse and
> control over when it's being accessed is lost.  Note: this is not
> actually done right now on cached pages, since writeback always copies
> to temp pages.  So we can continue to do that when doing a splice and
> not risk any performance regressions.
> 

I wrote this before already - what is the advantage of a tmp page copy
over /dev/fuse buffer copy? I.e. I wonder if we need splice at all here.



Thanks,
Bernd



