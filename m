Return-Path: <linux-fsdevel+bounces-1667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E27DD762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7472F1C20CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68C22EE2;
	Tue, 31 Oct 2023 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR0SspFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC3225D3;
	Tue, 31 Oct 2023 20:49:33 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD31B1;
	Tue, 31 Oct 2023 13:49:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ac9573274so5682466276.0;
        Tue, 31 Oct 2023 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698785370; x=1699390170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UEKIn1EcPqCI5NkayxDOClFglax7lJCCgowr0cBZZO8=;
        b=MR0SspFZ0V2Pg8TzthKbLS/IuX6qbQxoZdKybTI2KKKhWCXlz0FaTzAKHjbn0XDQC9
         fDIFo3IZTay+RyAFZmZFVBvnGjcO0ONvSv0Dw3Yjc9tY5VOpv+ylYdJ5Q7t+yMec4p5P
         2WmF0GzjzyHRJDR6s1fkk9qVm1ytxPGJpI8PUQ5qeOZpTG7roG8EARdtPAvCiNs1yvoX
         2MmOKtC4I7NCQx23cq1lXXwHY25N4bOQhgBOh+5jUY12BReUDDyFtjWc2hG3seDYHW4O
         k/8MqKp1sEHCAj38fn5Lmi3SCyvZCump9QUkvwVTUWj8jO9v/QIH+JWi4hwguwq3N5D+
         jRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698785370; x=1699390170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEKIn1EcPqCI5NkayxDOClFglax7lJCCgowr0cBZZO8=;
        b=NtzVezT6Ole0Cdd6fG9Sj3SHSSgY/idkrZe3nhma2lOJ6p4FFOIC7AcrIFpgm1fUyp
         txkY7WtSV0XqOlj1YERct4Ql5pEDRCim/jR7Xx5Y8y8PZERJJr4IOCt2jvCxL1r+LdR0
         bi7RTfc6EkDlAnc5GhoZS9G0FiftnCNm8UgJKKbphFCmFVCedvOBBOoiMPKm5adXL92A
         YAa3guhFDFnWF+kIIEkIKKLWRA2VCHABmuIJispV+jTMDNFqRnkNsbDrQ6I0vEC+pauc
         sUJc8jMbdHPqsJMF5f7StyeZL01WDfJ374E+f+IYBYXNfWZbWrxOM66OiCJTFP7sgzmf
         zxqw==
X-Gm-Message-State: AOJu0YwVlgLpRB+c0w0IwOvbnkEJkrWloj7EJocTNayU0JwV69yMtctw
	pSQQ4QuGBfroJWtGGtiMBq1lUHf3Rfw2iGa8Fik=
X-Google-Smtp-Source: AGHT+IGKzgiNyqCnRO8+p8zvWUss0xsNjob8K35mKfNJAMx0WZcnBRtmtllkujAsR7c1usRJ88CinZSrTmO5ryugbsc=
X-Received: by 2002:a25:8706:0:b0:d9b:90bf:e74b with SMTP id
 a6-20020a258706000000b00d9b90bfe74bmr12074102ybl.7.1698785370169; Tue, 31 Oct
 2023 13:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux> <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home> <ZTQDztmY0ivPcGO/@casper.infradead.org>
 <ZTQnpeFcPwMoEcgO@Boquns-Mac-mini.home> <ZTYE0PSDwITrWMHv@dread.disaster.area>
 <CANeycqq49Ubj-3BKcUaMOKeEwFastZzC17z_uk_VE3RDDv2wfw@mail.gmail.com> <ZT8VG0MTKNNpGDOC@dread.disaster.area>
In-Reply-To: <ZT8VG0MTKNNpGDOC@dread.disaster.area>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 31 Oct 2023 17:49:19 -0300
Message-ID: <CANeycqpwFs3Sfz86ngG-ysQuP1-MzVdkMNZPFXWUgvBrphdiAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
To: Dave Chinner <david@fromorbit.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Benno Lossin <benno.lossin@proton.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Oct 2023 at 23:29, Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Oct 23, 2023 at 09:55:08AM -0300, Wedson Almeida Filho wrote:
> > On Mon, 23 Oct 2023 at 02:29, Dave Chinner <david@fromorbit.com> wrote:
> > > IOWs, if you follow the general rule that any inode->i_state access
> > > (read or write) needs to hold inode->i_lock, you probably won't
> > > screw up.
> >
> > I don't see filesystems doing this though. In particular, see
> > iget_locked() -- if a new inode is returned, then it is locked, but if
> > a cached one is found, it's not locked.
>
> I did say "if you follow the general rule".
>
> And where there is a "general rule" there is the implication that
> there are special cases where the "general rule" doesn't get
> applied, yes? :)

Sure. But when you say "if _you_ do X", it gives me the impression
that I have a choice. But if want to use `iget_locked`, I don't have
the option to follow the "general rule" you state.

I guess I have the option to ignore `iget_locked`. :)

> I_NEW is the exception to the general rule, and very few people
> writing filesystems actually know about it let alone care about
> it...
<snip>
> All of them are perfectly fine.

I'm not sure I agree with this. They may be fine, but I wouldn't say
perfectly. :)

> I_NEW is the bit we use to synchronise inode initialisation - we
> have to ensure there is only a single initialisation running while
> there are concurrent lookups that can find the inode whilst it is
> being initialised. We cannot hold a spin lock over inode
> initialisation (it may have to do IO!), so we set the I_NEW flag
> under the i_lock and the inode_hash_lock during hash insertion so
> that they are set atomically from the hash lookup POV. If the inode
> is then found in cache, wait_on_inode() does the serialisation
> against the running initialisation indicated by the __I_NEW bit in
> the i_state word.
>
> Hence if the caller of iget_locked() ever sees I_NEW, it is
> guaranteed to have exclusive access to the inode and -must- first
> initialise the inode and then call unlock_new_inode() when it has
> completed. It doesn't need to hold inode->i_lock in this case
> because there's nothing it needs to serialise against as
> iget_locked() has already done all that work.
>
> If the inode is found in cache by iget_locked, then the
> wait_on_inode() call is guaranteed to ensure that I_NEW is not set
> when it returns. The atomic bit operations on __I_NEW and the memory
> barriers in unlock_new_inode() plays an important part in this
> dance, and they guarantee that I_NEW has been cleared before
> iget_locked() returns. No need for inode->i_lock to be held in this
> case, either, because iget_locked() did all the serialisation for
> us.

Thanks for explanation!

Let's consider the case when I call `inode_get`, and it finds an inode
that _has_ been fully initialised before, so I_NEW is not set in
inode->i_state and the inode is _not_ locked.

But the only means of checking that is by inspecting the i_state
field, so I do something like:

if (!(inode->i_state & I_NEW))
    return inode;

But now suppose that while I'm doing a naked load on inode->i_state,
another cpu is running concurrently and happens to be holding the
inode->i_lock, so it is within its right to write to inode->i_state,
for example through a call to __inode_add_lru, which has the
following:

inode->i_state |= I_REFERENCED;

So we have a thread doing a naked read and another thread doing a
naked write, no ordering between them.

Would you agree that this is a data race? (Note that I'm not asking if
"it will be ok" or "the compilers today generate the right code", I'm
asking merely if you agree this is a data race.)

If you do, then you'd have to agree that we are in undefined-behaviour
territory. I can quote the spec if you'd like.

Anyway, the discussion here is that this is also undefined behaviour
in Rust. And we're trying really hard to avoid that. Of course, in
cases like this there's not much we can do on the Rust side alone so
the conclusion now appears to be that we'll introduce helper functions
for this now and live with it. If one day we have a better solution,
we'll update just one place.

But we want the be very deliberate about these. We don't want to
accidentally introduce data races (and therefore potential undefined
behaviour).

Cheers,
-Wedson

