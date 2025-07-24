Return-Path: <linux-fsdevel+bounces-55964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89186B11127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F348E4E6D00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695A269806;
	Thu, 24 Jul 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bxtP0ehn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96B19EEC2;
	Thu, 24 Jul 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383057; cv=pass; b=Ko4/P6CCj//tnZrSNmCDPl7gtzhQXvmdpj73fBx7ZyiEB+5o3Y0vhjrfSB+rP6VQkS4Q4y+Vk9gQgz+XbcRMRQho/TIMKH44h3uTh8mAJSO5sqP1rki5MPEWv4WPUuuKs7GCmExTgpF2TVXnaANa4qRne1b8WS1MpmVf4kI4CR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383057; c=relaxed/simple;
	bh=CatsMGrYaSqiZzxtwSkAxSfGncG9RI2XBUzXsQIDsi0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fk6YUPJRQdI8E5Hmp3qSPhlHBHRvtUX3/KqO8RJ8FhyS/oPjYgRx8ipTjvD642OXm791ufkOn6LAuxNqQq8614EpqjrNAHQqIUF1zPW/ZiDZe8sdI6It5sMDNhCmTt8TD35Y4YR4vRT3MeQQBrPgco8+Cq9giB2ylLy5UYpbG0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bxtP0ehn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753383028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MpHMTuxUAqb4oRCWw4ibpqbslIYGOdCazZtwvUhou1OXZ8UcOHL1jDnyjOYq6quPVc6X2e3YRCosgbooy4t1O8uXAZHe5+8lFcyIBUYWWllB95jiBTehOKAmGnmjadzWl4oq/dQ6TJHxUm/XH4zVFGFcygOUX53+Ph/GdOTq/H0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753383028; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zUjBE1xSWZ/jaXPPwyRJK69aFYsYjVnhXaqAHUqMFpc=; 
	b=JRnHo/nfYbYUnJAYa/e+kFNWBF6OinORZmnmc3L1XY64dlJyzq4UiObhqZD9fn/BdPZHEsKB5uzTrOh9c3oDF6NniEOXubLqS6sWVt1P21V/TZvbJEu+rDYO9SyRqCVquLkdbqLFv/vx+XPaP9uzjOhfLi/QjrtwdQvfFTWlbSs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753383028;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zUjBE1xSWZ/jaXPPwyRJK69aFYsYjVnhXaqAHUqMFpc=;
	b=bxtP0ehnEfzmHeG/v506SxjsNt1XHDdhkZCojKt2FXUy3LqfTQYc2JJp82Gg9G3R
	yjjmxBytXehOSTFqGVYzkpG51l/Rhz6paVZBB6s8Mpyb3MMVg91Vf8jKaX1JBTF3Gce
	aGJcT59TXhv31WDVUj65YkJe9jBWCIj0HEsQrE/k=
Received: by mx.zohomail.com with SMTPS id 1753383025893371.2668099208014;
	Thu, 24 Jul 2025 11:50:25 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 0/3] rust: xarray: add `insert` and `reserve`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
Date: Thu, 24 Jul 2025 15:50:09 -0300
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 Janne Grunau <j@jannau.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39015200-6AB5-4331-A679-C0CF6DB4B930@collabora.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Tamir,

> On 13 Jul 2025, at 09:05, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> The reservation API is used by asahi; currently they use their own
> abstractions but intend to use these when available.
>=20
> Rust Binder intends to use the reservation API as well.
>=20
> Daniel Almeida mentions a use case for `insert_limit`, but didn't name
> it specifically.

Here is a patch that tests your code on Tyr [0]. I sadly didn't realize =
in time
that you were using impl RangeBounds as an argument to insert_limit(), =
which is
even nicer :)

Our internal tests still pass.

I also double-checked that the kunit/doctests pass, just in case.

>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v2:
> - Explain the need to disambiguate `Iterator::chain`. (Boqun Feng)
> - Mention what `Guard::alloc` does in the doc comment. (Miguel Ojeda)
> - Include new APIs in the module-level example. (Miguel Ojeda)
> - Mention users of these APIs in the cover letter.
> - Link to v1: =
https://lore.kernel.org/r/20250701-xarray-insert-reserve-v1-0-25df2b0d706a=
@gmail.com
>=20
> ---
> Tamir Duberstein (3):
>      rust: xarray: use the prelude
>      rust: xarray: implement Default for AllocKind
>      rust: xarray: add `insert` and `reserve`
>=20
> include/linux/xarray.h |   2 +
> lib/xarray.c           |  28 ++-
> rust/helpers/xarray.c  |   5 +
> rust/kernel/xarray.rs  | 533 =
++++++++++++++++++++++++++++++++++++++++++++++---
> 4 files changed, 536 insertions(+), 32 deletions(-)
> ---
> base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
> change-id: 20250701-xarray-insert-reserve-bd811ad46a1d
>=20
> Best regards,
> -- =20
> Tamir Duberstein <tamird@gmail.com>
>=20
>=20

Thanks a lot for working on this. It will definitely be used by us.


Tested-By: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-By: Daniel Almeida <daniel.almeida@collabora.com>

[0] =
https://gitlab.freedesktop.org/panfrost/linux/-/commit/791de453eb103af37e3=
cc6825e042f26d4c76426



