Return-Path: <linux-fsdevel+bounces-7033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5838203C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 07:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13535282FF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81123CF;
	Sat, 30 Dec 2023 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcm4Jiri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C211FA2;
	Sat, 30 Dec 2023 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6803466a1ccso27234116d6.3;
        Fri, 29 Dec 2023 22:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703917423; x=1704522223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecu4vvmdO6UPD1b6/h8AFWnYsyA/PB+JItDvVy5Yuz8=;
        b=mcm4JiribKwdwbZxOSsTaTUhvY6E2II5ViXyAuyrNkj/6i9/CkswnCWyf7QxY/kY5J
         yngvVs68+TuFOz5qEPwdZdU4CHqelPFBNBXdmZ5De6HstAJckuVYVMibllQ43+/Vk34d
         JVvuQvd6kUT/LJvzj3AZalYFko8iGdpbXUMZPeAulCkQqWmi/gFLF+RrG6UAamyToh5T
         1vMHgzoxLGisBxNKM3oVuOJMNW+3aZtoX2mZXrTkxNbV1zJes7ECWUg0nnVy6NRUPTQM
         Vg0UnbgmiD4Vo4W+YKDh5vUrmtuyJgNtO/CjwvEm/dhZyQLTC5B0YtWYx4W8dna7bRjl
         uMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703917423; x=1704522223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecu4vvmdO6UPD1b6/h8AFWnYsyA/PB+JItDvVy5Yuz8=;
        b=w32WvEji7dvpBPF4na8tTjqyZ8jSeW3CtnuEZOjXdsuRJDdL9kRzg7Ctygu/0yGUWS
         gfTl1+jOtObeGXJifrm/zo0wUXAE1mwfN29TXECYJ8c0lDE2h1hrdxBoKuFcdveGiG6q
         yZzA8q+VywGK6q7U8opTa81UOj1xYo8qp9RVKbTdJUjbjREvPthoqrjBk6FA53YSMQZd
         ywx8h0dlo5sgI3OdzldVpKvouCv/jGW4q0Evqij/6tJfbE0/soJvHflJKhEvRuBBgO96
         fTbIUkpX6Su1dNvqIqUpDgFZNRjUonRbvLo+qhwu87fVhMnEjMEOYIqTuM2DqfBw7UZy
         jhVA==
X-Gm-Message-State: AOJu0Ywsdv6Ef2uZQ+e0xcak5YTVfBCHl1kKJt2umeNEERZIJMpStnk1
	oiwONn64xiKcIZeoBF3GtRgJRxnET28N+H1HT00=
X-Google-Smtp-Source: AGHT+IHRXhkMCU5ssJ9H/lAHddtetRjLPvTI7Ny0xxhCWRCx5Jfr0dTgLZaX2YVBp2bYMXarAZIoRZ7uJ2wbVPp2fXk=
X-Received: by 2002:a05:6214:2421:b0:67a:3e38:6d77 with SMTP id
 gy1-20020a056214242100b0067a3e386d77mr15991291qvb.26.1703917422682; Fri, 29
 Dec 2023 22:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228201510.985235-1-trondmy@kernel.org> <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net> <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
 <ZY9WPKwO2M6FXKpT@tissot.1015granger.net> <a14bca2bb50eb0a305efc829262081b9b262d888.camel@hammerspace.com>
In-Reply-To: <a14bca2bb50eb0a305efc829262081b9b262d888.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 Dec 2023 08:23:31 +0200
Message-ID: <CAOQ4uxgcCajCD_bNKSLJp2AG1Q=N0CW9P-h+JMiun48mY0ZyDQ@mail.gmail.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 1:50=E2=80=AFAM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2023-12-29 at 18:29 -0500, Chuck Lever wrote:
> > On Fri, Dec 29, 2023 at 07:44:20PM +0200, Amir Goldstein wrote:
> > > On Fri, Dec 29, 2023 at 4:35=E2=80=AFPM Chuck Lever
> > > <chuck.lever@oracle.com> wrote:
> > > >
> > > > On Fri, Dec 29, 2023 at 07:46:54AM +0200, Amir Goldstein wrote:
> > > > > [CC: fsdevel, viro]
> > > >
> > > > Thanks for picking this up, Amir, and for copying viro/fsdevel. I
> > > > was planning to repost this next week when more folks are back,
> > > > but
> > > > this works too.
> > > >
> > > > Trond, if you'd like, I can handle review changes if you don't
> > > > have
> > > > time to follow up.
> > > >
> > > >
> > > > > On Thu, Dec 28, 2023 at 10:22=E2=80=AFPM <trondmy@kernel.org> wro=
te:
> > > > > >
> > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > >
> > > > > > The fallback implementation for the get_name export operation
> > > > > > uses
> > > > > > readdir() to try to match the inode number to a filename.
> > > > > > That filename
> > > > > > is then used together with lookup_one() to produce a dentry.
> > > > > > A problem arises when we match the '.' or '..' entries, since
> > > > > > that
> > > > > > causes lookup_one() to fail. This has sometimes been seen to
> > > > > > occur for
> > > > > > filesystems that violate POSIX requirements around uniqueness
> > > > > > of inode
> > > > > > numbers, something that is common for snapshot directories.
> > > > >
> > > > > Ouch. Nasty.
> > > > >
> > > > > Looks to me like the root cause is "filesystems that violate
> > > > > POSIX
> > > > > requirements around uniqueness of inode numbers".
> > > > > This violation can cause any of the parent's children to
> > > > > wrongly match
> > > > > get_name() not only '.' and '..' and fail the d_inode sanity
> > > > > check after
> > > > > lookup_one().
> > > > >
> > > > > I understand why this would be common with parent of snapshot
> > > > > dir,
> > > > > but the only fs that support snapshots that I know of (btrfs,
> > > > > bcachefs)
> > > > > do implement ->get_name(), so which filesystem did you
> > > > > encounter
> > > > > this behavior with? can it be fixed by implementing a snapshot
> > > > > aware ->get_name()?
> > > > >
> > > > > > This patch just ensures that we skip '.' and '..' rather than
> > > > > > allowing a
> > > > > > match.
> > > > >
> > > > > I agree that skipping '.' and '..' makes sense, but...
> > > >
> > > > Does skipping '.' and '..' make sense for file systems that do
> > >
> > > It makes sense because if the child's name in its parent would
> > > have been "." or ".." it would have been its own parent or its own
> > > grandparent (ELOOP situation).
> > > IOW, we can safely skip "." and "..", regardless of anything else.
> >
> > This new comment:
> >
> > +     /* Ignore the '.' and '..' entries */
> >
> > then seems inadequate to explain why dot and dot-dot are now never
> > matched. Perhaps the function's documenting comment could expand on
> > this a little. I'll give it some thought.
>
> The point of this code is to attempt to create a valid path that
> connects the inode found by the filehandle to the export point. The
> readdir() must determine a valid name for a dentry that is a component
> of that path, which is why '.' and '..' can never be acceptable.
>
> This is why I think we should keep the 'Fixes:' line. The commit it
> points to explains quite concisely why this patch is needed.
>

By all means, mention this commit, just not with a fixed tag please.
IIUC, commit 21d8a15ac333 did not introduce a regression that this
patch fixes. Right?
So why insist on abusing Fixes: tag instead of a mention?

Thanks,
Amir.

