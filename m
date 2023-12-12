Return-Path: <linux-fsdevel+bounces-5605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7732C80E0C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D45B215D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE38A3B;
	Tue, 12 Dec 2023 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POMy0qqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A0CE;
	Mon, 11 Dec 2023 17:25:25 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f380d8f6aso304722685a.2;
        Mon, 11 Dec 2023 17:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702344324; x=1702949124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acdHOCAiQMqkPWM1t1b37j8hmWv8asGLnF3nSjNDtxY=;
        b=POMy0qqKXSsPfkEQ0KV0+WC8FdZirzY0ulauLmG+mcz7YUKEg4Mf+e7cIEZcb5IWAA
         ZVrk3jusPz+arx697XjTxGBSd58UqDnGX1asSfVcu0aqL+NOkl7UV3a9mnMS+pGLxpKu
         MYRTVda/CHdYjvWQ7BgnqvFngD8742QZx0uW8XAGwWEdlPwvmOcDOHviIy/V1+4p9Rbs
         /Ms4T+LDdaqiIXYOWpp8+vV53VaZtudpDOxFoTsVHIiSomUWGW6EkbUMrDyD/y8YTSxm
         8jpzcL5VpKj3gKKEDlXZyC6zVO5vzSFMo4d/OYHiJ4rpzGiUWIFPinXxz7DkUEo6F+5Q
         Jp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702344324; x=1702949124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acdHOCAiQMqkPWM1t1b37j8hmWv8asGLnF3nSjNDtxY=;
        b=a+DHjoNl7Rtv9YDaoKWwjthh4cRCO6xrSlrW3GReIueKB5Kq0vsQtxGbi/cF99f+dd
         cZsEs7DBkZTwiSUOFqb+UrwJeE9JugX9H4GUXFalBixkMCz5aWd+XxPWQc6TrvSl4s0f
         Y1B2NOuTX5ni4hEy/f8FxnBMopqQVabszOhedDs/i5qpBx6a+PmkAHa0q8S8K+yR2k2d
         PQq8zZRfyEPhsBYvSEyjEgHwzGmi3CQczICgDduVSlopaYMNRply+l40A6nR0VnR8Ikq
         Sll408hZTh/gzNB0oHkEdei1YSIIBjFnlP6987zNxCIpQnk9kjlip6nkGdz2v7NSrsp/
         vpiQ==
X-Gm-Message-State: AOJu0YyXGG3BOFAjVrcuAR0U/0welxqccecOw57nbT5QY7o0/g99krkV
	OezfTEnCir6EZ1Y8nXwLGSAGj6OF1O4=
X-Google-Smtp-Source: AGHT+IEb95/ZGm8O6gm2t4mE3gP9Rlo4ON4qD/l33nhdEi2IolELBMvqoa7D3DYD6H7wM0F3aP6BPQ==
X-Received: by 2002:ae9:e905:0:b0:77d:4cb9:89ac with SMTP id x5-20020ae9e905000000b0077d4cb989acmr6056119qkf.32.1702344324191;
        Mon, 11 Dec 2023 17:25:24 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a278300b0077f435ed844sm3350413qkp.112.2023.12.11.17.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 17:25:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 149FE27C0054;
	Mon, 11 Dec 2023 20:25:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 20:25:23 -0500
X-ME-Sender: <xms:grZ3Za2GyBNybZZip9ZB5B1oMQqZZ-CX0EmiD_v7HSSL4fPjaMLgng>
    <xme:grZ3ZdHh0gpTJBJfV81u-qJAjqYnh8HMupNkWs22uaaz1jcHP99ZDknZ5IXa7UiAp
    CuUM24iNlyfWz_cwQ>
X-ME-Received: <xmr:grZ3ZS5EuHSYT0-yBVZ3coFRG-9SyvXrkzJDHvh71iplhG2OZ--zJCxqf90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:grZ3Zb3HAUP5xLGHERiqsDk9z4cvm0JP69G-dg7cDyGovICXoF71kQ>
    <xmx:grZ3ZdGdtWVeQF4bP-6wu4xf6f_3D1u1SXoACg8WlZvHfHYTgfPfuQ>
    <xmx:grZ3ZU-UsLUKEMc58q7qiOKi_wtOZP9KThtYCCNrgvxDshz7fQaOjA>
    <xmx:g7Z3ZSvw2CEO67Xk12lvV8pXRZuDsyaZMSfyQmtGbsXoNZ0tY6OgxA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 20:25:21 -0500 (EST)
Date: Mon, 11 Dec 2023 17:25:18 -0800
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
Message-ID: <ZXe2fpN4zRlkLLJC@boqun-archlinux>
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com>
 <ZXdJyGFeQEbZU3Eh@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXdJyGFeQEbZU3Eh@boqun-archlinux>

On Mon, Dec 11, 2023 at 09:41:28AM -0800, Boqun Feng wrote:
> On Mon, Dec 11, 2023 at 03:34:40PM +0000, Alice Ryhl wrote:
> > Benno Lossin <benno.lossin@proton.me> writes:
> > > On 12/6/23 12:59, Alice Ryhl wrote:
> > > > +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> > > > +    ///
> > > > +    /// Fails if this is called from a context where we cannot run work when returning to
> > > > +    /// userspace. (E.g., from a kthread.)
> > > > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> > > > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> > > > +
> > > > +        // In this method, we schedule the task work before closing the file. This is because
> > > > +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> > > > +        // attempt to close the file.
> > > > +
> > > > +        // SAFETY: Getting a pointer to current is always safe.
> > > > +        let current = unsafe { bindings::get_current() };
> > > > +
> > > > +        // SAFETY: Accessing the `flags` field of `current` is always safe.
> > > > +        let is_kthread = (unsafe { (*current).flags } & bindings::PF_KTHREAD) != 0;
> > > 
> > > Since Boqun brought to my attention that we already have a wrapper for
> > > `get_current()`, how about you use it here as well?
> > 
> > I can use the wrapper, but it seems simpler to not go through a
> > reference when we just need a raw pointer.
> > 
> > Perhaps we should have a safe `Task::current_raw` function that just
> > returns a raw pointer? It can still be safe.
> > 
> 
> I think we can have a `as_ptr` function for `Task`?
> 
> 	impl Task {
> 	    pub fn as_ptr(&self) -> *mut bindings::task_struct {
> 	        self.0.get()
> 	    }
> 	}

Forgot mention, yes a ptr->ref->ptr trip may not be ideal, but I think
eventually we will have a task work wrapper, in that case maybe
Task::as_ptr() is still needed somehow.

Regards,
Boqun

