Return-Path: <linux-fsdevel+bounces-6201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C1814DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B81C23D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA133EA7C;
	Fri, 15 Dec 2023 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JufxJbS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802603EA60
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-426114e5b3eso4315311cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702659620; x=1703264420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTde31bwF/Pd3FbsCVIO/Zp76ESUoaWjvdkuSmxzZD0=;
        b=JufxJbS0HR/g4h1cObcfecXW/bpuq9bSAXkc4QBSlPkj1K/f371khQRJmBvx0LUkJ2
         mwY4lAR8HA3LzRQbvYvZA65DZDBIxdIABwBa31Zn7XUzQWrGTXDbBKCFbpR25mq0JOsJ
         NswrXEiYr3Ja1WN2v6q4Sln2fP+ER+y1JI2HNNWZGT29U2Edk1Bj5TZHRLuLcQ+bEpwW
         7jzkBVOzYW3qx0zsvjSMsUplSgK7h5tXG3uqcFxRcnTAUTT7+jRHDh2ZHnX0ZIpWCDD2
         DFjBEOyMfRwwRhCANN5DqpG1sYveAi7B6ukQv76JbpjKD5V9e2JOrY0e494FcDh9s0an
         +ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659620; x=1703264420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTde31bwF/Pd3FbsCVIO/Zp76ESUoaWjvdkuSmxzZD0=;
        b=e7KRIAfAhT5GbUCWrCEhiErcRUAHVJVXoesE00QgBjX2q/PMbksZvUvFuhMKVOM0WB
         8xzHhgIOz3t0fhFFyKV4TBZUw3BlQf0K3gYn5lYURHKYn8s6n666CqRa71MaxdJk1aBG
         MBssvjgSgm3qncxrWpF0MhRT/GYYllrF/RvSmr3TosjJzihUUvLSkq5rCHOCmtRRClBq
         ycHRM2a5Dma59KJAtadhYSpmW92q5AInpv3SHyqENbCGV9s8zogfVX2qZT237Nz+/cgw
         V3Fw6XS5noKyGhltStwq8SWCJoUv4PCSsl+9ojEpTl6BghU7/h4uAits866p4gEu1ONE
         Ehdg==
X-Gm-Message-State: AOJu0YyhbiMBpvP89UepDloQGeZLErUkuDHcD11nK+8xoNeFU4UdTIcu
	2xmxxtPJbbSJXA/qLOTa3MPmRBGHzPO9413cNCw=
X-Google-Smtp-Source: AGHT+IGKfL+9MPAs0XRfKUcNB9wj+818ba1KH3AzcLuw28if/2tP8cEvmOj1l2scojWn57+PEbNYHl/LcLhccuWJhBs=
X-Received: by 2002:a05:622a:507:b0:425:aa8b:3aca with SMTP id
 l7-20020a05622a050700b00425aa8b3acamr14665033qtx.55.1702659619838; Fri, 15
 Dec 2023 09:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207215105.GA94859@localhost.localdomain>
 <CAOQ4uxiBGNmHcYCg2r_=pWFJVwx0WPmdmqQyrzDQdgWsiUTNYA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiBGNmHcYCg2r_=pWFJVwx0WPmdmqQyrzDQdgWsiUTNYA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Dec 2023 19:00:08 +0200
Message-ID: <CAOQ4uxj5GuOk7FdrZYdDVMmvp+CSBJty0SzsHN2T50NUBRFV4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Prepare for fsnotify pre-content permission events
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:34=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Dec 7, 2023 at 11:51=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Thu, Dec 07, 2023 at 02:38:21PM +0200, Amir Goldstein wrote:
> > > Hi Jan & Christian,
> > >
> > > I am not planning to post the fanotify pre-content event patches [1]
> > > for 6.8.  Not because they are not ready, but because the usersapce
> > > example is not ready.
> > >
> > > Also, I think it is a good idea to let the large permission hooks
> > > cleanup work to mature over the 6.8 cycle, before we introduce the
> > > pre-content events.
> > >
> > > However, I would like to include the following vfs prep patches along
> > > with the vfs.rw PR for 6.8, which could be titled as the subject of
> > > this cover letter.
> > >
> > > Patch 1 is a variant of a cleanup suggested by Christoph to get rid
> > > of the generic_copy_file_range() exported symbol.
> > >
> > > Patches 2,3 add the file_write_not_started() assertion to fsnotify
> > > file permission hooks.  IMO, it is important to merge it along with
> > > vfs.rw because:
> > >
> > > 1. This assert is how I tested vfs.rw does what it aimed to achieve
> > > 2. This will protect us from new callers that break the new order
> > > 3. The commit message of patch 3 provides the context for the entire
> > >    series and can be included in the PR message
> > >
> > > Patch 4 is the final change of fsnotify permission hook locations/arg=
s
> > > and is the last of the vfs prerequsites for pre-content events.
> > >
> > > If we merge patch 4 for 6.8, it will be much easier for the developme=
nt
> > > of fanotify pre-content events in 6.9 dev cycle, which be contained
> > > within the fsnotify subsystem.
> >
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >
> > Can you get an fstest added that exercises the freeze deadlock?
>
> I suppose that you mean a test that exercises the lockdep assertion?
> This is much easier to do, so I don't see the point in actually testing
> the deadlock. The only thing is that the assertion will not be backported
> so this test would protect us from future regression, but will not nudge
> stable kernel users to backport the deadlock fix, which I don't think the=
y
> should be doing anyway.
>
> It is actually already exercised by tests overlay/068,069, but I can add
> a generic test to get wider testing coverage.

Here is a WIP test:
https://github.com/amir73il/xfstests/commits/start-write-safe

I tested it by reverting "fs: move file_start_write() into
direct_splice_actor()"
and seeing that it triggers the assert.

Thanks,
Amir.

