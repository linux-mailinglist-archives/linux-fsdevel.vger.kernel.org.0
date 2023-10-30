Return-Path: <linux-fsdevel+bounces-1587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5D7DC200
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B9CB20EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204391CA9D;
	Mon, 30 Oct 2023 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="kZq3CYdK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+g7inei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5223C3;
	Mon, 30 Oct 2023 21:36:36 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FA9F;
	Mon, 30 Oct 2023 14:36:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A9285C01D2;
	Mon, 30 Oct 2023 17:36:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 30 Oct 2023 17:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1698701792; x=1698788192; bh=wIpBAZbF9GYPQMj2OF375tHBZiXVUABR09h
	G0/JgIbs=; b=kZq3CYdK3XxvyaxDk4d98shUzS9yAy3MwcA0nZ7P2CfZty66PBs
	QhwDsSp3cXeLxKL4hKi7BoH/AH04K4g7uJlvqAI71kvZjZG7S82OQ2S3T/yINgFE
	3cVH1bGjLgMURw2vwOHV3W8silLW0lekHviXdJYhmuAGFPj7mccwQqNZSfdzv0p6
	jQA4onG5cv7AMDUoGE91Ij4gAmw3emXRS8amDdox5kTPSBk4uK3aWKHvBCM7LhFw
	VQWBUcMe130oN/NWlJ8IilnP1nT99E6SrXhRihymrhSbNhmmgjtUbGrSRHdc3e1o
	NlVjyNcff76j8XjXnwnikppxoaIWM/9030g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698701792; x=1698788192; bh=wIpBAZbF9GYPQMj2OF375tHBZiXVUABR09h
	G0/JgIbs=; b=f+g7ineiNDskwpVnJ01oCjJ6GpwWtBxmbR6l8eTLVWqEtSyFXO7
	5el3bvzRZ7Yzs0DdGqjz/uqO79ESZnePc+6CjtPUuWgNJyk72utYEBPonVaaxDrA
	yq4x7+xJPJr8yzj5ZT4/aGZi1c53/L3FV9E7JSSTSBPk6Ft5jskN39liFW1qiyHr
	mvtbQoR1R5RDtlTIqo7jQd9QbSpHLpTjiG/zexNSAHIPI5XO7+7dHhvGsn2yQOT4
	zO1TO+KmrpSLKQCJgiA7bMCCoDWJXamlAWkkm8rSSDWPiCVfSBQKtf8nj3aORH7K
	9yzRWyvTHFKoFUB5wOT7vReG4rII+5QtbcQ==
X-ME-Sender: <xms:3yFAZXtkkTKV828XkN49wtZMux42IEVPxfpMm3RDI2EXwcGXKALD2w>
    <xme:3yFAZYdmiLvfSUBLEFPKBOpoeurbRijaGM6zd20gfR_MiDOv4EJUnDqcrwCg-sx1N
    knXhI2gDNT4aWfNlg>
X-ME-Received: <xmr:3yFAZaxJBfOgki_A-FvKwxPob2pCFjkB7hcWh2foJgY3uaR5TfvnPguM6dHoorUWGt9FNfgV2KwRU3be8Su49kuebwTftMJvYIma>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epudejudduledvkeeuffdvtdejtdejtddthedtgeejuddvleefvddtkefguefgheefnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdprhhushhtqdhlrghnghdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehr
    hihhlhdrihho
X-ME-Proxy: <xmx:3yFAZWNS5JBR1fN0ZIvbAmlqsRHiI6YHhRp-j4FfSAkvPGOcr2sI0w>
    <xmx:3yFAZX_Kw9wi6ayJfuT6SKsF3XK-JeMadW_LXBCUX6geY5dRJ2YTNw>
    <xmx:3yFAZWXuRTeW2z3Di2pAL0u4FaYAi3SH6NXV39ETQ_xgB7ccSD-5sQ>
    <xmx:4CFAZTT1idgeFlkBelTEdQZuPETaNEoZo78dQa17RmD5o17_OcupYw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 17:36:30 -0400 (EDT)
Message-ID: <9acc17ed-437d-47a2-9721-8191b59304d8@ryhl.io>
Date: Mon, 30 Oct 2023 22:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Content-Language: en-US-large
To: Benno Lossin <benno.lossin@proton.me>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-5-wedsonaf@gmail.com>
 <E5dn4WQzlLvA0snHR_r_i2h1IPRjiiTIwssBSR403Rda6JA2Fgd-7lOonQQ6Oz1DMqp45cvtDfyW0JwRFgSZurzvtXIk3KGNhtSBqvvBnF0=@proton.me>
 <4b19dd7d-b946-4a5c-8746-f7e9c2f55d25@ryhl.io>
 <5479e7c1-6616-4930-b33c-0075772c266e@proton.me>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <5479e7c1-6616-4930-b33c-0075772c266e@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/23 09:21, Benno Lossin wrote:
> On 28.10.23 18:39, Alice Ryhl wrote:
>> On 10/18/23 18:34, Benno Lossin wrote:>> +        from_result(|| {
>>>> +            // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
>>>> +            let fc = unsafe { &mut *fc_ptr };
>>>
>>> This safety comment is not enough, the pointer needs to be unique and
>>> pointing to a valid value for this to be ok. I would recommend to do
>>> this instead:
>>>
>>>        unsafe { addr_of_mut!((*fc_ptr).ops).write(&Tables::<T>::CONTEXT) };
>>
>> It doesn't really need to be unique. Or at least, that wording gives the
>> wrong intuition even if it's technically correct when you use the right
>> definition of "unique".
>>
>> To clarify what I mean: Using `ptr::write` on a raw pointer is valid if
>> and only if creating a mutable reference and using that to write is
>> valid. (Assuming the type has no destructor.)
> 
> I tried looking in the nomicon and UCG, but was not able to find this
> statement, where is it from?

Not sure where I got it from originally, but it follows from the tree 
borrows reference:

First, if the type is !Unpin, then the mutable reference gets the same 
tag as the original pointer, so there's trivially no difference.

The more interesting case is for Unpin types. Here, the creation of the 
mutable reference corresponds to a read, and then there's the write of 
the mutable reference itself. The write of the mutable reference itself 
is equivalent to the `ptr::write` operation, since exactly the same tags 
are considered to be affected by child writes and foreign writes. Next, 
it must be shown that [read, write] is equivalent to just a write, which 
can be shown by analyzing the tree borrows rules case-by-case.

You can find a nice summary of tree borrows at the last page of:
https://github.com/Vanille-N/tree-borrows/blob/master/full/main.pdf

I'm pretty sure the same analysis works with stacked borrows.

>> Of course, in this case you *also* have the difference of whether you
>> create a mutable to the entire struct or just the field.
>>>> +                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
>>>> +                // safe to mutably dereference it.
>>>> +                let inode = unsafe { &mut *inode };
>>>
>>> The inode also needs to be initialized and have valid values as its fields.
>>> Not sure if this is kept and it would probably be better to keep using raw
>>> pointers here.
>>
>> My understanding is that this is just a safety invariant, and not a
>> validity invariant, so as long as the uninitialized memory is not read,
>> it's fine.
>>
>> See e.g.:
>> https://github.com/rust-lang/unsafe-code-guidelines/issues/346
> 
> I'm not so sure that that discussion is finished and agreed upon. The
> nomicon still writes "It is illegal to construct a reference to
> uninitialized data" [1].
> 
> Using this pattern (&mut uninit to initialize data) is also dangerous
> if the underlying type has drop impls, since then by doing
> `foo.bar = baz;` you drop the old uninitialized value. Sure in
> our bindings there are no types that implement drop (AFAIK) so
> it is less of an issue.
> 
> If we decide to do this, we should have a comment that explains that
> this reference might point to uninitialized memory. Since otherwise
> it might be easy to give the reference to another safe function that
> then e.g. reads a bool.
> 
> [1]: https://doc.rust-lang.org/nomicon/unchecked-uninit.html

That's fair. I agree that we should explicitly decide whether or not to 
allow this kind of thing.

Alice


