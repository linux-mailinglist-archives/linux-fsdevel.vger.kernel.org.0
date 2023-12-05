Return-Path: <linux-fsdevel+bounces-4894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117B9805F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 21:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB911F21664
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A0675AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAMV11pj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB39135
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 11:18:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4254223c150so18391cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803911; x=1702408711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gb5idhR0OsNAQcLzIc/ASuFkkbs/5UorImoU2veMOs=;
        b=jAMV11pjPt6GiNCcmGBQv9REOigr3BmNZ88PqIzcnEJHtK1w2Ogs/dU0gUYsrnzgd2
         RWljb17+mdc/EydLvoj0JXihTYdm2FxnDtLItR55ZLzwAbdNijMv1WXo/Mdpl1Xf5Rzd
         zlGIWZmr7924mxJf0iNQeDLqVJ+nh/5yQAUWZYnXrGyfOaEAZJSOAMpCxcREiPcAJmcA
         V+7H0AZ5S9/HGmFoSsdomNDPJl/dUG2yH0T1qSqt+fj2ZSGuGyCxD+2tlImvSghSxy7B
         AgJl1lf84I/416BCeFEfN2qUasnup4wp4zb19e1ddDInY96aGU3JLdU8FSbfoJe6zCY5
         lClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803911; x=1702408711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Gb5idhR0OsNAQcLzIc/ASuFkkbs/5UorImoU2veMOs=;
        b=R4k3dYNgPPvNpM52npRhHO6GGwLINDAeMRe2DrAwOIe2klssehMD69YCuxkvyH9q/B
         FIZWcbGv55xk9gyDfG8cOvqU94UL6w7NAy2Yvv0cXGAF1+Ru7BVMYCTvv0VgmBunuuEZ
         aK5iYCqGQXKC9hqHI2W1E0/dUxQ1rbnwfaiP6dKtfGHs+dwHydBkaD5WEH5HSWvchN66
         Kp3lWisj/BVv10mTagosRSLwTjO7M5Uysk3hgxRueUYLXWPCXIhkP4DsELrtj8DI+De/
         Jh11QMirgphNjgieUhDF8u86Xqzky87eB/qWIs72D7ihHa2miIOTn4l7zRWjLt/2lMNx
         bpkg==
X-Gm-Message-State: AOJu0Yxpr5YFyHUGHhNqJF72RntnTZYTA3coQfiQ2PnjQUtEy9OKDKr1
	N3xh0zHQYV/joNPxKKeuFEXJ1eyiqLJuHwoge98=
X-Google-Smtp-Source: AGHT+IEJ/sUtyLNjBh/GuudVHNuZX5zz07FMWGe/Eux9vqWpKR62umzfmTjSyyheu6E+tY0CrlQERv/KNPFar8rNIkY=
X-Received: by 2002:a0c:fa41:0:b0:67a:a721:cb21 with SMTP id
 k1-20020a0cfa41000000b0067aa721cb21mr1791417qvo.130.1701803911680; Tue, 05
 Dec 2023 11:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm> <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com> <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
In-Reply-To: <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Dec 2023 21:18:20 +0200
Message-ID: <CAOQ4uxhUzXTzdrP6_ZBnFneivAupJq9L4QX0xMnfiTpWiXPr=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> >
> > FWIW, with FUSE_PASSTHROUGH, I plan that a shared mmap of an inode
> > in "passthrough mode" (i.e. has an open FOPEN_PASSTHROUGH file) will
> > be allowed (maps the backing file) regardless of fc->direct_io_allow_mmap.
> > FOPEN_PARALLEL_DIRECT_WRITES will also be allowed on an inode in
> > "passthrough mode", because an inode in "passthrough mode" cannot have
> > any pending page cache writes.
> >
> > This makes me realize that I will also need to handle passthrough of
> > ->direct_IO() on an FOPEN_PASSTHROUGH file.
>
> I really need to take a few hours to look at your patches.
>

Only if you want to glimpse at WIP.
There is still time before the direct_io/passthrough + mmap logic
is worked out.

Thanks,
Amir.

