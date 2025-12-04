Return-Path: <linux-fsdevel+bounces-70671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52541CA405A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 637F230E25CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9E34A76A;
	Thu,  4 Dec 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="GsbHQqeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196A349B05;
	Thu,  4 Dec 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857794; cv=pass; b=oui2q/Ll3GBkg9JlDQp8H7RR4ckHa5E8oDFqWtcoAqxFeDg/UGa8uspHwbn1lKXuU8YBjsGQo3AqE+7EeGVE0FiZ1fNR48McApzApsVofhvQsM5LqP3huG1gSpooLWg4Jw90F2FpVlYeaGshMRalWngASXzL3gAkRyPex79pYyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857794; c=relaxed/simple;
	bh=gHt+J80Ob8eRXYoaAkQPsr4A9Ta+wjn9csPQpWRjcZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUX3faDsHFPY/HjnjD0PogJ49H7n1uysD+0xhw4V6RSNiX4RsXOPaLJQ/Uiy6NAyBASIs+E4paY6oHjrUF+0F8wPY/TWXcGDE5TVVvjtScD75dPfCspN6It3KPH6zoce4R2PBpceXkz/AsZZvgE94Z0eQgOBhLZLTpNhqhPsg3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=GsbHQqeQ; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1764857770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=clEw83IrwTeYwspIaLvRmWXRoLG616Phdyy4zW/+jQyQY2jLuwyaOLkoiPDZjXj2tsibCNK+tAofll5S81Ofm/5d/CvkEj9VRjUex7E7n80cjilP1IvItrLtFjuEZ97fFFCPS5KQFeUaSLWkOfSTi+S0H1yMEiPSYRFA858Vwlw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857770; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0BbWCE/CpKUDF4JSDA7vlb370W1f2kNu1LZOcbo6yAs=; 
	b=B6IMjet3PpN/CTo6sMsVIQGXKPxxRFoZUbLswnlX4djDYZ0vaFNtq9O4Cdfs6nKAwH5amvAWsrRoDgXgqIdHfyWPtn3wcWq4cGLHrmOLSkA7t4CM5PJheV2b6Gwpt5BtnwO1pxiiUMbhxawrLsSWd3KlbOCr6S2CMg81FB+7mNQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857770;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=0BbWCE/CpKUDF4JSDA7vlb370W1f2kNu1LZOcbo6yAs=;
	b=GsbHQqeQYmH9KsWBYutliPZ1R/baj0SsieFOaVSCKgaG8OySw0GWTvdWDYQu1LNQ
	ZDjkGCbDLJ+gktF0M91kr8UgvXqTLlsUyhIv09ggduByoUyYIk1C1aLnOFivFtUXS/Y
	vJhcFfbp9HNrlAT0l0ycotxiCS5sQYa5+lbWBifg=
Received: by mx.zohomail.com with SMTPS id 1764857765694732.1743433635124;
	Thu, 4 Dec 2025 06:16:05 -0800 (PST)
Message-ID: <78c9b5eeb10051dd9791ed3cb0ce7a18eedc5e7f.camel@mpiricsoftware.com>
Subject: Re: [PATCH v3] lib: xarray: free unused spare node in
 xas_create_range()
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, willy@infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org
Cc: dev.jain@arm.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, janak@mpiricsoftware.com,
 shardulsb08@gmail.com
Date: Thu, 04 Dec 2025 19:45:59 +0530
In-Reply-To: <57d5793d-2343-49b3-a30c-cd12dc40460d@kernel.org>
References: 
	<7a31f01ac0d63788e5fbac15192c35229e1f980a.camel@mpiricsoftware.com>
	 <20251201074540.3576327-1-shardul.b@mpiricsoftware.com>
	 <57d5793d-2343-49b3-a30c-cd12dc40460d@kernel.org>
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

On Mon, 2025-12-01 at 09:39 +0100, David Hildenbrand (Red Hat) wrote:
> Please don't post new versions as reply to old versions.
> ...
>=20
> ...
> The first thing xas_destroy() does is check whether xa_alloc is set.
>=20
> I'd assume that the compiler is smart enough to inline xas_destroy()=20
> completely here, so likely the xa_alloc check here can just be
> dropped.

Got it, will share a v4 of the patch on a new chain with redundant
xas_destroy() removed.

> Staring at xas_destroy() callers, we only have a single one outside
> of=20
> lib: mm/huge_memory.c:__folio_split()
>=20
> Is that one still required?

I checked the callers of xas_destroy(). Apart from the internal uses in
lib/xarray.c and the unit tests in lib/test_xarray.c, the only external
user is indeed mm/huge_memory.c:__folio_split().

That path is slightly different from the xas_nomem() retry loop I fixed
in xas_create_range():

	__folio_split() goes through xas_split_alloc() and then
xas_split() / xas_try_split(), which allocate and consume nodes via
xas->xa_alloc.

	The final xas_destroy(&xas) in __folio_split() is there to
drop any leftover split-allocation nodes, not the xas_nomem() spare
node I handled in xas_create_range().

So with the current code I don=E2=80=99t think I can safely declare that
xas_destroy() in __folio_split() is redundant- it still acts as the
last cleanup for the split helpers.

For v4 I=E2=80=99d therefore like to keep the scope focused on the syzkalle=
r
leak and just drop the redundant "if (xa_alloc)" around xas_destroy()
in xas_create_range() as you suggested.

Separately, I agree it would be cleaner if the split helpers guaranteed
that xa_alloc is always cleared on return, so callers never have to
think about xas_destroy(). I can take a closer look at xas_split() /
xas_try_split() and, if it looks sound, propose a small follow-up
series that makes their cleanup behaviour explicit and then removes the
xas_destroy() from __folio_split().

Thanks,
Shardul

