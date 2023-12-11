Return-Path: <linux-fsdevel+bounces-5447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A818080BEB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 02:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07257280C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3A8813;
	Mon, 11 Dec 2023 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdBqw7yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AFED;
	Sun, 10 Dec 2023 17:20:50 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f552d4179so146145585a.1;
        Sun, 10 Dec 2023 17:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702257650; x=1702862450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uuz0jwb3PNQkrLULfff6ouksNMtSPtItSVdeK1cdQGc=;
        b=TdBqw7yyWm8e4PSZC8RkkJuQKv+WvgbrlMhMIGBhK2c5d/zji503YA6MMETsSmFQ18
         KpzUu5SanjjU/Bpg20H9f+F/ghJjJPbLmrvyyVlPU40fFh3GYeXz0W5xVWiD485Sxgef
         gaM4vqyNNJ0qqHM1RaKvGeyZQcQkk7F9SPpl1xsS04p2xW9AFabRwXcUO4W4GiibBVpq
         3j4OwYqClQZKljckgRczi6aTCk31WQi7txKcUuwlf1UJZscDcEPZ14QGqz3YzHGRdyLo
         MNQcIC+fiVRuWiQ4rAqNqDEljCkXinq9/Q0FzxgYeef44ObQPIVsRpOOZHe9iNbUDVr/
         Y2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257650; x=1702862450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uuz0jwb3PNQkrLULfff6ouksNMtSPtItSVdeK1cdQGc=;
        b=oX2XwKUar9zrVKlWm9UAEfRbdaY5SW89TZedSZKBUEwgBmhdsGhGkwMq/KbaMfukI2
         szdodmxCj9qFwg9AtxuL2aBHKb2DKUaAhEVfeg4ONtI3TzikWDXLOBrYNRIIPzfpDvlR
         p3TdACaexNQvNLBR10IUza/uF2n10f7/jeyE/854hWEItoo/zn2jq8jfoQZMeyqLvmqa
         jAK5tOH6SAVi2mI+nk6DgB3dxs2pBH2OenOn83dRiGC5/UFIibOJRjpnaSJSPeKqHo3K
         as6UsNsvdTydr3CFJbXLKiYtpOaqF2ric9RRa0Ab7c2r+S+9nHXoRS5rcUXsd07dAazX
         vWAg==
X-Gm-Message-State: AOJu0YyW2Go8HM6XYYb/yf3UdrdoWLy88PA0i3sjVv3rlCUQ1ZGWuVVy
	zhCDyr/gaKcQCqIyuIVrrxc=
X-Google-Smtp-Source: AGHT+IG2YneOH1fjVBLNsKVjeTO1Qmpnmz9N5QGIlgYQK4gwUQlL72tTSLGo67HZ3XBLoMoCCzXdPQ==
X-Received: by 2002:a05:620a:a58:b0:77f:69ed:7f40 with SMTP id j24-20020a05620a0a5800b0077f69ed7f40mr2501765qka.7.1702257649715;
        Sun, 10 Dec 2023 17:20:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm2505634qkn.129.2023.12.10.17.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:20:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id BDCE127C0054;
	Sun, 10 Dec 2023 20:20:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Dec 2023 20:20:48 -0500
X-ME-Sender: <xms:72N2ZWH4OqLhoJjPIu-xBvNG1v1zh5JUCVUiIYRevqTwampQ8LPuDA>
    <xme:72N2ZXUDpW0JpLk2NqST1PDbvVCRwbmvSfa1hIp4lnB0qSEc9z5TDM0WXqz0G2Zzc
    g-S2vOjbDC70WmVGQ>
X-ME-Received: <xmr:72N2ZQLvmY1VITeM4l9iKaEl6wLLzVzYcPZ2P5n5NiFb7uf5YFci8VfX7gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:72N2ZQH8Ae7bUawVz7AvMbaSHc_NeDP9SDt4qb4ksz8_kx3CErPCMg>
    <xmx:72N2ZcX2cIrtHyoVYeBKE05njYXgchs20UDdwdau7PiJwb_WC9w2DQ>
    <xmx:72N2ZTOsUETvW2YTjIs0-9juNf4RpCwIZGSqLr80gstqnrWDaiUyXA>
    <xmx:8GN2ZW-W_Fvq1hey4YOUfIuyPEL3g1x2PM7lmJ5o2fUQC6IyleGmXA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 20:20:46 -0500 (EST)
Date: Sun, 10 Dec 2023 17:19:28 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
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
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <ZXZjoOrO5q7no4or@boqun-archlinux>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-2-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-alice-file-v2-2-af617c0d9d94@google.com>

On Wed, Dec 06, 2023 at 11:59:47AM +0000, Alice Ryhl wrote:
[...]
> @@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
>          self.0.get()
>      }
>  
> +    /// Returns the credentials of the task that originally opened the file.
> +    pub fn cred(&self) -> &Credential {

I wonder whether it would be helpful if we use explicit lifetime here:

    pub fn cred<'file>(&'file self) -> &'file Credential

It might be easier for people to get. For example, the lifetime of the
returned Credential reference is constrainted by 'file, the lifetime of
the file reference.

But yes, maybe need to hear others' feedback first.

Regards,
Boqun

> +        // SAFETY: Since the caller holds a reference to the file, it is guaranteed that its
> +        // refcount does not hit zero during this function call.
> +        //
> +        // It's okay to read the `f_cred` field without synchronization as `f_cred` is never
> +        // changed after initialization of the file.
> +        let ptr = unsafe { (*self.as_ptr()).f_cred };
> +
> +        // SAFETY: The signature of this function ensures that the caller will only access the
> +        // returned credential while the file is still valid, and the C side ensures that the
> +        // credential stays valid at least as long as the file.
> +        unsafe { Credential::from_ptr(ptr) }
> +    }
> +
>      /// Returns the flags associated with the file.
>      ///
>      /// The flags are a combination of the constants in [`flags`].
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ce9abceab784..097fe9bb93ed 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -33,6 +33,7 @@
>  #[cfg(not(testlib))]
>  mod allocator;
>  mod build_assert;
> +pub mod cred;
>  pub mod error;
>  pub mod file;
>  pub mod init;
> 
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 

