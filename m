Return-Path: <linux-fsdevel+bounces-23148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A8927BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE71F228EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18932C85;
	Thu,  4 Jul 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="re7+uJgv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHdFMi0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39E23746
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113621; cv=none; b=eOqM8O9HsRbEJT+2SAWSPSBg83/gDEsxUPGhxRAUDcTdCtaFwHtqQJ+UaxDD4GwZz/mulU8qbtKwcyVlTiMO+/0BNtYboAY06zgWffvUxv1p8e63eoc9SoKcfL8ujy1ZAII1keA0qNJRQLEWtapmKbxEYyewyiL15Nxdi/ENo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113621; c=relaxed/simple;
	bh=QgHC9lZzkLcGjLblk8kG4iJfDzNiSi0MHAG/42IQ7L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LrbgNxPC/DxuFhJyuQDb40gk8v1zHkqrHfXcoVrC57b4nEUvDlQttRxv9QwSUwEgzmdJeJGKyBnfI1rRAIzLI/N507Gek7OLZyg1BX4qB50qRwL8UR5QUKlT+6gpTqavUwAGdixlT11kPhIgNN6gWhEoel9qoKDvVhBtcinpprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=re7+uJgv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHdFMi0t; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6DFB51140222;
	Thu,  4 Jul 2024 13:20:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 04 Jul 2024 13:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720113618;
	 x=1720200018; bh=ucCFHC203Wvbo7KdD/a7pVPwOUsZ8fD+RI2OkLTolNQ=; b=
	re7+uJgvqLm8umlVm0f30JlV2bispZ1Wa7f4Ti9A/FUhGrV335mh/5MvZMtl7l5D
	94DAPGcGB+G8T819fAJPtkXViCOyg/QyhEiTD9gDoISDwA5/2R4YKYzjbYJBcF5A
	fsohelfYsDk4KREA92JmnrfmJoIVaiyalnCEoUh1ydjO0lfaBx+Cvwyox2qRjLbp
	w93arIRX/CIwul9hNCz5WZj842TrfzuJf/jI7gHnqWtOseM65Z8Aj3e+fHYUl+B9
	Zm+yTYDFqi+gFWdYCJe2t3o+RVv7zWZxqEK6y5mwAwiJRQWS8hBMXFehj4aGvPn4
	71LVEVuXmxyK0y5qAz8ADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720113618; x=
	1720200018; bh=ucCFHC203Wvbo7KdD/a7pVPwOUsZ8fD+RI2OkLTolNQ=; b=t
	HdFMi0tQvuRLHvmSDhBgvasdUT2N2K1X/lx8RNWn+R1DoWoMuUdh5h13eu3nYUxB
	dz9BvsDymztyPTMtpZEeUC2bkI7VqmkGLEs4StxEY7iu6zm8JBIU3s70+xrt0kg+
	gPDl6354jhUU1OzqI1ArvNHWXlPyVF88IHnly6/zSzCsogVBvtGug6gmBdOjfQTk
	nHG3XAxn2kq2fqY+ZzSoAH33zwnhseCiGgvTUugq4BUhf23AXdhZM7yAGS6C0PJd
	7zLxlYTIByaS5zM9ZmeVnRQ7dzTYBBgctJJQuHy//97nB21qB+5cLtTi8kTdNE23
	cVFBQwsw6i5DkYBuiqfVg==
X-ME-Sender: <xms:0dmGZip6KIZWPKVqIcrCoCFcCsG8ZO2s4XK7nfsPzy9UiSWOXfYNVA>
    <xme:0dmGZgrcq8_cVPlOQtd5EQag0jceNQjpvhWofDk8CHKLGa9htgluCQ91f7dVJRVu5
    DzX9cyi8YBs3-MS>
X-ME-Received: <xmr:0dmGZnMEdlDLT9SSwON5-h9Tftbo_8BXSOg5uA-QWnSj1bB6tXgptg2y8SAUPj4QwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekffevgfdttddukeeiffelheelfeehhfduleei
    udehhfejhfeghedvfeekteefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:0dmGZh6jJmPOT8g5YqXuWZu5Dc6Hm41bhpPVInEuXyXxojK0DKfWIA>
    <xmx:0dmGZh4s7I3iRfsnUxsXBSsDztq9CCn07HZQUrTfv_eNUG7Ge5d-nw>
    <xmx:0dmGZhhZwM05dq5y1XC0UQt_pi8yA8REnaROyUKtex2IPeTxxX3nxg>
    <xmx:0dmGZr4Qr8-tj5Yk5fouh7nf3KOO8XBe2nWwlB4pdNsuaNWrpCGHeA>
    <xmx:0tmGZrnJQatoPy-xrM4Hq6tCVLulGAYTP6i46yylvfPQalP6e9-4D2AE>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 13:20:17 -0400 (EDT)
Message-ID: <21a2cfee-0067-43d1-b605-68a99abd9f53@fastmail.fm>
Date: Thu, 4 Jul 2024 19:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RESEND] fuse: add simple request tracepoints
To: Josef Bacik <josef@toxicpanda.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
References: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/24 16:38, Josef Bacik wrote:
> I've been timing various fuse operations and it's quite annoying to do
> with kprobes.  Add two tracepoints for sending and ending fuse requests
> to make it easier to debug and time various operations.

Thanks, this is super helpful.

[...]
> 
> +	EM( FUSE_STATX,			"FUSE_STATX")		\
> +	EMe(CUSE_INIT,			"CUSE_INIT")
> +
> +/*
> + * This will turn the above table into TRACE_DEFINE_ENUM() for each of the
> + * entries.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);


I'm not super familiar with tracepoints and I'm a bit list why "EMe" is 
needed
in addition to EM? CUSE_INIT is just another number?


Thanks,
Bernd

