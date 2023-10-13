Return-Path: <linux-fsdevel+bounces-342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6286E7C8DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 21:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B973282F13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A2224F8;
	Fri, 13 Oct 2023 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ar7Z0wwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C521A19
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 19:22:24 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF1A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so4237231a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697224941; x=1697829741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMlHIs+RXRwcCam9b7W7YcpdMJXw0XO1+U1rinkBh7Y=;
        b=ar7Z0wwUOKGizkJFuUYsyL3+sCaPZhvkSQ2iYos1tkBylKt3i7BH7yDUk9QHL6G7Ak
         vNUEKBW0JGgdpBh6XIGgKjmp2nh47DbDo9M8QPQJ9rdFaI3Blsya/ntVAhX/J+90oyjd
         J/XbymmNfvjgBsQIvhkBWUZwPDD4iO30ejQhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224941; x=1697829741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMlHIs+RXRwcCam9b7W7YcpdMJXw0XO1+U1rinkBh7Y=;
        b=X4fgaGjpgRVzwFluazHZGQCebKxtYlum/30U0+tNYzi+Gb3oEpwoNHyhvUuF5DTr9G
         2O6tDqvFs+4NlbG4qQIetuVMQ16M/SByFIltmiE7OOR8tTqmyew9UH33jPOoRXP2LBj5
         MZS/oaDYR8W8kvwoknSZNdGrp4L4EXvSUBdqqQJiZsax1/d/Nj3PW7pUxf6ByrPmUP/e
         zNJVAeoHL8oGKAUBsAt1yjDqeuGCQakPiFfffrDSc2t0we18PefgB2sV/UZ6YGlR5vyW
         IPz5VMNXrTwJTgwCUZsPeenmGqVvoBJMvPL7MCsphgjLVsFvyUK6Peu8krTRRCtKQuGT
         cF0A==
X-Gm-Message-State: AOJu0YzRFpEDJHQAJ7halr85+wrELt4nZWbKfmNf0ardYTNbRAjPTy7p
	yy7uMth75ddvoLHOK85GxETwkoRPx4jHa9iYQv8eNlrO
X-Google-Smtp-Source: AGHT+IEyBUmCtpYD16XRrd8g/I+l93Qi1xQFlX9cvEd8oAZ5qCBb2JvF3d6zoS7EG3r4M5wvR+zBew==
X-Received: by 2002:aa7:d94e:0:b0:527:fa8d:d40b with SMTP id l14-20020aa7d94e000000b00527fa8dd40bmr23692355eds.26.1697224941127;
        Fri, 13 Oct 2023 12:22:21 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c411000000b0053635409213sm11905697edq.34.2023.10.13.12.22.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 12:22:20 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99357737980so403968966b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:19 -0700 (PDT)
X-Received: by 2002:a17:907:7790:b0:9b9:facb:d950 with SMTP id
 ky16-20020a170907779000b009b9facbd950mr17575861ejc.72.1697224939431; Fri, 13
 Oct 2023 12:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com>
 <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
 <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com> <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
In-Reply-To: <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Oct 2023 12:22:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiBpw-0MKBbPkvo54=Cvyi0b3_1bDtqbgiD4ixd+OPow@mail.gmail.com>
Message-ID: <CAHk-=wiiBpw-0MKBbPkvo54=Cvyi0b3_1bDtqbgiD4ixd+OPow@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ramon de C Valle <rcvalle@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, 
	David Gow <davidgow@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 at 12:01, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Transparent unions have been standard C since C99.

Ahh, I didn't realize they made it into the standard.

In gcc, they've been usable for a lot longer (ie --std=gnu89 certainly
is happy with them), but the kernel never really picked up on them.

I think they've mainly been used by glibc for a couple of functions
that can take a couple of different types without complaining.

           Linus

