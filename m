Return-Path: <linux-fsdevel+bounces-729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BB7CF3D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C58B2128B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A09171BE;
	Thu, 19 Oct 2023 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUJNtTYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807E171B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:17:14 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70BA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 02:17:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so4709a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697707030; x=1698311830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEyDbtqB+udvOtvaRFHUtqkxP21cSIdHZt9QvgU76Yo=;
        b=gUJNtTYMrP5DGqoqxGj9WuqZk22rfp9lcd62KUldL91ausAgz/MBXtVh9xH3wIyciJ
         n0j5YQ91PA60pk+gW3M1D2a4rvwRchL3gFD5qlGrLxNYMevMZZX51yQu9vRRUIMC5dzx
         7yb9s+qTdgXD/XusbB0f8zHj0ZuVBTaEfbxgZz3su1xeGfg2TUKfqnOLa2CxO45TOVB4
         TCY5i4NhjEa6euMXefLFjM167qtiXoQdybBq4/xyC3lCZt2gmFZq+kl2s4kslU13KBMk
         pZZmwzols+DXQM3+sjj+cBKLmr2l7Nlteu2hI6Bba6jzF81StfMv4MCtOBt9TPHrdf71
         aAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707030; x=1698311830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEyDbtqB+udvOtvaRFHUtqkxP21cSIdHZt9QvgU76Yo=;
        b=RJRZg/2qgY4jK5JYsFvmhjEuEy9/pl3lTgKA6hdrPQWWto3lkOTOuoItBwt7JXRhd1
         8wmSk9P7VMiyi/kC+2qkbEN7TG5SJy1GTZlISIWv6MVOqtArLGVO37R2GfoX3CYN2lLz
         rjxO6jLRPG26UdTJexhOaGrHeBQa9vy9/YpHBrVrz293mcLUHDGEZ6cf77I3SvV9hDep
         EloI4EEqqb8U0HYbYEp9j+DTREoVUFhDTSyV1+OfXuUMqKewX+vXk0XlMBO5T+vflkIN
         Tj+1ukoVYjjpkWKIRg4aJLJqTGZclOC0mclvn3qHOSA6WvfjvFHqMTSZxdjGcIFQX7CQ
         TMAg==
X-Gm-Message-State: AOJu0Yz4MZsOjg9Na6cBkM6mGCJ+vHkF1JXs0d/SaJoJMmkUXSo9i/UT
	efJ6S0qXVFBzvgGB7zWaLmv6SL16xn+JeESLE6qNNQ==
X-Google-Smtp-Source: AGHT+IFEEOs06c4WLSibf/51HO7uvqmnfpk/QYoWjbqqV6cbgP/iEpuh1W4eTm4WVvsBFqs3xdA3t1pCVl57WxJ/c9c=
X-Received: by 2002:a50:a45a:0:b0:53d:b53c:946b with SMTP id
 v26-20020a50a45a000000b0053db53c946bmr92741edb.2.1697707030233; Thu, 19 Oct
 2023 02:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704122727.17096-1-jack@suse.cz> <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain> <20230822101154.7udsf4tdwtns2prj@quack3>
In-Reply-To: <20230822101154.7udsf4tdwtns2prj@quack3>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 19 Oct 2023 11:16:55 +0200
Message-ID: <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
To: Jan Kara <jack@suse.cz>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>, 
	Ted Tso <tytso@mit.edu>, syzkaller <syzkaller@googlegroups.com>, 
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thank you for the series!

Have you already had a chance to push an updated version of it?
I tried to search LKML, but didn't find anything.

Or did you decide to put it off until later?

--=20
Aleksandr

On Tue, Aug 22, 2023 at 12:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Eric!
>
> On Mon 21-08-23 22:35:23, Eric Biggers wrote:
> > On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> > > Writing to mounted devices is dangerous and can lead to filesystem
> > > corruption as well as crashes. Furthermore syzbot comes with more and
> > > more involved examples how to corrupt block device under a mounted
> > > filesystem leading to kernel crashes and reports we can do nothing
> > > about. Add tracking of writers to each block device and a kernel cmdl=
ine
> > > argument which controls whether writes to block devices open with
> > > BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> > > this flag for used devices.
> > >
> > > Syzbot can use this cmdline argument option to avoid uninteresting
> > > crashes. Also users whose userspace setup does not need writing to
> > > mounted block devices can set this option for hardening.
> > >
> > > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd=
9@linaro.org
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> >
> > Can you make it clear that the important thing this patch prevents is
> > writes to the block device's buffer cache, not writes to the underlying
> > storage?  It's super important not to confuse the two cases.
>
> Right, I've already updated the description of the help text in the kconf=
ig
> to explicitely explain that this does not prevent underlying device conte=
nt
> from being modified, it just prevents writes the the block device itself.
> But I guess I can also explain this (with a bit more technical details) i=
n
> the changelog. Good idea.
>
> > Related to this topic, I wonder if there is any value in providing an o=
ption
> > that would allow O_DIRECT writes but forbid buffered writes?  Would tha=
t be
> > useful for any of the known use cases for writing to mounted block devi=
ces?
>
> I'm not sure how useful that would be but it would be certainly rather
> difficult to implement. The problem is we can currently fallback from
> direct to buffered IO as we see fit, also we need to invalidate page cach=
e
> while doing direct IO which can fail etc. So it will be a rather nasty ca=
n
> of worms to open...
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

