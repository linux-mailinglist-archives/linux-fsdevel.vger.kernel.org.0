Return-Path: <linux-fsdevel+bounces-32024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840699F5AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086011C26DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854B1FBF57;
	Tue, 15 Oct 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="tvfpz6Tu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nfuw7vZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE331FAF1C;
	Tue, 15 Oct 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017278; cv=none; b=i0pwGxy156yBBf0gBA9u6QEiAA9CMXZaAp/3NzDXLWFI0rytRuoI2gNT/8pyEFFhQlCZcr3Y97mIwYS+ftGuVafwv80FoD7KWwiMQxS3OmkjOyj4P8Z1o1SgCjSQ9x9ZSun7xLgGmCcqKlt2vGdnvLH6yc8lmAhSEo/eurn/w98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017278; c=relaxed/simple;
	bh=5h4yJYD6mj749ehtFoj/pa6R5CAlrx/gSF34IkWjRkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRaC8pq+SCTOBw4XMx6EizvmFxBPRlipAhNwxkOuK5GPaiypypmMF96Csi6fGyI5/fOxggg3Mj/Ue+B3EnQWFwb2d/92QkfyQLyy1fLQFRfHQnGdaIEBCOVREc8Oedl3HVQRFpvOHw32KlgVHlKUswEcE/t73o34PYPI/7YUjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=tvfpz6Tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nfuw7vZb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 93CBA138021E;
	Tue, 15 Oct 2024 14:34:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 14:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729017275;
	 x=1729103675; bh=2ofm0Km157SSWcgNu+R/b0e4iC0q+FyX4UDhyX2UdbU=; b=
	tvfpz6TuGyrCZm7B2zCL38nXnJZE0OhzUTujPCRl5VsUpkKwnWAt4DxxYaoKMScu
	M40Cgq5qljrfecrxaUTPYdnuEt4t9gwMd6Lo1u0nAqbZSMqzChpnkrpkQ2xfHHsQ
	vHvbDbXNehsxSK3GxKhetg+Ww9eYKnV412qPBtTL0nHSFveEoUIUv3KYZYWS6mdr
	QbTOvmYeeD2aZ+/eQLRwhRH6LB8GNNMUHdCPN1YDgnTC9zYOh2ZUTspbhagjRcaR
	GB4CWu3glA+AHNhmXgnbyFn6DF2dQWy4stW6EjmGRuyCWjmq9ZAxbBVIp36N1YvV
	YYdEylVYXP32RUoWdYuoPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729017275; x=
	1729103675; bh=2ofm0Km157SSWcgNu+R/b0e4iC0q+FyX4UDhyX2UdbU=; b=N
	fuw7vZbh/PDW+w8I9GkfkLs64bs2Szvb6+KLGwEZiW5fPgzalTw9i43nlMFP1epA
	pp+uiqsjALa7rV0luFR3Zs38Gx/Y477soFQERgLmZgnr2riOjoaf2yoBLYiSH0XT
	2bEFzPwBgU8nURBoErODisuZTtVo4LNlP7pzRgjEO1L3YZXP8Dg7Jx5zZkvUESEi
	rVhZFp1oKr6nysPre/Nh6B/y2Q455fwK27RO+3y/kTOtJIoICcRr7ihywei+pWeK
	1sCf2kXWPzkun9iSwZwnxxnycDiLtajH2pZ0kmiLVE4Z10OLhA9oGXKp/+i6iwBa
	V8PziMjVswkw3lw5yid6Q==
X-ME-Sender: <xms:u7UOZ7rm0WAl9uloqGjdveH6Zxp7fReY4JbRNC08RXHf4-OPWGZq6w>
    <xme:u7UOZ1p1GBZOhmGXmGGDmtLQapW752DmPXbGHWq7i8odMLsAaLJ4mnoDi8HtOs-2j
    RyfN0qreBsrKhI1_A>
X-ME-Received: <xmr:u7UOZ4MrMZQ-WtXEFfsrZqTIY9cYzaymHrxNg2CT9FSfK1pw6cFJ0Xqf4A-byEN2mNQylXDuwhWs1GdanIb4Y71F0qv8NEQ88udo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepfefguefgtdeghfeuieduffejhfevueehueehkedvteefgfeh
    hedtffdutdfgudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheprg
    hlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgr
    rhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:u7UOZ-6krkHgJEnvWCs-VSfbNDGkD-opBEZAoD0LNJjfSCYC243QSA>
    <xmx:u7UOZ67RNYuKW8RyDrTfBA78KRPy_sr1Vgpg_APtULE-ooxx0XD3zw>
    <xmx:u7UOZ2g3m1EiMfcTYnAc6b9zIoWBPDayUoxISGLA929npthF5fgNlQ>
    <xmx:u7UOZ86YW-kxNjnSwrcqk1_CEev5D2ETdx-psrHPfLz22BWnHT_rAA>
    <xmx:u7UOZ9oC41FGfx0OnFbv_8L_z7jx6OX4kgPf82UtRI3GbKKzBG8dAWS_>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:34:32 -0400 (EDT)
Message-ID: <23a73a6f-160d-4d06-8d45-ec77293ff258@ryhl.io>
Date: Tue, 15 Oct 2024 20:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
 <Zw6zZ00LOa1fkTTF@boqun-archlinux>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <Zw6zZ00LOa1fkTTF@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 8:24 PM, Boqun Feng wrote:
> On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
>> The `Task` struct has several safety comments that aren't so great. For
>> example, the reason that it's okay to read the `pid` is that the field
>> is immutable, so there is no data race, which is not what the safety
>> comment says.
>>
>> Thus, improve the safety comments. Also add an `as_ptr` helper. This
>> makes it easier to read the various accessors on Task, as `self.0` may
>> be confusing syntax for new Rust users.
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>> This is based on top of vfs.rust.file as the file series adds some new
>> task methods. Christian, can you take this through that tree?
>> ---
>>   rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
>>   1 file changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
>> index 1a36a9f19368..080599075875 100644
>> --- a/rust/kernel/task.rs
>> +++ b/rust/kernel/task.rs
>> @@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
>>           }
>>       }
>>   
>> +    /// Returns a raw pointer to the task.
>> +    #[inline]
>> +    pub fn as_ptr(&self) -> *mut bindings::task_struct {
> 
> FWIW, I think the name convention is `as_raw()` for a wrapper type of
> `Opaque<T>` to return `*mut T`, e.g. `kernel::device::Device`.
> 
> Otherwise this looks good to me.
Both names are in use. See e.g. Page and File that use as_ptr.

In fact, I was asked to change the name on File *to* as_ptr.

Alice

