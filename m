Return-Path: <linux-fsdevel+bounces-5355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15380AC37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1CD2819BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B92232C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj4boYgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBBF85;
	Fri,  8 Dec 2023 09:38:02 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5c8c26cf056so21355047b3.1;
        Fri, 08 Dec 2023 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057081; x=1702661881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Z0YmFOw5rXYpuwdmLPjflIJNNlQ47AX9g0hYDvR5o=;
        b=Kj4boYgQtJLzej0yLJ+7OV6v6OYz3VZ/FbsL1ujauMdyAJgHtVFxiStLDdYUcGe2Zm
         dfoIjpPkwTU7IWLe8nyCO5XLA3IYa0l+yHSq4vpwD2msyRTXMdbN8tQrpiZLs5KMGW+4
         +VFk/K1qUn6GQ+KIqukK8k5w168Itux9sQ3rcp2ZPkplCH8KungUvcl0ERAg37tQfvSC
         fOhsxMJKhQeOZfoQgTp7w6spy+vJwPq0Wmxm0luT8wrazWd6D0U/8gZjTG3HU26IkjiJ
         cWz79nQjiYwBxGvCYGoHUi9a9HqKSsekooqkNzSShYwwA5fbIWk0gw3QhfbV/w9holZt
         TITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057081; x=1702661881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Z0YmFOw5rXYpuwdmLPjflIJNNlQ47AX9g0hYDvR5o=;
        b=vmwAUxi5ybJ7G3CB1vH9ufiHOrPVT+QWSvLJpRDvLEEigcUC4QwSVvn06xPCH3ax5d
         SI9qbxU3UnNjFQhI3UOvfX17b2Fejm/kGCbQqkjGbT3TY0dRY9xnS5HtdPNdw8yvW1v6
         g3XfnVHOKR+11fSBO90jHFY64qDbLZfmrc8OEXsz9DkiJO7TpgR8MGXQHwrlZUHzvk3C
         ZjSt15mGT9S6OMGaWscQmNBnrVxSM0s16V1/QT96vp4tXSwQseiZk/siTl/SKK3OWAMl
         47izNz79vSsn4DDeLojIQ59fHjvkxY160/kv8CIKeb44zlKGneExfYXGnIVmDwNi5k8b
         CeiA==
X-Gm-Message-State: AOJu0Yw/+q5+kL7IjqjyBoX9F5Pqxx/cRKJ3sdEEoBQ72VxUQCSY3r9i
	B4A/wwhTZ/uj1fIRRdgoolGP81QcVgIoH6ZmAtM=
X-Google-Smtp-Source: AGHT+IFawH7St5qCEWYP8PbcH0z/rJAZe3a3N6xzb6hdNjyDdzrYfhvprq/4hPtmWW3AExesCE1HztRglxhPVMsezf4=
X-Received: by 2002:a0d:ca05:0:b0:5d7:1941:2c0d with SMTP id
 m5-20020a0dca05000000b005d719412c0dmr353319ywd.58.1702057081504; Fri, 08 Dec
 2023 09:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com> <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net> <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com> <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
 <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
In-Reply-To: <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Dec 2023 18:37:50 +0100
Message-ID: <CANiq72nkXu1esMjK-DF3iCw93YfRzRCaFWZxr5emZthnvVr+zg@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: comex <comexk@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:09=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On paper, nothing comes to mind.  No promises though.

Thanks Nick -- that is useful nevertheless.

> From a build system perspective, I'd rather just point users towards
> LTO if they have this concern.  We support full and thin lto.  This
> proposal would add a third variant for just rust drivers.  Each
> variation on LTO has a maintenance cost and each have had their own
> distinct fun bugs in the past.  Not sure an additional variant is
> worth the maintenance cost, even if it's technically feasible.

I was thinking it would be something always done for Rust object
files: under a normal "no LTO" build, the Rust object files would
always get the cross-language inlining done and therefore no extra
dimension in the matrix. Would that help?

I think it is worth at least considering, given there is also a
non-trivial amount of performance to gain if we always do it, e.g.
Andreas wanted it for non-LTO kernel for this reason.

Cheers,
Miguel

