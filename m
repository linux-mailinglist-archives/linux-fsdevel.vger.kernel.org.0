Return-Path: <linux-fsdevel+bounces-1235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717F7D81AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E17B2145D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C12D05B;
	Thu, 26 Oct 2023 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLgA+35T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1D2D03C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:17:05 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9CD1AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 04:17:04 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-457d9ffc9d2so498602137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698319023; x=1698923823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADQcQPFXDFUAE1kDLSEymM4GykgZRpKmE6Mqe8TDGH4=;
        b=hLgA+35TwPIRTqpwo25BV1IqB+22lDsO+ZzJFFejglYNU/9CBRxzasxR079HuJaP2f
         Fi5D4lWHOm0QRKswoeNH/oI5IGtlaIB5zPrZ+BzqgDVRdZWp4QTDZ9C9NcFp0bd3YHhi
         Fpvi/P1favuSuzE3GgqZSo0CrStCLNAdKijyAcDlXWWXtb2cd0I46eEkZ1072haxM8BG
         IR00FZVGSJHkd7tBApkrlOHcrXgkT3bDe8mz64MTuvnd5lfBBTz51/6wwZ3mxIwJ3m1G
         H9yUD698Em0cNN/z11Dtdbo483KqIquOuP3cffQ8KHFB3AzfC0gyGQrTdtbP65Qsh1/G
         IZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698319023; x=1698923823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADQcQPFXDFUAE1kDLSEymM4GykgZRpKmE6Mqe8TDGH4=;
        b=gNg96zJjroLgpB3baojLUL1JV7PqS0r2V/G+3dhQKjU7JMNAbsjToUmd6XX5bjrsNn
         44SmqdEK+VHCwcovCXlJiK+XGaA0xi28ZP3tVL6GF6LSHuAcXB6AZ7ywGgHVpjDqIk1H
         f0xLiip//ztEIdkAby8+RyB4p3nxmBYmwoEbobwOMOFN1U/V/G8LMcVHv+EtRWxwgUin
         G7WsshNvxP+k4Bt4nOKAk/NC9na3YbXVs9DuYLiQ0c4sMFUMrRRybnnYkCcX2SJkxGdM
         Rg3ycPZJZw8Ssk3b0xSQJyZUZgsQxAtg69f1CHQZw2x8hw+GvnyVz2Mtck+6TaJUlr9N
         0nSg==
X-Gm-Message-State: AOJu0YyQccMkPMVA/XVffyvUZZ6OWtaTyHVUJXgoEqrg70Ql/hY9FL2V
	OmGR9QWCYE7Ww0pIRpUk82kDO8me9u2g+JOx4RTdgQ==
X-Google-Smtp-Source: AGHT+IFL1Bi1n9i8tyu/TR0kE59uAhq0MbAYLquMr3viL391nUxuNb4eUNFXaqX2lALhkyqgTfVTxU9ppHTJB0CpVFA=
X-Received: by 2002:a67:e086:0:b0:450:cebb:4f15 with SMTP id
 f6-20020a67e086000000b00450cebb4f15mr1164753vsl.1.1698319023532; Thu, 26 Oct
 2023 04:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
In-Reply-To: <20231025195339.1431894-1-boqun.feng@gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 26 Oct 2023 13:16:25 +0200
Message-ID: <CANpmjNN6PN7tNLuUKZXcTe5n=HOv9Po0er0cDhvP9x=uA7rTTw@mail.gmail.com>
Subject: Re: [RFC] rust: types: Add read_once and write_once
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Oct 2023 at 21:54, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> case of the data races [1]. However, kernel uses volatiles to implement
> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> don't cause UB. And they are proven to have a lot of usages in kernel.
>
> To close this gap, `read_once` and `write_once` are introduced, they
> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> regarding data races under the assumption that `read_volatile` and
> `write_volatile` have the same behavior as a volatile pointer in C from
> a compiler point of view.
>
> Longer term solution is to work with Rust language side for a better way
> to implement `read_once` and `write_once`. But so far, it should be good
> enough.

One thing you may also want to address is the ability to switch
between READ_ONCE implementations depending on config. For one, arm64
with LTO will promote READ_ONCE() to acquires.

