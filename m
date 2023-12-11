Return-Path: <linux-fsdevel+bounces-5508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9480CFA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994EE1C21470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5114C3A3;
	Mon, 11 Dec 2023 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onmjAnwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266AEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:36 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2ca0ab9a5e6so36781001fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308875; x=1702913675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUIMj7SokYe9+NucCQM3I+38l8wF3qwhiLyrCEXuHf4=;
        b=onmjAnwQv7+u5hvxUkl+WhxGESLzgQ6hPoJnPE/UULqdsqTQgqxZfF1w2NoiLXJYoj
         BIAROyXskTwjZo2Npvuhux+xZMuWoZg0HTYQqQEQQXYa1An+2shh7qzPThqdrum8qZju
         oBADg9fP3JnmbedB2pgrD/BS58tUnPZrpXjln0A4pXOsSFC1KNSUljJZnkwbDUY3htby
         2ZTjJr6AcpZJD+wRoSojx1GA61cai4jBo57ut6b7/0kLV1iN5kH7jpfg8vxJwY3T0iQB
         nK57bM+oMrQ4YeLTWW3PyWBCYpObMVqp/i56DOiPKz/9CzSa2/NO9vsA1Qt6oFy6E9iG
         zetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308875; x=1702913675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUIMj7SokYe9+NucCQM3I+38l8wF3qwhiLyrCEXuHf4=;
        b=DsM+IZGxn8K6WSU7WE+P21FY1b1m0c9c1HjViP8WtxySeZUuOX0s11FualiAYuNWGh
         sIuiu0sd6mo/O/oXrgRAuqPnPBVmd3GGroRjYOAMzb60pnvzrm2cijoQWORchz3DG0+g
         CBCVWlSQO0f0p4SDj0+hOFi+yYdZPzqevotDLAmZJSQUj4lYwQnkGxnuQGPuauiAFVRV
         geymArXpA2zTboQs6EQ2vqUT424e4YLlpZ536FGoATU4VnI9bhnTup2Je5z++cvmaEeu
         FgTmowTklvRY+qls7Wd2uZiv/eZl6QR5Myak2ev31xaJowOlyRA6xRHoJPk2pm30EhMC
         eIPg==
X-Gm-Message-State: AOJu0YwADzMyvldHiVemS6G2I9phi+j7mceQEy/pEMFQ55sCzTs/dfKf
	JfBctma1pva+1LhpSHDuD4HfS2bENxShQVQ=
X-Google-Smtp-Source: AGHT+IGaBat9LnXmgGDC1xTwQa726jVkMyE2+JmsFmeGn8kv7qUVzlL7wGfbeD+9loa8mNUt1gkdtNAeahGjqIU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a592:0:b0:2cb:2bc8:5fca with SMTP id
 m18-20020a2ea592000000b002cb2bc85fcamr37033ljp.7.1702308874720; Mon, 11 Dec
 2023 07:34:34 -0800 (PST)
Date: Mon, 11 Dec 2023 15:34:32 +0000
In-Reply-To: <bynTQw4ZTfXBA0m3PYPL50jFnGQIzZnONT_L0TUNuWGtLwJhk6m0jeYQktfEIRmcVZIvKX9MOHwu4RgLWuH3nm5E_AiWNDKuKt_D2HSqsQw=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bynTQw4ZTfXBA0m3PYPL50jFnGQIzZnONT_L0TUNuWGtLwJhk6m0jeYQktfEIRmcVZIvKX9MOHwu4RgLWuH3nm5E_AiWNDKuKt_D2HSqsQw=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153432.4161918-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 3/7] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Benno Lossin <benno.lossin@proton.me> writes:
> On 12/6/23 12:59, Alice Ryhl wrote:
> > +impl SecurityCtx {
> > +    /// Get the security context given its id.
> > +    pub fn from_secid(secid: u32) -> Result<Self> {
> > +        let mut secdata = core::ptr::null_mut();
> > +        let mut seclen = 0u32;
> > +        // SAFETY: Just a C FFI call. The pointers are valid for writes.
> > +        unsafe {
> > +            to_result(bindings::security_secid_to_secctx(
> > +                secid,
> > +                &mut secdata,
> > +                &mut seclen,
> > +            ))?;
> > +        }
> 
> Can you move the `unsafe` block inside of the `to_result` call? That way
> we only have the unsafe operation in the unsafe block. Additionally, on
> my side it fits perfectly into 100 characters.

Will do.

> > +    /// Returns the bytes for this security context.
> > +    pub fn as_bytes(&self) -> &[u8] {
> > +        let ptr = self.secdata;
> > +        if ptr.is_null() {
> > +            // We can't pass a null pointer to `slice::from_raw_parts` even if the length is zero.
> > +            debug_assert_eq!(self.seclen, 0);
> 
> Would this be interesting enough to emit some kind of log message when
> this fails?

I'm not convinced that makes sense. I'm pretty sure that if this API
returns a null pointer under any circumstances, then we're in some sort
of context where security contexts don't exist at all, and then they
would be hard-coded to use a length zero as well.

> > +            return &[];
> > +        }
> > +
> > +        // SAFETY: The call to `security_secid_to_secctx` guarantees that the pointer is valid for
> > +        // `seclen` bytes. Furthermore, if the length is zero, then we have ensured that the
> > +        // pointer is not null.
> > +        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
> > +    }
> > +}
> > +
> > +impl Drop for SecurityCtx {
> > +    fn drop(&mut self) {
> > +        // SAFETY: This frees a pointer that came from a successful call to
> > +        // `security_secid_to_secctx` and has not yet been destroyed by `security_release_secctx`.
> > +        unsafe {
> > +            bindings::security_release_secctx(self.secdata, self.seclen as u32);
> > +        }
> 
> If you move the `;` to the outside of the `unsafe` block this also fits
> on a single line.

Will do.

Alice

