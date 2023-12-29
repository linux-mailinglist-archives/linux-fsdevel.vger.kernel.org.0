Return-Path: <linux-fsdevel+bounces-7025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840848200FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D85B216E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DB612B8D;
	Fri, 29 Dec 2023 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKrdhbpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28612B82;
	Fri, 29 Dec 2023 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-680496bc3aaso16998616d6.0;
        Fri, 29 Dec 2023 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703872468; x=1704477268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgJgtyWKKmG9drWdDVYQvzVHZZPAT+G8Hw1ZAEuDKug=;
        b=YKrdhbpto/+l5mtvxoy9HLedD+uSUt++APeVuaJUpWzH8d0ArVt1obaVHVMbDW+mC9
         rS0Pi+QcuFO2wthgjjsnI99P6ll7HP0OykvskB5M+LZiQa53oaadKIKpdAJqssULWF/l
         xeTMFKgN4zl3At51J9M5D4QNgYqzjnXUMlw6CTYh/oLAXRpsY3SRBLFHK8ImtQpVmkBF
         RX3eFQCiUXC14rXJxDPKGB3U0qko3ihkYNynF6DvBFsp0WazQ6gw4QSKB0dmi5160pJA
         uW5WR4tNilfpggbWSTCJ4n2O+c3vZ2v/ab5qQkljLAX7qzLDzqFe4lFAPzVVIz11/+im
         FL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703872468; x=1704477268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgJgtyWKKmG9drWdDVYQvzVHZZPAT+G8Hw1ZAEuDKug=;
        b=OJy+hVWYqhJTMSCl1i0OjF3OodSjcbkSiNnKOTj086IlWn3dDfD96S2hUHBf13cERc
         AcANJOV2dKpo2wP9PinLGJeYRRTU6mVctKkO+6uldHPsG9Pk+vmmnYAoQweiHTKRdfsi
         suORN9kRA1TO3wwJzbpIbDMxA1PXYBvAJ8X7PiGLda/diCLHiQ6Z3JLzryoGA1ZWlEVL
         yY3j5n4GejDnotozvFcvt15FXuI6fYxYL+bN7bGr21ap0NGIXB7zCicJzQNrkgzvMU7g
         MbUWj1RSxqNmp/JAiSA0dNhdp+VWUKINPx6ZX6Sls7U1PcnjZhE4bKDkMpEekvSn5/qk
         HGWw==
X-Gm-Message-State: AOJu0YyH1yXp1oTZFkTfAjnBDWt130vFY/rDbJrwmQjNRgxYBKBHc068
	g6SNLcrO333gMUHsa0rL8MbugHWybtPQSP/ooJu/4Ehqj6s=
X-Google-Smtp-Source: AGHT+IGkaFOcosr5K4ll9aROMGeWRIBm/zFMZG8twVvXOHgkR/VD6ODDcWiQCY1ppvhB9qc+e0p55eC4QpIc3NCH1Vk=
X-Received: by 2002:a0c:ea25:0:b0:67f:998b:bfbd with SMTP id
 t5-20020a0cea25000000b0067f998bbfbdmr12262650qvp.123.1703872467755; Fri, 29
 Dec 2023 09:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228201510.985235-1-trondmy@kernel.org> <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
 <a68a47d136decfeb6c1cc7959353ae51aca47ae7.camel@hammerspace.com>
In-Reply-To: <a68a47d136decfeb6c1cc7959353ae51aca47ae7.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Dec 2023 19:54:16 +0200
Message-ID: <CAOQ4uxiOZobN76OKB-VBNXWeFKVwLW_eK5QtthGyYzWU9mjb7Q@mail.gmail.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 5:22=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2023-12-29 at 07:46 +0200, Amir Goldstein wrote:
> > [CC: fsdevel, viro]
> >
> > On Thu, Dec 28, 2023 at 10:22=E2=80=AFPM <trondmy@kernel.org> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > The fallback implementation for the get_name export operation uses
> > > readdir() to try to match the inode number to a filename. That
> > > filename
> > > is then used together with lookup_one() to produce a dentry.
> > > A problem arises when we match the '.' or '..' entries, since that
> > > causes lookup_one() to fail. This has sometimes been seen to occur
> > > for
> > > filesystems that violate POSIX requirements around uniqueness of
> > > inode
> > > numbers, something that is common for snapshot directories.
> >
> > Ouch. Nasty.
> >
> > Looks to me like the root cause is "filesystems that violate POSIX
> > requirements around uniqueness of inode numbers".
> > This violation can cause any of the parent's children to wrongly
> > match
> > get_name() not only '.' and '..' and fail the d_inode sanity check
> > after
> > lookup_one().
> >
> > I understand why this would be common with parent of snapshot dir,
> > but the only fs that support snapshots that I know of (btrfs,
> > bcachefs)
> > do implement ->get_name(), so which filesystem did you encounter
> > this behavior with? can it be fixed by implementing a snapshot
> > aware ->get_name()?
>
> NFS (i.e. re-exporting NFS).
>

Ah.

> Why do you not want a fix in the generic code?
>

I do not object to your fix at all.
I only objected to the Fixes tag.
I was just pointing out that this is not a complete solution.
A decode of an NFS (re-exported) file handle could fail if
get_name() iterates the parent of a snapshot root dir
and finds a false match (which is not "." nor "..") before it
finds the snapshot subdir name.

It may be solved by nfs_get_name() which does not stop when
if finds an ino match but checks further, but I don't know nfs re-export
to know what else could be checked.

Anyway, for this patch, without the Fixes tag, feel free to add:
Acked-by: Amir Goldstein <amir73il@gmail.com>

I'd prefer the use of is_dot_dotdot(), but I do not insist.

Thanks and a happy new year!
Amir.

