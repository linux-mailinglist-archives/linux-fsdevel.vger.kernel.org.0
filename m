Return-Path: <linux-fsdevel+bounces-3350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB767F3D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 06:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476B9281A77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2E11CB6;
	Wed, 22 Nov 2023 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2glseKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B6DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 21:38:17 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7788f513872so386501985a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 21:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700631497; x=1701236297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk8ZSY5PNFh4Ks6gnMB1P9ncZ3FVWfYIaPLfONhDmgo=;
        b=Y2glseKYVuUM7X3s+S3VgYoYCFM6/13ya6Bu34gHX8CPdhGUQ/FfQX/Nar9YzN8y2+
         QZsRQ+AcuHNBaNz1ootzJrF+Q6f0DO1nvNcbFp+1VXIvhjBSuzTljOMna8VenKnQIboQ
         7NakbIPZQEhBMZvI/WtdbzoAwVnckZJJW2lsR8cJPRFqJzr7nR4SbKiPQnzXuryLiGYX
         5Cu+2EGdVUniW4ACMITLEhouX9VJLPQAEKr5D5BH7E0O+fviwykgxbD7ickbOraiHo4F
         wT0MW1pSDDYYy5TPc2quJ8AZcC4p2BiEog6rfMklvI6hjIgT9q3xS6+j3PQ7RtFz9CiA
         8BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700631497; x=1701236297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk8ZSY5PNFh4Ks6gnMB1P9ncZ3FVWfYIaPLfONhDmgo=;
        b=hdvENLOnp32syLX5ST4OgWhHUbeCpQwQdoQfgG6gB3mal2CImpW+ryd3xMZc2V3FkL
         T16qOW4PG1Qtf9mt3FzztdS/vvJhTfr7LNxe+6X0Er38moiK54cQdkHBchglYJy7HFug
         CWejNPHlyJXt3N/IUvmmfenI3EE6WS5gWWOiO5Ubxnxbn+09MiKJqXuTHzu2DhqUPYhW
         EXP14Aewp720FBUyiR26CMq1GC0R4n99GyPvT2jaAOF8y6jhJPoWNjSyeDs+kRPOSEX2
         nCJiqfNGzdldWeiSVXhWfI/EJv1ilST7e3hiGLYFBBGH2GLcJwCz/TGkqCbRskMlTOtp
         dsuA==
X-Gm-Message-State: AOJu0YyLsKB2M4DMeWWdN9ew4VAgegoA20EzsyjbC8kMofC1C9Q7MRRC
	DHHpaZpPU9GgiWQR4DRL/+JhJLRy+HWV0GrO9X8=
X-Google-Smtp-Source: AGHT+IE8Vbhe9cz6uZCVgucJcp5h7nbbGCoA55ISmSwOp+icutWGhkFdsJD0Zi2Ird4crn2EVQeAMoTp3dqInGs69yk=
X-Received: by 2002:a05:620a:1909:b0:76c:ea3f:9010 with SMTP id
 bj9-20020a05620a190900b0076cea3f9010mr1513192qkb.16.1700631496849; Tue, 21
 Nov 2023 21:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121132551.2337431-1-amir73il@gmail.com> <20231121210032.GA1675377@perftesting>
 <ZV0hWVWeI6QOVfYM@dread.disaster.area>
In-Reply-To: <ZV0hWVWeI6QOVfYM@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Nov 2023 07:38:05 +0200
Message-ID: <CAOQ4uxjexNYM8bat1SS8kykNhXj6JOW9W6Za9FSs5JO+e4NcCw@mail.gmail.com>
Subject: Re: [PATCH] fs: allow calling kiocb_end_write() unmatched with kiocb_start_write()
To: Dave Chinner <david@fromorbit.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:30=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Tue, Nov 21, 2023 at 04:00:32PM -0500, Josef Bacik wrote:
> > On Tue, Nov 21, 2023 at 03:25:51PM +0200, Amir Goldstein wrote:
> > > We want to move kiocb_start_write() into vfs_iocb_iter_write(), after
> > > the permission hook, but leave kiocb_end_write() in the write complet=
ion
> > > handler of the callers of vfs_iocb_iter_write().
> > >
> > > After this change, there will be no way of knowing in completion hand=
ler,
> > > if write has failed before or after calling kiocb_start_write().
> > >
> > > Add a flag IOCB_WRITE_STARTED, which is set and cleared internally by
> > > kiocb_{start,end}_write(), so that kiocb_end_write() could be called =
for
> > > cleanup of async write, whether it was successful or whether it faile=
d
> > > before or after calling kiocb_start_write().
> > >
> > > This flag must not be copied by stacked filesystems (e.g. overlayfs)
> > > that clone the iocb to another iocb for io request on a backing file.
> > >
> > > Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88=
rH1UfEeP8AtP+w@mail.gmail.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > This is only a problem for cachefiles and overlayfs, and really just fo=
r
> > cachefiles because of the error handling thing.
> >
> > What if instead we made vfs_iocb_iter_write() call kiocb_end_write() in=
 the ret
> > !=3D EIOCBQUEUED case, that way it is in charge of the start and the en=
d, and the
> > only case where the file system has to worry about is the actual io com=
pletion
> > path when the kiocb is completed.
> >
> > The result is something like what I've pasted below, completely uncompi=
led and
> > untested.  Thanks,
>
> I like this a lot better than an internal flag that allows
> unbalanced start/end calls to proliferate.  I find it much easier to
> read the code, determine the correct cleanup is being done and
> maintain the code in future when calls need to be properly
> paired....

Yes! I like it too.

Thank you Josef!
I'll test that and post v2 with your RVBs.

Amir.

