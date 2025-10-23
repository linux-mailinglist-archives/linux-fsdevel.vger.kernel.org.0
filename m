Return-Path: <linux-fsdevel+bounces-65296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 689CBC009F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F5C4EAAF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE930B514;
	Thu, 23 Oct 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI5i6AjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337530C375;
	Thu, 23 Oct 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217420; cv=none; b=YXozHbNTs4eKT0gQlC0qlLJ8hgQTG6eJUc2bGMqxVY7ISwsQ9lqnTC7gKgQCqUql4oI0xPMalCgvk+3bmCcKd0yTvAhGsXT7bEgl+Hfs3CmLHQt3Zk+7qDhSZl5G6l2NakLbM/V625yXZPiCZgVJUN6L6KSPkeSSCpblZvg0rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217420; c=relaxed/simple;
	bh=hgYU/otvTYwYyjpmBrCCG+P8GjUEb3ooE2uhRepKbWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FiqTHtujGQMWMaFFtVh+UGaw7TXypITnOwvCgNUVuU+SOeIikMnL6Ov3BiGRW4b1+UN35IlN9L0zwNlfAb3LNBMLJpQAN6WMcOvhLTu2XCSNUl9DTF11bj3uDnAvKIRb9w/p5V3gNCnBfLO+L1Lko9jWvW0V7FR42joLx6LPLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI5i6AjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C8C4CEE7;
	Thu, 23 Oct 2025 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761217419;
	bh=hgYU/otvTYwYyjpmBrCCG+P8GjUEb3ooE2uhRepKbWE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=oI5i6AjNf9nLRpgx+TtRRPlMFvvGB53Krcu+hLbmzevmSOeL8pwcw1XCl5bh5xIra
	 rzZ1xlUfgf3MLhlc4vEppPWONdUe0/UilNX0N+Nq3/aj9mM5ZrEkUF/m8nIcmxaIEO
	 L279y7rMulLjLGKHjHlpdDabWgwDow6B1ucMcQTEnySRrQc9QfKzJ0jhpm2q7pTwFq
	 vit6M1gntqMI6WVxuOKufbXAnRPphPc6+Oy7XVIXcpiTPCRaiv+Rc5pTsrfBZvBnZR
	 L/19+j2qlWXj4/nsGxPzgEujokOZxYbEoL5lgi5j/Wa8zfMVtcUJiSimpavSCRyuOz
	 cuspWsNXjSxHw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 13:03:35 +0200
Message-Id: <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org>
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
In-Reply-To: <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>

On Thu Oct 23, 2025 at 12:37 PM CEST, Alice Ryhl wrote:
> On Thu, Oct 23, 2025 at 12:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> On Thu Oct 23, 2025 at 10:30 AM CEST, Alice Ryhl wrote:
>> > On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
>> >> Add UserSliceWriter::write_slice_file(), which is the same as
>> >> UserSliceWriter::write_slice_partial() but updates the given
>> >> file::Offset by the number of bytes written.
>> >>
>> >> This is equivalent to C's `simple_read_from_buffer()` and useful when
>> >> dealing with file offsets from file operations.
>> >>
>> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >> ---
>> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>> >>  1 file changed, 24 insertions(+)
>> >>
>> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> >> index 539e77a09cbc..20ea31781efb 100644
>> >> --- a/rust/kernel/uaccess.rs
>> >> +++ b/rust/kernel/uaccess.rs
>> >> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8=
], offset: usize) -> Result<usiz
>> >>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.=
len()))
>> >>      }
>> >>
>> >> +    /// Writes raw data to this user pointer from a kernel buffer pa=
rtially.
>> >> +    ///
>> >> +    /// This is the same as [`Self::write_slice_partial`] but update=
s the given [`file::Offset`] by
>> >> +    /// the number of bytes written.
>> >> +    ///
>> >> +    /// This is equivalent to C's `simple_read_from_buffer()`.
>> >> +    ///
>> >> +    /// On success, returns the number of bytes written.
>> >> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut fil=
e::Offset) -> Result<usize> {
>> >> +        if offset.is_negative() {
>> >> +            return Err(EINVAL);
>> >> +        }
>> >> +
>> >> +        let Ok(offset_index) =3D (*offset).try_into() else {
>> >> +            return Ok(0);
>> >> +        };
>> >> +
>> >> +        let written =3D self.write_slice_partial(data, offset_index)=
?;
>> >> +
>> >> +        *offset =3D offset.saturating_add_usize(written);
>> >
>> > This addition should never overflow:
>>
>> It probably never will (which is why this was a + operation in v1).
>>
>> >       offset + written <=3D data.len() <=3D isize::MAX <=3D Offset::MA=
X
>>
>> However, this would rely on implementation details you listed, i.e. the
>> invariant that a slice length should be at most isize::MAX and what's th=
e
>> maximum size of file::Offset::MAX.
>
> It's not an implementation detail. All Rust allocations are guaranteed
> to fit in isize::MAX bytes:
> https://doc.rust-lang.org/stable/std/ptr/index.html#allocation

Yeah, I'm aware -- I expressed this badly.

What I meant is that for the kernel we obviously know that there's no
architecture where isize::MAX > file::Offset::MAX.

However, in the core API the conversion from usize to u128 is considered
fallible. So, applying the assumption that isize::MAX <=3D file::Offset::MA=
X is at
least inconsistent.

