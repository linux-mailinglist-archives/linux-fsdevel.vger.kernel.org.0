Return-Path: <linux-fsdevel+bounces-17022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221628A6442
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35FC282873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA46E619;
	Tue, 16 Apr 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4EpvtrB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJzRYCLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461D6CDB9;
	Tue, 16 Apr 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249863; cv=none; b=iqH2UZic1Qb+OUcGNn3hreBZCje74fkuIQyUcUPaxxlvzfA59D8aicDOtvencJYLkt/UdDC2/Dy/BTwGpCqASFhv2tid3vRhF104+MQzujtM+dv2YhiLdTDQ+BHNM3XKa/HHC9ifr6VXGzg10aY3DkN06q8iVhanF5wL9XK4K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249863; c=relaxed/simple;
	bh=IDXyCoMqGfsMJVQO4R4ACB5kFoxMOUpZEeJyD5og0ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnVUmhyJSzpAzKJMnJbYhacoCpxhoxhDqfLA7DGLz8Vw3D0il0CE4sGjMysXCl7aj1NytG2jY25sKgks740uJ1EwVfFaTdYIQstZeayON4uuCXL1C8ZrXyDk1s2iEZdQnWFIwJZRfmxyd4lsGeNywed1nUcEHyuDkJYw3UIKz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4EpvtrB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJzRYCLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Apr 2024 08:44:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713249860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXvhT03wv4aD4mG7No4QBS1v7N0JoskGOicMYBhMYkU=;
	b=I4EpvtrBMDw8wtNcnN+FtV7XaKNKQxwSOUjI+gsa86yDttz6jik4c/ITUTbXRVSMCW5FgE
	j1ybcCdXv3uk9RbqRiJmEvwk5X19kmTOqqW7XWK5vpS+z5gXt+zzrtLg+99Om0014tdyES
	JOGcCCdqpzz9eib45hed8UOKMuFptKmg26d1n753cdw/gQeNFq8/Ci+ZBGGIEA7tYOKPTP
	7+dPSEYQv42OGaQobWn8yXdYHZ/+NegmuisSyNJ4LpjxPnq/lfLTs6vY3NMEzyPVu1SGa3
	g8U9b4BDtMDqJ8s+HwmPK7jcY5THj01jQ37v9JTWYtAJWMZcER3OE84d6Bzi1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713249860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXvhT03wv4aD4mG7No4QBS1v7N0JoskGOicMYBhMYkU=;
	b=bJzRYCLQmILvJC51K4zxw1Cp6h4ntNM+6v4foRDudJvLy+lpJM+x1SDNyCTogQ89bV3viq
	bSPWcQsruKAKuDCA==
From: Nam Cao <namcao@linutronix.de>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Andreas Dilger
 <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240416084417.569356d3@namcao>
In-Reply-To: <87le5e393x.fsf@all.your.base.are.belong.to.us>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
	<20240413164318.7260c5ef@namcao>
	<22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
	<20240414021555.GQ2118490@ZenIV>
	<887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
	<87v84kujec.fsf@all.your.base.are.belong.to.us>
	<20240415-festland-unattraktiv-2b5953a6dbc9@brauner>
	<87le5e393x.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-15 Bj=C3=B6rn T=C3=B6pel wrote:
> Thanks for getting back! Spent some more time one it today.
>=20
> It seems that the buddy allocator *can* return a page with a VA that can
> wrap (0xfffff000 -- pointed out by Nam and myself).
>=20
> Further, it seems like riscv32 indeed inserts a page like that to the
> buddy allocator, when the memblock is free'd:
>=20
>   | [<c024961c>] __free_one_page+0x2a4/0x3ea
>   | [<c024a448>] __free_pages_ok+0x158/0x3cc
>   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
>   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
>   | [<c0c17676>] memblock_free_all+0x1ee/0x278
>   | [<c0c050b0>] mem_init+0x10/0xa4
>   | [<c0c1447c>] mm_core_init+0x11a/0x2da
>   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
>=20
> Here, a page with VA 0xfffff000 is a added to the freelist. We were just
> lucky (unlucky?) that page was used for the page cache.

I just educated myself about memory mapping last night, so the below
may be complete nonsense. Take it with a grain of salt.

In riscv's setup_bootmem(), we have this line:
	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);

I think this is the root cause: max_low_pfn indicates the last page
to be mapped. Problem is: nothing prevents PFN_DOWN(phys_ram_end) from
getting mapped to the last page (0xfffff000). If max_low_pfn is mapped
to the last page, we get the reported problem.

There seems to be some code to make sure the last page is not used
(the call to memblock_set_current_limit() right above this line). It is
unclear to me why this still lets the problem slip through.

The fix is simple: never let max_low_pfn gets mapped to the last page.
The below patch fixes the problem for me. But I am not entirely sure if
this is the correct fix, further investigation needed.

Best regards,
Nam

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..17cab0a52726 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -251,7 +251,8 @@ static void __init setup_bootmem(void)
 	}
=20
 	min_low_pfn =3D PFN_UP(phys_ram_base);
-	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
+	max_low_pfn =3D PFN_DOWN(memblock_get_current_limit());
+	max_pfn =3D PFN_DOWN(phys_ram_end);
 	high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
=20
 	dma32_phys_limit =3D min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn=
));

