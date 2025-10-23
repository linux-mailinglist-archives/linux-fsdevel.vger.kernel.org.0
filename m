Return-Path: <linux-fsdevel+bounces-65310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB1C0131C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 14:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE3319A755B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188430F7ED;
	Thu, 23 Oct 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iczP/9oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D262F1FE6;
	Thu, 23 Oct 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223405; cv=none; b=enT6hE5gWH3fHy3RBZQEN8SUb8G2x8545c3ihIPJHuaO8VmGOpDHpeeyLurSEwdvJu1iYNmzgimLFd4yUs03zCNlcsHkrX2/NhQUhGZL/UWCo9Oi7lAWB9Q7jUxd6RmOHp0Oh5V03zo/QBUL0J9xaFcR77eXv0SKvblIk10uyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223405; c=relaxed/simple;
	bh=al+DPQz4YQhivF4SLVa2PpT/m2RtlvnEATBY44DPTiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Rw++uUSqMTEqOW7qltJTI3q26xuBGFIGSXaS4Om/rr9rRoaWRk5EOn/Bx1gKaJbYlU9/UrLTkyl5FV9qj55k3XP1rT4M2iMtTmi//2DLaoJAEhUia6YG38Pu3byTJX/Kam5vGZtq9A09CBMth77qZvTkVK3D2QKLaui+bJYTnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iczP/9oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4511AC4CEE7;
	Thu, 23 Oct 2025 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223405;
	bh=al+DPQz4YQhivF4SLVa2PpT/m2RtlvnEATBY44DPTiI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iczP/9oC06j/N3i3MMv7wHOJW80UuCo914UVvhM65AlK9aX+pC3sgC7k3nwd/knxk
	 XqdOpVMYMAolMvOeFz9rbXvNLaK5Dz+A1EGG4reTOowWEDggHCq3xW9GG+jlu7AsH9
	 eECpkvQN7Lys0hHjVulvzMlHMaTChXQx7uSsRqH6xcr3X0CLnUddrMUgtU2hDwLnx5
	 4VQAld5cS1LmmYsveBLqS3P2fkgB1uDnqra6+qpzLY9qCxKoXKO78iF/P5JCmMOyRW
	 WaWDcJg2MlEuDq99kGQ/Ex/csPot+fy7kKKvH+ng9bn35BL6DFErJ4/UBOSMGeV1SN
	 A4uUdNIQhs+DA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 14:43:20 +0200
Message-Id: <DDPPL8HKEERV.2JXDADIJPM6NY@kernel.org>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add
 UserSliceWriter::write_slice_file()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-6-dakr@kernel.org> <aPnnkU3IWwgERuT3@google.com>
 <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
In-Reply-To: <aPoPbFXGXk_ohOpW@google.com>

On Thu Oct 23, 2025 at 1:20 PM CEST, Alice Ryhl wrote:
> I would love to have infallible conversions from usize to u64 (and u32
> to usize), but we can't really modify the stdlib to add them.

We can (and probably should) implement a kernel specific infallible one.

I think we also want a helper for `slice::len() as isize`.

> But even if we had them, it wouldn't help here since the target type is
> i64, not u64. And there are usize values that don't fit in i64 - it's
> just that in this case the usize fits in isize.

Sure, it doesn't change the code required for this case. Yet, I think that =
if we
agree on having a kernel specific infallible conversions for usize -> u64 a=
nd
isize -> i64, it makes this + operation formally more consistent.

Here's the diff I'd apply:

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 681b8a9e5d52..63478dd7deb8 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -125,6 +125,22 @@ pub fn saturating_sub_usize(self, rhs: usize) -> Offse=
t {
     }
 }

+impl core::ops::Add<isize> for Offset {
+    type Output =3D Offset;
+
+    #[inline]
+    fn add(self, rhs: isize) -> Offset {
+        Offset(self.0 + rhs as bindings::loff_t)
+    }
+}
+
+impl core::ops::AddAssign<isize> for Offset {
+    #[inline]
+    fn add_assign(&mut self, rhs: isize) {
+        self.0 +=3D rhs as bindings::loff_t;
+    }
+}
+
 impl From<bindings::loff_t> for Offset {
     #[inline]
     fn from(v: bindings::loff_t) -> Self {
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 20ea31781efb..44ee334c4507 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -514,7 +514,8 @@ pub fn write_slice_file(&mut self, data: &[u8], offset:=
 &mut file::Offset) -> Re

         let written =3D self.write_slice_partial(data, offset_index)?;

-        *offset =3D offset.saturating_add_usize(written);
+        // OVERFLOW: `offset + written <=3D data.len() <=3D isize::MAX <=
=3D Offset::MAX`
+        *offset +=3D written as isize;

         Ok(written)
     }


