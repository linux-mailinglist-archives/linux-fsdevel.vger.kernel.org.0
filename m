Return-Path: <linux-fsdevel+bounces-1128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F47D607A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 05:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D74B211ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE45220;
	Wed, 25 Oct 2023 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZGzhejL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC01FBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 03:20:16 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE15112F;
	Tue, 24 Oct 2023 20:20:14 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66cfd0b2d58so34144866d6.2;
        Tue, 24 Oct 2023 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698204014; x=1698808814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ0kHwYcA3WBYxuA4qFv7+Oyd4eJP2fjd8A3g9tIxhw=;
        b=bZGzhejLt7jg78IJNPuTK43iZCXtA4jy+tL1AEXHYwnWQlGnQMrnlZtytj8JtsrXKl
         rsRigOrGadqRYGwExsqHHFn/49y9nrAxDujBX4/Q67q5GSUOiSeYBj8cZMgoWHCNUpZ2
         mo9ugV1oHSSrKJ2yeP8/f2RiG+bemyr03qsMOG+rieS4MChTrHBYcgFMyVOILdmvYp8D
         sSwRmId/ReTgVQtLT+oqc3ZBTsqqDch/s5tMNWTl3/pp25JLNXDW203IZXfZ17SWkc2r
         6R6I7hXs+jkSsuvX/8RGK3MhxCi/U5MTwtmn0oQzWPGm2q6stlt8IiRM6MEPtip2FK0x
         cWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698204014; x=1698808814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ0kHwYcA3WBYxuA4qFv7+Oyd4eJP2fjd8A3g9tIxhw=;
        b=ZjZQPVCt8dfId5J9x3RKc4Ow1SKzNvEBuxkxMCksweS2HW2wvrulkWfD+hmCIFLb/s
         5bBVzlwdd2nvUGLtCCpmzxtcIJue1d7tdITI3hRx0DLWdFu33//iXvGzU2TR5JOsd1Hm
         hukQct83PmwJ2/0w1UFEiIG/7f6VD7Q3S+GTta8RhvT+5TzxCLaR34UcjNraeyN5vEqd
         TTmr3QhsCeNnjKpxixIrCOpEZ8oIGNn+yKwCSgEX2ZrGdysCKVWsUohn9fpNzMCD82+n
         lUsUoVNYvoEJAhmIVtVfo//7Zr7cZMYcwCJjPg4TFeJQWBf5EixFIOiLGYTkHllWVoq6
         BsIA==
X-Gm-Message-State: AOJu0YzfRBOQ4Ca6r7e8SHbXeHkoqbS/7+F2VFoUrG5tt+SvC2yPjFy2
	Rj/0zy7EEEf5lGJDDJ/iJkYpJDVUe0W1Uk1d+sC14B87mTJJSA==
X-Google-Smtp-Source: AGHT+IEBUnKyzIyof/7vwEwP7XOYFrnkk2dHmI/XBzZUr++4DPzQnC6/+UDVAZVlxP0ATTrrPct/uoHc/qAm8kbn7h4=
X-Received: by 2002:a05:6214:224c:b0:658:7441:ff1b with SMTP id
 c12-20020a056214224c00b006587441ff1bmr17972681qvc.45.1698204014008; Tue, 24
 Oct 2023 20:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024110109.3007794-1-amir73il@gmail.com> <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
 <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
 <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com> <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
 <41F5B54F-0345-4C44-99FB-6E2A6C9F365C@redhat.com>
In-Reply-To: <41F5B54F-0345-4C44-99FB-6E2A6C9F365C@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Oct 2023 06:20:02 +0300
Message-ID: <CAOQ4uxgFybKV5WG5fQtzG0HD3TkxcGD-+CuwU7DBwNG4HOvQNQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:01=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 24 Oct 2023, at 13:12, Amir Goldstein wrote:
> > On Tue, Oct 24, 2023 at 6:32=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >> Yes, but if the specific export is on the same server's filesystem as =
the
> >> "root", you'll still get zero.  There are various ways to set fsid on
> >> exports for linux servers, but the fsid will be the same for all expor=
ts of
> >> the same filesystem on the server.
> >>
> >
> > OK. good to know. I thought zero fsid was only for the root itself.
>
> Yes, but by "root" here I always mean the special NFSv4 root - the specia=
l
> per-server global root filehandle.
>
> ...
>
> >> I'm not familiar with fanotify enough to know if having multiple fsid =
0
> >> mounts of different filesystems on different servers will do the right
> >> thing.  I wanted to point out that very real possibility for v4.
> >>
> >
> > The fact that fsid 0 would be very common for many nfs mounts
> > makes this patch much less attractive.
> >
> > Because we only get events for local client changes, we do not
> > have to tie the fsid with the server's fsid, we could just use a local
> > volatile fsid, as we do in other non-blockdev fs (tmpfs, kernfs).
>
> A good way to do this would be to use the nfs_server->s_dev's major:minor=
 -
> this represents the results of nfs_compare_super(), so it should be the s=
ame
> value if NFS is treating it as the same filesystem.
>

Yes, that would avoid local collisions and this is what we are going
to do for most of the simple fs with anon_bdev [1].

But anon_bdev major is 0 and minor is quickly recyclable.
fanotify identified objects by {f_fsid, f_handle} pair.
Since nfs client encodes persistent file handles, I would like to try to ho=
ld
its f_fsid to higher standards than those of the simple fs.

You say that server->fsid.minor is always 0.
Perhaps we should mix server->fsid.major with server->s_dev's minor?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20231023143049.2944970-1-amir73il=
@gmail.com/

