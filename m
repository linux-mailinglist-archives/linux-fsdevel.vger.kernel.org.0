Return-Path: <linux-fsdevel+bounces-6819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0281D315
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 09:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B250C285658
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407038BF8;
	Sat, 23 Dec 2023 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGYtOw/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B48BE0;
	Sat, 23 Dec 2023 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f962cf6c9so9808036d6.0;
        Sat, 23 Dec 2023 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703318842; x=1703923642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+tvtCEx4amSruCH34EZmfpOJxMPeGVyIrnjY29bi6Q=;
        b=bGYtOw/8DZDcFz+w7qviDeWIhBkueAynCHYIyr5BeQh6KI1wpiCptA5LDErNigwZyo
         Rc9lj7KBr5+eSHgP5cBfqeJZJ15QAqLd73yYMGD1ymCj0GCxXJqlwGTv0RAHNdPhlimz
         5lGtoBIOy8L+vobhlHl+nZ5js8JBwd5dr09ruUFv43Xe0bos3NtjzHo/peMgFZ/33djr
         Cb0gwksE5fbLcz1O8IKp41ShSJDjncTSgL8NKT27L13CFf09L4jzhQ/1QHdrhxyyoset
         8MWvaXw1BjQOsl4jCiB1r+rpxnNFMVrgTcG8STOZTj/OWzPSxSVniyqd7WYQRBVaWhq/
         lEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703318842; x=1703923642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+tvtCEx4amSruCH34EZmfpOJxMPeGVyIrnjY29bi6Q=;
        b=ldakWCStJOtsQoKdWyVAiLOggOr9UGdmi4NgFd1IsssEoPd2KicpcpTqA1P9t8nPWk
         c5v5k/EUivqZxMGkoifid4tQPh9SeAkl+PvXOnu0akOcOaJFiur+0O4sh8lbbS05Qed0
         PvosTEdEN11TUoOnCZCkVGwqhsv9CcQky+FIXCb/Obhw1PzVL2TcKY6578YjXIT9lIzK
         +YjJUlL7BDikzDakO1pqdF6+oKtvEPg6Ebp/0MJTAu5CNGBedmv9HlZjjP6w31h4SS/M
         Oz3T756J6nBaI4VXV2AIsTa9YFQHEMW7kWHXY8jaahzBPX3sRduZLYIjkwfDghLfMAPJ
         3DVA==
X-Gm-Message-State: AOJu0Yz174/MXcGwFH9KPyPy6VwMyK3E6a27vg5Om6qnjxKuY+mF4ksJ
	kKMW2AKil3D6yhjV+Rfebnac5gNRTQKrTs3XnrLXz806NN8=
X-Google-Smtp-Source: AGHT+IG/7QFR7PWvuf7572ZqbI6RswYtmjphZBW3gbVj6nw4G3JDVtx8Iov5pQ6XoR0/If1PT4xL5C6Glb4APGRsHr8=
X-Received: by 2002:a05:6214:262d:b0:67f:40c9:8184 with SMTP id
 gv13-20020a056214262d00b0067f40c98184mr5298274qvb.30.1703318842734; Sat, 23
 Dec 2023 00:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221095410.801061-1-amir73il@gmail.com> <20231222-bekennen-unrat-a42e50abe5de@brauner>
In-Reply-To: <20231222-bekennen-unrat-a42e50abe5de@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Dec 2023 10:07:11 +0200
Message-ID: <CAOQ4uxiDEHattVW2NecEwf66GNrUnkAief9XSTWbegcgyzuSbA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Intruduce stacking filesystem vfs helpers
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:44=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > If I do that, would you preffer to take these patches via the vfs tree
>
> I would prefer if you:
>
> * Add the vfs infrastructure stuff on top of what's in vfs.file.
>   There's also currently a conflict between this series and what's in the=
re.

I did not notice any actual conflicts with vfs.file.
They do change the same files, but nothing that git can't handle.
Specifically, FMODE_BACKING was excepted from the fput()
changes, so also no logic changes that I noticed.

The only conflict I know of is with the vfs.rw branch,
the move of *_start_write() into *__iter_write(), therefore,
these patches are already based on top of vfs.rw.

I've just pushed branch backing_file rebased over both
vfs.rw and vfs.file to:
https://github.com/amir73il/linux/commits/backing_file

Started to run overlayfs tests to see if vfs.file has unforeseen impact
that I missed in review.

> * Pull vfs.file into overlayfs.
> * Port overlayfs to the new infrastructure.
>

Wait, do you mean add the backing_file_*() helpers
and only then convert overlayfs to use them?

I think that would be harder to review (also in retrospect)
so the "factor out ... helper" patches that move code from
overlayfs to fs/backing_file.c are easier to follow.

Or did you mean something else?

> io_uring already depends on vfs.file as well.
>
> If this is straightforward I can include it in v6.8. The VFS prs will go
> out the week before January 7.

Well, unless I misunderstood you, that was straightforward.
The only complexity is the order and dependency among the PRs.

If I am not mistaken, backing_file could be applied directly on top of
vfs.rw and sent right after it, or along with it (via your tree)?

If I am not mistaken, backing_file is independent of vfs.file, but surely
it could be sent after vfs.file.

The changes I currently have in overlayfs-next for 6.8 are very mild
and do not conflict with any of the aforementioned work.

If you prefer that I send the PR for backing_file via overlayfs tree,
I can do that, even in the second part of the merge window, after
vfs.file and vfs.rw are merged, but in that case, I would like to be
able to treat vfs.rw and stable from here on, so that I can pull it
into overlayfs-next and put backing_file to soak in linux-next.

Let me know how you want to deal with that.

Thanks,
Amir.

