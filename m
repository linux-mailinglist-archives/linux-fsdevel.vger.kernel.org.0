Return-Path: <linux-fsdevel+bounces-70181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E778C92D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 368DF4E5B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15E33374D;
	Fri, 28 Nov 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JLkiHJgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972652C030E;
	Fri, 28 Nov 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352280; cv=pass; b=dDzVjdwowFJG5W3rI9d0LZC/GnOVY7YfSOCfNUYG3Pj7zypfUf3JlA9VpOtTLPiruyXLabs12LKmMpEEvIwgd/N0BHtN52ahTOb1HyJuW4Pz6otFVu4qcEkJbbqM+d2eR/2z+AJeLJGDbYNDB0CchKe+fgK0Cvyn1+/tm8wxx9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352280; c=relaxed/simple;
	bh=G9TaF18+b9gVs6g2UJus3J79mfgPZhN/PNb4rQNmNVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hFiAZs5LAOaoeuOhHY20hi1hbofDxZnNX3xln0Sf73Of1QcrY0tojQ5VWHsF+v+eaiyEyraqbozGKnwn/Mtv9Xd7FSC1WJqA2+l1HMXY1a844UOptGJfd1G9Hm4f7oeBWCcRDiQCmlKWJM9y7jcH0hcK9gZ4FL0/umXxAuSzGg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JLkiHJgR; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764352242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jD1ZKYLI2d1J3n7Nn8PEelO5qXEL36eak47f/IL7PSnywyFON56Cz6XgCW6BAIRpNIh7z8XrJq41OJJmJMPAuyS7xa4B/oc8hxL4cIZy57+klHWD4IyeeRtIHckf1Eizx9HROuF9ooTM0ogOD94O51JZQjj7uM3etGKFsh/RmCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764352242; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CSvU9cF2EFsAjALyezUXtFWtkOVH0bcqxKUZhyUrvCM=; 
	b=hlWt7Ul8JWfnS5es+gdb3ogNyD1wyqlkaLaWdMm61GW/7kBYctfSbVqSjj9RNklpyw4fYmQA4s6Iv8VAeihZgRkxkO9HkOVZopXkloqHJzRaGg9fN/jroBYneUN8K6/E3/RQVYeEv/UUkp2f5jCJ8LPncQis3ZHBpGQYbcGGvks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764352242;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=CSvU9cF2EFsAjALyezUXtFWtkOVH0bcqxKUZhyUrvCM=;
	b=JLkiHJgRDZgOdpKVEbGaoTfTGM7cuUbG17mJn/6NMuYT6u06OPec0sZe6nT3/+Fo
	lhUdjv/UJIHSKjH8Cqh4iCDSYbq56Gg4UDmparCStPUdkcm/T1803IpgjoIH0GBQaSi
	6b4WuqAHjpec+TxDUK+qmFyq8X158V9inSAayWOk=
Received: by mx.zohomail.com with SMTPS id 1764352240347383.8438430122677;
	Fri, 28 Nov 2025 09:50:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v13 3/4] rust: Add missing SAFETY documentation for `ARef`
 example
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251117-unique-ref-v13-3-b5b243df1250@pm.me>
Date: Fri, 28 Nov 2025 14:50:21 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Benno Lossin <lossin@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06C410F4-8534-43B4-8DE1-039F70B26E5A@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-3-b5b243df1250@pm.me>
To: Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 17 Nov 2025, at 07:08, Oliver Mangold <oliver.mangold@pm.me> wrote:
>=20
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/sync/aref.rs | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 4226119d5ac9..937dcf6ed5de 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self =
{
>     /// # Examples
>     ///
>     /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>     ///
>     /// struct Empty {}
>     ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does =
not count references and
> +    /// // never frees the underlying object. Thus we can act as =
having a refcount on the object

nit: perhaps saying =E2=80=9Can increment on the refcount=E2=80=9D is =
clearer?

> +    /// // that we pass to the newly created `ARef`.
>     /// unsafe impl RefCounted for Empty {
>     ///     fn inc_ref(&self) {}
>     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>     ///
>     /// let mut data =3D Empty {};
>     /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>     /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>     /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>     ///
>=20
> --=20
> 2.51.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

