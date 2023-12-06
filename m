Return-Path: <linux-fsdevel+bounces-5000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637658072A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 15:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2F2813D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F230CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzSejHzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4013BD47
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:58:05 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-464dcdaa83bso361924137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701867484; x=1702472284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGoYDW3YQsCzUXqvsbiGGRLqfJtz8CuECDoHvJMwowA=;
        b=zzSejHzlYCtxzkwSxFmJ9cLnJ870it9JXKAFDEm2WFo5VgI0wNWxiv/Axq67CA8XL3
         VifHzekUcvZSuvIlNUuyttJ23igW+uxMcYfiW0rgOg9zPiJ0r1RQ/SceXDG5fTgogY0x
         /gcfgPTzrxpGDr/D2gpszfk0Ms2ObBqG7mWCFCDXfQgESGrtt28ITRZTppJuXbeh0Eyq
         +eUu+bTb9tMFCc6BjGU3mjAyseLGOoq2MCZOvx3Tpg7sgO++0AB/D3T+Jpi5sJtdKRkj
         KyM3gXzGSVdpvpRpgcICjn8XxPqfk2r4ZYj6YsoFrxI5SMw0wpg8NMSATsJhrVrfc4IT
         ZwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701867484; x=1702472284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGoYDW3YQsCzUXqvsbiGGRLqfJtz8CuECDoHvJMwowA=;
        b=BbKBy949+HJB/6vXwBnFi3jKyLVc6sna8BhObhbt1Jwv19LF2Hmffly5IvObBtE0Le
         gJ64MeHBVUy0MyS3yFQ/bau74+0xFKjYVNjYO9l03EOWEzhMQ1pLZ7C5Fu/0Ib3ZudQS
         tj+6MbdEBGXI3AbSCCPk7xI88EHgY27R+8dwBgUJEVKlpY248b3gQ2bRxwZ2LsboZDI8
         AUwr7/UIYsAz7ky9e4AqNVfmL9rY+fCM4pSTkJvR4EQo5dDvm9O4NQHGkqUtlMCU5oJi
         XMx9XlLvPpCbykDQEm05s74+11qUfL9tVWaZFE76Ouj7Mq3VQOc6vkNTrlr10ktUZP1g
         dxdg==
X-Gm-Message-State: AOJu0Yz5ZPaXEE+OkjbmiRIreIWSOFocc3NlFqfcW1c+ls+l+zBwxH78
	qqI7Vy0tvLr6K5jovr0Ocrod+cttYI9L6iyEVPDzHQ==
X-Google-Smtp-Source: AGHT+IG1/Vjpae3H5W+ZbnTi936i2LjYA50NrGUUAe1mup4QsNLrUvjnIaS+tKWBM8ZO1uqYk3un/FSr1qp/knN9p3M=
X-Received: by 2002:a05:6102:53b:b0:464:5913:60e with SMTP id
 m27-20020a056102053b00b004645913060emr265114vsa.29.1701867484173; Wed, 06 Dec
 2023 04:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com> <20231206123402.GE30174@noisy.programming.kicks-ass.net>
In-Reply-To: <20231206123402.GE30174@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 6 Dec 2023 13:57:52 +0100
Message-ID: <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Dec 06, 2023 at 11:59:50AM +0000, Alice Ryhl wrote:
>
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index fd633d9db79a..58e3a9dff349 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struc=
t *t)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> >
> > +kuid_t rust_helper_task_uid(struct task_struct *task)
> > +{
> > +     return task_uid(task);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> > +
> > +kuid_t rust_helper_task_euid(struct task_struct *task)
> > +{
> > +     return task_euid(task);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
>
> So I still object to these on the ground that they're obvious and
> trivial speculation gadgets.
>
> We should not have (exported) functions that are basically a single
> dereference of a pointer argument.
>
> And I do not appreciate my feedback on the previous round being ignored.

I'm sorry about that. I barely know what speculation gadgets are, so I
didn't really know what to respond. But I should have responded by
saying that.

I can reimplement these specific functions as inline Rust functions,
but I don't think I can give you a general solution to the
rust_helper_* problem in this patch series.

Alice

