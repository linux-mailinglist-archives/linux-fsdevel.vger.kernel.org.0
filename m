Return-Path: <linux-fsdevel+bounces-1659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E67DD4DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBE281991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ADE21375;
	Tue, 31 Oct 2023 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPlY5QvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE48210FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 17:44:37 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFCB4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:36 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-457bc2de48dso2488312137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698774275; x=1699379075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2pf2UeKJGxSstepbc/JkwKNsVXc4AOzvgZnTDRRJGo=;
        b=jPlY5QvUgS3tFNV0jui5CvEzXpYlx8E3yz/3+0+9N6PyPuWuZD28ooyVQuK/4cHPiD
         bzAGOIUcOlYq9KC4FduZf+1DJhlsQ/LZGp4qpBe/rJqc2TNyaa6e9oyaLJtJ9mK9Fo3v
         KHFtHDx1OMR+wGpTe18J2nk1MW+vbLCbelDWfp8hOxdS0JUZDni7IvORB3NftHVJgxZU
         2EuEByAhpub91RLYISzS4qLi+4GwKAvTSdrsUwfVDTTEC4cgilrUcfL58vxn+W3Uwy9Y
         js/32yiEGEXEvCLQRkXpBKViUs55NDhWW+N9oeTaU1PdiOxosLJaU0xlRSAzmlR8jV1q
         mfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774275; x=1699379075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2pf2UeKJGxSstepbc/JkwKNsVXc4AOzvgZnTDRRJGo=;
        b=VOnyJ+3fQDz+VkNoLv3Y5LVWURd1tkUAtmRnNh74B1Eh2fXjd3b8ImNR3Nrlsw4pC7
         ToNhRGzvEHru6luxmE/PJmt3ewCc4YcSAbeiHobmfDUHp2DrdmUSAA8mhiVHlSvnnKMD
         oxQtAgevjlXfAIcDbyHMDUaIpZC9b4pnUKVITp+oK0F/gifHo0bjKjG9DyWBrBvztYQz
         v5XLDT5MF8fskz5ZhMd+k1L2fyj1Bzol9MmSvqzwYIHf+EQavP/h4vG/PBHAeXvzMPS9
         zDo3p/6d61A3VsdpDgQsCplifatCYy3oNvTsaOTnscus3nSfHiqweIGry8WFY7sCjMDZ
         3btw==
X-Gm-Message-State: AOJu0YyXTuiWC3yP5VF7TLJVVrtJa0L+TTiWalxI2xxxNWj06NYmWc+R
	dyDGdEJ0pI5uoNvdndppWg8MVrm2ZD49EaoNgZORLofcvyMtvA==
X-Google-Smtp-Source: AGHT+IHzJ6emVdo3N2OZYxZGrhlYlPvBq/iIUijsaFozXIFoL2x8vpUH6V9fJojmqPYRBCS0YYGKyeu43xuDp9i000Q=
X-Received: by 2002:a05:6102:512a:b0:45a:9bb2:d486 with SMTP id
 bm42-20020a056102512a00b0045a9bb2d486mr15090817vsb.15.1698774275249; Tue, 31
 Oct 2023 10:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com> <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
In-Reply-To: <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Oct 2023 19:44:23 +0200
Message-ID: <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 5:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 31 Oct 2023 at 13:31, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Current patch set does not implement "backing inode" for FUSE inode,
>
> What prevents us from storing a fuse_backing reference in fuse_inode
> while the file(s) are open?
>
> AFAICS it just needs a counter in fuse_inode to account the number of
> open instances.
>

The current patches do not enforce that all fuse_file of the same fuse_inod=
e
passthrough to the same backing_file (or same backing inode).

I agree that functionally, we could enforce that, and it may be good for
"backing inode" mapping on lookup going forward
The problem is that at the time of FUSE_DEV_IOC_BACKING_OPEN,
we do not know which fuse_inode is going to be associated with the
fuse_backing object.

v13 patches had a mode that pass nodeid with the fuse_backing_map
request (inode bound mode) and refcount the fuse_backing object
from the fuse_inode (with no backing idr) at the time of the ioctl and
then -EBUSY could be returned for a conflicting backing map request.

The problem with that API was with CREATE of a new nodeid, where
the FUSE_DEV_IOC_BACKING_OPEN ioctl happens before fuse
knows about the new nodeid.

In that case, we would be able to "attach" the fuse_backing object
to fuse_inode on CREATE response. If we end up with a backing map
conflict at this point, we can return -EBUSY error to the user and forget
the inode, but the server would have no easy feedback on its mistake.
Also, -EBUSY to user would be confusing if user did not request O_EXCL.

Do you consider the described "atomic_open conflict" case an API problem?

It is true that with v14 patches that do not enforce backing inode conflict=
s,
the attribute coherency model that I proposed may result in attribute
cache thrashing if the backing inode of a fuse inode is ambiguous.

Do you have an idea how to handle this case elegantly?

Thanks,
Amir.

