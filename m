Return-Path: <linux-fsdevel+bounces-5744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C480F8C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A749128220F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E865A83;
	Tue, 12 Dec 2023 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRBKQEsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD829C;
	Tue, 12 Dec 2023 12:57:25 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d9ac148ca3so4277836a34.0;
        Tue, 12 Dec 2023 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414645; x=1703019445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxUS3TvB03LQRggRYNx3o//YXpkkNOZ5SD+QK8zWX3I=;
        b=HRBKQEsxumkDhnQoQNYIXqn6Q1y9Ef9q0/yfg8Wj9T/OuQ5Bo/4qAu0NsuupC4Ju9P
         wCQMm4FbNgorNQlIJdJik0t6MCN90el5arediuIK9GtQhdQnqJnIQZgllJkbSxk6nlpq
         dNXsZ3xxM+n1zuZ1p8aP/N8YR2SW/pdDatfawEUCE0sSxAygEvb2pcoHr63gfeg2StMl
         0IzjaWsk1oAXBY1w1VVFXcqPt8KIPRtrNJ+Kx/a/6uR0gT1m0B3IUoIsFie1Ft1eABVw
         6UCdcBAg4vm7JDbKXDWdGDjVWBjY7HdyR/oFBbFSlDPh/8UpQhKgqZDP8EppKzyRM5z6
         VeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414645; x=1703019445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxUS3TvB03LQRggRYNx3o//YXpkkNOZ5SD+QK8zWX3I=;
        b=NGK8LY9/eMNSnZpUAJzcUlBR2HZbZpeuplMV0iKAudqHf+1Y1rApFWfqo6OI7Wy23A
         z+qq/JRNchEbQ7ILzKi0w703TiPMj4RTlzpDBqhtkLNmQ5TVpx0sXV/aDBsqwZJtoGJ9
         xyAinh/UjCzcgqebNFiREgB64Xj3uca8VSr6dcoYXBKbUXTpjzevFsn6FkNlWnA4Q+Wf
         8d4apJJYGPd/xQvR0/2soRdkcWPtT7BtpLZ3DeD37ty3TQ8hX6RkFTAcaC67a0BIP8sh
         VyEKrwaR9pZ6Ij8/IAIhkW4REJ5D0pGmqF3k5uvU5suSCwhNXE3vH/WRlTHgsSIF8iy2
         RmxQ==
X-Gm-Message-State: AOJu0YziBa00Eb95PiDohB5rREtvh6CKhzK7mh9TwNA9iESUIduP56GD
	3TmVw56HZRzG9XahDdwU0tE=
X-Google-Smtp-Source: AGHT+IEVzm5XTtaCzqg2+BKz+d+ww4qaD2Ty2ZL0BHf5n6W2aZ2p1Jo797BtLikgI7m1n2m3o+Yt5g==
X-Received: by 2002:a05:6358:924:b0:170:d002:bc4b with SMTP id r36-20020a056358092400b00170d002bc4bmr3727807rwi.60.1702414644715;
        Tue, 12 Dec 2023 12:57:24 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qg1-20020a05620a664100b0077f01c11e3bsm4012250qkn.61.2023.12.12.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:57:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9741727C005B;
	Tue, 12 Dec 2023 15:57:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Dec 2023 15:57:23 -0500
X-ME-Sender: <xms:Msl4ZVVZI7oukuAUE9yddPyTIabWISbhBOnPpvIFFP4B1fB4geumiA>
    <xme:Msl4ZVmDoVsPDXAM5SlBgN2oo7kAQ8gjkG0ZNMzrs_QsiwkIJh4MNP_3szB0uPePY
    C4m9j5GOcgLad5iZw>
X-ME-Received: <xmr:Msl4ZRY7M1t6IHbvwxF2c8Qn6g4YWXr-mjXMDMqQvSEgxrc5b4yFSlRa8xuz-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Msl4ZYVYEa1uxYonKzRmrUloD3R1zdFUCsphZycW7OqnL6vdbWQgig>
    <xmx:Msl4ZfnyyXI5_hZafTEqdFMEC8C5IfxRsjCW8l7CCGV_ue6bVGvWWw>
    <xmx:Msl4ZVfGurwOgMgQaXsHcFemZ6iP672J07Ol0NTxm8d-DqMxao13Og>
    <xmx:M8l4ZfOEKKQzdWtXLtomTBc67jbtFF3PZqikg51JLT6nVRb5tZcS5A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 15:57:22 -0500 (EST)
Date: Tue, 12 Dec 2023 12:57:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: benno.lossin@proton.me, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	arve@android.com, bjorn3_gh@protonmail.com, brauner@kernel.org,
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
	gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <ZXjJLP5NdbxEzKpC@boqun-archlinux>
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com>
 <ZXdJyGFeQEbZU3Eh@boqun-archlinux>
 <ZXe2fpN4zRlkLLJC@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXe2fpN4zRlkLLJC@boqun-archlinux>

On Mon, Dec 11, 2023 at 05:25:18PM -0800, Boqun Feng wrote:
> On Mon, Dec 11, 2023 at 09:41:28AM -0800, Boqun Feng wrote:
> > On Mon, Dec 11, 2023 at 03:34:40PM +0000, Alice Ryhl wrote:
> > > Benno Lossin <benno.lossin@proton.me> writes:
> > > > On 12/6/23 12:59, Alice Ryhl wrote:
> > > > > +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> > > > > +    ///
> > > > > +    /// Fails if this is called from a context where we cannot run work when returning to
> > > > > +    /// userspace. (E.g., from a kthread.)
> > > > > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> > > > > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> > > > > +
> > > > > +        // In this method, we schedule the task work before closing the file. This is because
> > > > > +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> > > > > +        // attempt to close the file.
> > > > > +
> > > > > +        // SAFETY: Getting a pointer to current is always safe.
> > > > > +        let current = unsafe { bindings::get_current() };
> > > > > +
> > > > > +        // SAFETY: Accessing the `flags` field of `current` is always safe.
> > > > > +        let is_kthread = (unsafe { (*current).flags } & bindings::PF_KTHREAD) != 0;
> > > > 
> > > > Since Boqun brought to my attention that we already have a wrapper for
> > > > `get_current()`, how about you use it here as well?
> > > 
> > > I can use the wrapper, but it seems simpler to not go through a
> > > reference when we just need a raw pointer.
> > > 
> > > Perhaps we should have a safe `Task::current_raw` function that just
> > > returns a raw pointer? It can still be safe.
> > > 
> > 
> > I think we can have a `as_ptr` function for `Task`?
> > 
> > 	impl Task {
> > 	    pub fn as_ptr(&self) -> *mut bindings::task_struct {
> > 	        self.0.get()
> > 	    }
> > 	}
> 
> Forgot mention, yes a ptr->ref->ptr trip may not be ideal, but I think
> eventually we will have a task work wrapper, in that case maybe
> Task::as_ptr() is still needed somehow.
> 

After some more thoughts, I agree `Task::current_raw` may be better for
the current usage, since we can also use it to wrap a
`current_is_kthread` method like:

    impl Task {
        pub fn current_is_kthread() -> bool {
	    let current = Self::current_raw();

	    unsafe { (*current).flags & bindings::PF_KTHREAD != 0 }
	}
    }

Regards,
Boqun

