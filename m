Return-Path: <linux-fsdevel+bounces-72046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8ACDC2B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA1830206A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC132D0DC;
	Wed, 24 Dec 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="hA1TjIyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38F224F3;
	Wed, 24 Dec 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577662; cv=pass; b=NmL6mulYklmQxNavLKSRzDOIGg5h22WvdIfOHbikxssNEhIZkI+sVcp8jWXtdY8QVXEV5agQ+RXB4gwgP5bkw9eVYbU6YZggF3kd78cuqC77avWdHQHl+ksdEk4MWGvR1HP1+El8nEiLt2bXd1CyUUvmZ/Oshq9isDaHDNuDR0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577662; c=relaxed/simple;
	bh=176Ole/tvAjRYt/vFqeQ1qgguYONJYLg0pmUl0ZM7B0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7jJoSFUoDtrc4fGEi5oWHUD0TpFLxfKqnh/OD9ZlabCEnOGa/jc6JTFKFsmnAGt7QKiTVsBX0pULDwq0aws6MeCBVXTnx7SPZdwKWvpHhyXMfn8nE4776PPmCOONCoUQOp4VwhzZq2qQv9HrsVSK8IVc2HbtRArKkSRPTVU2U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=hA1TjIyI; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1766577639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Unpy3JJyqNbHxIi+olVVYLFLGs3nzkcpGGbvN45njelkqsar42IxZ20/lgHkAcobqdtyNW8htXneldJ4hsuKelPoPzFSB/MlGQzb+IP7yu2pxj0P4NG/HY0UcTri27w0vTIqaTjMoNf49OsZw/PFUYbuzBCtkR6u0MR2SGm5mT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766577639; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=176Ole/tvAjRYt/vFqeQ1qgguYONJYLg0pmUl0ZM7B0=; 
	b=UpPARitklb3x7yRw5BgSDErDOz0gZxO9fA9cO1YEURqNGcULQVD7IPqH+9sh+lH/GQEavNyq2I5xlgXQEWAWJKpM8ZabkCNyZDO4kQOcDbJTR1nvIqFNAnYoHtaajUnq7wWclmwgYia9nr7Ts3L8cNvuP36CzHZOyTh/eRQ+DV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766577639;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=176Ole/tvAjRYt/vFqeQ1qgguYONJYLg0pmUl0ZM7B0=;
	b=hA1TjIyIMJAMbsl0EqRy7clGDOUHQREZJJicrwFLe7bQ7TGSVGFFUBNpQ/vha1Ir
	sloaF9i1EU+wFjlu5N2DTVKUoswiiDyh43SZhVkukhk/T1wJ0fePHGWVZwYgC5CF/SF
	uDWuB+M0CBUF/W3ANrs9A5aSFEzTGoLJSkeeHb00=
Received: by mx.zohomail.com with SMTPS id 1766577636521335.3919721590854;
	Wed, 24 Dec 2025 04:00:36 -0800 (PST)
Message-ID: <966687093123e00c166afabc0a9de87e0ba844d5.camel@mpiricsoftware.com>
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
	 <linux-kernel@vger.kernel.org>, shardulsb08@gmail.com
Date: Wed, 24 Dec 2025 17:30:30 +0530
In-Reply-To: <1e0095625a71cca2ff25c2946fd6532c28cfd1b0.camel@ibm.com>
References: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
	 <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
	 <a817a3a65e5a0fe33dbdf1322f4909c3ff1edfcc.camel@mpiricsoftware.com>
	 <1e0095625a71cca2ff25c2946fd6532c28cfd1b0.camel@ibm.com>
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

On Tue, 2025-12-16 at 20:28 +0000, Viacheslav Dubeyko wrote:
>=20
> The fix in hfs_bmap_alloc() sounds reasonable to me. But I don't see
> the point
> of adding hfs_bnode_get() in hfs_bnode_create() for the case of
> erroneous
> situation [1]:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (node) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_crit("new node %u already hashed?\n", num);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON(1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return node;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> It will be much better to return ERR_PTR(-EEXIST) here. Because, it
> is not
> situation of "doing business as usual". We should not continue to
> believe that
> "sun is shining for us", but we should stop the logic somehow.
>=20
> Thanks,
> Slava.
>=20
> [1] https://elixir.bootlin.com/linux/v6.18/source/fs/hfs/bnode.c#L518

Hi Slava,

Thanks, agreed.

I=E2=80=99ll keep the hfs_bmap_alloc() change to ensure node 0 is never
allocated.

And I agree that the =E2=80=9Calready hashed?=E2=80=9D case in hfs_bnode_cr=
eate()
should not try to continue by returning a pointer (even with an extra
hfs_bnode_get()). Callers like hfs_btree_inc_height() and
hfs_bnode_split() treat the returned node as a freshly allocated node
and immediately rewrite its header/records. If hfs_bnode_create()
returns an existing hashed node, that effectively overwrites live node
contents and amplifies corruption, which can then cascade into later
failures.

So I=E2=80=99ll rework v2 as a small series:
1/2: guard against allocating node 0 in hfs_bmap_alloc()
2/2: make the =E2=80=9Calready hashed?=E2=80=9D path return ERR_PTR(-EEXIST=
) and
propagate the error

I=E2=80=99ll send the updated series shortly.

Thanks,
Shardul

