Return-Path: <linux-fsdevel+bounces-5345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDFC80A962
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E571F2106B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB838DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXCHcDS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED67173F;
	Fri,  8 Dec 2023 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t0CMqzi0Or9T5yhoHSEfgXb8zwflGCNNeN2wQKj6R40=; b=LXCHcDS1GTsrpuzZ1wlJ6Ihawd
	hzs8XrN4sd8AxSDKY+8Gclm09YVmnTAYZM4xVc8KKtB3Xr+8johFi0vSdv0Q+fzDhteeco7mWVlIU
	Yu0ir3kL4MB6DKWcGy8B3MJCZgEGqQP9bpphlbMQCvIXck77pIL4IcJVvpnksW1UrDvV5+cHIT+TU
	3Pv1z1WAeEKDZMoN7rc1eCoKNsmA/XceymQLjjJO8xk3Gf+Nh9A7kHrajHoDtHvwdYVngtTgEBYXq
	M4h5ncihw0LOjc5i0rruRuJLgR6UOrLZL6OZ33oAPtJyAp/rHd/D973O0KTx2MQQGQnyTqE5o19mw
	R6nmPklQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rBdg9-006dg5-2S;
	Fri, 08 Dec 2023 16:26:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6E4C7300338; Fri,  8 Dec 2023 17:26:16 +0100 (CET)
Date: Fri, 8 Dec 2023 17:26:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231208162616.GH28727@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <20231206195911.vcp3c6q57zvkm7bf@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206195911.vcp3c6q57zvkm7bf@moria.home.lan>

On Wed, Dec 06, 2023 at 02:59:11PM -0500, Kent Overstreet wrote:

> I suspect even if the manpower existed to go that route we'd end up
> regretting it, because then the Rust compiler would need to be able to
> handle _all_ the craziness a modern C compiler knows how to do -
> preprocessor magic/devilry isn't even the worst of it, it gets even
> worse when you start to consider things like bitfields and all the crazy
> __attributes__(()) people have invented.

Dude, clang can already handle all of that. Both rust and clang are
build on top of llvm, they generate the same IR, you can simply feed a
string into libclang and get IR out of it, which you can splice into
your rust generated IR.

