Return-Path: <linux-fsdevel+bounces-385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52A7CA55E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C42B20E22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982123748;
	Mon, 16 Oct 2023 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM9sAAKO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB123740
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 10:30:26 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96ADEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:30:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af603da0f0so2843929b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452221; x=1698057021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBC6xeFm+CN3ABZOuHXE0paAAwVB5wUlw+oDzZda2HE=;
        b=ZM9sAAKO9B0EcLMcA/O2dMLePYriZnT/rtqN3Gik0ltjr4j3Ye7yjPwi+ijXn+q0aM
         uyuwJa27isbXYk9TTtTL6z8+kafx9BqAl7d0COqw9OybL7socfNn4c3Lqr96IWoJ5zNR
         kPoNLo6oJEkvEdfq5IDHAf1D+CzE3G+xLw5HyOBU/jmX6zk+MK+pL+S0Qe8S7z05NBH/
         qYzU4FPbv2hjvH1NOzLxAUcTP7a80RW6HFQgIHvyQTsWNH6iTaNMtloqBzPTlVgDDKTd
         chQxemietRMWHzW4vPhhuqbnCB3GZqFhYfIF2zIYq+EMdKres9/uapm6TfOHRUgzwUwb
         Khbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452221; x=1698057021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBC6xeFm+CN3ABZOuHXE0paAAwVB5wUlw+oDzZda2HE=;
        b=NUK7ekn+IIIaN/QKmBXdX2j8EIZhaxZ4QX4cUEMjgFgL/22bMbefcMvOvRUqp0NMRc
         K9nJJoLazT2pGHr/H9CpJBFBsvLgoDZ3h05Tv0pJMG8SakW8Xi1JPk5hQNh308Djz9U2
         Ff2WMZ3ou/ri48IMAXU2TaS8Uj711CL/3lahvvyR0K/utQOMTNknEHBe5izALQn9p2OB
         xAFwWZrG9yWAqm4iat4ylaskbx4abNIqj3HI53R6rVIpg+1P0Pj4C6LwlUksQSOO5vt0
         Hw64IDBx9BbZhjR8kuj4MzAlWDhYB5/9g0q8wvHvongK3PFUaphA/4UXQh/h1NonGSBm
         BT/A==
X-Gm-Message-State: AOJu0YwMPj87A+iMkyndQFIuneop8+o8pDTk/FTxskTLLcABIKIkhxJ/
	1tUmunfScnXykYP/cNsPZrgRgtVaMcW2eVgrHg3/DJO7nWW/Vg==
X-Google-Smtp-Source: AGHT+IFmXNGEbDgQO20kAvjOMwn4CCQDm2IwySwrtCAVCpV/XmHOPdNfn3VZipCio9egRy0VcHyyewAnKguxSSfjYMo=
X-Received: by 2002:a05:6808:138b:b0:3af:9fc4:26c6 with SMTP id
 c11-20020a056808138b00b003af9fc426c6mr40481990oiw.20.1697452220964; Mon, 16
 Oct 2023 03:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
 <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com> <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
In-Reply-To: <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Oct 2023 13:30:09 +0300
Message-ID: <CAOQ4uxg+8H5+iXDygA_8G+yZPpxkKOADVhNOPPfuuwo4wYmojQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 5:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 8 Oct 2023 at 19:53, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Ok, posted your original suggestion for opt-in to fake path:
> > https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73il=
@gmail.com/
> >
> > Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
> > the fake (fuse) path is not known.
> >
> > We can set the fake path on the first FOPEN_PASSTHROUGH response,
> > but then the whole concept of a backing id that is not bound to a
> > single file/inode
> > becomes a bit fuzzy.
> >
> > One solution is to allocate a backing_file container per fuse file on
> > FOPEN_PASSTHROUGH response.
>
> Right.   How about the following idea:
>
>  - mapping request is done with an O_PATH fd.
>  - fuse_open() always opens a backing file (just like overlayfs)
>
> The disadvantage is one more struct file (the third).  The advantage
> is that the server doesn't have to care about open flags, hence the
> mapping can always be per-inode.
>

OK, this was pushed to the POC branches [2][3].

NOTE that in this version, backing ids are completely server managed.
The passthrough_hp example keeps backing_id in the server's Inode
object and closes the backing file when server's inode.nopen drops to 0.
Even if OPEN/CREATE reply with backing_id failed to create/open the
fuse inode, RELEASE should still be called with the server provided nodeid,
so server should be able to close the backing file after a failed open/crea=
te.

I am ready to post v14 patches, but since they depend on vfs and overlayfs
changes queued for 6.7, and since fuse passthrough is not a likely candidat=
e
for 6.7, I thought I will wait with posting, because you must be busy prepa=
ring
for 6.7(?).

The remaining question about lsof-visibility of the backing files got me
thinking and I wanted to consult with io_uring developers regarding using
io_uring fixed files table for FUSE backing files [*].

[*] The term "FUSE backing files" is now VERY confusing since we
     have two types of "FUSE backing files", so we desperately need
     better names to describe those two types:
1. struct file, which is referred via backing_id in per FUSE sb map
2. struct backing_file, which is referred via fuse file ->private
    (just like overlayfs backing files)

The concern is about the lsof-visibility of the first type, which the serve=
r
can open as many as it wants without having any connection to number
of fuse inodes and file objects in the kernel and server can close those
fds in its process file table, making those open files invisible to users.

This looks and sounds a lot like io_uring fixed files, especially consideri=
ng
that the server could even pick the backing_id itself. So why do we need
to reinvent this wheel?

Does io_uring expose the fixed files table via lsof or otherwise?

Bernd,

IIUC, your work on FUSE io_uring queue is only for kernel -> user
requests. Is that correct?
Is there also a plan to have a user -> kernel uring as well?

I wouldn't mind if FUSE passthrough depended on FUSE io_uring
queue, because essentially, I think that both features address problems
from the same domain of FUSE performance issues. Do you agree?

Am I over engineering this?

Thanks,
Amir.

Changes from v14-rc1 to v14-rc2 [2]:
- rebase on 6.6-rc6 (and overlayfs and vfs next branches)
- open a backing_file per fuse_file with fuse file's path and flags
- factor out common splice/mmap helpers from overlayfs
- remove inode-bound (no backing id) backing file mode
- use backing_id as input arg for close ioctl
- remove auto-close mode

Changes from v13 to v14-rc1 [1]:
- rebase on 6.6-rc1
- factor out common read/write helpers from overlayfs
- factor out ioctl helpers
- per-file and per-inode backing file modes
- optional auto close flag

[1] https://github.com/amir73il/linux/commits/fuse-backing-fd-rc1
[2] https://github.com/amir73il/linux/commits/fuse-backing-fd-rc2
[3] https://github.com/amir73il/libfuse/commits/fuse-backing-fd

