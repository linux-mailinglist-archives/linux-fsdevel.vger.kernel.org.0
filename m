Return-Path: <linux-fsdevel+bounces-1621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AC7DC6E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 08:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3944B20FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8A107AD;
	Tue, 31 Oct 2023 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGu8sDMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A71D2F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:11 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BCBC1;
	Tue, 31 Oct 2023 00:04:10 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2ec9a79bdso3722468b6e.3;
        Tue, 31 Oct 2023 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698735849; x=1699340649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QHIvEcmJ0urypIUJ4I1hXriZ0FhrfT5zBc+eZq8EH4=;
        b=RGu8sDMnVECcxZipxda9i97yZ/pIfwDsIIb+3b2zZq56s1BY6VCn5HmyXldhnmvzzc
         8i+fmOuZk8f1KZ7pxAxYYHVN6qyrkTRGZt8l6IOZV7GR3wn36jluzhJ0rUp0fZTnHKyv
         X0d4u+vJ7i7/t3zxhEjrujgwrdgeS4FgJj8pTAWnAXStlVFmJQ8JxezRreBusixqW1bm
         YHWEb2hFmdozsss/cKJeMpdQuCyNw5PFL6w6wPXHPFVqJE7DsLZuHODdvnnvroLwpMsZ
         7e2zybt171UfnePSC2axUVAIuWPT0+6GppjANhk0UtiLtWf8NIYUO1LiubYQlyl9gCSx
         T8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698735849; x=1699340649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QHIvEcmJ0urypIUJ4I1hXriZ0FhrfT5zBc+eZq8EH4=;
        b=dHYIGGMJrnxtshFvdGVFK2mx96a31Mwt4br4T3G/JZ3SrvbXvl5wxrA8u6OAuALP+x
         zZg/2wvFtwz9+qV7daNCkB6JMBfB4JQpeozEPKZGWv1doK2/30PyXOEgWDigUlkZati3
         Ty/rztRD3pW17Inpv5cXYfC1Z8R+AcapClWxfc7pJG5CFt4Y7H4UlMR3NsCy9mmGcOn1
         GI7NTDOyGak1xNK4NiuLwdqXnOhO87hzz3W0FwkMG6rsKFgMsDPzz/+WwbDBemKZctaP
         /ShDX4VHsLvg0bXi/STdMzsfb3qWygDKK9siHAEBR4fVCOLtgHCPkF9eDyw884UPvyjo
         Batg==
X-Gm-Message-State: AOJu0Yx5ImwNhoFQ2lZRM2zNZWHGZwerLDD2uIXQCqw4/FUsIY75oPBW
	GLkrhi/NCfUt35O+Ie3nL4qgAO+iuxe9sxzoCbQ=
X-Google-Smtp-Source: AGHT+IFJczJ9Y/Gta2VEUUZlMPlc/e+BEvHoooShDS3IUryTcj10C5j9NWzQ+H0qQ0tSno1kZ94fcMD7UWyA5SIWMGk=
X-Received: by 2002:aca:909:0:b0:3b0:da4a:4823 with SMTP id
 9-20020aca0909000000b003b0da4a4823mr12874300oij.56.1698735849512; Tue, 31 Oct
 2023 00:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area> <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
In-Reply-To: <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Oct 2023 09:03:57 +0200
Message-ID: <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 3:42=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
[...]
> .... and what is annoying is that that the new i_version just a
> glorified ctime change counter. What we should be fixing is ctime -
> integrating this change counting into ctime would allow us to make
> i_version go away entirely. i.e. We don't need a persistent ctime
> change counter if the ctime has sufficient resolution or persistent
> encoding that it does not need an external persistent change
> counter.
>
> That was reasoning behind the multi-grain timestamps. While the mgts
> implementation was flawed, the reasoning behind it certainly isn't.
> We should be trying to get rid of i_version by integrating it into
> ctime updates, not arguing how atime vs i_version should work.
>
> > So I don't think the issue here is "i_version" per se. I think in a
> > vacuum, the best option of i_version is pretty obvious.  But if you
> > want i_version to track di_changecount, *then* you end up with that
> > situation where the persistence of atime matters, and i_version needs
> > to update whenever a (persistent) atime update happens.
>
> Yet I don't want i_version to track di_changecount.
>
> I want to *stop supporting i_version altogether* in XFS.
>
> I want i_version as filesystem internal metadata to die completely.
>
> I don't want to change the on disk format to add a new i_version
> field because we'll be straight back in this same siutation when the
> next i_version bug is found and semantics get changed yet again.
>
> Hence if we can encode the necessary change attributes into ctime,
> we can drop VFS i_version support altogether.  Then the "atime bumps
> i_version" problem also goes away because then we *don't use
> i_version*.
>
> But if we can't get the VFS to do this with ctime, at least we have
> the abstractions available to us (i.e. timestamp granularity and
> statx change cookie) to allow XFS to implement this sort of
> ctime-with-integrated-change-counter internally to the filesystem
> and be able to drop i_version support....
>

I don't know if it was mentioned before in one of the many threads,
but there is another benefit of ctime-with-integrated-change-counter
approach - it is the ability to extend the solution with some adaptations
also to mtime.

The "change cookie" is used to know if inode metadata cache should
be invalidated and mtime is often used to know if data cache should
be invalidated, or if data comparison could be skipped (e.g. rsync).

The difference is that mtime can be set by user, so using lower nsec
bits for modification counter would require to truncate the user set
time granularity to 100ns - that is probably acceptable, but only as
an opt-in behavior.

The special value 0 for mtime-change-counter could be reserved for
mtime that was set by the user or for upgrade of existing inode,
where 0 counter means that mtime cannot be trusted as an accurate
data modification-cookie.

This feature is going to be useful for the vfs HSM implementation [1]
that I am working on and it actually rhymes with the XFS DMAPI
patches that were never fully merged upstream.

Speaking on behalf of my employer, we would love to see the data
modification-cookie feature implemented, whether in vfs or in xfs.

*IF* the result on this thread is that the chosen solution is
ctime-with-change-counter in XFS
*AND* if there is agreement among XFS developers to extend it with
an opt-in mkfs/mount option to 100ns-mtime-with-change-counter in XFS
*THEN* I think I will be able to allocate resources to drive this xfs work.

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Ma=
nagement-API

