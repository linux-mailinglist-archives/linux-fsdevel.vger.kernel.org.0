Return-Path: <linux-fsdevel+bounces-51205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D011AD4609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2523D189E4A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640128B501;
	Tue, 10 Jun 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="adsoeZyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJtu2jdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28699248F74;
	Tue, 10 Jun 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594905; cv=none; b=XNx3qZeRYuG8GNi+Ek7sayhdp1oJ6Q+pk07EkiNrkNviIOsg1Z5izlwl7XhDBDPHRAAAQmT+2fNw+pVEvIEY9OdH0fd5mh6c8jYgKYbmJH+3qrAgI3v+M2c2moP4He/uyKg7J06VA9vurvI2D4w+3aiDuOYA0RRZBKzF+wn+a74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594905; c=relaxed/simple;
	bh=1EMGdU6IE0W644eUYQI/fZPsXySyFcb8BnJx2RowYkU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nomi80sKKw2Rfv6SWoYZ9h+2qi9FdUL6yQmMBOMNWxAL09K/td6suzK/9L+eIHz+K+YDWCFc7iaPxG53SdeRFeOcD74KPd0yAXEuXrXvtMUFubV6LgbFUNmp4BLWzaF1irg9ReyJZnsC7BRMSfSF3sS+iWf9eEbvd4t4mY4VLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=adsoeZyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJtu2jdc; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 17220200400;
	Tue, 10 Jun 2025 18:35:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 18:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749594903;
	 x=1749602103; bh=OQnDrS/DN6K5yUEx9VnU0adPPOUwDA6gZgTptWERHUk=; b=
	adsoeZyz2R2F1dGCiXK4fueP77MOQoorz1q55I39S4VRt17iWeJaQjCz/ll0q5JZ
	49glsyS7tfuhEwI+8iDcGcVM/+L+pRCD5Yi07H8XZknQA23wP63pXbNZxcwuxKIc
	i4aS1YPjvxr3LiFW7s+jw3DAFL0WI+kWvu46TvHsbtT6iB9AywK3gLw0G9nS5ZfE
	X0yz7E4mX07jXOuIxP0VPQRdaVMq+BnMlN/gUDdLsV+5DLvZDD2bVIAmcbYKyBg6
	g76R3lX7MBPwlqyTnGifajKVbiXlSRz3r0ug5PQ720I4lACnz9VFuHTug8QrtUb3
	Z0AOaMtNP/w8ZE/0BZU2TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749594903; x=
	1749602103; bh=OQnDrS/DN6K5yUEx9VnU0adPPOUwDA6gZgTptWERHUk=; b=l
	Jtu2jdcbTDWlcx/rKVrJ7j0h6U4cTx4f0x77JHlZhUFBl/EeWnaPVJEheH6QV6iI
	9JpBKTHEh2m6K72nNvCBCUNvH11U58GsAu5iQiMruL57VOkaH9GT7O/tApu7ELmC
	nblti+2a5TsRilKXRO6xIsu+mQyIubdh1XG6/knNn3rsk9S4qdngIMG82soZTHyj
	xjyQg47RrL6KzC/q3zHP5qgIrfqIhmODKt2RQwoVV4hn7BcACYynseMie4vmP5YO
	v7EUFdrKr+BE9IJV9TX1MWZ/JQlSRUH+3KZ43fuTBLhNw7prZ6eyIha1YsZw/xVi
	i8ztlU9jQHni/ewCIiVNg==
X-ME-Sender: <xms:FrNIaPBqzQqhaYzcbCg2fN6HeGkNczEdZBAqHdh3yjMq5ueqqGgmUg>
    <xme:FrNIaFhEwCRNAo1xSfU3UjhjRQqMDTIs5c4J35Hgzu2wutXwInGPnNOoiLJKfDhz6
    rT0eyda5cOPbXADAWs>
X-ME-Received: <xmr:FrNIaKmBxKtjJsi0sT1i4pt0reFwMfRbjG1c1E1wYTtvGy8xe0ZyZgh52u3RMCi8OKJ6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthejredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeehffelgeektdeufeeludeuheeuveffudehjeduudevvedt
    veekleektdduhfdvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegsphhfsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FrNIaBx32AmYKBCX-YfL-iRL9U6-zy-cnIe9lMVURLsZaFUrgdiRTA>
    <xmx:FrNIaESjQf6z-lo7VQ9ZP188YIGANHmQYcfAv9oF1cM1YnZUHAng5A>
    <xmx:FrNIaEY4ODaacENy_X_itHuByX9OJICUCG46x6B-E_E3BSqwh5Vwnw>
    <xmx:FrNIaFRrpJ_wTX1YouzMgnJRkTVjU_PLl9qzMVm0J1u7GAU-XPe4Jg>
    <xmx:F7NIaJaKPsSQBsN3WUaKuOA8G-45XYu_KLndEo34BDJTe1vbye1dDo4C>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 18:34:59 -0400 (EDT)
Message-ID: <b9d54a37-3381-4949-a1af-0b4bc7b7fbe1@maowtm.org>
Date: Tue, 10 Jun 2025 23:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
From: Tingmao Wang <m@maowtm.org>
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org> <20250610.rox7aeGhi7zi@digikod.net>
 <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
 <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
Content-Language: en-US
In-Reply-To: <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 23:26, Tingmao Wang wrote:
> [...]
> 
> A quick suggestion although I haven't tested anything - maybe we should do
> a special case check for IS_ROOT inside the
>     if (unlikely(path->dentry == path->mnt->mnt_root))
> ? Before "path_put(path);", if IS_ROOT(p.dentry) then we just path_get(p)
                                                                     ^^^ sorry I meant put
> and return false.

