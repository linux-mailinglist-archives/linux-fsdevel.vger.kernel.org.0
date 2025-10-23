Return-Path: <linux-fsdevel+bounces-65291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCDC00861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3FB535992F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5230C359;
	Thu, 23 Oct 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3jbtYKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82C3074AA;
	Thu, 23 Oct 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215709; cv=none; b=kn0XVMpwmXQibPOB6YZxPLXojQWp2gAkjGFX8rDVfAobySp6nFNe1hYGZUOH9BedbXdbaVgXs5t+KeIaNy6iLY3dJGiBj6jaJq+50m+uwZkk9T8MzjlKDLwjYj4qMKOUyRmmzL9x4LWr5yVS9Orzg/1TPn8IJbiHsN5Kfxn/3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215709; c=relaxed/simple;
	bh=KWZesjALQXrvlEpZwW7w2wXe8TzRSwdkOj2ULLZbyCw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=OwN+uazb3tpcr/BkA33YbwoqrHJ6leNW62zv2cMIBQsaiT6PG70TJRkICI5PoIOJynk/yY3tAck5mI2BfvYob8qCRXYN2Vv8B0x3LcBfWkPf9VyLyFl2/N7dm9hayv9hsJzzmcEPRZiJRWAGpuRGeL/15Qjhj5KC47Mxst8+8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3jbtYKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C9EC4CEF7;
	Thu, 23 Oct 2025 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761215705;
	bh=KWZesjALQXrvlEpZwW7w2wXe8TzRSwdkOj2ULLZbyCw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Q3jbtYKpzcsG6ejmQ1Hr1si5MCi+CfFZgIRELINxR5zSCDSqRVw0E1xRPTT4hLycD
	 MveWF5cmaG/KpZQ1DUB8TJn2qtkjp2r6OQg0k2vuZd/rfWLqNrR8k1+hwZsVJR2ylc
	 PlH9gjl6w63o/khCpF8T0zURis38wEuwuxOEBTRua8UzVTRbVifFCpvJ4Rdbay8rHe
	 Qt1C6G51tJPiuTiALLcZ+JhmZTxI/unjrKaNnFJnj2lJuggScRhfRRd+0jMPwqkH3x
	 rXa4h2WL897kpFvi3CWlByfSetQEwa2paMyYJc9xdUQuoMUps/QEOtmFq91wL2JKY3
	 uZ4DPMTpyXA/w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 12:35:00 +0200
Message-Id: <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add
 UserSliceWriter::write_slice_file()
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-6-dakr@kernel.org> <aPnnkU3IWwgERuT3@google.com>
In-Reply-To: <aPnnkU3IWwgERuT3@google.com>

On Thu Oct 23, 2025 at 10:30 AM CEST, Alice Ryhl wrote:
> On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
>> Add UserSliceWriter::write_slice_file(), which is the same as
>> UserSliceWriter::write_slice_partial() but updates the given
>> file::Offset by the number of bytes written.
>>=20
>> This is equivalent to C's `simple_read_from_buffer()` and useful when
>> dealing with file offsets from file operations.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>=20
>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> index 539e77a09cbc..20ea31781efb 100644
>> --- a/rust/kernel/uaccess.rs
>> +++ b/rust/kernel/uaccess.rs
>> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8], =
offset: usize) -> Result<usiz
>>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len=
()))
>>      }
>> =20
>> +    /// Writes raw data to this user pointer from a kernel buffer parti=
ally.
>> +    ///
>> +    /// This is the same as [`Self::write_slice_partial`] but updates t=
he given [`file::Offset`] by
>> +    /// the number of bytes written.
>> +    ///
>> +    /// This is equivalent to C's `simple_read_from_buffer()`.
>> +    ///
>> +    /// On success, returns the number of bytes written.
>> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file::=
Offset) -> Result<usize> {
>> +        if offset.is_negative() {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let Ok(offset_index) =3D (*offset).try_into() else {
>> +            return Ok(0);
>> +        };
>> +
>> +        let written =3D self.write_slice_partial(data, offset_index)?;
>> +
>> +        *offset =3D offset.saturating_add_usize(written);
>
> This addition should never overflow:

It probably never will (which is why this was a + operation in v1).

> 	offset + written <=3D data.len() <=3D isize::MAX <=3D Offset::MAX

However, this would rely on implementation details you listed, i.e. the
invariant that a slice length should be at most isize::MAX and what's the
maximum size of file::Offset::MAX.

Even though I don't expect any of the above to change any time soon
saturating_add_usize() seems reasonable to me.

> I can't help but think that maybe this should be a + operation instead?

