Return-Path: <linux-fsdevel+bounces-4558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D088D800B03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835AC281309
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9E1F616
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAX2L9u9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E347DE;
	Fri,  1 Dec 2023 02:36:45 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a295e40baso10816686d6.1;
        Fri, 01 Dec 2023 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701427004; x=1702031804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1CSvziGe/qbcOkKXo9IQPR3y1xjDPlILN2WHHl8yYE=;
        b=EAX2L9u9pfQmtiQ7puEQ0bQB43z+FHTSKdwWQz6a39zOwe3gpcgzjfEF+5Y7TskRLd
         FX1BpsQzVoIlOwCRdaGNgPpPTEuJX9QwxtTPhDGwrAMv6y9ukma2Gpe6jcOgHSjatRjG
         UVC4NNVY1W0oXZTh7IDMTGyBqH8/3lrp97xDvVCwTVG19l9toEawUV4tozOqdtTuZ04m
         vZNiXxWP9QbvUJ+o64gJHnczpgY4HDUG0apuwce8fvX9gyi5e/sW+C8SZ73Maw6pkGMJ
         ycLz2+ZXk3ZVZ4v4WDpckFSBkmUh7mbyqBxfX4AvR7DtDludtfw2Cy00fkZS/e0xTpMR
         +gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701427004; x=1702031804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1CSvziGe/qbcOkKXo9IQPR3y1xjDPlILN2WHHl8yYE=;
        b=bxRvzz1mxRIyEifnWIIMZ6L3wgGw8zgYfmGKhFTNW9ilJweSXTv65BO/TvXYsHIF8O
         WBhFweONX230EnCaRn7yoaLjTJVL0jkpzXn5d4FM8E4ERZeORAI/0oC1uNLvxo0usLT8
         6jlOsee3V2LdwXMBnHw1MPKj5+qAOznwhnjpCQanndUYOzLBy6WeC9+Rp3xF8sx0UoWm
         NE5yvmonjA77vmhbZ1DJamPzNvd1RGmo51RZ9be4B2GqHXSLZvrOwC0E/D9JQJNVxtD8
         6DWVR5ucP1vBaYTXka7QWM9q/FfmTjx4PyTZIvrilcLZveL+rB5Yr0d+Qm+V2g8wKq0e
         o77A==
X-Gm-Message-State: AOJu0YxPMRS8BdEIR/aRBaftHe/RLr+QjBygJWrrkqfOIqT2ya4PsKY+
	Wj36dzcXYRCq8vYtqtp0sJ8=
X-Google-Smtp-Source: AGHT+IH/N7qs1+keta3j5dgaOQn5pnyM0432C78QHFxQAM7OJhtFbhoQVStmruTbCa77V8FDMz+82w==
X-Received: by 2002:ad4:42c3:0:b0:67a:4709:34bb with SMTP id f3-20020ad442c3000000b0067a470934bbmr16104179qvr.41.1701427004422;
        Fri, 01 Dec 2023 02:36:44 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q20-20020a0cf5d4000000b0067a4452d459sm1380580qvm.116.2023.12.01.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:36:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6D28E27C0054;
	Fri,  1 Dec 2023 05:36:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 01 Dec 2023 05:36:43 -0500
X-ME-Sender: <xms:OrdpZdyYzsRjmakWy7jQ_qAYWAeLmvh4KsJ1M1b5NuG-sFkPlbX6SA>
    <xme:OrdpZdTZEmSsMsgbCgAinTm1OtRrIpuh_INBOFoZ7q4-AK-bc6rpFJopot4TVYHao
    kf1ZI_v5UH-C9U0Jg>
X-ME-Received: <xmr:OrdpZXWPiypSbJWQm4Xz9tNPPXU7pxL2UZ2HJULdThdE95MONgE-5kwyCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelueeiffdugeeliedvjeethfettdeiffffueeiffelhfejgefghedtjedv
    ffffhfenucffohhmrghinhepghhithhhuhgsrdgtohhmpddttddttddqihhnlhhinhgvqd
    grshhmrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OrdpZfieDnseTYfSrzkeHadb8cRYXoZvuhCFgJKLiQHLxMuq0CjI6A>
    <xmx:OrdpZfBD8GCumgXRpc5JVJNklzmOx_N-JzSLAzvI5neWV6Nb-1kSBA>
    <xmx:OrdpZYIpfWUCXQi0h2zv3RYVRBoOhbYjG89sNO3GraUWlR4SivnS7Q>
    <xmx:O7dpZaVfAHXypI2kUAIvwy0-WLqBe9Pff0zXgyFT1XwXm9zQNO6YtA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 05:36:42 -0500 (EST)
Date: Fri, 1 Dec 2023 02:36:40 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>,	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,	linux-fsdevel@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <ZWm3OGWWhIWmB9gV@Boquns-Mac-mini.home>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
 <20231201085328.GE3818@noisy.programming.kicks-ass.net>
 <ZWmlEiiPXAIOYsM1@Boquns-Mac-mini.home>
 <20231201094037.GI3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201094037.GI3818@noisy.programming.kicks-ass.net>

On Fri, Dec 01, 2023 at 10:40:37AM +0100, Peter Zijlstra wrote:
> On Fri, Dec 01, 2023 at 01:19:14AM -0800, Boqun Feng wrote:
> 
> > > > 	https://github.com/Amanieu/rfcs/blob/inline-asm/text/0000-inline-asm.md#asm-goto
> > > 
> > > Reading that makes all this even worse, apparently rust can't even use
> > > memops.
> > 
> > What do you mean by "memops"?
> 
> Above link has the below in "future possibilities":
> 
> "Memory operands
> 
> We could support mem as an alternative to specifying a register class
> which would leave the operand in memory and instead produce a memory
> address when inserted into the asm string. This would allow generating
> more efficient code by taking advantage of addressing modes instead of
> using an intermediate register to hold the computed address."
> 
> Just so happens that every x86 atomic block uses memops.. and per-cpu
> and ...
> 

Oh yes, I found out Rust's asm! doesn't support specifying a memory
location as input or output recently as well.


I don't speak for the Rust langauge community, but I think this is
something that they should improve. I understand it could be frustrating
that we find out the new stuff doesn't support good old tools we use
(trust me, I do!), but I believe you also understand that a higher level
language can help in some places, for example, SBRM is naturally
supported ;-) This answers half of the question: "Why are we even trying
to use it again?".

The other half is how languages are designed is different in these days:
a language community may do a better job on listening to the users and
the real use cases can affect the language design in return. While we
are doing our own experiment, we might well give that a shot too.

And at least the document admits these are "future possibilities", so
they should be more motivated to implement these.

It's never perfect, but we gotta start somewhere.

Regards,
Boqun

> 

