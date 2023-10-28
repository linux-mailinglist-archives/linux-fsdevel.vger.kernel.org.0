Return-Path: <linux-fsdevel+bounces-1483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329E7DA819
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A858C1F21ADF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130A15AD1;
	Sat, 28 Oct 2023 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="MLN9dH3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1lCYYoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D523A5;
	Sat, 28 Oct 2023 16:37:55 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14535ED;
	Sat, 28 Oct 2023 09:37:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B70C73200312;
	Sat, 28 Oct 2023 12:37:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 28 Oct 2023 12:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1698511072; x=1698597472; bh=dMa7bkda/jUzx0xX9fiF353eZ/NQo4woDy/
	hHwVKMRo=; b=MLN9dH3YBA+tgJQfIbJgmZBbrKlBo6fTui7Fwsm/86yHJrW283q
	844IWDT/W+PMPiGyQOFyst9/l3xxxqb1byVgAJe2SBzEXlUMQSjKAAf4ASE6o22W
	7dASywHzD3GC04m/SCFWTqCFKRsfUQfAy8rcrGYgZZN3S11rkqH6mP7S4coPtBrf
	knxiceI2/x4q+Vtur/E4aldZdViafpdABkuPoUjjkl7ZsdUlmNJomC58icxVr15I
	bY62dwC5q2CyekqFqq0DUuO01f6Gqdatdm0O8FA796wd7mhaBHGKpIqkol6wowXc
	n7sbOxAlsQgtajlxbr3m/Ho/p2Br64lt8FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698511072; x=1698597472; bh=dMa7bkda/jUzx0xX9fiF353eZ/NQo4woDy/
	hHwVKMRo=; b=a1lCYYoRN3GQ5t/4tlbqR1Q5tD87I6Te/cBcAfy0I6C2dj5KoD4
	rFdTVrSSAddteIXiUxbbU8rRpwI5imZ5kSJa8k61tapjao3ZgK5a1FVuyK/ufr4Z
	YupMeRWVGyQiJyGt5iabCIi5FLCW9VEOnQsji+NdicRv2+o/SDztXbnJ5u2rJxYs
	qGAWZBfGGWZA9eavIc/at3CAv+RXZil6mAnS8t2p9QYUHWlN93IbZBW7jX13gfnK
	LcrUx0U/vbp/fg3IBVDgQxIcnQvdjWPrQDbfllXGVcqrJ3O8jsj8NNTIbTmjzQ1q
	MeqOmxnTd8Ye9FGG8WX/lwS0Dh7kFaDyeXQ==
X-ME-Sender: <xms:3zg9ZSP4Jf5Ja6tBeme7J6Vow__-AtFf4pvUlQvK2WiI_dFwIpEccg>
    <xme:3zg9ZQ81VLWGJ0idsAD-WDUJ-qQ8zdNr9y9yfiSPbYhchCsNATRRttsXoqAvPtFIa
    BP8E6XT94ckoKZlhg>
X-ME-Received: <xmr:3zg9ZZRpur-O5M7hOmWg3jzjY3Nq12aRq57EJqUnpgfe2E2cb0kp-6q2HvVPWFRg5UeV75TRzq2VfnweVPc8890Y1Cvzn-hZXTb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephf
    eghfelgeffleegffffveegtdfhleetgeefveeihedufedtffffledufefhgeehnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:3zg9ZStYjQ6i05ZlXF2V0sizQlFuh0dA4Bv6OpKfv1Ceas8yOZ-dAA>
    <xmx:3zg9ZafwTP3cpnxUAqtswRzvwx2-DJF9ltCjtWSd8kFysM1zlhKuVw>
    <xmx:3zg9ZW0d0yb3NS5L9HJWqMMIPQ-S5qybUkQPvUU-iy99tyhx17UnPw>
    <xmx:4Dg9ZRzf5rHXeBHlEjbIr_Rta3zupCLiNwQahtGKjGLIbcaPlgWj5w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 12:37:49 -0400 (EDT)
Message-ID: <4b19dd7d-b946-4a5c-8746-f7e9c2f55d25@ryhl.io>
Date: Sat, 28 Oct 2023 18:39:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Content-Language: en-US, da
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
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <E5dn4WQzlLvA0snHR_r_i2h1IPRjiiTIwssBSR403Rda6JA2Fgd-7lOonQQ6Oz1DMqp45cvtDfyW0JwRFgSZurzvtXIk3KGNhtSBqvvBnF0=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 18:34, Benno Lossin wrote:>> +        from_result(|| {
>> +            // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
>> +            let fc = unsafe { &mut *fc_ptr };
> 
> This safety comment is not enough, the pointer needs to be unique and
> pointing to a valid value for this to be ok. I would recommend to do
> this instead:
> 
>      unsafe { addr_of_mut!((*fc_ptr).ops).write(&Tables::<T>::CONTEXT) };

It doesn't really need to be unique. Or at least, that wording gives the 
wrong intuition even if it's technically correct when you use the right 
definition of "unique".

To clarify what I mean: Using `ptr::write` on a raw pointer is valid if 
and only if creating a mutable reference and using that to write is 
valid. (Assuming the type has no destructor.)

Of course, in this case you *also* have the difference of whether you 
create a mutable to the entire struct or just the field.
>> +                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
>> +                // safe to mutably dereference it.
>> +                let inode = unsafe { &mut *inode };
> 
> The inode also needs to be initialized and have valid values as its fields.
> Not sure if this is kept and it would probably be better to keep using raw
> pointers here.

My understanding is that this is just a safety invariant, and not a 
validity invariant, so as long as the uninitialized memory is not read, 
it's fine.

See e.g.:
https://github.com/rust-lang/unsafe-code-guidelines/issues/346

Alice

