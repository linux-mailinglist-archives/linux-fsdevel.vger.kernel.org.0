Return-Path: <linux-fsdevel+bounces-71781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCECD1C31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60533058848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F02737F6;
	Fri, 19 Dec 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kYZHsUm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg/gGMV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D712B9B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176539; cv=none; b=pa2tk2UC4zBEghFB1AxmTrZdSaaDvlDAegbVhKXEjBG6s0YQTeThrad6fNr4DFjY8jYQHG0M9tBKiKpqWkdFkeS6pSjv/vfgR0dRJoftV5mlqojeUe3Kh4VJWWhgG2RwdSENFmhwyb+jsgaYcDvooPI8vzZCL5hWnej+XigQ42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176539; c=relaxed/simple;
	bh=13m/MvfA5W2PTP6wUUFHvxV3P477NCO3RFTFxvdIRtY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eYAOTCuKxSeh/bC/c2DvWGmzZFOaMVUMCU0g8fs1yhZhIyc/l0kYJcxmcQlRHbw7z3/UNFZj1M2EpJaL7nLVj4Lzr2cgOcWKJmmF+BiNQCE1NFSgSoxtztH1PV4zCPGEJVqtc1DF00L+jeH7tCS1VrvCXxl9gZEI4075vuxTWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kYZHsUm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg/gGMV6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 29D571D000A9;
	Fri, 19 Dec 2025 15:35:36 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Fri, 19 Dec 2025 15:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766176536;
	 x=1766262936; bh=3d9fLzjQ/AZqtv2ZVueKEFb1bGfJIO9edpVZ3H1jqFw=; b=
	kYZHsUm3yqBHaQvpro/+WVGIWBVYSVMFfzAK54GcyEOPEhFKvEFuAPrGR+cJTmUh
	WuqFNjPxZvQkkBDtAeuRT4Y6eEryMc/WKH8n1pZWJH0y0k42xCztHwa4qzaYSulv
	c8fjOxu/1OEcujcVhSJRl1VueSwH7a0Ugi7lgTQ5pJVnjDFeQ+QadG4vzWSUDkJf
	Gl2ii6dZ4T7T5QD5RZhU72HA+grnsmxMyM4UoZW8OJbUnvEkKRNTYf6Dyx7OFD1c
	z/BtnKw4w6z4ekb5gkp4VO5JU4ctwu672Z8pByzhuSQ+RGzGy4TN2hQsMMQkhZp4
	yDjEpWPhj/OnA/BzylISAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766176536; x=
	1766262936; bh=3d9fLzjQ/AZqtv2ZVueKEFb1bGfJIO9edpVZ3H1jqFw=; b=R
	g/gGMV6hGJSilE/ezNtky0vmAjZSzpFmvQe4yQSfpUOWkGu4+khqfe+CKsUsbbH/
	NWhG+aLxCk7W9xlqRRomISPzMad0RNuBJ4JzW8+tV77CvLOrZwYZpBfBxOSSIz9v
	cJinNF6Ej5OguuUgo8Ffg2liakO4Iuak9WNah7aNB2NdDJH+Agy4cPQGpoTO0R1I
	E50NjYk69gfh6dHUbDP691rKb0j1Kwmm+hQck5oLYemr4vJt5HIyG0JkVIr8FnPc
	MEIR7CnWx/AMfasIuVZN8J6smZ16rnvAZK0DfZAWUSQvK/TV++Mw9B67WJ7GlM/n
	iHzqzayWG1vya99RM3gvg==
X-ME-Sender: <xms:F7dFaetfjsH_R0FrwIjtYohr1MfQyeE2o_Kf225FkyDcAyfvlGgXag>
    <xme:F7dFaeTM_mVgkLqy_zis7ZjunWXe23L2cRxu6fojMT-CUeK-upeQDeRRCMxTOLG3t
    PM_he3EDc61UZJY2PHV6HnMgC-TNEEwy52aM303P8LlBxIBV9FxxI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepfihilhhlhies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhlhgvrhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    giekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtg
    hkrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordho
    rhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:F7dFabR9fuVGLS8b2nH0EJEL7gMeVQyE2RmW6pjAmP-j5ztg66sWYA>
    <xmx:F7dFaSWdbgkitKG_ozO6MG4TRqQ12N7HBRnMw8O3mjcTSiNw9HFycw>
    <xmx:F7dFaaautW2GXmPM0khIdUKFWjjMT3nNkDSx5fj18akTdZS3YoKf0g>
    <xmx:F7dFab6-0sXi3QVEQ4kxkCC7Ickcc4xkhCmDssD-fi6cLmyMFZeyFA>
    <xmx:GLdFaZ8lTCnaSOSLz8dsTEi9P5rYOub2PGkiNAXcyFkNFyLQKKniTZRF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E0EFC40054; Fri, 19 Dec 2025 15:35:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQxZfb8dcq5J
Date: Fri, 19 Dec 2025 21:34:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <513078d3-976a-4e6d-b311-dcfcfea99238@app.fastmail.com>
In-Reply-To: <20251219171412.GG254720@nvidia.com>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-4-arnd@kernel.org>
 <20251219171412.GG254720@nvidia.com>
Subject: Re: [PATCH 3/4] ARM: remove support for highmem on VIVT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 19, 2025, at 18:14, Jason Gunthorpe wrote:
> On Fri, Dec 19, 2025 at 05:15:58PM +0100, Arnd Bergmann wrote:
>>  arch/arm/Kconfig                    |  1 +
>>  arch/arm/configs/gemini_defconfig   |  1 -
>>  arch/arm/configs/multi_v5_defconfig |  1 -
>>  arch/arm/configs/mvebu_v5_defconfig |  1 -
>>  arch/arm/include/asm/highmem.h      | 56 ++---------------------------
>>  arch/arm/mm/cache-feroceon-l2.c     | 31 ++--------------
>>  arch/arm/mm/cache-xsc3l2.c          | 47 +++---------------------
>>  arch/arm/mm/dma-mapping.c           | 12 ++-----
>>  arch/arm/mm/flush.c                 | 19 +++-------
>>  9 files changed, 16 insertions(+), 153 deletions(-)
>
> This looks great, but do you think there should be a boot time crash
> if a VIVT and HIGHMEM are enabled, just incase?

Do you mean in the common code or just for Arm?

We could use the Arm specific cache_is_vivt() macro, but it feels like
the 'dpends on !CPU_CACHE_VIVT' Kconfig check I added is both
safer and simpler.

In common code I don't see a way to detect vivt caches. There is
cpu_dcache_is_aliasing(), but that also seems to cover ARM11
processors with aliasing VIPT caches, which are otherwise fine
here.

     Arnd

