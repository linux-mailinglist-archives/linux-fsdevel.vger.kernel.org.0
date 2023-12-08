Return-Path: <linux-fsdevel+bounces-5348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FF80AC2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB51F20620
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0941C91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC2Qa9ZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B2E10C0;
	Fri,  8 Dec 2023 08:43:24 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77f48aef0a5so68807785a.2;
        Fri, 08 Dec 2023 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702053803; x=1702658603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2xmBI6l/MRigs2qcRLIfKFKtDGM2v75E3mtvHqRCsg=;
        b=MC2Qa9ZM4DXAGDa/+6ppKt4Xpe73i7xU5i33UASeM99ne8DjchNursPOiFaSBICVc4
         VnZgr+yYeaSwC+wHYzU9Yb36IKMcCaXTtxwZJ1sqVQ83rKwazyC8Zr2zxO2kBaOPjbPg
         SJ+I6UalWSSmxM4PoQgJxIF+VAONg4eL4x/SEbLyClWJfvkrDPNbrkUTE6o95xzftGxF
         8BfpfN7WguXgIf4EqRSVJfyiSVJIVvkvBiByorde4qew6LnVtwPwWMN8p5rUcxx1Q4So
         OB1pdvMzpn0DoLyCoXy7IdC2cljZ2iZFFCqEb8RtyeEiggWmX/IZtbmERFVOw6qotb67
         /IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053803; x=1702658603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2xmBI6l/MRigs2qcRLIfKFKtDGM2v75E3mtvHqRCsg=;
        b=eLYFWPpYFiZcLqzVD4kQOaRK0eS/mD+gpQ1dtOiqZvI2DfBqbexd1v3n/eLC6fO2lo
         EsZmtnxHCNi7VMKnNb02D3BVcWRoqjnDrLGbugttC/IrYQuYYEVUmLj8gmS1iv3fMlam
         Sll/aCOVeCPQVCS0o4POI6eDfKL+UtPWLxNMn2EN2NBznJf2gQANyKliliTjkQZgmzhN
         cP9rcKX3bZRNs2UO5FwVfbb+cwhFOurcNhOEdnUErzCEKJttWB01qYvHHBkw2Okf6Sc4
         VVRclx5eNCxSgqWxjxP6bdIT/px9MCtv3BjyKapJly9+SooHBjKIhPT4E0lhs5vIqdUR
         x8uA==
X-Gm-Message-State: AOJu0Yxq5IZ8Mk/r2E6F9qAKtXwsiNP0PsjKixzbE3Mg75tBKQmftVXV
	1yoXKysoNXzS89wJvTC5N0k=
X-Google-Smtp-Source: AGHT+IEMOz970vAIG8DxK4T2yh2+WraPteOycduxnsty4R7dX7DngxnM5LsoneUyFj/oXZERR6tzDA==
X-Received: by 2002:a05:620a:480c:b0:77e:fc1c:97d8 with SMTP id eb12-20020a05620a480c00b0077efc1c97d8mr396826qkb.36.1702053803249;
        Fri, 08 Dec 2023 08:43:23 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id tn24-20020a05620a3c1800b0077d660ac1b6sm819532qkn.21.2023.12.08.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:43:23 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 460D527C0054;
	Fri,  8 Dec 2023 11:43:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 08 Dec 2023 11:43:22 -0500
X-ME-Sender: <xms:qUdzZbotq4UvVMS3WlWLbJx9Sp0rj6zkQc0-E2mt7kQndGnjM2kYuA>
    <xme:qUdzZVqwZXAQ2Byj9o9m6Fqlj9ihFQcVqSB0Vp-FjN9oQhTnayC2KCO9fKofLp2lE
    BIwdeRe-u1avJL4zg>
X-ME-Received: <xmr:qUdzZYNKFc5fy14mIlO6iL6XLpqviCe5aG6FYFm-IoRGZyhGcySPiXWePg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qUdzZe7XqW-hjLAsX1oyO4cn0scCOoVHOfAtHCgFpu1pSFm0npM3vQ>
    <xmx:qUdzZa6I_NLuhDJKl-bRRt8EteI8_p2xnQMJmCuWy67zn35Smy2mtA>
    <xmx:qUdzZWgioR2VErb7GXQ8neQC1KyE-WOLfOVeLbZ5xMSQn0n7Codz5Q>
    <xmx:qkdzZdzsKWvY1dwOV2PynGYMI5E4mCr_NqaYeQnuu6_fX35THKQSBQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 11:43:20 -0500 (EST)
Date: Fri, 8 Dec 2023 08:43:19 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <ZXNHp5BoR2LJuv7D@Boquns-Mac-mini.home>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>

On Fri, Dec 08, 2023 at 04:40:09PM +0000, Benno Lossin wrote:
> On 12/6/23 12:59, Alice Ryhl wrote:
> > +    /// Returns the given task's pid in the current pid namespace.
> > +    pub fn pid_in_current_ns(&self) -> Pid {
> > +        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
> > +        let namespace = unsafe { bindings::task_active_pid_ns(bindings::get_current()) };
> 
> Why not create a safe wrapper for `bindings::get_current()`?
> This patch series has three occurrences of `get_current`, so I think it
> should be ok to add a wrapper.
> I would also prefer to move the call to `bindings::get_current()` out of
> the `unsafe` block.

FWIW, we have a current!() macro, we should use it here.

Regards,
Boqun

> 
> > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
> 
> What about `namespace`?
> 
> -- 
> Cheers,
> Benno
> 
> > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> > +    }

