Return-Path: <linux-fsdevel+bounces-5350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66080AC2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35301F210BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7474CB20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9BTnAv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA198;
	Fri,  8 Dec 2023 09:00:03 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d8e816f77eso22849117b3.0;
        Fri, 08 Dec 2023 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702054803; x=1702659603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBtWBJQTohnwJ/b4g/t2c8OgOzR4vIJu5QNlR9uw3Ag=;
        b=S9BTnAv6vbJZmflvnfS6WdzPy1/qUNc45rZHO2y0n0lndurlK3RKpOY495AV2lUBqn
         Xx1FMbTbCmTCFH8zrfwVUNhZ8kZkEudPiG4kxr8VlQL6SAPN2AQ8FbzcuLyLILFOmmAC
         wSWaPprUdzsraE/9aF3K7nJsHn79E8Jo3pGFKG9MNbdG/TtlB8OVfwIy5KSW/OE6GLQA
         Oe6vxrv8c+v2Dr7xr6KIz7Vz4VPga9lMspIZqSYBVojvc0N53Of2v2/NSGDwDl61PFtE
         4vEmqzJVIgPlEBy9oYFdZPaaqataairMWan8L2oSs3aj9GJbF6Ebiws8Da3HrP7Oq5U7
         r5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054803; x=1702659603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBtWBJQTohnwJ/b4g/t2c8OgOzR4vIJu5QNlR9uw3Ag=;
        b=GeIfApPoLmrB6QKg00Z6X4F1BKzUospe43cck4dsRnxQEJry4dO0yn2vLW8EN9h4NX
         U+lwgg2+yVdWQTn4Hh2YktJSeJSdWRdG6ragB3WD6Z25Lh11L/opaED1Dv+XzQh3+s6A
         Xjl3aZESdNu7k4yhXgh56nJp7KwT7/gAnvEjnpbCYCNQFBA2tbTwDsHiGWDUwlixgpIp
         drEXV1CyiOdONqiIs4j+k3A2YKoAB1+Wn4owHpKiAQYdpazKzNqKYypstWMjEnglhw71
         F5KusIMlo+KLslpX7P6xDU9QWXtcq+nUrIWn91ptmQCIJzH2hSAzBaAClrfFZLlVdiZw
         fvHQ==
X-Gm-Message-State: AOJu0YzC4aRuFs0JnhHzYyfM/tU4s7/FfnRhJ689BUWN2UAtVHmt4cwn
	lU3BqklJQtVqdU26x02X/+52WIgrJK9VZigdMnY=
X-Google-Smtp-Source: AGHT+IEDEFuGPlOOaOqUwW/5TKcG+a0eq2uylZH8LKW32NcjbTMw/3yBjEt8q8/2YI2E/lZAzSV05OlXUyuh9c79ALE=
X-Received: by 2002:a05:6902:1828:b0:db5:4653:7214 with SMTP id
 cf40-20020a056902182800b00db546537214mr253408ybb.42.1702054802494; Fri, 08
 Dec 2023 09:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner> <20231206200505.nsmauqpetkyisyjd@moria.home.lan>
In-Reply-To: <20231206200505.nsmauqpetkyisyjd@moria.home.lan>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Dec 2023 17:59:51 +0100
Message-ID: <CANiq72kWx5td7SfP3KWcce4ZqvWBg1NPjT=dNeed2eG2rEHWjw@mail.gmail.com>
Subject: Re: [PATCH 0/7] File abstractions needed by Rust Binder
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Wed, Dec 6, 2023 at 9:05=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> I spoke to Miguel about this and it was my understanding that everything
> was in place for moving Rust wrappers to the proper directory -
> previously there was build system stuff blocking, but he said that's all
> working now. Perhaps the memo just didn't get passed down?

No, it is being worked on (please see my sibling reply).

> (My vote would actually be for fs/ directly, not fs/rust, and a 1:1
> mapping between .c files and the .rs files that wrap them).

Thanks Kent for voting :)

Though note that an exact 1:1 mapping is going to be hard, e.g.
consider nested Rust submodules which would go in folders or
abstractions that you may arrange differently even if they wrap the
same concepts.

But, yeah, one should try to avoid to diverge without a good reason,
of course, especially in the beginning.

Cheers,
Miguel

