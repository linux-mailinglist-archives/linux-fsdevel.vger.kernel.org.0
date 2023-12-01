Return-Path: <linux-fsdevel+bounces-4553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32077800861
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9508BB21135
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F504210E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RINB/361"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957F1700;
	Fri,  1 Dec 2023 01:52:31 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77bcbc14899so99714785a.1;
        Fri, 01 Dec 2023 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424350; x=1702029150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCG5IQaPKoGK76AgX9Ix4rl77A8iS5D+kL05VMvqY14=;
        b=RINB/361rYQh2KsDlM504nUQ4+2f5hOIyFVQlU5QU0GN8qg81eMdHQzqVKr4rEHzKz
         iqeXxGqsZEywPLvA8qd8/aeb8DKlbpt8WbkNB7UyicvbDMf/TriZVLmdMA3weBMCTKgd
         Vkat2SPZ9VU0q6GSsrHv87wKF7/tTP+roNXKbB/LDBjehkQl6bAt8KSnj+x3MvakpYt+
         nrjnF06StfQ4/Z9UBaLrg3eme/ffXCVIeLWw0taYk/S1MmXXY2wPwcvLCl0B94eWpEMq
         3BqVMP2danpsBV8Z5FegNaNCdjQ3dXGUeKEqtC6o+O3bcLr+P48K+/Z1SvSp92CtWyAr
         J5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424350; x=1702029150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCG5IQaPKoGK76AgX9Ix4rl77A8iS5D+kL05VMvqY14=;
        b=mnKOJvUKq5KVdOMk+/VNEUDryocArz0tAAnXKjxVHYYt+0G8Z3abaMtfA5BttirVXs
         uBy12AAEp+2Rz5dc7rKDFx7B92dVYZdSYaKBqeK0WztTIVIogNwRvjEUBXML6aWfZ5KD
         j37e/Xc1Ikc0wSnO1SYWZjBqP2yWDZeE0zkemmi9qgZnzNKN8S9bfLau7pSseFl447Qz
         B+s6h1zZQkNrAI8a3zoAe2y4PQWNd+MzaPJnIbzbRY0vsde8kdFVf1gBgu2UFu7tUMuy
         m5WRSw1o/xk6kUKYgCfIQKP54445ut5mnCwCR/M41Nx+GqxGEAdbUZfVBrDyOSr1tzo0
         5wbg==
X-Gm-Message-State: AOJu0YwzYx7Y0k5V3/r+PWRyiSQgao+Ac0DzJtbya7qIIXTm3/IpyYwr
	O20lOO/H2A1sKV6+OOzyw3I=
X-Google-Smtp-Source: AGHT+IEJDtiSZHpwdAx3Np9eEcegnDkTcFyj/S7JEBT0l05UEYFSZS4FUG/cSXuGzc59Ia8c3Bm4NA==
X-Received: by 2002:a05:620a:cef:b0:77d:51b3:208b with SMTP id c15-20020a05620a0cef00b0077d51b3208bmr23282239qkj.4.1701424350348;
        Fri, 01 Dec 2023 01:52:30 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qr13-20020a05620a390d00b0076f1d8b1c2dsm1333409qkn.12.2023.12.01.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:52:30 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5354527C0054;
	Fri,  1 Dec 2023 04:52:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 04:52:29 -0500
X-ME-Sender: <xms:26xpZXLo3w12y51LpyGns8Z0WlsW4Ah8qgIPQRJewiwEdEG0dTz3oQ>
    <xme:26xpZbKAOoC_5hiOEydnZxuQEVWV2T1xl7CnKyKfrK8RojHu_YF91BpoURU9t_n2k
    2tX2BxTPFlfB5QQRA>
X-ME-Received: <xmr:26xpZfsPASDq5ZzIrytVIYcfs1AYmfBRBbE_CdkYJ7grlmDGkJpfe27Udw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:26xpZQa8Fj_hObxQ_-Q3WgnMp1kZrv59sQqHSsy9Gdnojdk6pVXphQ>
    <xmx:26xpZeY2Zw-5wOh5a_1o-d5sEW_O7Dph4kS2mzvB1vB9Px0SwoUlKA>
    <xmx:26xpZUCgM9tElUiY5kvWWJtDT1N-NDYsRvGvnETslGJYZFbLtjG4jA>
    <xmx:3axpZZsFqrM1JxNSDnwaztD27Y-lHTCFhHFOuetBjPMz1_0L3ZTsSQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 04:52:27 -0500 (EST)
Date: Fri, 1 Dec 2023 01:52:25 -0800
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
Message-ID: <ZWms2SJ5uzYzw48p@Boquns-Mac-mini.home>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
 <20231201090039.GF3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201090039.GF3818@noisy.programming.kicks-ass.net>

On Fri, Dec 01, 2023 at 10:00:39AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 30, 2023 at 07:25:01AM -0800, Boqun Feng wrote:
> 
> > seems to me, the plan for this is something like below:
> > 
> > 	asm!(
> > 		"cmp {}, 42",
> > 		"jeq {}",
> > 		in(reg) val,
> > 		label { println!("a"); },
> > 		fallthrough { println!("b"); }
> >     	);
> 
> Because rust has horrible syntax I can't parse, I can't tell if this is
> useful or not :/ Can this be used to implement arch_static_branch*() ?

I should think so:

	asm!("jmp {l_yes}", // jump to l_yes
	     "..."          // directives are supported
	     l_yes { return true; } // label "l_yes"
	     fallthrough { return false; } // otherwise return false
	)

Rust uses LLVM backend, so the inline asm should have the same ability
of clang.

But as I said, AFAIK jumping to label hasn't been implemented yet.

Regards,
Boqun

