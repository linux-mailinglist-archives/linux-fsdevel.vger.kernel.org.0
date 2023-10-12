Return-Path: <linux-fsdevel+bounces-194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293B7C7519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01161282B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CE3714C;
	Thu, 12 Oct 2023 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3W2IPThL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6636B16
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 17:51:14 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EBBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 10:51:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4526b9404b0so1564733137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133073; x=1697737873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/kcvd3Ium4zd9I0dnayawEHaM8pcXlmWMrCCjUShbo=;
        b=3W2IPThLUpR4uRpb6oTtQfLXnzANytWXRUZiYHiRYSFhKxf9lemNt20TYDEXYshlOr
         i0sJ9ca542vaR2iT186pzEru/LiPQMEpsGKhKkB+s+NsXi+tdJ6TRV/bgSqnj+krUJ7S
         3/1nz6DgSOEPcBgAg6VV4ss7/gBWvftrymcbkeEnwk0eebJNw70AeWeWQlEHiNIgmSXm
         61sA/AAiL8cr88SacWq3D7hJaWMsMPm9XZfRnDa4fKrNYVmtc2rL45byNu5W51dyKYvv
         OpP4yIez6M53AOheVIEEvhtPcTEnBE/DeVhF1WYu/LmdzdybqskNQh7AC87UQWSCZ3Yw
         feEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133073; x=1697737873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/kcvd3Ium4zd9I0dnayawEHaM8pcXlmWMrCCjUShbo=;
        b=ewG4As2S+6AOqM/f2hShXerOCq3Gc9ntA1YpNRbV+VutUlpscZGytOGvuLjqnPjC2x
         kEEtnTfWPAkP0zjuED91enM9+doa3EpaHnKl5JUEFKVv32LEPg9AUk7FdqvmTdiwNpNv
         pkDHbZV+KQeYkOR/If3kZvK9ot3uQWT2MiFpOSVg1yixTNgmJaPlrExEgbhdpcOudrFD
         Um/gawXv4wv07Ag2Fku1l3eO7/CwohpnvN382q6YQCwG3eINAIzzp98OnecevIrixe+q
         p3raKNszBURh2XsrmT6iQ7v6G/gOdkC17F+eUAHNSvSfCJcMH2PELFUdCqMwqDhOaMjl
         eFFw==
X-Gm-Message-State: AOJu0YxGQEXcPdFEcspiXsuGKKSTNe5vvo2qAdp4OmKFkq2EsxP6rRIk
	t6iQjORNoPYSAe1NRdwQvmAbP+4BdUBlIdbQmox0Gw==
X-Google-Smtp-Source: AGHT+IFBDsg58VP5xYZQboRt0WLteQXM1skYg3czfbQs8hc1QGVa/ZbStRHvWCw3FQEgq8wuA3BSiMYUfa0Ix7/fOAY=
X-Received: by 2002:a05:6102:579b:b0:452:6d82:56e3 with SMTP id
 dh27-20020a056102579b00b004526d8256e3mr13976905vsb.6.1697133072474; Thu, 12
 Oct 2023 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com> <20231012104741.GN6307@noisy.programming.kicks-ass.net>
In-Reply-To: <20231012104741.GN6307@noisy.programming.kicks-ass.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 12 Oct 2023 10:50:36 -0700
Message-ID: <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@google.com>, David Gow <davidgow@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 3:47=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Oct 14, 2022 at 11:34:30AM -0700, Sami Tolvanen wrote:
> > On Fri, Oct 14, 2022 at 11:05 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@google.co=
m> wrote:
> > > >
> > > > Rust supports IBT with -Z cf-protection=3Dbranch, but I don't see t=
his
> > > > option being enabled in the kernel yet. Cross-language CFI is going=
 to
> > > > require a lot more work though because the type systems are not qui=
te
> > > > compatible:
> > > >
> > > > https://github.com/rust-lang/rfcs/pull/3296
> > >
> > > I have pinged Ramon de C Valle as he is the author of the RFC above
> > > and implementation work too; since a month or so ago he also leads th=
e
> > > Exploit Mitigations Project Group in Rust.
> >
> > Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> > and he expressed interest in helping with rustc support for it. In the
> > meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> > issues here.
>
> Having just read up on the thing it looks like the KCFI thing is
> resolved.
>
> I'm not sure I understand most of the objections in that thread through
> -- enabling CFI *will* break stuff, so what.
>
> Squashing the integer types seems a workable compromise I suppose. One
> thing that's been floated in the past is adding a 'seed' attribute to
> some functions in order to distinguish functions of otherwise identical
> signature.
>
> The Rust thing would then also need to support this attribute.
>
> Are there any concrete plans for this? It would allow, for example,
> to differentiate address_space_operations::swap_deactivate() from any
> other random function that takes only a file argument, say:
> locks_remove_file().

I haven't really had time to look into it, so no concrete plans yet.
Adding an attribute shouldn't be terribly difficult, but Kees
expressed interest in automatic salting as well, which might be a more
involved project:

https://github.com/ClangBuiltLinux/linux/issues/1736

Sami

