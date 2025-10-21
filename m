Return-Path: <linux-fsdevel+bounces-64933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ABEBF7005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1984418A1A64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4233B97C;
	Tue, 21 Oct 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIh9XmSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771532BF59;
	Tue, 21 Oct 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056067; cv=none; b=QMRrpgIbyXcy+mUl5kqSIjh69eoodOMFY+DkPggeL6XB59/vEdxtAHW59GcM6LlAuC+o5P2iNMvq4k/m+0PnesN7JWjvAU7nfpGv7215bg9qyugOdQbPXk1TKHIxZH0yeUPXNnJb27cnXNJKcIie+mnp8wKjF5LIduq2v2xNsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056067; c=relaxed/simple;
	bh=mmPDSNu+MmHZLlNmu3xhON2g5qb18NClmdf/a+MlqDE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qTQ39uswk8hxJd5Lhcof1YScVRXT9o8fEZF4z83VLkAhSKovrws0fhNhWMDr91yrZjcQW2jSvmQmeFYhERM2/POAgj3oyQS6U34YF37sT4UzxVaJNDLuwNTidrqk3soloLGjJPazU5P34fgCY3ls/J/LDvCqwmiZovbpC6Vc9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIh9XmSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F91DC4CEF1;
	Tue, 21 Oct 2025 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761056067;
	bh=mmPDSNu+MmHZLlNmu3xhON2g5qb18NClmdf/a+MlqDE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GIh9XmSU7xIg6QTh1ha0OWPIdIM52hl/JgQq5VGhjgLmf0gEc4bz7xPfwCCgUvFbN
	 2qFMNhxLQVVoHiTJRT4rlXE90oqLtU6GUM0H7tb9KBswXaAV/Je8mJK/F1EZhMMIL/
	 T8b1W5L3HtdZsR3nYw+YHgU6IRqp9Q5EIwR3QxBhVEhpkVy3tmJ7h4a3W9kgl8vZ11
	 Hkjl7WPStPE+Aj/guF1gGKpIlBotrrZUBrMafughlwG9YumzJyMUOPevm/qTkNlqe+
	 N2FgvuVMqzJ7EDLFkBpOemqej1mIGPhm6HLt7D2nNK/88dLNbfsRcu5ZjkPWQZDPhs
	 ERMpGFRwEmM2Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 16:14:22 +0200
Message-Id: <DDO29UN4UBVV.E90DEBURH63A@kernel.org>
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
In-Reply-To: <aPeSCuFNrV-_qvBf@google.com>

On Tue Oct 21, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
> On Tue, Oct 21, 2025 at 12:26:15AM +0200, Danilo Krummrich wrote:
>> The existing write_slice() method is a wrapper around copy_to_user() and
>> expects the user buffer to be larger than the source buffer.
>>=20
>> However, userspace may split up reads in multiple partial operations
>> providing an offset into the source buffer and a smaller user buffer.
>>=20
>> In order to support this common case, provide a helper for partial
>> writes.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>=20
>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> index 2061a7e10c65..40d47e94b54f 100644
>> --- a/rust/kernel/uaccess.rs
>> +++ b/rust/kernel/uaccess.rs
>> @@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Resul=
t {
>>          Ok(())
>>      }
>> =20
>> +    /// Writes raw data to this user pointer from a kernel buffer parti=
ally.
>> +    ///
>> +    /// This is the same as [`Self::write_slice`] but considers the giv=
en `offset` into `data` and
>> +    /// truncates the write to the boundaries of `self` and `data`.
>> +    ///
>> +    /// On success, returns the number of bytes written.
>> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: file::Of=
fset) -> Result<usize> {
>
> I think for the current function signature, it's kind of weird to take a
> file::Offset parameter
>
> On one hand, it is described like a generic function for writing a
> partial slice, and if that's what it is, then I would argue it should
> take usize because it's an offset into the slice.
>
> On another hand, I think what you're actually trying to do is implement
> the simple_[read_from|write_to]_buffer utilities for user slices, but
> it's only a "partial" version of those utilities. The full utility takes
> a `&mut loff_t` so that it can also perform the required modification to
> the offset.

Originally, it was intended to be the latter. And, in fact, earlier code (t=
hat
did not git the mailing list) had a &mut file::Offset argument (was &mut i6=
4
back then).

However, for the version I sent to the list I chose the former because I
considered it to be more flexible.

Now, in v2, it's indeed a bit mixed up. I think what we should do is to hav=
e
both

	fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<us=
ize>

and

	fn write_slice_???(&mut self, data: &[u8], offset: &mut file::Offset) -> R=
esult<usize>

which can forward to write_slice_partial() and update the buffer.

Any name suggestions?

