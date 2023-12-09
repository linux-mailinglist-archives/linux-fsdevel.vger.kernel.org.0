Return-Path: <linux-fsdevel+bounces-5408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83880B2BE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3051B20CD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910F15AB;
	Sat,  9 Dec 2023 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ+ZyJqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4CD5B;
	Fri,  8 Dec 2023 23:24:50 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so1159464b6e.1;
        Fri, 08 Dec 2023 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702106690; x=1702711490; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA6npP4B/1h8Lv3vDYT50LP0HFiir56XGpjRhpKMK7Q=;
        b=PQ+ZyJqyI3alLnQm4J1OcJ0vHwSxcnkBAjQeJqtr8LtTYWT8i06FAtkBo7t8zGWsb1
         7VW6PvbiN4VKQfJtaUpXvcJrhk1NHb0IEAeT5VhpJANvzKU81p8pvoRK556SNRs37psG
         HaU/WKxVXtepGBpZ9hVx96mTUxLDhglwx8hGNQB4GEdq9K23x0VP8d6HbWZ2/eQlDHtY
         mVU/jD4c22mSKVhZqmXOX4TLBvJqP0k5toS+s7PD1HY/AJA7Zb5sG5O6TgSlWLwzTWi9
         hGoVsbX6RkPHMUXBnfwtVV6Y36mibl2gY4e3zcqRTHKJey1ldw2SyrHCvnbYnNIafM+s
         +0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702106690; x=1702711490;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA6npP4B/1h8Lv3vDYT50LP0HFiir56XGpjRhpKMK7Q=;
        b=eD44ILXzitgfn1PCUg5BgSlT+B+nhDLW15d/pBdXAaEh9CwCsqC7nC6ciHFIfnhrpM
         4BS7howJXDs5aFJ1gkl4g02T4Z7KiS7CthpmDAzKQj5U2in2SIZ3l1BFWNfi3Mj7CORa
         0ObAlxmrHve3NZ/o8l7tNG8/0ChVCQQFrwlJF1e6lKh4ig/HgiPnf9+lesAWyyopCO5r
         IN2rJTyZG/q7phAzUGVNEEsX9Z1MnBvd/jRrGeHkTWUzj3CumO11T4/8i7tm5t28ls1c
         3q6q9mJa0rl4CB3uuspVFAhTegI33cFQR0rq36/wnCYH+6Fal4joW7XP+r9n/llSPwpm
         XcMw==
X-Gm-Message-State: AOJu0Yyomo21hq7zDwgiC/3z4NbMGBPvthubDmQZMh9Yuk+ltam5Ea48
	3O6eBuFDz3MqGe0Og9k92es=
X-Google-Smtp-Source: AGHT+IGYs36YJSRK1ZVmaBkJb+Iy1NEnIFrzQTgWan5NjNjvr9PNhQmEwveSqekX+ik6sq3a4cawzA==
X-Received: by 2002:a05:6808:120c:b0:3b8:b063:505e with SMTP id a12-20020a056808120c00b003b8b063505emr1458196oil.95.1702106689952;
        Fri, 08 Dec 2023 23:24:49 -0800 (PST)
Received: from smtpclient.apple ([2601:647:4b00:6db0:219a:6f4c:ab6a:436d])
        by smtp.gmail.com with ESMTPSA id q28-20020a056a0002bc00b006ce350d946csm2682652pfs.41.2023.12.08.23.24.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 23:24:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
From: comex <comexk@gmail.com>
In-Reply-To: <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
Date: Fri, 8 Dec 2023 23:24:35 -0800
Cc: Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Kees Cook <keescook@chromium.org>,
 Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4364B468-E0DD-4419-B26E-13B9C3F53F7C@gmail.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
 <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

On Dec 8, 2023, at 8:19=E2=80=AFAM, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> If LLVM folks think LLVM-wise nothing will break, then we are happy to
> go ahead with that (since it also solves the performance side), but it
> would be nice to know if it will always be OK to build like that, i.e.
> I think Andreas actually tried it and it seemed to work and boot, but
> the worry is whether there is something subtle that could have bad
> codegen in the future.

One potential issue is incompatibility between the LLVM versions used by =
rustc, Clang, and LLD.  At minimum, whichever tool is reading bitcode =
(LLD in my example) should have an LLVM version >=3D that of the tools =
producing bitcode, since newer LLVM versions can read older bitcode but =
not vice versa.  But ideally the tools would all just be linked against =
the same copy of LLVM.

If you=E2=80=99re getting your tools from a distro, then that may =
already be true for you.  But if you=E2=80=99re using upstream rustc =
binaries, those are built against a custom branch of LLVM, which is =
based on upstream release versions but adds a handful of patches [1]; by =
policy, those patches can include cherry-picks of miscompilation fixes =
that are upstream but haven=E2=80=99t made it into a release yet [2].  =
Upstream rustc binaries are accompanied by a copy of LLD linked against =
the same LLVM library, named rust-lld, but there=E2=80=99s no =
corresponding copy of Clang [3].  I=E2=80=99d say that agreement between =
rustc and LLD is the most important thing, but it would be nice if =
they'd make a matching Clang available through rustup.

[1] =
https://github.com/llvm/llvm-project/compare/release/17.x...rust-lang:llvm=
-project:rustc/17.0-2023-09-19
[2] =
https://rustc-dev-guide.rust-lang.org/backend/updating-llvm.html#bugfix-up=
dates
[3] https://github.com/rust-lang/rust/issues/56371=

