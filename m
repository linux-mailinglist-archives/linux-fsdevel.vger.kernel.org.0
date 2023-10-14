Return-Path: <linux-fsdevel+bounces-362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F797C963C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33671C209B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014CF241E1;
	Sat, 14 Oct 2023 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoZNg/9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B31D541;
	Sat, 14 Oct 2023 20:25:28 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18680B7;
	Sat, 14 Oct 2023 13:25:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fe612beabso134480239f.3;
        Sat, 14 Oct 2023 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697315126; x=1697919926; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5emPS0MjB2QN+kJ9u45m+WJbhux12t/sQVDicjCU/8=;
        b=FoZNg/9m2jGGR7OXBZEqZS1ob68oXOgCSQtor36JxX9h/EneI1/IbWE4TijMQHg6Te
         2Jud98WUAs9qLmtXthB/MHwHVJoucMd2pK25NN2Cy0es07grH92gO5zE6V2qHn2IwrkW
         cz8myndtn4WBQ8XLNCM8cq8Sm1y2hPsnVyCKcjWVFRe5gsdyZU1Xdrn7UI9JzmovWd4D
         3Hk0Y/cIZsyxd9GTrSTTH5H38/hjuxIVnrqI5o/MQ5wXqNqP3/b/I+Cid4jdLYZPmq6u
         9xbShp9RSv/WivYv3Y7mfudDE+Y24IAycY/GfEaRcbBKf10zeIDi2bavi+w0FTIA3pEQ
         OUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697315126; x=1697919926;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5emPS0MjB2QN+kJ9u45m+WJbhux12t/sQVDicjCU/8=;
        b=n0scYJyKs/VkRdzrlS5xlICJVxPM3jMzeS8CMkGUcWvWPV83//y7Uk7fDW4EdZd0tk
         dL9lIgQ+T+Ddda928raB4jPR3brPPULHUtR/+XXZy0do0lxk4El5xuHAzSU78BZ3i2nD
         DeBmQmN/mRpU6wGWjhvHS/XnXojafruPki7kvUNrJc1EIykdQ65IzNdRHZVPji8TYV8x
         nzQtCLp5U5RwS9PxhHvbSe51/wBJZmzEkWA3t3PMt5uF0/tdHAOgAmqbkwnPxPOgXabk
         yTJne+xk72g/DxYORgzX6WrS3QaR/w51r7QI7OIXnTY79n4gS27WYOFLOJX2UT9vBDed
         x0dQ==
X-Gm-Message-State: AOJu0YyCusGpJf70DpLpNWTyd9KaNRZNlPJ4TCXyBlmdiTpUxSUeDFQY
	oIe8/3t1pTQ4FF20wiK8g8k=
X-Google-Smtp-Source: AGHT+IHQ0wSofw+mCUxwMOTU704LFNtov6E/5kWHV55+P8O46TcQpo0iXIpmVZ9xJ+NCX1B/ckWz1g==
X-Received: by 2002:a5d:9d10:0:b0:79f:c9ad:19ce with SMTP id j16-20020a5d9d10000000b0079fc9ad19cemr30998453ioj.15.1697315126209;
        Sat, 14 Oct 2023 13:25:26 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:4b00:6db0:ed49:22d9:e5d5:b7e4])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c5076ae6absm5861510plb.126.2023.10.14.13.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Oct 2023 13:25:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
From: comex <comexk@gmail.com>
In-Reply-To: <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
Date: Sat, 14 Oct 2023 13:25:12 -0700
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ramon de C Valle <rcvalle@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 patches@lists.linux.dev,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@google.com>,
 David Gow <davidgow@google.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDD45A2A-1447-40DD-B5F3-29DEE976A3CD@gmail.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net>
 <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook>
 <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com>
 <20231013075005.GB12118@noisy.programming.kicks-ass.net>
 <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
 <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
 <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 13, 2023, at 12:00=E2=80=AFPM, H. Peter Anvin <hpa@zytor.com> =
wrote:
>=20
> Transparent unions have been standard C since C99.

I don=E2=80=99t think that=E2=80=99s right.  Certainly =
__attribute__((transparent_union)) is not standard C; are you referring =
to a different feature?

