Return-Path: <linux-fsdevel+bounces-1489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45A7DA856
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3607F282012
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAC17985;
	Sat, 28 Oct 2023 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="ZLvWKI5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgRcfZYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E8F9D6;
	Sat, 28 Oct 2023 18:00:48 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C99ED;
	Sat, 28 Oct 2023 11:00:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 937065C0221;
	Sat, 28 Oct 2023 14:00:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Oct 2023 14:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1698516043; x=1698602443; bh=r5Iv7KlUTDlzwwnmGkYjIj9iq5UnXnPNbbm
	Dn/hs7Dc=; b=ZLvWKI5Qf24AHCz9o3K4c+uwZ2Bz8ev7FMTvzMjv3yOJXz6nAUm
	yMRXBzb9tJB3hXvqqrem5Ksl5AUosk4Huq1LLmD+GaIy3NBbYnsQTBHG6dqtszvw
	WouiCMgooKjFMDJL6MnzLA9yz9y+raFelLNW2Zp0urUrgLkHdRSzCBNrQdQi2LLR
	oTJ0CpHAqZoNBYhXLzHCzYmoCoWf0HkSGH5lYbxqu2fSMSlsZ//iwnEBl3VrraC7
	UPwt7q4/dMaF8J+LmUyNJrm0C0B2sc11MSczaXwSO1Y5SsyQT6/qrjUlu2wsRell
	Gm6v705rQ/EFmgLpeeVSB37Q9kU1z5x6FSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698516043; x=1698602443; bh=r5Iv7KlUTDlzwwnmGkYjIj9iq5UnXnPNbbm
	Dn/hs7Dc=; b=jgRcfZYxJyFXzFr9A7vyrfI0CiC9t2TKd5lJfaBqyyPntTqQLjT
	RYisYOwW6laiJeWLrYB0K/Pz1dqSq4lmiHat90P/mkpTJFZTSqGpjMz34JhhIdSw
	s7Qm6n0ZDkvbdBPjNWFz/DQKGLTMPum9l8TCXjbnoOCHZpkpMhK9HHwiqyvd7O7a
	1jgCYvGefRoSYFIARYssCnLl7xTunNhpOZIGIexU/ZxAuCyDxuTW8f4K9AU3qgDO
	gGEWyubpQIAJAdDqeZcYKapaR2Iy9kz/zUI6YDCBPT9eL910RhEfgqxpq52dhzpT
	bNaK44BDssG2aqKLih6V6t0L32wNoa30kPw==
X-ME-Sender: <xms:Skw9ZU3B4JC_7BcNf3z6z86y6Xno9KT1J-BvR9gVqdeljKFt9xLYHw>
    <xme:Skw9ZfGXT962OGHnESBAUm2vtfDNmLlcguEexl3n2JmLYGppwdt6oJds0XT5La_17
    83kK4mMTjMLiT1EQw>
X-ME-Received: <xmr:Skw9Zc6P8jGQ3ME4w6eOlY0G1-XcbXbL3sA_HlkRmI9joTDl4upyUa2agMLFj8tPWE3bHajXVncjliY3r848dEI_KZInCZgd9saf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepfe
    fguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:Skw9Zd26RawqmjRs4tAit_DqLbkYGmFH5CN6Wx4HiLUlnvlMEYbBow>
    <xmx:Skw9ZXHikiWKcx2qhOlNQFE48ppGeVge3-rMbqwPftX7GRICmb-SFA>
    <xmx:Skw9ZW-MDja8Aut2m_ob1SNwpta8eRR6iiyaqzt3fbEGP1MCSk2NDA>
    <xmx:S0w9ZW0AAz1UmxRPmY2-xG-mW58keGLOQR5PWokISIm68B_ltQBTgw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 14:00:41 -0400 (EDT)
Message-ID: <86207b78-db19-4847-b039-c84ab9452060@ryhl.io>
Date: Sat, 28 Oct 2023 20:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Content-Language: en-US-large
To: Wedson Almeida Filho <wedsonaf@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231018122518.128049-6-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 14:25, Wedson Almeida Filho wrote:
> +    /// Returns the super-block that owns the inode.
> +    pub fn super_block(&self) -> &SuperBlock<T> {
> +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
> +        // shared reference (&self) to it.
> +        unsafe { &*(*self.0.get()).i_sb.cast() }
> +    }

This makes me a bit nervous. I had to look up whether this field was a 
pointer to a superblock, or just a superblock embedded directly in 
`struct inode`. It does look like it's correct as-is, but I'd feel more 
confident about it if it doesn't use a cast to completely ignore the 
type going in to the pointer cast.

Could you define a `from_raw` on `SuperBlock` and change this to:

     unsafe { &*SuperBlock::from_raw((*self.0.get()).i_sb) }

or perhaps add a type annotation like this:

     let i_sb: *mut super_block = unsafe { (*self.0.get()).i_sb };
     i_sb.cast()

Alice

