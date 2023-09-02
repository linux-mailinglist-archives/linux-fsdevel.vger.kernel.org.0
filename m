Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD647907B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 13:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjIBLyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Sep 2023 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIBLyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:54:14 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0A10F6
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Sep 2023 04:54:09 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9a621359127so83259866b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Sep 2023 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693655648; x=1694260448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xTi8JzWSoRZ9awQ9tP2xRmkPxZTOmK3Z+NAkxP1LPY=;
        b=VSRPMj1Zgn4p8HqWEqnf3gw6fTqxwyqpO5XQwpFDSVVRCkk372h0Dma/egkxi355qI
         UBnycBMm7cQ9LhfadWDziN0LF7CH7cV+mhGY0fK0QLgAx/1FlKicQRgPY5T8muvqoiUC
         N83SyRLJktu6TwfOVN08/r4exDXRKfzRZiDqPBMoJj1e1oh4fAYSskoJGYZqZOtukCkp
         uEWlC/kH6wRwPYGaa/1hJ3GeIuZHmEFRIgXE3EwBpuXq3KNiSg7LYnqE+ScFn4ri9qfZ
         xyIIdEV9pF0xPAnxmsRt4pozHMtTHD9mR5zbImDdhIteGGsBju9E6pSnGvB4Z1gxSFP7
         zLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655648; x=1694260448;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xTi8JzWSoRZ9awQ9tP2xRmkPxZTOmK3Z+NAkxP1LPY=;
        b=fkkxj7BhIc1mBUeOLfyfnveNEuCSUe2uPCXm4pg5KUR7E6HhRPixX4Acba6E2EC0a3
         gu3yin0PlStNPt6ACb5mIfwY3+K+y94+bi3wsknp85ArjQAYyN0RQKM8KNzs6SwPz7Wv
         W/QmyZ+LRju3yRge0qPuSgUnoVBIe8fnL3Or91EIv9aD9BxAv/Zn5oBdUfOTNdM3jinC
         g/PoqmY9wxpmiepG9a6iAZNibGAz7ILTTJm8RjFDrAk1Cqc4uSiMDhL4Irp4F3RmqQc1
         uqc2/a+GWWwbIdOflIi3uleADMuI/V4Z18MonVR3BKVDqGqeN++4d5sez00J8RqOfO20
         /20g==
X-Gm-Message-State: AOJu0YwvJaVpHrI9v/sQ9PWYvFr9hgqyhZmYpvZ8Vg3WINpX/h647APn
        k8LWhlTkfuuwG38FZctUc+jwg4XUI00=
X-Google-Smtp-Source: AGHT+IHcgc+x0g52MeRFpfHWF/N5g/r8clf+a8kl2FfPB9ny2mr/mLxZTKdlcPNEkRw56N3vjIPGpx7npL8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:989:1456:793b:32f4])
 (user=gnoack job=sendgmr) by 2002:a17:907:6217:b0:9a1:eb41:eb4f with SMTP id
 ms23-20020a170907621700b009a1eb41eb4fmr46738ejc.7.1693655648117; Sat, 02 Sep
 2023 04:54:08 -0700 (PDT)
Date:   Sat, 2 Sep 2023 13:53:57 +0200
In-Reply-To: <20230826.ohtooph0Ahmu@digikod.net>
Message-Id: <ZPMiVaL3kVaTnivh@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com> <20230825.Zoo4ohn1aivo@digikod.net> <20230826.ohtooph0Ahmu@digikod.net>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

Thanks for the detailed review again!  The FIONREAD implementation that you
suggested works.  With FIOQSIZE I ran into some surprises - I believe the c=
heck
is a noop - more details below.

On Sat, Aug 26, 2023 at 08:26:30PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Aug 25, 2023 at 06:50:29PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Aug 25, 2023 at 05:03:43PM +0200, G=C3=BCnther Noack wrote:
> > > FIONREAD gives the number of bytes that are ready to read.  This IOCT=
L seems
> > > only useful when the file is open for reading.  However, do you think=
 that we
> > > should correlate this with (a) LANDLOCK_ACCESS_FS_READ_FILE, or with =
(b)
> > > f->f_mode & FMODE_READ?  (The difference is that in case (a), FIONREA=
D will work
> > > if you open a file O_WRONLY and you also have the LANDLOCK_ACCESS_FS_=
READ_FILE
> > > right for that file.  In case (b), it would only work if you also ope=
ned the
> > > file for reading.)
> >=20
> > I think we should allow FIONREAD if LANDLOCK_ACCESS_FS_IOCTL is handled
> > and if LANDLOCK_ACCESS_FS_READ_FILE is explicitly allowed for this FD.

Just paraphrasing for later reference, because I almost misunderstood it:

FIONREAD should work even when LANDLOCK_ACCESS_FS_IOCTL is *handled*,
which is lingo for "listed in the ruleset_attr.handled_access_fs".
When it is listed there, that means that the Landlock policy does not
grant the LANDLOCK_ACCESS_FS_IOCTL right.

So we treat FIONREAD as blanket-permitted independent of the
LANDLOCK_ACCESS_FS_IOCTL right, under the condition that we have
LANDLOCK_ACCESS_FS_READ_FILE for the file. -- Sounds good to me, will do.


> > > FIOQSIZE seems like it would be useful for both reading *and* writing=
? -- The
> > > reading case is obvious, but for writers it's also useful if you want=
 to seek
> > > around in the file, and make sure that the position that you seek to =
already
> > > exists.  (I'm not sure whether that use case is relevant in practical
> > > applications though.) -- Why would FIOQSIZE only be useful for reader=
s?
> >=20
> > Good point! The use case you define for writing is interesting. However=
,
> > would it make sense to seek at a specific offset without being able to
> > know/read the content? I guest not in theory, but in practice we might
> > want to avoid application to require LANDLOCK_ACCESS_FS_READ_FILE is
> > they only require to write (at a specific offset), or to deal with writ=
e
> > errors. Anyway, I guess that this information can be inferred by trying
> > to seek at a specific offset.  The only limitation that this approach
> > would bring is that it seems that we can seek into an FD even without
> > read nor write right, and there is no specific (LSM) access control for
> > this operation (and nobody seems to care about being able to read the
> > size of a symlink once opened). If this is correct, I think we should
> > indeed always allow FIOQSIZE. Being able to open a file requires
> > LANDLOCK_ACCESS_FS_READ or WRITE anyway.  It would be interesting to
> > check and test with O_PATH though.
>=20
> FIOQSIZE should in fact only be allowed if LANDLOCK_ACCESS_FS_READ_FILE o=
r
> LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are handled
> and explicitly allowed for the FD. I guess FIOQSIZE is allowed without re=
ad
> nor write mode (i.e. O_PATH), so it could be an issue for landlocked
> applications but they can explicitly allow IOCTL for this case. When
> we'll have a LANDLOCK_ACCESS_FS_READ_METADATA (or something similar), we
> should also tie FIOQSIZE to this access right, and we'll be able to
> fully handle all the use cases without fully allowing all other IOCTLs.

I implemented this check for the Landlock access rights in the ioctl hook, =
but
when testing it I realized that I could not ever get it to fail in practice=
:

ioctl(2) generally returns EBADF when the file was opened with O_PATH.  Ear=
ly in
the ioctl(2) syscall implementation, it returns EBADF when the struct fd do=
es
not have the ->file attribute set.  (This is even true for the commands to
manipulate the Close-on-exec flag, which don't strictly need that. But they
might work through fcntl.)

In my understanding from the open(2) man page, the only ways to open files =
are
with one of O_RDONLY, O_RDWR, O_WRONLY or O_PATH:

- O_RDONLY: we had LANDLOCK_ACCESS_FS_READ_FILE at the time of open(2).
- O_WRONLY: we had LANDLOCK_ACCESS_FS_WRITE_FILE at the time of open(2).
- O_RDWR: we had both of these two rights at the time of open(2).
- O_PATH: any ioctl(2) attempt returns EBADF early on

So at the time that the ioctl security hook gets called, we already know th=
at
the user must have had one of the LANDLOCK_ACCESS_FS_READ_FILE or
LANDLOCK_ACCESS_FS_WRITE_FILE rights -- checking for it again is not strict=
ly
necessary?

Am I missing something here?  (In particular, am I overlooking additional w=
ays
to call open(2) where the read and write rights are not necessary, other th=
an
O_PATH?)

I'd propose this path forward: Let's keep the check for the rights as you
suggested, but I would just keep it as an additional safety net there, for
Landlock's internal consistency, and in case that future Linux versions
introduce new ways to open files.  I believe that at the moment, that check=
 is
equivalent to always permitting the FIOQSIZE command in that hook (with the=
 same
logic as for FIOCLEX, FIONCLEX etc).


> > > (In fact, it seems to me almost like FIOQSIZE might rather be missing=
 a security
> > > hook check for one of the "getting file attribute" hooks?)
> > >=20
> > > So basically, the implementation that I currently ended up with is:
> > >=20
> >=20
> > Before checking these commands, we first need to check that the origina=
l
> > domain handle LANDLOCK_ACCESS_FS_IOCTL. We should try to pack this new
> > bit and replace the file's allowed_access field (see
> > landlock_add_fs_access_mask() and similar helpers in the network patch
> > series that does a similar thing but for ruleset's handle access
> > rights), but here is the idea:
> >=20
> > if (!landlock_file_handles_ioctl(file))
> > 	return 0;
> >=20
> > > switch (cmd) {
> > 	/*
> > 	 * Allows file descriptor and file description operations (see
> > 	 * fcntl commands).
> > 	 */
> > >   case FIOCLEX:
> > >   case FIONCLEX:
> > >   case FIONBIO:
> > >   case FIOASYNC:
> >=20
> > >   case FIOQSIZE:
>=20
> We need to handle FIOQSIZE as done by do_vfs_ioctl: add the same i_mode
> checks. A kselftest test should check that ENOTTY is returned according
> to the file type and the access rights.

It's not clear to me why we would need to add the same i_mode checks for
S_ISDIR() || S_ISREG() || S_ISLNK() there?  If these checks in do_vfs_ioctl=
()
fail, it returns -ENOTTY.  Is that not an appropriate error already?


> > >     return 0;
> > >   case FIONREAD:
> > >     if (file->f_mode & FMODE_READ)
> >=20
> > We should check LANDLOCK_ACCESS_FS_READ instead, which is a superset of
> > FMODE_READ.

Done.


=E2=80=94G=C3=BCnther
