Return-Path: <linux-fsdevel+bounces-72040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C8CDC05D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF80E301B829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114663191A0;
	Wed, 24 Dec 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QeJJgFZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyacBheg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31131618C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572810; cv=none; b=XF7lJ+lHNGDUA7ErfqG4rwSJMW3+Epg9KNc9dlpewo+VFJDvBRXqxnkRys6bhaYW0imb/7BsDyZLOGT2+Cu0entJCZZtINDcYgrCsUx5CAZp6h+cmpDA3ZqboMzZBvoW61visSqkQxRVn3bNgvMRroCYLzjeXZ/GxQDqOPhgvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572810; c=relaxed/simple;
	bh=U2BLbPj3kQ/cXsnTnjjcp7gLD2gSynIOimDsajpv8go=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gp8EPZzHXxd1eRNwwpk3Jrt7XEkdTp639pTPXdYQ6FgyRbp5qCabD0PO/9wKLD/PA6GOb/GHatjEP3PYcAXcuVsN3Lk+vik032gUicgMsNLO18dlDfsnRxmYIin4+lJj3mziZY8LPY8cpz2bUHOhPz02aCQIqpr8lXFgfQCfknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QeJJgFZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyacBheg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16CC97A0111;
	Wed, 24 Dec 2025 05:40:07 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 24 Dec 2025 05:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766572806;
	 x=1766659206; bh=YX0Iu63byjNVx+YuTlIdUvEoIm6dN1b2nrc/xx3b1B4=; b=
	QeJJgFZhNvvg0LviLTt+Pq5z3YtzD9j7TUGykYJZMwfAX0UFf6qeDVyVIERLmj5p
	U7j/beLiLT4zFfDYY/bX9GbjBd2MkzDcWJM5CapFk/lYhsWlrLjvRsHhPArOucK+
	oM5O4fAp1pWVB50sMYoixNnD8B8mWIkErPF7ZfAchJJE8jEe9oHngj4CWWcTzurL
	UtR+OffS0D49o+dM8YZ9iDIoYxUkTRr3trBcSI+qd6I7+MRdqma44EA6FE/24IrX
	3IiZXXefHN2GRZ7XkOIhYgzFpUarW7nIQRqisVOBOoYkhoSoJDRQezI3JQUok0MD
	9Kh4HKMAAVKu6Pxb7e9xjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766572806; x=
	1766659206; bh=YX0Iu63byjNVx+YuTlIdUvEoIm6dN1b2nrc/xx3b1B4=; b=L
	yacBhegZDB19uOBTAp/wSlLXl8g6HBw0+822kqJcnJiIdEm6W+a8lHW2tr66/HJF
	oxpnd+iRDmx4rCaC9u/H8yFh09nkx538PDqIQ86KzhtVmuBR/VllurMBodF5p6iq
	vlKcjySvJq+ECORrqOCTpFi5do4v4hP3x+B8FG4uiIGoV3VJ11w41ifHkyMxpVkX
	PItiB//BWRFNF6Cz0U0TPgDDV5jRYxZfWpRzmR2q90i/hBnqbh2gYMGeVoN2OZiM
	rFWjIge4/DHxL2S3RVSBxZ5tVMR2YUdnrN9PhqjhfadJZ/cHELc8gkooejWNHcFj
	WgatZY5d/aQpBvTMtWZTA==
X-ME-Sender: <xms:BcNLaQ8_rLHVTGubTg2P5ApbiePHfRLPueQURHHYIn4yM1yRNivjNw>
    <xme:BcNLaTgnYWbussBHtYvReijMeyGzF5RDOnjwZpljyD3i3rzrX4cvRjTLXaI3xtGjs
    xFX0CfAf-Krn4xifppTrCf97cnrPk_15Du-2hfEAbYIdTHkwk1xb4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeivdeglecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:BsNLabj5Yb1efwgwyTd1LSIMoi70vcnjBOt3SFtI-jp0Z29wK1e9LA>
    <xmx:BsNLadkCZiJD4h480VwjNs-pq8OK3G1CzOk3qfrOsmNA6HAkAqeqMQ>
    <xmx:BsNLaUq0Wy6zYySKPnxsEUBzUKAr8PGSq2bXJWTVEibcouFQDC-kzA>
    <xmx:BsNLaZJ9xGBNNGmTeO_GCEZiyEqQkgoYgAA_A9A2X_-wwwkI0r4IJQ>
    <xmx:BsNLaQOG8zh3VdLD6QUVIu4Ol1HBvAQigwbEglcR8MAqbb0gtF6h8g8h>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4F4570006D; Wed, 24 Dec 2025 05:40:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQxZfb8dcq5J
Date: Wed, 24 Dec 2025 11:39:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-mm@kvack.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <f6c49549-57af-4640-a09e-896c47bb8657@app.fastmail.com>
In-Reply-To: <aUtPRFdbpSQ20eOx@nvidia.com>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-4-arnd@kernel.org>
 <20251219171412.GG254720@nvidia.com>
 <513078d3-976a-4e6d-b311-dcfcfea99238@app.fastmail.com>
 <aUtPRFdbpSQ20eOx@nvidia.com>
Subject: Re: [PATCH 3/4] ARM: remove support for highmem on VIVT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 24, 2025, at 03:26, Jason Gunthorpe wrote:
> On Fri, Dec 19, 2025 at 09:34:33PM +0100, Arnd Bergmann wrote:
>> On Fri, Dec 19, 2025, at 18:14, Jason Gunthorpe wrote:
>> >
>> > This looks great, but do you think there should be a boot time crash
>> > if a VIVT and HIGHMEM are enabled, just incase?
>> 
>> Do you mean in the common code or just for Arm?
>> 
>> We could use the Arm specific cache_is_vivt() macro, but it feels like
>> the 'dpends on !CPU_CACHE_VIVT' Kconfig check I added is both
>> safer and simpler.
>
> Okay, so maybe I'm asking if !CPU_CACHE_VIVT then the kernel fails to
> boot on vivt systems, maybe it already does?
>

Yes, in two separate ways:

- you can build a kernel for any combination of armv4/v4t/v5 CPUs
  (all VIVT), or any combination of armv6/v6k/v7/v7ve/v8 CPUs
  (all VIPT or PIPT), but we already enforce that you cannot mix
  the two in any way. The two sets are sufficiently different in
  terms of instruction set, MMU cache and FPU that trying to boot
  the wrong one probably doesn't even get to the point of printing
  any output.

- If something changed about the assumption above, any Arm kernel
  still needs to enable support for each individual CPU model that
  you may want to boot on. Enabling a SoC family will select the
  CPUs used in that SoC, and enabling a CPU type selects
  the cache features like CPU_CACHE_VIVT. Attempting to boot
  on a CPU model that is not enabled in the kernel build makes
  it fail in setup_arch() with:

                pr_err("CPU%u: configuration botched (ID %08x), CPU halted\n",
                       smp_processor_id(), midr);
                while (1)
                        ;

     Arnd

