Return-Path: <linux-fsdevel+bounces-71447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2851CC10DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 07:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9363064AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74F3358A3;
	Tue, 16 Dec 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="XKJGAoZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798E314D3F;
	Tue, 16 Dec 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864970; cv=pass; b=Dx5iH0DzdtbCgIbxq8mcmiYeA5Rs92Hggjcm/AxIYwjRRXzOeoHegYdAHTQJaWib7Ii/ilJq29a+zUxlo3cjGC0/XcIGyt3pSgNDfdC/O8pexVGzspTxJAeYqWZcpyyQRW9UUwjIaX7reyxnB0NjgNILsChod2xWna3rvavVfDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864970; c=relaxed/simple;
	bh=o3Qg5JRmMwGDF3p/T3/l0ZjhBDewxanTJLhadQipe+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXlqd+2HpOrwIgsWmHK5pdtd3Ru9+F4ReVh/uzIGGUsE0NEdrBdHqAQnPFPOA98IvSmc2t2CllvDC/zndgQPvu2YhKnI+aMDtBqo/u4BGiOOcJSf5e9Pbubf7QTPr8QLsuWPhSY611frmeRTejDvBGOsjINCY6Hbm2TqqRQKUu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=XKJGAoZy; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1765864913; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jz/b+kKpyoMrARisG49XzLwX6Px4pIDmV+mKjxv3Cwxyx288kJieL1MbZ3+Iify9uWhUEX1e8Gswlldl24aHfeLk+7O+ycgPwgRYRI6do49hH05Ny8ofiWGt9Pmqmx9HYp0dVRJYNIZLsX/X9Ny0DzVRt5O4qYeAp8zVIC4UkzM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765864913; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iDKJSy1+HGomXOdPqIFVnYQ2TFsCA8v+FwGq799BqTg=; 
	b=RbeS+bUSgEc/6eNZ0uFurM0oNWlBZlYd/t+mZNkLjczkE1x6QGjbT+eDgDTz//DIAKzketlRHmNLXviB6hnxWdIvySHYCuOY/vYZ1jlMxI79dLB9ebH0HW2i5wHEL6Lh5g7TwhVUUxSUalKO3Lr2S2+H7i0GsCz2roC/zkjqEzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765864913;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=iDKJSy1+HGomXOdPqIFVnYQ2TFsCA8v+FwGq799BqTg=;
	b=XKJGAoZy3fZOjTUr29LTr0zSYjGkOvaMjlPOS79ONTBpIepZ/AmH2kSGuktF4n+Q
	xWTC2cFQoedv4XEu2llAVoV2XNhZv1Klp7COf1t/pnMfUtfFkZeyDc0wAc1AmhMekW/
	5PfgWXkKNIHq2tKKA6yPviNaO6G69HUMc7Bczq1g=
Received: by mx.zohomail.com with SMTPS id 1765864910514260.799509465318;
	Mon, 15 Dec 2025 22:01:50 -0800 (PST)
Message-ID: <a817a3a65e5a0fe33dbdf1322f4909c3ff1edfcc.camel@mpiricsoftware.com>
Subject: Re:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "zippel@linux-m68k.org"
	 <zippel@linux-m68k.org>, "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"frank.li@vivo.com"
	 <frank.li@vivo.com>
Cc: "akpm@osdl.org" <akpm@osdl.org>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Tue, 16 Dec 2025 11:31:44 +0530
In-Reply-To: <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
References: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
	 <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-12-15 at 19:29 +0000, Viacheslav Dubeyko wrote:
> Frankly speaking, I don't see the fix here. You are trying to hide
> the issue but
> not fix it. This is situation of the wrong call because we sharing
> error message
> and call WARN_ON() here. And the critical question here: why do we
> call
> hfs_bnode_create() for already created node? Is it issue of tree-
> >node_hash? Or
> something wrong with logic that calls the hfs_bnode_create()? You
> don't suggest
> answer to this question(s). I've tried to debug likewise issue two
> months ago
> and I don't know the answer yet. So, you need to dive deeper in the
> issue or,
> please, convince that I am wrong here. Currently, your commit message
> doesn't
> convince me at all.
>=20

Hi Slava,

Thank you for the review. You are absolutely correct- the panic is a
symptom of a deeper logic error where the allocator attempts to re-
allocate an existing node.

I have investigated the root cause using the Syzkaller reproducer and
analyzed the crash logs. I found two distinct issues that need to be
addressed, which I plan to submit as a v2 patch series.

1. The Root Cause: Corrupted Allocation Bitmap (Allocator Logic Error):
The Syzkaller-generated image has a corrupted allocation bitmap where
Node 0 (the Header Node) is marked as "Free" (0).

    Mechanism: hfs_bmap_alloc trusts the on-disk bitmap, sees bit 0 is
clear, and attempts to allocate Node 0.

    Conflict: It calls hfs_bnode_create(tree, 0). Since Node 0 is the
header, it is already in the hash table. hfs_bnode_create correctly
detects this and warns:
[41767.838946] hfsplus: new node 0 already hashed?
[41767.839097] WARNING: fs/hfsplus/bnode.c:631 at
hfsplus_bnode_create.cold+0x41/0x49

Proposed Fix (Patch 1): Modify hfs_bmap_alloc to explicitly guard
against allocating Node 0. Node 0 is the B-Tree header and is
structurally reserved; it should never be allocated as a record node,
regardless of what the bitmap claims.

2. The Crash: Unsafe Error Handling (Refcount Violation) Even though
the allocator shouldn't request Node 0, hfs_bnode_create currently
handles the "node exists" case unsafely.

    Mechanism: When it finds the existing node (the header), it prints
the warning but returns the pointer without incrementing the reference
count.

    Result: The caller receives a node pointer, uses it, and eventually
calls hfs_bnode_put. Since the refcount wasn't incremented, this leads
to a refcount underflow/panic.

    Evidence: The panic occurs later in the execution flow (e.g.,
inside hfs_bnode_split or hfsplus_create_cat), proving the system is
running with a "ticking time bomb" node pointer.
[41767.840709] kernel BUG at fs/hfsplus/bnode.c:676!
[41767.840751] RIP: 0010:hfsplus_bnode_put+0x4a0/0x5c0
[41767.840826] Call Trace:
[41767.840833]  hfs_btree_inc_height.isra.0+0x64e/0x8b0
[41767.840878]  hfsplus_brec_insert+0x97b/0xcf0

Proposed Fix (Patch 2): I still believe we should add
hfs_bnode_get(node) in hfs_bnode_create (the original patch). Even if
the allocator is fixed, hfs_bnode_create should be robust. If it
returns a valid pointer, it must guarantee that pointer has a valid
reference reference to prevent UAF/panics, consistent with the fix in
__hfs_bnode_create (commit 152af1142878).

Plan for v2:

    Patch 1: hfsplus: prevent allocation of header node (node 0) (Fixes
the logic error)

    Patch 2: hfsplus: fix missing hfs_bnode_get() in hfs_bnode_create()
(Fixes the crash safety)

Does this approach and analysis address your concerns?

Thanks, Shardul

