Return-Path: <linux-fsdevel+bounces-72082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46332CDD492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DE2300B69C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 04:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661ED2D190C;
	Thu, 25 Dec 2025 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="VtPP2esm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6C2853E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636177; cv=pass; b=NV4mMXvWMhnaGy1a3Yym9xX+O7r9Fq1p7K3nI/hw08hAIJa1vBI6XQMzVIGPPQUNGyyUjS9cLJIh2XGA6vDgQ1hZKWHWU2UdXEjKVdQCFPhGn/RUCkJG6wKP/RlosE5nN8yK4/GpzSGn9G8ylhc480mcHOslfwtWf7/hnOhXO00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636177; c=relaxed/simple;
	bh=En56k355+h6jvrDLlFr7qoTzHrfLKklZe97f8ari3Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDCdTl/B3tjUM2lvVgE0Wh5xSH7OsAICb58ZVpaMqzeSwhty98U1TgD6qfUhu8iJMfL8h9KdHpGeDeg1YuqsGsxfEES+USWRDiPrFyhwvct4mETehnjdmQSj5G420eRTzzLBpYDVoC0pURP2yWFXWPJd8tYGou2FfRnBCdZD6ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=VtPP2esm; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766636127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZTAoD8k3e5x54K2r3e6I4xg7TJj+5JxUrAp/MNkDuF7LkUpLGGP9EjBq1sGQxOFiO7DvM3g0dPiKruZk7Wx7UBSev6MRUfdUupmFgAVDncV/wSwp+Fj6g0C4Ha4SCQYmXMCd98ZSjTp7QjTrRuN+AKUsYBKW1MnlSs0PhEJhuzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766636127; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=En56k355+h6jvrDLlFr7qoTzHrfLKklZe97f8ari3Rs=; 
	b=gLg8MdjYhYyvcrjhd9rzBeLAnInKK6bK7uiSKYwPjJdectsuQpu5mSro/t2GLMNBLXNwFjrJuEX42/L7gnDz2QgPxBm7A26x/vq7ToVA6ZQV1LH1T0IU4JLSyHYsWDA2WGRrvv57+1Aav7Mh+rP6/28Y+Ps29tc3tqq4LSL6MBg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766636126;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=En56k355+h6jvrDLlFr7qoTzHrfLKklZe97f8ari3Rs=;
	b=VtPP2esmCZun/qqTOpz/+Z4su++uOmrG0ldjJNWaO1XcISlU1wLDnr7bgx91f0xd
	BXTaDXFFP5Kre+FkJXw+3V0BjPRs2RgffLkhPuVCjOZMqRyjXuLAbhly7v/hVfjeoc8
	x1fE6IJwykqkSrpTNv1n4oPHCznmWs0dXrn+ub4s=
Received: by mx.zohomail.com with SMTPS id 17666361239511021.7792756869057;
	Wed, 24 Dec 2025 20:15:23 -0800 (PST)
Message-ID: <308b7b3c4f6c74c46906e25d6069049c70222ed8.camel@mpiricsoftware.com>
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Jinjiang Tu <tujinjiang@huawei.com>, "David Hildenbrand (Red Hat)"
 <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Matthew
 Wilcox <willy@infradead.org>, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev,  linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, shardulsb08@gmail.com
Date: Thu, 25 Dec 2025 09:45:16 +0530
In-Reply-To: <a629d3bb-c7e2-41e0-87e0-7a7a6367c1b6@huawei.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
	 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
	 <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
	 <05bbe26e-e71a-4a49-95d2-47373b828145@kernel.org>
	 <a629d3bb-c7e2-41e0-87e0-7a7a6367c1b6@huawei.com>
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

On Thu, 2025-12-18 at 21:11 +0800, Jinjiang Tu wrote:
>=20
> =E5=9C=A8 2025/12/18 20:49, David Hildenbrand (Red Hat) =E5=86=99=E9=81=
=93:
> =C2=A0
> > >=20
> >=20
> > =C2=A0Thanks for checking. I thought that was also discussed as part of
> > the other fix.=20
> > =C2=A0
> > =C2=A0See [2] where we have=20
> > =C2=A0
> > =C2=A0"Note: This fixes the leak of pre-allocated nodes. A separate fix
> > will=20
> > =C2=A0be needed to clean up empty nodes that were inserted into the tre=
e
> > by=20
> > =C2=A0xas_create_range() but never populated."=20
> > =C2=A0
> > =C2=A0Is that the issue you are describing? (sounds like it, but I only
> > skimmed over the details).=20
> > =C2=A0
> > =C2=A0CCing Shardul.=C2=A0
> Yes, the same issue. As I descirbed in the first email:
> "
> At first, I tried to destory the empty nodes when collapse_file()
> goes to rollback path. However,
> collapse_file() only holds xarray lock and may release the lock, so
> we couldn't prevent concurrent
> call of collapse_file(), so the deleted empty nodes may be needed by
> other collapse_file() calls.=20
> "

Hi David, Jinjiang,

As Jinjiang mentioned, this appears to address what I had originally
referred to in the "Note:" in [1].

Just to clarify the context of the "Note:", that was based on my
assumption at the time that such empty nodes would be considered leaks.
After Dev=E2=80=99s feedback in [2]:
"No "fix" is needed in this case, the empty nodes are there in the tree
and there is no leak."

and looking at the older discussion in [3]:
"There's nothing to free; if a node is allocated, then it's stored in
the tree where it can later be found and reused. "

my updated understanding is that there is no leak in this case- the
nodes remain valid and reusable, and therefore do not require a
separate fix.

David could you correct me if I am mistaken?

[1]
https://lore.kernel.org/linux-mm/20251123132727.3262731-1-shardul.b@mpirics=
oftware.com/

[2]
https://lore.kernel.org/linux-mm/57cbf887-d181-418b-a6c7-9f3eff5d632a@arm.c=
om/

[3]
https://lore.kernel.org/all/Ys1r06szkVi3QEai@casper.infradead.org/

Thanks,
Shardul

