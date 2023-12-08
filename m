Return-Path: <linux-fsdevel+bounces-5302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC9809E2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 09:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315B21C20966
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB12125BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnomz1hX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4711724
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 23:34:21 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-464816f90f4so496201137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 23:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702020861; x=1702625661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT8Gfxvzkgk2pxTnQDmBH2f3jpBALHUu0aVfan33AJA=;
        b=fnomz1hXimlDfHiE47hMxGG2oeveHieghL6dpu/3Ke5UupVPXusGxbNwAiZoFiEBZH
         Xy6F7e1qnmgya2QI3G1/yrLJdwQaecdYAqaOfwGgcEH5ofrnuHdD9Hc/2Fo6gZRTPzZV
         ROKonXpnZ5Um05pBmDT4PTY4F8haCoEnn3q4IIlwjN1yhoY2RXoDwf9EmpMXAo2byr/r
         omxWNmwCAP3T/ObkH6G5ipHRmAz7NoX4w4uClaFEmi98ZlQaCxo89njSasONgxvrzDbA
         CHMkBvFzVyyzCbuKcvRUtWcOzQs1c2gbJyjfomFK1VQmR/7JVZAf/fgk/YjW5q5dkE9n
         Ed5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702020861; x=1702625661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT8Gfxvzkgk2pxTnQDmBH2f3jpBALHUu0aVfan33AJA=;
        b=gCV949u4AQwO8e1rUCqOmYbW67z3s18YvWM1/2QsSCcqO2Xj3XEKAq//F4jJIMf/SQ
         BCu8LiVYWV7j0cVgvhwuSn7uHzKCf/kDT83Qe0unHUqF93xPb/oocfaZos1MNqUg6ViL
         vlQyj9PZEOAGA0Xfuhd+k6v7O6j4DRSUb22Q27s6hvhGBQaLM5glRpXhynN43qTmQdvT
         qsosVsd8hNa/2JgF2WafqtW2vAjKUGJ2NNy27wjfga4J6eyI131Jc4LU//BgWqROIZTi
         7kAnz3uZ4Gm2ya8N0mGHToswsV/pT7tgBFM7az/Y0jFxaKXF4WQg0NoduM5bnbpVjhV1
         dUVw==
X-Gm-Message-State: AOJu0YwVCIFV8PwByTwvbSgSUd8Y0roH6T/Qgio5eIIosyQQnGHeWeQS
	XITKsSGDmmOvyKUmz1lttufPg1MGCMAX9knXPgY=
X-Google-Smtp-Source: AGHT+IExWJdcbgLzEH1iShAfRXZs0Fg1nslIXOcDBGVIn5a9v0W6D9LPoIAZihuQ7YHskK6Z6YfzmxCULjzYUtbbaxc=
X-Received: by 2002:a05:6102:c87:b0:464:73d8:769a with SMTP id
 f7-20020a0561020c8700b0046473d8769amr4455372vst.26.1702020860707; Thu, 07 Dec
 2023 23:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207215105.GA94859@localhost.localdomain>
In-Reply-To: <20231207215105.GA94859@localhost.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2023 09:34:09 +0200
Message-ID: <CAOQ4uxiBGNmHcYCg2r_=pWFJVwx0WPmdmqQyrzDQdgWsiUTNYA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Prepare for fsnotify pre-content permission events
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 11:51=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Dec 07, 2023 at 02:38:21PM +0200, Amir Goldstein wrote:
> > Hi Jan & Christian,
> >
> > I am not planning to post the fanotify pre-content event patches [1]
> > for 6.8.  Not because they are not ready, but because the usersapce
> > example is not ready.
> >
> > Also, I think it is a good idea to let the large permission hooks
> > cleanup work to mature over the 6.8 cycle, before we introduce the
> > pre-content events.
> >
> > However, I would like to include the following vfs prep patches along
> > with the vfs.rw PR for 6.8, which could be titled as the subject of
> > this cover letter.
> >
> > Patch 1 is a variant of a cleanup suggested by Christoph to get rid
> > of the generic_copy_file_range() exported symbol.
> >
> > Patches 2,3 add the file_write_not_started() assertion to fsnotify
> > file permission hooks.  IMO, it is important to merge it along with
> > vfs.rw because:
> >
> > 1. This assert is how I tested vfs.rw does what it aimed to achieve
> > 2. This will protect us from new callers that break the new order
> > 3. The commit message of patch 3 provides the context for the entire
> >    series and can be included in the PR message
> >
> > Patch 4 is the final change of fsnotify permission hook locations/args
> > and is the last of the vfs prerequsites for pre-content events.
> >
> > If we merge patch 4 for 6.8, it will be much easier for the development
> > of fanotify pre-content events in 6.9 dev cycle, which be contained
> > within the fsnotify subsystem.
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Can you get an fstest added that exercises the freeze deadlock?

I suppose that you mean a test that exercises the lockdep assertion?
This is much easier to do, so I don't see the point in actually testing
the deadlock. The only thing is that the assertion will not be backported
so this test would protect us from future regression, but will not nudge
stable kernel users to backport the deadlock fix, which I don't think they
should be doing anyway.

It is actually already exercised by tests overlay/068,069, but I can add
a generic test to get wider testing coverage.

Thanks,
Amir.

