Return-Path: <linux-fsdevel+bounces-4515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7680003C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B241828167C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE995393
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrB8ntL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4D91;
	Thu, 30 Nov 2023 14:40:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778927f2dd3so76248485a.2;
        Thu, 30 Nov 2023 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701384012; x=1701988812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXwCIKbVtUeEXTV0MUcastO1Z1eOm+7jm5G1pyECEhU=;
        b=JrB8ntL31PZyD8fQEsG2TFA1S0cesYtDkUYNGrYEOwDJlKQh7wnlWQe1u2ePPzaqLs
         bIwfqdpVbzZGkQYWSMa93q+csONPG2IYdys7sPyZYsgiKn2wnenpVXxAjDDcovYE+GgM
         +iaYY/rEUxeH3znnUPxC0l2oMt6C9+JvN6/9EXiduqMY2uFu3r6vCLxbLRfqO/Hlr07f
         S0av5o3fmT57vIFSLiD8ZTYL+hq4cyoP18ALJNox6nCVFYsZWNiQF/jqXXRmL7SezHDL
         rT8qa9CgiqhOxD23wBR2N7kuqFRPahbi9KyR01zBNkXjiqPaiQ0HNQ1MRD+ZwU3DMp3h
         zzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701384012; x=1701988812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXwCIKbVtUeEXTV0MUcastO1Z1eOm+7jm5G1pyECEhU=;
        b=BBUvWCyH5ijyreiwgh+FJPFFsX89KdczqRGixpIsJMmx6IvbAYrnejYSuCIaGi6/vL
         ID+I7yhnY37EslzfkZ5ojQvsg/reqL2EQia0ev406gHF3+9Gmsz4HMIxf6V6KwCC4RXE
         HDCBgaVyVbSw3FXwondZ4XZF+e1wVA5OkQQBf/ff1wlfk5MNUWQxu04IsnaDK1aLBsHR
         D4bS+drGgXucmmNME2Fe4mLyMM8pZDYSsWoTMEF5zB6J1/q8svypZpVkQiNdYdeXp+q3
         Glrdtpm0nxSMPiEmHD9BY25yhakz0Z0U34tHKgvRnrNx2XxqoMYWJCkseeV56mPnuFhP
         OQmg==
X-Gm-Message-State: AOJu0YyokVfXnk/E7+MwytysmOUl4hNdBOge4e+AqK6hjYQIigmzX7dG
	j4DzLe2eFjcZ05gRd5M1UUQ=
X-Google-Smtp-Source: AGHT+IEtUwZMDjYVbpOpdd06R4MVKj/IQs4wnsbZcfKC82PD5NHGsaJ/c+z7ZOIEl8K2usLJePqrdg==
X-Received: by 2002:a05:620a:469f:b0:777:72a1:efae with SMTP id bq31-20020a05620a469f00b0077772a1efaemr26923782qkb.67.1701384011786;
        Thu, 30 Nov 2023 14:40:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a288500b0077d8526bcdesm896467qkp.86.2023.11.30.14.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:40:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8144C27C005B;
	Thu, 30 Nov 2023 17:40:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Nov 2023 17:40:10 -0500
X-ME-Sender: <xms:SQ9pZfp3w6_vSIK1DhpA53z1kvTLDnyPEJoST-K8VowJP-1xv8Mh2A>
    <xme:SQ9pZZrNciJwQA2-Y_fLrdiEy2G8-X-ChfoCbB7EEchEg6W67ZovAHp2VEb4uu2Rj
    Vu43mGhYZfc1pMAsg>
X-ME-Received: <xmr:SQ9pZcM-8tyNZj5CUk0vr_dfTGiekLNbOcwAGGy9zP3TUQXA2uUKkdkXmXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:SQ9pZS5XL_Ims4H4euVhEu_IIY9XY-yiz9UeCOboIBAaOAnQPsJY9Q>
    <xmx:SQ9pZe42JyUC8TS8QZ2GB02qykYtZ9vF8393QRWxnJA_-BUoOzUo3Q>
    <xmx:SQ9pZajTWpUSwbC_AXmJG0iCE-NOYEkDfjuZc68B223lYexgxWcbxQ>
    <xmx:Sg9pZRwMoOwJ8wsrTZYQoP0I0-TQ1KCC3lTmchCFICVRiRL8Ea6rOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 17:40:08 -0500 (EST)
Date: Thu, 30 Nov 2023 14:39:20 -0800
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
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <ZWkPGF5AS6creWTH@boqun-archlinux>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-7-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-7-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 01:12:51PM +0000, Alice Ryhl wrote:
> The existing `CondVar` abstraction is a wrapper around `wait_list`, but
> it does not support all use-cases of the C `wait_list` type. To be
> specific, a `CondVar` cannot be registered with a `struct poll_table`.
> This limitation has the advantage that you do not need to call
> `synchronize_rcu` when destroying a `CondVar`.
> 
> However, we need the ability to register a `poll_table` with a
> `wait_list` in Rust Binder. To enable this, introduce a type called
> `PollCondVar`, which is like `CondVar` except that you can register a
> `poll_table`. We also introduce `PollTable`, which is a safe wrapper
> around `poll_table` that is intended to be used with `PollCondVar`.
> 
> The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
> to ensure that the removal of epoll waiters has fully completed before
> the `wait_list` is destroyed.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> That said, `synchronize_rcu` is rather expensive and is not needed in
> all cases: If we have never registered a `poll_table` with the
> `wait_list`, then we don't need to call `synchronize_rcu`. (And this is
> a common case in Binder - not all processes use Binder with epoll.) The
> current implementation does not account for this, but we could change it
> to store a boolean next to the `wait_list` to keep track of whether a
> `poll_table` has ever been registered. It is up to discussion whether
> this is desireable.
> 
> It is not clear to me whether we can implement the above without storing
> an extra boolean. We could check whether the `wait_list` is empty, but
> it is not clear that this is sufficient. Perhaps someone knows the
> answer? If a `poll_table` has previously been registered with a

That won't be sufficient, considering this:

    CPU 0                           CPU 1
                                    ep_remove_wait_queue():
                                      whead = smp_load_acquire(&pwq->whead); // whead is not NULL
    PollCondVar::drop():
      self.inner.notify():
        <for each wait entry in the list>
	  ep_poll_callback():
	    <remove wait entry>
            smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
      <lock the waitqueue>
      waitqueue_active() // return false, since the queue is emtpy
      <unlock>
    ...
    <free the waitqueue>
				       if (whead) {
				         remove_wait_queue(whead, &pwq->wait); // Use-after-free BOOM!
				       }
      

Note that moving the `wait_list` empty checking before
`self.inner.notify()` won't change the result, since there might be a
`notify` called by users before `PollCondVar::drop()`, hence the same
result.

Regards,
Boqun

> `wait_list`, is it the case that we can kfree the `wait_list` after
> observing that the `wait_list` is empty without waiting for an rcu grace
> period?
> 
[...]

