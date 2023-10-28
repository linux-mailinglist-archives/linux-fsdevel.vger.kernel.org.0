Return-Path: <linux-fsdevel+bounces-1482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6587D7DA800
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D442821BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A8171BE;
	Sat, 28 Oct 2023 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="N4FRKACP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSBF+vNv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBF1548D;
	Sat, 28 Oct 2023 16:17:42 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825AE5;
	Sat, 28 Oct 2023 09:17:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 731C132006F2;
	Sat, 28 Oct 2023 12:17:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 28 Oct 2023 12:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1698509854; x=1698596254; bh=w80hlvlTCNOQG4aYFG6NUXJNBRCQv4MBoN+
	0yf17uRo=; b=N4FRKACPavII3sgSlbNz6OHXXdzTbPDkcgdRj0nIVw5WWjE9wBV
	gE7Ld0ca+bxQXm8KNl1nic+99eKZiZuaBRFDnalct1DmgB7PlCbEt23r7DOFvGwX
	x00AG1LI87EDjTeVBa5xH+HL+/DOuhvddsr85jpqs7f89YGmnPqZ01BE1/BQwy4U
	0gi6wXbwR2RUpcVviihvyaCvfXeaVnLZPX5vHgabz8cOurBidqTFpwxfUA7S8B5i
	KH+bS5Fh93qmHGZPqGfHrPPAYEDAxAlbYr60iN2qFVMD67cxeS/6eyFgYHuc4ic6
	PmmhnXXIGOBPSKzPiFyepFs/DfFCbC8GxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698509854; x=1698596254; bh=w80hlvlTCNOQG4aYFG6NUXJNBRCQv4MBoN+
	0yf17uRo=; b=aSBF+vNvNvAL5LACG0wUmj+W2ij2gxhuLGjJwPHY25/YEkAGQdL
	uhOVuRoS3ZPIABeSGdoswaDSGEbcyd5r9t/Nor5/0T4SsAkM7EQxmsGJVIB/GWsL
	dQzm0uR4a9ETpOdhF4I2h+63dxX0C3eqCQwavVl9RCj4Z8k7BAuvE8BdJung/21U
	bhFwqZL2xl2OOD52xe1E7pjjgGgTpGsZifqPQly8knDG3fFqi8rWibQZo8JIywc6
	B5p3PvjmJ876ZnmWk1T5/wquaHHHaMkTB++sJ5KLJ+Gt7OkYEnXNjVU6KXsw36I0
	x2WMnr2vff2op/KCsOVGS2lhtI5Uq0gqDWA==
X-ME-Sender: <xms:HjQ9ZUYO-9NKdBpO-S9ZsDfwx284WeqzDF4DdzGIjt9MF7p7TC6DRg>
    <xme:HjQ9ZfYTNvWMGxU5STSXWmMZO1_jU2rQXWnQWcaEqH8u5iexgbkgOVHeFwNWX498S
    cyPhJdr29sse5C0-Q>
X-ME-Received: <xmr:HjQ9Ze_bHbBgyn8ZY6ArxpVa0y92tm1KEqViD04VdzX-TaavXuPQTfFx6WqJEQSf2R_te6ttxE8GsuOHek4kea2BlTrXI6OMNNSi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepfe
    fguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedtffdutdfgudejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:HjQ9ZerKhhfh2YbL77LsMWYCcfjIlv2AZdkOMUriSYCpJV4rnXIHcg>
    <xmx:HjQ9ZfplrlZh2HWLDJE7bgYgSha2roKnM2keXHlSyOjYg9QFsSg14A>
    <xmx:HjQ9ZcSjPufyvRQZdyvhAVw5GuqmEkiGujeBoPFdc-bxHsLsH1Cpaw>
    <xmx:HjQ9ZbKHxOyUR2jUZmqO0QyPeSkz0_DlS8mVPKsMi9bZCClsjKN4OA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 12:17:32 -0400 (EDT)
Message-ID: <0278c96f-7a4a-4a3c-81b8-583f2cc62226@ryhl.io>
Date: Sat, 28 Oct 2023 18:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/19] samples: rust: add initial ro file system
 sample
Content-Language: en-US, da
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-4-wedsonaf@gmail.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231018122518.128049-4-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 14:25, Wedson Almeida Filho wrote:> +kernel::module_fs! {
> +    type: RoFs,
> +    name: "rust_rofs",
> +    author: "Rust for Linux Contributors",
> +    description: "Rust read-only file system sample",
> +    license: "GPL",
> +}
> +
> +struct RoFs;
> +impl fs::FileSystem for RoFs {
> +    const NAME: &'static CStr = c_str!("rust-fs");
> +}

Why use two different names here?

Alice

