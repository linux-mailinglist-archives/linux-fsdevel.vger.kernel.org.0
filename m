Return-Path: <linux-fsdevel+bounces-5002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A058072AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB51C208C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5753EA80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEWAA+lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCEC7;
	Wed,  6 Dec 2023 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HCaDhHjqMUm7iZFzDCXLcNgiTgr4z8Ne9p0cOAccwCU=; b=oEWAA+ljNDN4NFWDfhVL7YvkG+
	hh4O78O3JT4GNvGm0wMfgUvzeuHvqj/baNlyfPbrzjgbvYuNvSGOSH5PTBS+meMPeIao12JYtv8RC
	AjdV5pzJIHyNmGxqAok1AsAWkdYvmCXqNjehjVRF/SHjgE4vP0pE5XYp6Xw/O4E2LEW8hm3JxEs2f
	gzJuEjgaFwUIubAVbZSCYxLm2wQ26U2y2MumVLGBS3o3NE7iHV09/1LycihISc25fEIFWl9x3/M9E
	PhrslYJhK8oE8jMQDtUr2x894gnwPDmlbm3CrCM5VL53MH2dUTD0msT/fMneWcypUVUmRuzHafRf4
	/uH5ICOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAs8p-002wdo-3u; Wed, 06 Dec 2023 13:40:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7975C300451; Wed,  6 Dec 2023 14:40:41 +0100 (CET)
Date: Wed, 6 Dec 2023 14:40:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231206134041.GG30174@noisy.programming.kicks-ass.net>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>

On Wed, Dec 06, 2023 at 01:57:52PM +0100, Alice Ryhl wrote:
> On Wed, Dec 6, 2023 at 1:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Dec 06, 2023 at 11:59:50AM +0000, Alice Ryhl wrote:
> >
> > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > index fd633d9db79a..58e3a9dff349 100644
> > > --- a/rust/helpers.c
> > > +++ b/rust/helpers.c
> > > @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> > >
> > > +kuid_t rust_helper_task_uid(struct task_struct *task)
> > > +{
> > > +     return task_uid(task);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> > > +
> > > +kuid_t rust_helper_task_euid(struct task_struct *task)
> > > +{
> > > +     return task_euid(task);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
> >
> > So I still object to these on the ground that they're obvious and
> > trivial speculation gadgets.
> >
> > We should not have (exported) functions that are basically a single
> > dereference of a pointer argument.
> >
> > And I do not appreciate my feedback on the previous round being ignored.
> 
> I'm sorry about that. I barely know what speculation gadgets are, so I
> didn't really know what to respond. But I should have responded by
> saying that.

Sigh... how many years since Meltdown are we now? Oh well, the basic
idea is to abuse the basic speculative execution of the CPU to make it
disclose secrets. The way this is done is by training the various branch
predictors such that you gain control over the speculative control flow.

You then use this control to cause micro-architectural side-effects to
observe state, eg. cache state.

In the case above, if you train the indirect branch predictor to jump to
the above functions after you've loaded a secret into %rdi (first
argument) then it will dereference your pointer + offset.

This causes the CPU to populate the cacheline, even if the actual
execution path never does this.

So by wiping the cache, doing your tricky thing, and then probing the
cache to find out which line is present, you can infer the secret value.

Anywhoo, the longer a function is, the harder it becomes, since you need
to deal with everything a function does and consider the specuation
window length. So trivial functions like the above that do an immediate
dereference and are (and must be) a valid indirect target (because
EXPORT) are ideal.

> I can reimplement these specific functions as inline Rust functions,

That would be good, but how are you going to do that without duplicating
the horror that is struct task_struct ?

> but I don't think I can give you a general solution to the
> rust_helper_* problem in this patch series.

Well, I really wish the Rust community would address the C
interoperability in a hurry. Basically make it a requirement for
in-kernel Rust.

I mean, how hard can it be to have clang parse the C headers and inject
them into the Rust IR as if they're external FFI things.



