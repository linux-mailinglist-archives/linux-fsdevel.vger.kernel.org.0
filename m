Return-Path: <linux-fsdevel+bounces-7657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD4828D28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A09F1C24C72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37D3D0C6;
	Tue,  9 Jan 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0wb5r9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E93A8D9;
	Tue,  9 Jan 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbeff3fefc7so2001022276.2;
        Tue, 09 Jan 2024 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704827606; x=1705432406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxWrlYegF797Z4IP6KFPqGZXgNfKFyYe3/fBpA8p+S4=;
        b=F0wb5r9Mj02NX5UIRpWPD90CWF1u+uCNmwFgd1HSIOPqltKVTDQrZMxlpoHVU9UOWS
         IvvTyp7taismm78bggez1gzyvJsmHR4aBkHT97+BQhJWy0F0SUHP8l5d2EQr+NdsRUr4
         oI/qnUGi5YR0mmUBk9eEvDb1zIGdrW90g43r+gKf+DKp3WYLCir16aL2K/0g41gK6WRY
         yO4yfGhkUXpER9AAo3XJAoO4EH4sWL/xI8iv+6k76KxmTbAvQjOFOOyxAE2DnNBr+8bj
         A1OZtKZjoTS9tGH8IsMFMZLvejYgauyMdXlygDAzqTK6G3Fh7zXoEPUicw5+eWXR/rk5
         jaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827606; x=1705432406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxWrlYegF797Z4IP6KFPqGZXgNfKFyYe3/fBpA8p+S4=;
        b=un797lC+L0VKF5QYxy5GXF8gCGkSOD3Rhs++GxBPzin7p5KLLX295C5bFdjWTJFNSD
         3ZERm6kiRRv778++BDOcV5VqMETHTBsTCJKackyiXWUKXDRNlUdaURh1bbf/dMhaHEml
         qW5ZBxP5CXTnK3FgtEczyBkhtD4Q+q+7968b5byM+TuoLGFxFlq1Emf66lXjLyukPsCd
         tBJoAtnkcvvdmb3q3P5ynRSb0hGNZjk/UGFufii4+4f8Minh/vSippXDUwvGJCRSgjUy
         X100rl3N05+6VkV3TNGBKA9XsD6g2fF5EhDX8TQiMBP0ytAp07VynbD5b/zzX6MqgY8D
         yceg==
X-Gm-Message-State: AOJu0Yy81vgA5g4pVbMtCqe6pndO6+GKNvzlbhzWn9JX5hIxKPQiZP/C
	9ZO78/5SWuMXtQE4a+qS8TiEUPUU5djUbXnpznQ=
X-Google-Smtp-Source: AGHT+IHo1UMFX0D4DBV1EkbVLtzyxMnAJyz9Ic1QmEu81ODPdKu7+w4d/2rDGxQAojik2w604SIwlbAGN5eKs+GklqQ=
X-Received: by 2002:a25:a246:0:b0:db7:dad0:76d2 with SMTP id
 b64-20020a25a246000000b00db7dad076d2mr3084640ybi.110.1704827605777; Tue, 09
 Jan 2024 11:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org> <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
In-Reply-To: <20240103204131.GL1674809@ZenIV>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 9 Jan 2024 16:13:15 -0300
Message-ID: <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 03, 2024 at 02:14:34PM -0500, Kent Overstreet wrote:
>
> > We don't need to copy the C interface as is; we can use this as an
> > opportunity to incrementally design a new API that will obviously take
> > lessons from the C API (since it's wrapping it), but it doesn't have to
> > do things the same and it doesn't have to do everything all at once.
> >
> > Anyways, like you alluded to the C side is a bit of a mess w.r.t. what's
> > in a_ops vs. i_ops, and cleaning that up on the C side is a giant hassle
> > because then you have to fix _everything_ that implements or consumes
> > those interfaces at the same time.
> >
> > So instead, it would seem easier to me to do the cleaner version on the
> > Rust side, and then once we know what that looks like, maybe we update
> > the C version to match - or maybe we light it all on fire and continue
> > with rewriting everything in Rust... *shrug*
>
> No.  This "cleaner version on the Rust side" is nothing of that sort;
> this "readdir doesn't need any state that might be different for different
> file instances beyond the current position, because none of our examples
> have needed that so far" is a good example of the garbage we really do
> not need to deal with.

What you're calling garbage is what Greg KH asked us to do, namely,
not introduce anything for which there are no users. See a couple of
quotes below.

https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
The best feedback is "who will use these new interfaces?"  Without that,
it's really hard to review a patchset as it's difficult to see how the
bindings will be used, right?

https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
And I'd recommend that we not take any more bindings without real users,
as there seems to be just a collection of these and it's hard to
actually review them to see how they are used...

Cheers,
-Wedson

