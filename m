Return-Path: <linux-fsdevel+bounces-71253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129ACBB206
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 19:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E557C3050CD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573172EC0A2;
	Sat, 13 Dec 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="seHpzZNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12941C3F36;
	Sat, 13 Dec 2025 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765648937; cv=none; b=CSeQ/mfmgaUcyBZQxQh79oh8VlqYMCIXF4TJ0y1I5wl2XUzZvy5ukZfuziyemWQzzOIawDqrydmGM6DXvYdYd2/yG9m+vgpOBYXatoLqWeGeHHRMFFBrRFoMoZsmJzuO4s/71n2m+sLe4J7BKvnXqOJm0jE2vrbG/R1yvVxelMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765648937; c=relaxed/simple;
	bh=BssAw7PET8/BHQwHSesp0XaFFVQIIVin3LW+oHfDG8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afsc84bm3OETVf4j52cyTaVGoW4VEImh7vuR4uKV1TNZ4B2JpUERRUYeONFX7QrIoX+Ptr9Hpha5KfGJDBcI9TjNAkF75wNRH/FHSIB4MXryNno+yK27jzh+erCJBoxJ92Qdc60ben84YBeqQr8J4MWWGgA3RAMX7gGFJsyT3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=seHpzZNV; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=frWSxsEqJYXGybxfwxfHXEnWNQMWsNHUqRASmbPzKAU=; b=seHpzZNVeFLzWx1fRKuHGvlng7
	iKti/JOY3PNS+bWGc//UBofzRUP4IrPk4TRMcUk6Up+dIkDHiBWjunind+fMZhHr22FvWhLsBVBBJ
	hcnw0Msq8aPX4h1xPEBn40cK+JD84WYUg+vXU/+1pQRFIx/hmCAyxZTnlf0Ndrwyw8eiF6NscKrM/
	GcSja4r1T7xvzufKKi85QY33Wzv0YlpUexFBT7zPnoFCRhIYQVll0UIipTF+lD0oozcFl01Xjbuwy
	7tvkeexlkhi3sht8SSaXMJSh2KFp0OdeiOn5gycbInllntiNIgFF+NUyltNoPOOHElzq0HAsjCzNv
	bGooeJN4rIuApNOSvhHlIkuz0tYt1WCEmjbzwOMuaGM/Ctotz/ZLf1clP473s5kn6O3sfEYP+DEsX
	/fCWw6W8ZKCzekBaKLQd4u82KM0K2cXqVZRrSRBWyfsEor2pJqUJqPl2Gb2P1kO27Ikc90fLbKMCN
	unfeKsiiVs0J0mb0VqbdWLw5wrkBS/egoELWQ8MXWFvAJiGeageosox+T4GEGpvcmYaBgdwpB1ZIs
	moUK1si8aQkAIGwHeCDvwCgCLG4F6bpNdcmnZydt634ODejokq9XDRYQbJkSyxWn+HG+x/AqrZiNh
	Hoi7qhT/Ybm9K0d6YosupvZqo/PkJ21EOGkgziHB4=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Christoph Hellwig <hch@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 asmadeus@codewreck.org, Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] 9p/virtio: convert to extract_iter_to_sg()
Date: Sat, 13 Dec 2025 19:02:00 +0100
Message-ID: <22933653.EfDdHjke4D@weasel>
In-Reply-To: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
References: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 13 December 2025 16:07:40 CET Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> This simplifies the code quite a bit and should fix issues with
> blowing up when iov_iter points at kmalloc data
> 
> RFC - Not really tested yet!!

TBH, that bothers me. Also considering the huge amount of changes; again, what
was actually wrong with the previously suggested simple patch v1 [1]? All I
can see is a discussion about the term "folio" being misused in the commit log
message, but nothing about the patch being wrong per se.

[1] https://lore.kernel.org/all/20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org/

> This brings two major changes to how we've always done things with
> virtio 9p though:
> - We no longer fill in "chan->sg" with user data, but instead allocate a
>   scatterlist; this should not be a problem nor a slowdown as previous
>   code would allocate a page list instead, the main difference is that
>   this might eventually lead to lifting the 512KB msize limit if
>   compatible with virtio?

Remember that I already had a patch set for lifting the msize limit [2], which
was *heavily* tested and will of course break with these changes BTW, and the
reason why I used a custom struct virtqueue_sg instead of the shared sg_table
API was that the latter could not be resized (see commit log of patch 3).

[2] https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/

/Christian



