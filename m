Return-Path: <linux-fsdevel+bounces-72085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D5FCDD60B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F294A302069E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45662D9ED1;
	Thu, 25 Dec 2025 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="mR2lDkmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DC381AF;
	Thu, 25 Dec 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766644396; cv=pass; b=aPhTOXteNywoXLsxH3OP/Bqy8LoQttsAXdN2Xm4iTlx4jB6nB4FkAwOPh4zLPmTXgCEYaAyoZfWx+5YYcgQVWylfDxATdDm1RtP2V8ZSf7pKWQ7SqLv11d5wgPdAzCp8MPNDSIafYWHTxo3HAs5mPa+UHfzC7IXGRsyiruUiQGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766644396; c=relaxed/simple;
	bh=GOXBLxqo2LMwRHYZpfnLzcR4hzPaQhiZWC9cjpL3nQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mBKuUkm6kpEZ8o9xJoRWzoTbsgGkhKw8n9dbiuzomAv/lcbM3Z43MR+isihf2eTcNRhhYpRYOis1q6YaRuT37ojv5deMvypup2ynNKTuLQI8fhwsqXdfz2iH2cEqTS1UxFSADoKDZPlPjrJcLnjbponlzK1XT3GokfUB07DEaNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=mR2lDkmi; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766644374; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lbzXpn8WiivnVnb7MrkYfxidlLafTrqPBmTp8NEa+yt0y0y3WRq+KTT/RiDEHHrkypi9Jl+ZUVc0OuD4atf99aZeYgg3c1W1IbCJ4wtQtngW2SK3UaeHPnm7fJxK9r0+KfxY9OQ10JRtKvuZyZdsF29vHFjhvwQ9XDb2kBVDN1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766644374; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GOXBLxqo2LMwRHYZpfnLzcR4hzPaQhiZWC9cjpL3nQ4=; 
	b=oLAiGCNoSgP32et/IvkkLCPbI1AWaOvdb8jY27aiJyd9QEz1FyohA5v7mu671/sTsb4DiPE/R0hj1GVdPr2j/Flf3WhYT6KELlRGdfV2mAd8kMeL8lqepXWxKZSlLe5eALC65211o8WP52yCzQLKhUm9d8VgLr59NiH9Tdtmkdo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766644374;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=GOXBLxqo2LMwRHYZpfnLzcR4hzPaQhiZWC9cjpL3nQ4=;
	b=mR2lDkmilQLEZsXnrHfapOppLMDUcoXuW8KKLGQrwMNCGiz/lnYJnKVn6vhuJLkA
	WS1siLber1sekCQCmNxWNvZ8hhu8Ibr68joEepjNrM2yxmUgkAHuTpl2iUcDbGNDR8o
	OQKzOUkHmt7zE3q4EymLsO/6UpIfmKVRWynENY4Q=
Received: by mx.zohomail.com with SMTPS id 1766644372700994.7161841320656;
	Wed, 24 Dec 2025 22:32:52 -0800 (PST)
Message-ID: <de697a2fbf2464297d5e303a109b0edddddef207.camel@mpiricsoftware.com>
Subject: Re: [PATCH v2 1/2] hfsplus: skip node 0 in hfs_bmap_alloc
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, zippel@linux-m68k.org, 
 linux-fsdevel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janak@mpiricsoftware.com, 
 stable@vger.kernel.org,
 syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com, 
 shardulsb08@gmail.com
Date: Thu, 25 Dec 2025 12:02:46 +0530
In-Reply-To: <63e3ff1595ebd27e9835ae7057204b7eef0c1254.camel@dubeyko.com>
References: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
	 <20251224151347.1861896-2-shardul.b@mpiricsoftware.com>
	 <63e3ff1595ebd27e9835ae7057204b7eef0c1254.camel@dubeyko.com>
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

On Wed, 2025-12-24 at 20:02 -0800, Viacheslav Dubeyko wrote:
>=20
> I think that it's not completely correct fix. First of all, we have
> bitmap corruption. It means that we need to complain about it and
> return error code. Logic cannot continue to work normally because we
> cannot rely on bitmap anymore. It could contain multiple corrupted
> bits.
>=20
> Technically speaking, we need to check that bitmap is corrupted when
> we
> create b-trees during mount operation (we can define it for node 0
> but
> it could be tricky for other nodes). If we have detected the
> corruption, then we can recommend to run FSCK tool and we can mount
> in
> READ-ONLY mode.
>=20
> I think we can check the bitmap when we are trying to open/create not
> a
> new node but already existing in the tree. I mean if we mounted the
> volume this b-tree containing several nodes on the volume, we can
> check
> that bitmap contains the set bit for these nodes. And if the bit is
> not
> there, then it's clear sign of bitmap corruption. Currently, I
> haven't
> idea how to check corrupted bits that showing presence of not
> existing
> nodes in the b-tree. But I suppose that we can do some check in
> driver's logic. Finally, if we detected corruption, then we should
> complain about the corruption. Ideally, it will be good to remount in
> READ-ONLY mode.
>=20
> Does it make sense to you?
>=20
Hi Slava,

Yes, that makes sense.

Skipping node 0 indeed looks like only a local workaround: if the
bitmap is already inconsistent, we shouldn=E2=80=99t proceed as if it is
trustworthy for further allocations, because other bits could be wrong
as well.

For the next revision I plan to replace the =E2=80=9Cskip node 0=E2=80=9D g=
uard with a
bitmap sanity check during btree open/mount. At minimum, I will verify
that the header node (node 0) is marked allocated, and I will also
investigate whether other existing nodes can be validated as well. If
corruption is detected, the driver will report it and force a read-only
mount, along with a recommendation to run fsck.hfsplus. This avoids
continuing RW operation with a known-bad allocator state.

In parallel, I plan to keep the -EEXIST change in hfs_bnode_create() as
a robustness fix for any remaining or future inconsistency paths.

I=E2=80=99ll post a respin shortly.

If you=E2=80=99re OK with it, I can also post the hfs_bnode_create() -EEXIS=
T
change as a standalone fix, since it independently prevents a refcount
underflow and panic even outside the bitmap-corruption scenario. I=E2=80=99=
ll
continue working on the bitmap validation in parallel.

Thanks,
Shardul

