Return-Path: <linux-fsdevel+bounces-64936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9EBF71A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C6480EC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D33339B5C;
	Tue, 21 Oct 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwgmuw5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB226E6F4;
	Tue, 21 Oct 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057294; cv=none; b=RQ2GrdyGMz6SpH4w+SdHO9EyDPUx5p+klPefaNK2KA17W2DBr8pOBXB30oAJLDPkKIatyN//pYpN2DyUcxtrA65l+Z7tsabSeACh4zpx6t8xZoN+olnoQCVLQvb4hCEoMpmLIU9YecjRm993HTmdwymEu7Jld+uM7uJMyBQVhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057294; c=relaxed/simple;
	bh=EWE6Nx+FX60ueBkFeon7uOBNuF+baquUoJwDWQJ1f1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BwTH1piBXlneOwSQ1LSWmkkM7y7T9IOwU2it9tCg5TOd2Ix3BzOZRfnIC/uJcYfA9DZVT1didu0kFsGaNrjOvmYc5B+9xxjS40+UGcyH3mOz+aFabGDBwcc9eD3MY1GQrmKrP2a06kH0OLo9EPONjJkLz7X0p//iMqMHRAjbOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwgmuw5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01617C4CEF1;
	Tue, 21 Oct 2025 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761057293;
	bh=EWE6Nx+FX60ueBkFeon7uOBNuF+baquUoJwDWQJ1f1Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Kwgmuw5H+aQlxQX6eJSn7Gcv8q0JrBmHJ9cw0dWIcOGjxbyrlM3se7qxa64BX/1Ic
	 s0zQXlAEj7KknU4FoxF6k3CBY4x4DgGxFEWmmXc2XexkiioEjXorZrCgQtUHL5W1mZ
	 7RYwQy6w5TXVU6Rz7dwTOsSBlc9wfjou+R9Fux4trp4yJbpnYPMQYYr3csRQtNIzQ6
	 C1Z7OVf0OoKWZX4l+6U74qAXbG6MOVhorivH8FA4gzaALV8Tm8WttcY7vAG1EccWrf
	 JzmV0T6cu2mG7xT34/P+AWSEngOfmQtDz0c2uNz7zwOqzQfzQw/aPf7dJb6clnDACu
	 lA+GOVYzi90Xg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 16:34:49 +0200
Message-Id: <DDO2PI0D2L6Q.3OPXNQOV7Y0H6@kernel.org>
Subject: Re: [PATCH v2 3/8] rust: uaccess: add
 UserSliceWriter::write_slice_partial()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-4-dakr@kernel.org> <aPeSCuFNrV-_qvBf@google.com>
 <DDO29UN4UBVV.E90DEBURH63A@kernel.org> <aPeWOhycOIl_rlI-@google.com>
In-Reply-To: <aPeWOhycOIl_rlI-@google.com>

On Tue Oct 21, 2025 at 4:18 PM CEST, Alice Ryhl wrote:
> On Tue, Oct 21, 2025 at 04:14:22PM +0200, Danilo Krummrich wrote:
>> On Tue Oct 21, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
>> > On Tue, Oct 21, 2025 at 12:26:15AM +0200, Danilo Krummrich wrote:
>> >> The existing write_slice() method is a wrapper around copy_to_user() =
and
>> >> expects the user buffer to be larger than the source buffer.
>> >>=20
>> >> However, userspace may split up reads in multiple partial operations
>> >> providing an offset into the source buffer and a smaller user buffer.
>> >>=20
>> >> In order to support this common case, provide a helper for partial
>> >> writes.
>> >>=20
>> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>> >>  1 file changed, 24 insertions(+)
>> >>=20
>> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> >> index 2061a7e10c65..40d47e94b54f 100644
>> >> --- a/rust/kernel/uaccess.rs
>> >> +++ b/rust/kernel/uaccess.rs
>> >> @@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Re=
sult {
>> >>          Ok(())
>> >>      }
>> >> =20
>> >> +    /// Writes raw data to this user pointer from a kernel buffer pa=
rtially.
>> >> +    ///
>> >> +    /// This is the same as [`Self::write_slice`] but considers the =
given `offset` into `data` and
>> >> +    /// truncates the write to the boundaries of `self` and `data`.
>> >> +    ///
>> >> +    /// On success, returns the number of bytes written.
>> >> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: file:=
:Offset) -> Result<usize> {
>> >
>> > I think for the current function signature, it's kind of weird to take=
 a
>> > file::Offset parameter
>> >
>> > On one hand, it is described like a generic function for writing a
>> > partial slice, and if that's what it is, then I would argue it should
>> > take usize because it's an offset into the slice.
>> >
>> > On another hand, I think what you're actually trying to do is implemen=
t
>> > the simple_[read_from|write_to]_buffer utilities for user slices, but
>> > it's only a "partial" version of those utilities. The full utility tak=
es
>> > a `&mut loff_t` so that it can also perform the required modification =
to
>> > the offset.
>>=20
>> Originally, it was intended to be the latter. And, in fact, earlier code=
 (that
>> did not git the mailing list) had a &mut file::Offset argument (was &mut=
 i64
>> back then).
>>=20
>> However, for the version I sent to the list I chose the former because I
>> considered it to be more flexible.
>>=20
>> Now, in v2, it's indeed a bit mixed up. I think what we should do is to =
have
>> both
>>=20
>> 	fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result=
<usize>
>>=20
>> and
>>=20
>> 	fn write_slice_???(&mut self, data: &[u8], offset: &mut file::Offset) -=
> Result<usize>
>>=20
>> which can forward to write_slice_partial() and update the buffer.
>
> SGTM.
>
>> Any name suggestions?
>
> I would suggest keeping the name of the equivalent C method:
> simple_read_from_buffer/simple_write_to_buffer

Hm..that's an option, but UserSliceWriter corresponds to
simple_read_from_buffer() and UserSliceReader corresponds to
simple_write_to_buffer().

I think having UserSliceWriter::simple_read_from_buffer() while we have
UserSliceWriter::write_slice() is confusing. But swapping the semantics of
simple_read_from_buffer() and simple_write_to_buffer() is even more confusi=
ng.

So, I think using the existing names is not a great fit.

Maybe something like write_file_slice() or write_slice_file()? The former c=
ould
be read as "slice of files" which would be misleading though.

