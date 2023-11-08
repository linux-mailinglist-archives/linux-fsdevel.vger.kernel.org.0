Return-Path: <linux-fsdevel+bounces-2356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88C7E5041
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB721C2097F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 06:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50973D264;
	Wed,  8 Nov 2023 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh3z8lvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC56CA67;
	Wed,  8 Nov 2023 06:15:23 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACA10FE;
	Tue,  7 Nov 2023 22:15:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so6880289276.2;
        Tue, 07 Nov 2023 22:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699424122; x=1700028922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzB+EF22puVq+VRM0bcttHwDOL8IYQtCvuuzMeeaFA8=;
        b=Sh3z8lvo1/deYpsNDC6Uqdt82nLPDKgjeL6UL3HlzIw8nYAQcj10oRCgSnk0sLrgqj
         /xb74fwmD2Tb+WkZpTCDtMKPcsjyUGFLKs/q4T2jPFhzVb7BTXrT5XPVF0YrslmKhg7V
         aK7jw1FBl7ZrTkeD9t2Dcin/LO6C9Cu+PzEMKUOB4kn4UAgd/sZTY281CzJ81mdBU0kT
         jt+rOIiRuYawoeMxYJwPxOGmRpbzqIXrA+4hMEwzk8LBn6lgGf9Yfo14CxkwqHD0WSCf
         GI2meFwJmC8uGDFnWoIRpIwBcMB2Ld6cNuuXeVjwiL95NXW+KsQjRyIO4Qk1zFPZuSQS
         1gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699424122; x=1700028922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzB+EF22puVq+VRM0bcttHwDOL8IYQtCvuuzMeeaFA8=;
        b=tkuVYjVFojWyC2QR0ZxpuwcRF2SJAMC+5y/kfDNYVyUXi5plD6jwY8piFx+nxg3ewL
         T6jZmAe51bidAk6OPbeosYcsJqaWv5Jsj4qxWhC5yijAUuuCRwkH174jSf42pKA3jHJm
         +khKOIH7jIAiqt98xuFCZYDrsSaBjoZmxivN0N+dv5XQLNvZVR7LYg5aVnAKV/59twn5
         mLK8f82bKYbkdmf4PsGCyMTuHZ5L4hiT3Y57zKX9V5e98kk3HSLt832H1BxmG72fZrYl
         v9mwtj/hhjlEmxyZ0aDzAFmZinHY04KFwYkdF9GWVT7E1jdWJchYxt1dv1eC3vzyuN0j
         dirw==
X-Gm-Message-State: AOJu0YwBNCY0xYuaCYDEvZFQTZIt+34VaMK2dmis2jkZjDlZZ9Cc0G+W
	pby+mSZ7dSAj13m7mqYjM4b67TCDxxyn1atXZwI=
X-Google-Smtp-Source: AGHT+IG6zOLQE9YTxU3Y1EjQsWo3CJh+0NkXAYgY8LPbJpCUQj29+6DuD96fGKDEt6a526Khm0spk6/LmXcjYG13XPc=
X-Received: by 2002:a25:cbcd:0:b0:d9a:4a5f:415d with SMTP id
 b196-20020a25cbcd000000b00d9a4a5f415dmr1219985ybg.0.1699424121731; Tue, 07
 Nov 2023 22:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux> <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home> <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home> <ZTYE0PSDwITrWMHv@dread.disaster.area>
 <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com>
 <ZT8VG0MTKNNpGDOC@dread.disaster.area> <CANeycqpwFs3Sfz86ngG-ysQuP1-MzVdkMNZPFXWUgvBrphdiAQ@mail.gmail.com>
 <ZUsUcU/s56zogyac@dread.disaster.area>
In-Reply-To: <ZUsUcU/s56zogyac@dread.disaster.area>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 8 Nov 2023 03:15:10 -0300
Message-ID: <CANeycqquMa6POSafEqSdAXUbnMiEsqYxOXp9Opc+4e1X8Dru_A@mail.gmail.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
To: Dave Chinner <david@fromorbit.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Benno Lossin <benno.lossin@proton.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Nov 2023 at 01:54, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Oct 31, 2023 at 05:49:19PM -0300, Wedson Almeida Filho wrote:
> > On Sun, 29 Oct 2023 at 23:29, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 09:55:08AM -0300, Wedson Almeida Filho wrote:
> > > > On Mon, 23 Oct 2023 at 02:29, Dave Chinner <david@fromorbit.com> wrote:
>
> > If you do, then you'd have to agree that we are in undefined-behaviour
> > territory. I can quote the spec if you'd like.
>
> /me shrugs
>
> I can point you at lots of code that it will break if bit operations
> are allowed to randomly change other bits in the word transiently.

Sure, in C you have chosen to rely on behaviour that the language spec
says is undefined.

In Rust, we're trying avoid it. When it's unavoidable, we're trying to
clearly mark it so that we can try to fix it later.

> All the rust code that calls iget_locked() needs to do to "be safe"
> is the rust equivalent of:
>
>         spin_lock(&inode->i_lock);
>         if (!(inode->i_state & I_NEW)) {
>                 spin_unlock(&inode->i_lock);
>                 return inode;
>         }
>         spin_unlock(&inode->i_lock);
>
> IOWs, we solve the "safety" concern by ensuring that Rust filesystem
> implementations follow the general rule of "always hold the i_lock
> when accessing inode->i_state" I originally outlined, yes?

Ah, the name of the functions iget_locked() and unlock_new_inode()
threw me off, I thought I wouldn't be able to lock inode->i_lock.

Ok, I will do this for now, I think it's better than relying on
undefined behaviour. Thanks!

Actually, looking at the implementation of iget_locked(), there's a
single place where it returns a new inode. Wouldn't it be better to
just return this piece of information (whether the inode is new or
not) to the caller? Then we would eliminate the data races in C and
the need to lock in Rust, and we would also eliminate a memory load
from inode->i_state in all callers.

> > But we want the be very deliberate about these. We don't want to
> > accidentally introduce data races (and therefore potential undefined
> > behaviour).
>
> The stop looking at the C code and all the exceptions we make for
> special case optimisations and just code to the generic rules for
> safe access to given fields. Yes, rust will then have to give up the
> optimisations we make in the C code, but there's always a price for
> safety...

I'm not trying to do clever optimisations at all. I'm trying to figure
out how to do things by looking at imperfect documentation in
filesystems/porting.rst (which, BTW, checks I_NEW without a lock) and
the functions I call. So I look at what existing filesystems do to
learn the hopefully most up to date way of doing things. If you have a
recommendation on how to do this more efficiently, I'm all ears!

Thanks,
-Wedson

