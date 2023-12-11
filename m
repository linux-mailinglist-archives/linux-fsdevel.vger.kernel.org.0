Return-Path: <linux-fsdevel+bounces-5505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1918C80CFA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D417B2152D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D504B5D0;
	Mon, 11 Dec 2023 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFV9FKn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C93E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:27 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2cb2ca46c2cso11109841fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308866; x=1702913666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quKkQtDAheMF2d2l383YfhdmdDBNq69Kqr0DxY+KMkw=;
        b=FFV9FKn7kl/ny0nza0ThrFt5QMxSaOhfRjD1pgshwnb22WTfWk87cE8RiZrGFt0WeG
         xTNyUJ3i6nVz36V9Etfigqu61F1NIDfUu/4vESCLvfw6sYHDPUvaKzQXoVinSi1fFRMn
         8R47r3735qCgfVL0Y7Re+7UlLBp7sC/kUhqJx2XWOGVV822Rdn400qUpsj6WEGmfyM9c
         EcMlTWEQCeaUo9oXgiu1URGLRhU12556gdlM0Ei5tShAni33xa19sn4V/FkaVqyCk3yl
         4PwAPONcSRMnJaYroJ0PnK+QddaBtIivYHaF/ckkbDBspAtzRvV5SDUpi1iz4fIVv8KY
         HS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308866; x=1702913666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quKkQtDAheMF2d2l383YfhdmdDBNq69Kqr0DxY+KMkw=;
        b=ZQyWrYgSKs2ADr+zrtS1B1y8V73YkpO2HHy4gbO4Lf4jzts2VqqP4AMRVUIjfcWwCj
         l83KGaSbbY2+kEgU1Yd9Q2AAASUQjjvk6Y3BJMrxqc9zUBpCHzPjVyeDYsxiKZYJi0Fo
         2Eg48RTgQqUCSswP3byFoje7V5XoqRjwp9RX9TtvqbhgSGbzYEQr49MDAtuyYKlNO8r5
         Tz/XcJ+u592RuEPYu9TZ+cGvdTXX6/QmeMmEOB6V86Fj5JfIw+BJVMsYQLDofwhlG62n
         p61RvITd0yeoJ9xQ18U9/HJThDV6s8It8MhkBRtMwglIZUrRmuAlwDk0PKXfcvlLk0YX
         A72Q==
X-Gm-Message-State: AOJu0YyMFzynp/z+HbLB8Rpmg+ooryYUTlOFQeVa2j6QX40qsmhiq0nS
	ccKg3QivWa6zWuWw47DSKDgVHZ/H9m3gWNs=
X-Google-Smtp-Source: AGHT+IG8Cg8DINjQAYQUvGbJJE7A8mvaWFGAWJ8W1agA8FjPYmtW/ujH6tQlBNwpTSqn4hac9NByvFt3FV6R7Uk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9c8e:0:b0:2c9:f93d:994b with SMTP id
 x14-20020a2e9c8e000000b002c9f93d994bmr92946lji.4.1702308865917; Mon, 11 Dec
 2023 07:34:25 -0800 (PST)
Date: Mon, 11 Dec 2023 15:34:23 +0000
In-Reply-To: <9q-gcPBFqAZ1mAEZ333ax8Y16e8foTXUWsMijcJyvMhBVu91g4cBo3xRVXVFJeMUW3_67bCukA-bfAzpCwXdbHqwEdciNa8UJBJaCL2q2nw=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <9q-gcPBFqAZ1mAEZ333ax8Y16e8foTXUWsMijcJyvMhBVu91g4cBo3xRVXVFJeMUW3_67bCukA-bfAzpCwXdbHqwEdciNa8UJBJaCL2q2nw=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153423.4160836-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 1/7] rust: file: add Rust abstraction for `struct file`
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

Benno Lossin <benno.lossin@proton.me> wrutes:
> > +        // SAFETY: `fget` either returns null or a valid pointer to a file, and we checked for null
> > +        // above.
> 
> Since now both the Rust and C functions are called `fget`, I think you
> should refer to `bindings::fget`.
> [...]
> > +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> > +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> 
> The comment should also justify the cast.

I'll make both changes.

Alice

