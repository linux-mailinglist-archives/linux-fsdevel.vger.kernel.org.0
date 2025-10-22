Return-Path: <linux-fsdevel+bounces-65081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C032BFB2BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98F68353A07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74D28B7D7;
	Wed, 22 Oct 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyKM0r+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0F78F4A;
	Wed, 22 Oct 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125669; cv=none; b=ZtGkf2Utu2wTowJHNsMIeO/2urpqM1TdKmV4QVQt4n+OlQwbrnq+cOWCE8YT41TYFm+xMWmFhgS3etfBLEAPaXqI15IW/LnebFECz6Ns8MRA5jsyQOTcCjz/HSq0Zi9H19De695aqpcW88HX1dKuM6y8/mtQD735bYwiKBAZO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125669; c=relaxed/simple;
	bh=4xaiC4XhhkvyIH5pxwidU1FpKTe9W6nHx3lEZnopVOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF9IT7T7I5ZiWxwEZdFYo7xGVIJSeJiTUgemv08la0axEpeuJuR52sJcBalz9vu6tHPozDbXXnPgWDPQSrlBAhaTwkc/IP2KEF6Dp2qXjb2aORBov07UpR1ROLr/iWWyvFXTvRidXEqi5KY0Csksa00JHdb4VdE5nJ7YBJQ0oVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyKM0r+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A05C4CEE7;
	Wed, 22 Oct 2025 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761125668;
	bh=4xaiC4XhhkvyIH5pxwidU1FpKTe9W6nHx3lEZnopVOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OyKM0r+3ijI80HxzqSS6g9XG0k4qDg+TMRlfBQ2wO1DsHTsXOA9aWBqF/APmfAw0X
	 XuArhHvV04AAUssgdseccfs6o0BdzxL9AHatu1tPhQGTCc5Zj6BhVw4icO6UlHJlkG
	 K55Z1JpMfKMxx5TUTSuvF+vhLJurLJR4J0QsStVaMply7zVOQxGkvEL17WPkqRIVHS
	 tMNmiKAEaBMLuHRlbyj4dQJrQs7w2Ur1A2YLEdTaJ0vW0pIjgvGgqTcsDIBzEhMWg9
	 Y85brb9z6CV51Ze0IrXedIawfZH2+PTJCh/np9P5w+tp1pufDN7VJOEO4AKabcLYOw
	 Wa9JIedehUawA==
Message-ID: <deb9881f-5ef2-4e6a-a63d-56695c822f80@kernel.org>
Date: Wed, 22 Oct 2025 11:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] rust: debugfs: support blobs from smart pointers
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-6-dakr@kernel.org>
 <DDOMC4F138FF.30W347U04XWZ8@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDOMC4F138FF.30W347U04XWZ8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 7:57 AM, Alexandre Courbot wrote:
> On Tue Oct 21, 2025 at 7:26 AM JST, Danilo Krummrich wrote:
> <snip>
>> @@ -51,12 +54,14 @@ pub trait BinaryWriter {
>>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize>;
>>  }
>>  
>> +// Base implementation for any `T: AsBytes`.
>>  impl<T: AsBytes> BinaryWriter for T {
>>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
>>          writer.write_slice_partial(self.as_bytes(), offset)
>>      }
>>  }
>>  
>> +// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
> 
> I guess these two comments belong in the previous patch?

I added them in this patch since it is where the comments become useful, but
technically they can indeed go in the previous one.

>>  impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
>>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
>>          let guard = self.lock();
>> @@ -65,6 +70,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) ->
>>      }
>>  }
>>  
>> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an inner lock.
>> +impl<T, A> BinaryWriter for Box<T, A>
>> +where
>> +    T: BinaryWriter,
>> +    A: Allocator,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
>> +
>> +// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no lock or an inner lock.
>> +impl<T, A> BinaryWriter for Pin<Box<T, A>>
>> +where
>> +    T: BinaryWriter,
>> +    A: Allocator,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
>> +
>> +// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lock.
>> +impl<T> BinaryWriter for Arc<T>
>> +where
>> +    T: BinaryWriter,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
> 
> These 3 implementations are identical - can we replace some/all with
> just an implementation for anything implementing `Deref<T>`?

Unfortunately, this would lead to some ambiguity for the compiler. A type could
match

	impl<T: AsBytes> BinaryWriter for T {}

and

	impl<T, D> BinaryWriter for T
	where
    	    T: Deref<Target = D>,
	    D: BinaryWriter,
	{}

at the same time.


