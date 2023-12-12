Return-Path: <linux-fsdevel+bounces-5619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442C80E44A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E1C1F21A73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1085DDBB;
	Tue, 12 Dec 2023 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvf7uW/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3DC7;
	Mon, 11 Dec 2023 22:33:08 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67adea83ea6so38788106d6.0;
        Mon, 11 Dec 2023 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702362788; x=1702967588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0yoMnhVrZoXXOzV7JcsnzLTyx8nAYFpnTJSaGd1kHY=;
        b=hvf7uW/FGIFQVizDCrf8zvA4FxVpdgXFLPe+BztxuMqZJrPOynaVFAV6Mw2+442rhc
         +qXZAnOLYTEOjoG+caaSgQoiKI2pcZmp1qQG3bQ4mHQvIPgImn9v8GxdtDGGo2tEnKz2
         i7Ty7czzHSBbwZUgQfvp5fEiCJwf3o7o/qQ0kls1wasvpqWSQ8DpabCdmBSgFbYC6G/g
         oZG6S+Revm8pmH9a+dGwNbRQX5tfWx7eHx+QRvM2LGZUIz+h73EJ3RsPP5v46E4U9qQu
         uJ9z0dCN8oz6BZdbotK1ufeCptp0V3ofkQ6j5AnUhnPJc0xnsFRvfvbWLXyDmIoxIl7u
         fMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702362788; x=1702967588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0yoMnhVrZoXXOzV7JcsnzLTyx8nAYFpnTJSaGd1kHY=;
        b=eyslWaKNCAb4gON++2GzT0MSvl3F/Mg9GfUTLAobG4zqOzuuJT22ZT/TI1qWfbYUuz
         RktLwxmoJNzg+EUPF4nra9ll96bM69+6F1ES/OyKA41/gzQztKn+KAJoUhMjaOWHm5jx
         7pLd+m9sknwVbx1+U+HaQ2VTZFRJj8Ci3UGKvbLyEcntM1Vbls+/6ar5RQqEyXN/JbBT
         fg/rtknhkCkT/mxaev+4bUnX2TfAfqH1TduHuPhkG/6jmbkHzT7mJaACis5O5NZIKWqx
         28bi4f4FYSqR+zcOcNLoSu6mHAT7QyEEf4TFJ34SCtHOZ5JRHlzIqOLeBQBGomnQnCgE
         /ggQ==
X-Gm-Message-State: AOJu0YzOX3ZB4MKtONYIFgu4tohEIXwafSMktO0UdmJxnyvq65QcnLgb
	oKFy5WV0io5Vxl1UXAm+RfafLOcintpj2JN/c7T6Bjsc1No=
X-Google-Smtp-Source: AGHT+IHwWJEuFtKJ2sbXPuPNVzpHfgKRR0WkeMks112aLciopACUffrGRkq+Kwj+hhrEvsoyXIrTOrJeojEt0UGT9Xk=
X-Received: by 2002:a05:6214:1107:b0:67a:970a:c003 with SMTP id
 e7-20020a056214110700b0067a970ac003mr6832394qvs.12.1702362787977; Mon, 11 Dec
 2023 22:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan> <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
In-Reply-To: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Dec 2023 08:32:55 +0200
Message-ID: <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org, 
	Stefan Krueger <stefan.krueger@aei.mpg.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 7:53=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > On Tue, Dec 12, 2023 at 10:53:07AM +1100, NeilBrown wrote:
> > > > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > > > On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> > > > > > On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > > > > Thoughts?
> > > > >
> > > >
> > > > I'm completely in favour of exporting the (full) filehandle through
> > > > statx. (If the application asked for the filehandle, it will expect=
 a
> > > > larger structure to be returned.  We don't need to use the currentl=
y
> > > > reserved space).
> > > >
> > > > I'm completely in favour of updating user-space tools to use the
> > > > filehandle to check if two handles are for the same file.
> > > >
> > > > I'm not in favour of any filesystem depending on this for correct
> > > > functionality today.  As long as the filesystem isn't so large that
> > > > inum+volnum simply cannot fit in 64 bits, we should make a reasonab=
le
> > > > effort to present them both in 64 bits.  Depending on the filehandl=
e is a
> > > > good plan for long term growth, not for basic functionality today.
> > >
> > > My standing policy in these situations is that I'll do the stopgap/ha=
cky
> > > measure... but not before doing actual, real work on the longterm
> > > solution :)
> >
> > Eminently sensible.
> >
> > >
> > > So if we're all in favor of statx as the real long term solution, how
> > > about we see how far we get with that?
> > >
> >
> > I suggest:
> >
> >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> >                               same inode number
> >
> >
> >  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and
> >                    stx_ino MUST be the same.  Exact meaning of volumes
> >                    is filesys-specific
> >
> >  STATX_VOL         Want stx_vol
> >
> >   __u8 stx_handle_len  Length of stx_handle if present
> >   __u8 stx_handle[128] Unique stable identifier for this file.  Will
> >                        NEVER be reused for a different file.
> >                        This appears AFTER __statx_pad2, beyond
> >                        the current 'struct statx'.
> >  STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
> >                    receiving statx info has at least
> >                    sizeof(struct statx)+128 bytes.
>
> Hmmm.
>
> Doesn't anyone else see or hear the elephant trumpeting loudly in
> the middle of the room?
>
> I mean, we already have name_to_handle_at() for userspace to get a
> unique, opaque, filesystem defined file handle for any given file.
> It's the same filehandle that filesystems hand to the nfsd so nfs
> clients can uniquely identify the file they are asking the nfsd to
> operate on.
>
> The contents of these filehandles is entirely defined by the file
> system and completely opaque to the user. The only thing that
> parses the internal contents of the handle is the filesystem itself.
> Therefore, as long as the fs encodes the information it needs into the
> handle to determine what subvol/snapshot the inode belongs to when
> the handle is passed back to it (e.g. from open_by_handle_at()) then
> nothing else needs to care how it is encoded.
>
> So can someone please explain to me why we need to try to re-invent
> a generic filehandle concept in statx when we already have a
> have working and widely supported user API that provides exactly
> this functionality?

Yeh.

Not to mention that since commit 64343119d7b8 ("exportfs: support encoding
non-decodeable file handles by default"), exporting file handles as strong
object identifiers is not limited to filesystems that support NFS export.

All fs have a default implementation of encode_fh() by encoding a file id
of type FILEID_INO64_GEN from { i_ino, i_generation } and any fs can
define its own encode_fh() operation (e.g. to include subvol id) even witho=
ut
implementing the decode fh operations needed for NFS export.

Thanks,
Amir.

