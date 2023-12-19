Return-Path: <linux-fsdevel+bounces-6514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424C818F11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D853D1F29E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8C39856;
	Tue, 19 Dec 2023 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="dvjG3qMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAjWUgxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503A37D04;
	Tue, 19 Dec 2023 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 49FAA5C01CF;
	Tue, 19 Dec 2023 12:56:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 19 Dec 2023 12:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1703008594; x=1703094994; bh=WU2yvYz91b
	oprhIP6+puBEddYZyA+Gt+AEiyct5l+lI=; b=dvjG3qMoNl9UGeyecEjJDCHnYd
	2dJrM02zRpoAh3BwrJVyhz2biS2BZzRMgNxs8RIqCeWAn8tNXUgpWeaK5C3JTmA7
	UwWTVY0DsYlUsYeZMzmFoE3mNUeFzz/+tAh24W8+hJmIa2ztb3mnyPQoV1Pm1cvW
	S6urYKvOCjhmQ0VHnw9B6Gy5DqTGo1G+HkirihxPB3NfnBmIFVYLqDPt6nAVeOaB
	A8At/HO3cCrycOp/dzTZ+npiPojsdDH7AhJviSHDKPaVBVDXuGbYBRTgZavzDdVV
	v2NNVvu4qEKI7Q5lny4BrsDQ4nSz/nDghbNL4B3nkj+IgJMkYfVXdPSTN5kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703008594; x=1703094994; bh=WU2yvYz91boprhIP6+puBEddYZyA
	+Gt+AEiyct5l+lI=; b=LAjWUgxdNQEEA7YL6h9fYC30mhGXTmWiOtzP1t+2r+ID
	UGmiL9g+TTZ5TOTCGNN3+5Z1LjfX3a7nA74wBI5Ky2Ixjrg9dFQpWLektiv9LAan
	+vLbv4VG6tmP4y4FJ+w9DngEKC3pMCMrtFgg/2/BD0rp6v8vs2CXTz6Gh7p/9v3o
	fBfBxgifOZV6wN0yOl42+TY/UbGeUIpgHbLpnO/DH0e8yTVc6OorT8Y0Dvdh3eRt
	oXV1eBl0oapZ/++1Iv7DGM2pDMYJtNUM3ZW6g8Goi0O2Zv8fheIlYgalZpefy1sg
	j454hi3496+qrKuu22vg/bx9Kj9Xrds2w31MDq2Sdg==
X-ME-Sender: <xms:UdmBZT2LPq5AQXeUJ76Rxm6x1wlt2QWpRHACFl0xFC8TyFK_NLrsAA>
    <xme:UdmBZSEz7OsC6iDcp4JP4VbkaVdOOJBPCYj_CZSYZNNcR3ZmIOl9TeXb-gsC2hYPb
    iHKdR-Io-Q-MafBqac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedfufhtvghfrghnucftohgvshgthhdfuceoshhhrhes
    uggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeekheefvdetueetffffhe
    ffhfdutddtkeejueffveeijedvgffhffehvefhgefggfenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:UdmBZT7DTWGge1FTeADib-vAWfZIfCHZSoYqQRA93BLmJoa9UIJyPw>
    <xmx:UdmBZY1BkVGn3MSxcGtGo_zGWVh1q8M4n34Er-yqCx1xqfi4VwTPHg>
    <xmx:UdmBZWFb_SsUJJahl5wZAHp9YbGeldtuzDBSftOA1FbvYqdlAGRajA>
    <xmx:UtmBZTONf8rtXvgtasvmGC3CMDU6vFRWZJfVKdb-LgDLhIh7UpEOTg>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 60A88B6008D; Tue, 19 Dec 2023 12:56:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <79e0cb77-ea6a-427f-af5e-c1762049ac89@app.fastmail.com>
In-Reply-To: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
References: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
Date: Tue, 19 Dec 2023 09:56:12 -0800
From: "Stefan Roesch" <shr@devkernel.io>
To: "Jingbo Xu" <jefflexu@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v3 0/2] mm: fix arithmetic for bdi min_ratio and max_ratio
Content-Type: text/plain

It would be good if the cover letter describes what this fixes.

On Tue, Dec 19, 2023, at 6:25 AM, Jingbo Xu wrote:
> changes since v2:
> - patch 2: drop div64_u64(), instead write it out mathematically
>   (Matthew Wilcox)
>
> changes since v1:
> - split the previous v1 patch into two separate patches with
>   corresponding "Fixes" tag (Andrew Morton)
> - patch 2: remove "UL" suffix for the "100" constant
>
> v1: 
> https://lore.kernel.org/all/20231218031640.77983-1-jefflexu@linux.alibaba.com/
> v2: 
> https://lore.kernel.org/all/20231219024246.65654-1-jefflexu@linux.alibaba.com/
>
> Jingbo Xu (2):
>   mm: fix arithmetic for bdi min_ratio
>   mm: fix arithmetic for max_prop_frac when setting max_ratio
>
>  mm/page-writeback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> -- 
> 2.19.1.6.gb485710b

