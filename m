Return-Path: <linux-fsdevel+bounces-4237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D347FDF82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29E01C204BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA375DF10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM/zah9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D2BC;
	Wed, 29 Nov 2023 09:08:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77dd54d9da2so5486585a.0;
        Wed, 29 Nov 2023 09:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701277699; x=1701882499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqpbWl3d4t7hd7UzjUjrZAkkyJ8NQqp/9vDtc/IE+6s=;
        b=VM/zah9oJ9oDtJWw6px6aOW3yezQrVHgTRYZN/aVPug2KQv1+xf22M2plfz4x+fonZ
         Z0WgT9vCfgLSvt90ZTplR2FsnRuU/Dq0um4pDTX0fHSj5i26wrqodSlN9ntGSHkd8o8X
         KlO6ubHvErZAyeWi49v3fOEzpztvPZGIQmjUcz6fRMDhS2gar9S1DXothH/AORQJMcMg
         1j7BWg+xvacUP6GnnlMZ0LbG37+31adPtadmKn7xSIPJhjbe2XuAWvdVyTzQyTaHcxFT
         i8DV9XcVXfzVSMQyUlvNp80EAxLv+nE5MrjmTQUjRVNt2L4+cu9u/tMHH6FNXSIL8jpi
         XcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277699; x=1701882499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqpbWl3d4t7hd7UzjUjrZAkkyJ8NQqp/9vDtc/IE+6s=;
        b=r8Ki6WLwh2XIYY0ZEqRSWjDk8owabFi/1tOt7uG+IG9l8D2RYfV4ys156T5KQARp3E
         q4oHkPlLRyQSKJehVCLyCuVIAoLDyQTYFGjxo+NA8FpxCvgYdj5mENCOKY1e75zZXXza
         ep0KNjdKlDg7OTIIPGzX0KKictdDAHFKRhWoPTHtw+mBX/bRnWL3us4ljT1A3VCRgMs9
         AJugg18K+shAYbH0gWDldYzPOtKG26YZ/0BZ2YxE/naZMgOALwGX50ivYh6AsoDSF4e8
         yP8fukwLqebHjVerM8fRan8sRDURgRhprdFuzGjq3dUDhP8A/tWXxK08Va1CjloXdDN/
         rl4A==
X-Gm-Message-State: AOJu0YyJQ9ByJoO6kfdhB3CdhpwGMUbhK58IeSQrYqLIen9UOVX54v6n
	A+iENY6nfHhSqWxI8O0QPbo=
X-Google-Smtp-Source: AGHT+IFnOswN6PitZD9K0blChM5gWwA6ocFLICLCsqV5hyKCfq/pDMc/huFj8zMq/d2itJpsfbP0EQ==
X-Received: by 2002:a05:620a:1266:b0:77d:5f72:3c82 with SMTP id b6-20020a05620a126600b0077d5f723c82mr18621228qkl.32.1701277699615;
        Wed, 29 Nov 2023 09:08:19 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id rk9-20020a05620a900900b0077dd0ec0320sm413785qkn.130.2023.11.29.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:08:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9D98F27C0054;
	Wed, 29 Nov 2023 12:08:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 Nov 2023 12:08:18 -0500
X-ME-Sender: <xms:AHBnZf-T4zoGMSjWiYoHVOc454Cwp1QSjzd1Xq7O31IhoUnO8HeKRA>
    <xme:AHBnZbs552LAuIG9QgzNQr1iWbt199SWDRLQ0oxxx5u8hIaRpSGpF31Yzt_wRiZ2m
    1yTuDhmXNcU0BZ-NA>
X-ME-Received: <xmr:AHBnZdDuFTRrpSfSH1K-Ny74M87OJ3lK7GbVt8bfe0DdS5gNuAT8YODZRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:AHBnZbf6iK6vMZ_RRHx6pGJi2ozhUUcZOApUvEb-QvvXoMxE_VShhw>
    <xmx:AHBnZUPuinDjp9b7wo3m8867wWgpX22NQ7D9qUhDKhq8zWS2oAfYug>
    <xmx:AHBnZdlA4v32DwcBzGnD3Do-1yOHc4c4-M358TfUpbIwC7_jCc2AKw>
    <xmx:AnBnZSUoZ1bG97raNN2xn2ubWQcXcoxau0HwsZiPUCHEB9UC2scf-g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 12:08:15 -0500 (EST)
Date: Wed, 29 Nov 2023 09:08:14 -0800
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
 rust-for-linux@vger.kernel.org,	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129152305.GB23596@noisy.programming.kicks-ass.net>

On Wed, Nov 29, 2023 at 04:23:05PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 03:13:22PM +0000, Matthew Wilcox wrote:
> 
> > > @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > >  
> > > +struct file *rust_helper_get_file(struct file *f)
> > > +{
> > > +	return get_file(f);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> > 
> > This is ridiculous.  A function call instead of doing the
> > atomic_long_inc() in Rust?
> 
> Yeah, I complained about something similar a while ago. And recently
> talked to Boqun about this as well,
> 
> Bindgen *could* in theory 'compile' the inline C headers into (unsafe)
> Rust, the immediate problem is that Rust has a wildly different inline
> asm syntax (because Rust needs terrible syntax or whatever).
> 
> Boqun said it should all be fixable, but is a non-trivial amount of
> work.
> 

Right, but TBH, I was only thinking about "inlining" our atomic
primitives back then. The idea is since atomic primitives only have
small body (most of which is asm code), it's relatively easy to
translate that from a C function into a Rust one. And what's left is
translating asm blocks. Things get interesting here:


Originally I think the translation, despite the different syntax, might
be relatively easy, for example, considering smp_store_release() on
ARM64, we are going to translate from

	asm volatile ("stlr %w1, %0"				\
			: "=Q" (*__p)				\
			: "rZ" (*(__u32 *)__u.__c)		\
			: "memory");

to something like:

	asm!("stlr {val}, [{ptr}]",
	     val = in(reg) __u.__c,
	     ptr = in(reg) __p);

, the translation is non-trivial, but it's not that hard, since it's
basically find-and-replace.

But but but, I then realized we have asm goto in C but Rust doesn't
support them, and I haven't thought through how hard tht would be..

Regards,
Boqun

