Return-Path: <linux-fsdevel+bounces-5638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FD80E7EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B99281FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F3584FA;
	Tue, 12 Dec 2023 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHzAsDdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F02EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:44 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b8903f7192so3923460b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702374044; x=1702978844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBPastpn1RC87z2hLEiZW6KtB1XJZ0fz+MiJEWfk6hU=;
        b=aHzAsDdNxgosCtPLlh4A7a7Pd9lK10j1bcD+5midrPZFIulAaKCBBM021VmiWWJf1i
         DsXaPooqliJv2rn2gA4pNTYl0sJNEnr55neuH4Eeocp/bsL4EBhtSBHxXz0Dd4KUF0Zb
         fCKDXSyN19/TSQv49O60rsk+wvvtWOJ8WO6ZM7QhxThLt4v8ArGuiNFD0U1fffaIhYXW
         PmZNAtebFqfh54fio1652/DkUAHp8JF7iFRzxlP//DN2g6E7r8R/4PwB20dgjFRcAGSf
         j1AS0Ha70elH1dxAxO+KwYRJ1P0nSQoZ3N92BPl0a9yDoIkHwNuk5RhCfs+8E3E1cWbj
         /ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374044; x=1702978844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBPastpn1RC87z2hLEiZW6KtB1XJZ0fz+MiJEWfk6hU=;
        b=b4Ab2vhdz65vMCa7KN3+LvdRnRXuUO7Ch+LxbmGfT+kHKgavkGwmAdkugSmK5V54E9
         GJJW+mANeEbc9Bz941vnovWDqdszV6K0mUNZ03RCbHSNuSn0wCHLzzrTNmUCGflmeWZI
         LL/FQ5a4HP8GRs8Iob1hXf4OHKQcnz1LFZcoO09NS9bIUGp7Mh8QZnN8hqRSchP9Ly1E
         xWH8B6yumV/W6P/0Dqta45f1yxISmYlWVoAnsW8OOcPU/yrwy4EShdpXFarslRztHvio
         eZXGUv/R46mRbJg/qlbu0Zhymcu6boTtRpmrO3lhVrektkwqerxIRl/09hnlTbiC+70H
         8uBg==
X-Gm-Message-State: AOJu0Yyb0EZDaaGW5hXd31eA/uLJ2uNitNeTEOsAI43xqm3omWwkYanr
	IlW4YG/Y9ZyMr29WbTqgfTwWKieom4svG9JkqpzkvA==
X-Google-Smtp-Source: AGHT+IHTSiZ6LzgVymhn5KubTf+HT5hUzMz3vldIiaU9GfA+4GJncv76WqjD73+5ZSklO9GCgIaWXZcxpODcXU0Y6u8=
X-Received: by 2002:a05:6808:130a:b0:3b8:7a9d:af5b with SMTP id
 y10-20020a056808130a00b003b87a9daf5bmr6387114oiv.35.1702374043714; Tue, 12
 Dec 2023 01:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXZjoOrO5q7no4or@boqun-archlinux> <20231211153429.4161511-1-aliceryhl@google.com>
 <ZXdIbEqSCTO62BHE@boqun-archlinux>
In-Reply-To: <ZXdIbEqSCTO62BHE@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 12 Dec 2023 10:40:32 +0100
Message-ID: <CAH5fLghbOA6s1d8GFz3JwcqDtzq+VbM3dc3M=enF0UHQN_Nt5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, brauner@kernel.org, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:35=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> On Mon, Dec 11, 2023 at 03:34:29PM +0000, Alice Ryhl wrote:
> > The safety comment explains what the signature means. I think that
> > should be enough.
> >
>
> For someone who has a good understanding of Rust lifetime (and the
> elision), yes. But I'm wondering whether all the people feel the same
> way.

The safety comment doesn't require understanding of lifetime elision
to be understood: "The signature of this function ensures that the
caller will only access the returned credential while the file is
still valid."

Yes, if you don't know the syntax for lifetimes, you'll have to trust
me that this is what the signature means. But I think that's the case
either way. I don't think it needs to be changed.

Alice

