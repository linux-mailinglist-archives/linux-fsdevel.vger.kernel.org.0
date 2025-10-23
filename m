Return-Path: <linux-fsdevel+bounces-65287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF9C0066B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 148AB4F6CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1230ACFD;
	Thu, 23 Oct 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N72g76qk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6892FB99B;
	Thu, 23 Oct 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214199; cv=none; b=DLij0lTZAREFrgKKKjWAve6LYJdyLO+N8BBCTubsjx4mQyld1zM8xpn6RzqSPjHEk2QA7hh/zFJnc1QqhIpvo9zRLtVVjWjAnu/TRrSohJLW2ETctYnp2uca+YzCNUFx+G0wabHX5RSIfTOYQEEUVLcEfXtDuJI9Px1UEoisaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214199; c=relaxed/simple;
	bh=7khVb0M8RKeetCTJkkf/If8a4rZrOUrez+Hz6QaX/+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CYDrItG+XEchyTbMBf9q1uMLuAWQ47/j0OcH87w8bIW7F8oSJpc00JVcXLB2oPaAw+Wp95kc4/Z6R+fUKG1zcMxo5OprXQ8pvBoBezI1KzeV5HqYc3OAR3FqamwX4nGE3GKHjZA4X/GYvkXNkfcdI7f0nxKRlHC4vAfrw5THmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N72g76qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FB2C4CEF7;
	Thu, 23 Oct 2025 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761214198;
	bh=7khVb0M8RKeetCTJkkf/If8a4rZrOUrez+Hz6QaX/+M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N72g76qkuquJIwQO3RB8nKCnZsrg9KRBlxIlG0h5Qbbdx7kWNY0u+SX0QI+BYZAF3
	 Wu1D/MVOonocLyuJSrr2FlMq1ey2G5/Cp+aFqLMp7u0dGIINlEeVtbJl17fDgqlfKM
	 MkPHdA/IP6aHIHcY29svvsubH8EqS1utcBkywGIXUpZm92yT2pFgEA941PNh23bOEv
	 pC2jB+0FMVdTg23LxNdnt87l0erPGw6hcnOD9gyH24w322WQ6e9dN+Qg95pKViFQDA
	 hthgq5n0JxAs1UHz2UbY1LaJ0rdUcKjTA+31JbFsBSIAjbsDV+8ZkZi89SinroWm+b
	 nTZF6InBDnfiA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 12:09:54 +0200
Message-Id: <DDPMBR9EUYJ6.23AYG1B27BUEN@kernel.org>
Subject: Re: [PATCH v3 06/10] rust: debugfs: support for binary large
 objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-7-dakr@kernel.org> <aPnmriUUdbsQAu3e@google.com>
In-Reply-To: <aPnmriUUdbsQAu3e@google.com>

On Thu Oct 23, 2025 at 10:26 AM CEST, Alice Ryhl wrote:
> On Wed, Oct 22, 2025 at 04:30:40PM +0200, Danilo Krummrich wrote:
>> Introduce support for read-only, write-only, and read-write binary files
>> in Rust debugfs. This adds:
>>=20
>> - BinaryWriter and BinaryReader traits for writing to and reading from
>>   user slices in binary form.
>> - New Dir methods: read_binary_file(), write_binary_file(),
>>   `read_write_binary_file`.
>> - Corresponding FileOps implementations: BinaryReadFile,
>>   BinaryWriteFile, BinaryReadWriteFile.
>>=20
>> This allows kernel modules to expose arbitrary binary data through
>> debugfs, with proper support for offsets and partial reads/writes.
>>=20
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Reviewed-by: Matthew Maurer <mmaurer@google.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
>> +extern "C" fn blob_read<T: BinaryWriter>(
>> +    file: *mut bindings::file,
>> +    buf: *mut c_char,
>> +    count: usize,
>> +    ppos: *mut bindings::loff_t,
>> +) -> isize {
>> +    // SAFETY:
>> +    // - `file` is a valid pointer to a `struct file`.
>> +    // - The type invariant of `FileOps` guarantees that `private_data`=
 points to a valid `T`.
>> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
>> +
>> +    // SAFETY:
>> +    // `ppos` is a valid `file::Offset` pointer.
>> +    // We have exclusive access to `ppos`.
>> +    let pos =3D unsafe { file::Offset::from_raw(ppos) };
>> +
>> +    let mut writer =3D UserSlice::new(UserPtr::from_ptr(buf.cast()), co=
unt).writer();
>> +
>> +    let ret =3D || -> Result<isize> {
>> +        let written =3D this.write_to_slice(&mut writer, pos)?;
>> +
>> +        Ok(written.try_into()?)
>
> Hmm ... a conversion? Sounds like write_to_slice() has the wrong return
> type.

write_to_slice() returns the number of bytes written as usize, which seems
correct, no?

