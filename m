Return-Path: <linux-fsdevel+bounces-4226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C607FDF71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F03F1C20839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D65DF03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxGElo7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F04AF;
	Wed, 29 Nov 2023 08:48:41 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so6421236276.2;
        Wed, 29 Nov 2023 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701276521; x=1701881321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59EDV5ZbuzePYVCkCOjXBnyedLCPg9XW8OpMw3xKT/o=;
        b=kxGElo7+38ZHHyLGdAw0cjb+nyV9NW5KKT2sXJWKMjZkBWn2qSyJnObfiSRcd6mp47
         gjrrHYFbFg0N8d/IEQ81wXG25I8iqpB84wSHtgZIPH9V8wvzQ4XuhGxkZ+1u7L+pl9Mf
         ytygwPHnWEfBMpU07AWv/44FaPH6MlASmAwSuTQ1cuHhZKQLT1VVGlLXlmlkThsq2guL
         ws0tKB2nMOUIysJdo02WLI3kSqTTK4yq4qHAQrguDfIi8vzXR9GNXWEN/pSHZ0+/36Cw
         pHIKP8EDYGxKKyOBni6+ftA7xLQW6+XwIGpKkofiaKZ6BSWDuvjNxPcG3b+iYL6mRfKe
         Co3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276521; x=1701881321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59EDV5ZbuzePYVCkCOjXBnyedLCPg9XW8OpMw3xKT/o=;
        b=rkZ2ghbHgHm0pOwV4eaubmICwsqzk7/3qQ5w3Tai//BqqiR9XayKlA//co7Cy2YY/I
         eoZ+S+7BoWg44EwktgnDJtscQWrD7LCAl3+bX48HAFm3NmYxdr8ctjqVldyEZvbgGydz
         Ws54scypygWUPoawbrFKxOcEpG1uvTCVvHZ9friYVdIFhPBfaYbOQ8M5A5FEp4SUV/OJ
         1V12VpRoyquTPfzI0c36R2xqRWW4kHEjaKuJ7L41ATsi5Ek00KXHqza5qmQkTck5hN7q
         ++kxr+C3TiJh2nvz3MmKgisjDom/g32LsBtKbAccoCMlhOwbixuWA+TZFAyee4sjGJaP
         nxrw==
X-Gm-Message-State: AOJu0YyVF5nA4Nipo7H1i0O6SGrCx9oJCuCItUkIjVOJX4VeXiUcU602
	vFUqBdqgEGnQYAc+JUBnWj3UnXcCo65xRN8cjdQ=
X-Google-Smtp-Source: AGHT+IFaMsug/ziZHCY6aqd5ojdPGfqA3gjUJOjRbTdNpNOb4CU6tQReflQg58AZ9b0xudu4WlmLjkFLS1Cz8uBHScY=
X-Received: by 2002:a25:8407:0:b0:d84:e7a6:fc09 with SMTP id
 u7-20020a258407000000b00d84e7a6fc09mr19474669ybk.17.1701276520936; Wed, 29
 Nov 2023 08:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
In-Reply-To: <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Nov 2023 17:48:29 +0100
Message-ID: <CANiq72mQrVr5x2A4jCMhYcdt3rs+D+Y0JyNf_cef1bJ+c8DohQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] File abstractions needed by Rust Binder
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> That's pretty far away from the subsystem these wrappers belong to. I
> would prefer if wrappers such as this would live directly in fs/rust/
> and so live within the subsystem they belong to. I think I mentioned
> that before. Maybe I missed some sort of agreement here?

The plan is that the code will be moved to the right places when the
new build system is in place (WIP). Currently the "abstractions" go
inside the `kernel` crate.

Cheers,
Miguel

