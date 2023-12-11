Return-Path: <linux-fsdevel+bounces-5510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDE80CFAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C99B2159D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F14C3D3;
	Mon, 11 Dec 2023 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFgbkwmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BE120
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:42 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50c1e669bf2so3888730e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308880; x=1702913680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOZT5zqEHYky1Ps7K/Q4ciJTn5tJsl8dEphldkaSknY=;
        b=IFgbkwmi+XllibOQ9klKOZKnBHD1mYUtRzsWTeQ8ix0M6qqRMIR9oHy1FmkWo7vp/2
         /X0iHs91+FR9tCE+dYdopOSwBZbF1SUXNKSNmBFokuTBhehbDaw0LNbyEx7ETFp6XKcG
         iWAyHqif/1BMyblwqPlbh61ZNWRLU1VvXHRcKeddIsZzJBE9TGnnPBLOtOgYFDAEaq63
         SHpN9Qwi1kIVvVQtefuwx39ubreuRp4Eoy4wWrDwTjOetvjmsaan2C9edM+apecJebSh
         B/7D9z0wqsgES9TLt65guEhXc8ZBS10ebCX2JWwi8d0Ljy6GU+KBDWGEfp/fqNhnu/lj
         jphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308880; x=1702913680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOZT5zqEHYky1Ps7K/Q4ciJTn5tJsl8dEphldkaSknY=;
        b=A07fxj4JbfWZ14fUBBHiSYOCb02XhLRWPh/m7QWXPcbPwD+9sFk7DhscESAbVCjK47
         IYRXw4MElmYOVGkIicromnuAnWbNlO05blNWQneie8y9uubZTGyAoFSDPq2OXCbpMs9Z
         JFbEgxDaRDx7fs4mjGV7I0o7hPqEo105Ufo0R1t2N8EwyDLxUUdx6MbddDIIpq0qnVdR
         xbTTopOHm9AfnINOOcQly5x4Qv8aJ01kEr7Cjb3stv4Bl7qRbvVjvW+xcng5FjrUnC8n
         FElw9PKG7H7DQ3hieop/Hbb1j0i0Y+5GrFVDQ/+I8Y9Ah51MIR/1uK0N8MRjTO0RDnAq
         O4OQ==
X-Gm-Message-State: AOJu0YxsQqtvfNBh2MQW9vpoKKauR81/23IGsErvRGyVGMufAifDXhOc
	qoDPWl+c2E5GaimFWd0H+rcAx93SYZd+7kI=
X-Google-Smtp-Source: AGHT+IHCOPlTjdNBqi3JUoYkiYaObiziNKxt5OpfQsN0bHdAP695dwHkr0Ehqcwzx9VVbzzEmXS4TnwSIMrRWbk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3d9f:b0:50d:1456:58fa with SMTP
 id k31-20020a0565123d9f00b0050d145658famr31682lfv.9.1702308880329; Mon, 11
 Dec 2023 07:34:40 -0800 (PST)
Date: Mon, 11 Dec 2023 15:34:37 +0000
In-Reply-To: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153437.4162587-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
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

See thread on patch 6.

> > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
> 
> What about `namespace`?

I'll update the comment.

Alice

