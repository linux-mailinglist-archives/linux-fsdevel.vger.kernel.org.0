Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04AD79E69E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbjIMLY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbjIMLYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:24:53 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5719B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 04:24:49 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a754db0fbcso2318721241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694604288; x=1695209088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VHxmzp9QWHIArD2/rI8I+K3gfyVh4UD9rKM0tXdhT0=;
        b=BDCAIiIL4+i5Yq+HWu9KlPnqecW+YFBuk6X7UIAX/D67cwcXoAIaZhSsKawHRE0g+0
         uxliGhD8tH6Bou61SawZ8tE4mQ3eze1Mb0dwSnHAEs5wmZErpBDh/mT/SfXhr1+Jo13b
         JKAfYU2OrtJX+ZWJ8E5kZKqOjd+qTqnGce4BJA/QX1ATl6tMXYFqZrZWrWzfmXkp83PP
         DGx7XPwzwBiLfYO84tIZt7XgqJZRvthVZOLgjC6Tx6EVjKonIGxiDJ1K4sbzKKE0O9Zi
         6MwsIJ4D94nKt3ozxheRsw80jipqcyQe2f1pr1CkZnqdFvEmUrg95d3gor2Sxt2LvuNG
         Bdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604288; x=1695209088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VHxmzp9QWHIArD2/rI8I+K3gfyVh4UD9rKM0tXdhT0=;
        b=CFeDsXfDqLVNYu/HfywtIEMTz/Djp6w/4kLpuOESeJ94PjPOL2LVQ8yi8nm3nUhHzW
         ntNURikx8hfSaw9culSzy/qm6HPWIEhPps2SMiT+hUMat1vi5aa5LZniEzRraAijgn76
         /7HKKOv7Hg2mfRKwt8tHGmsLxapEhrxjOb7E955Nz8LI3Nw7xmdjkSbPROpbuEV1t/fH
         4q6/2Yt3qQ5dIM8SGD81EvMNWsTgQupYaNB6KbJa2gDyU+F9eI72tT8r0WbRlaEdaMbV
         L4OXj6aKFjlETIzXJP5nJefv+4OjZoJ6IOy+dL2AawMeh4LYOIhwSqsmQYg7sn2qVDaF
         YmmQ==
X-Gm-Message-State: AOJu0Yyn9UR9n6hP9EG8PThPCzZpkp6/iCW/H2p72fzzfbNDys9AZSUL
        UPelcmqEiTih3J5SxD/PotuIRV7gVPaoxkIVnug=
X-Google-Smtp-Source: AGHT+IHMmZyT6oFf73CZxlr68gX8HglUfbwljBa07Sj4e2zkENBVk8/3DRUYVgthQYXIk4JT1pz7QqKtZ5Dg7Y5G/XI=
X-Received: by 2002:a67:b342:0:b0:44d:50f0:f43e with SMTP id
 b2-20020a67b342000000b0044d50f0f43emr1835351vsm.30.1694604288169; Wed, 13 Sep
 2023 04:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com> <20230913-galaxie-irrfahrt-a815cf10ebdc@brauner>
In-Reply-To: <20230913-galaxie-irrfahrt-a815cf10ebdc@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 14:24:36 +0300
Message-ID: <CAOQ4uxgta6y7fi_hfrF4fDvHA2RjeA+JTCb-eSaORZOY6XZbVQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Sep 12, 2023 at 09:54:08PM +0300, Amir Goldstein wrote:
> > Overlayfs stores its files data in backing files on other filesystems.
> >
> > Factor out some common helpers to perform io to backing files, that wil=
l
> > later be reused by fuse passthrough code.
> >
> > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BB=
WwRFEAUgnUcQ@mail.gmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > This is the re-factoring that you suggested in the FUSE passthrough
> > patches discussion linked above.
> >
> > This patch is based on the overlayfs prep patch set I just posted [1].
> >
> > Although overlayfs currently is the only user of these backing file
> > helpers, I am sending this patch to a wider audience in case other
> > filesystem developers want to comment on the abstraction.
> >
> > We could perhaps later considering moving backing_file_open() helper
> > and related code to backing_file.c.
> >
> > In any case, if there are no objections, I plan to queue this work
> > for 6.7 via the overlayfs tree.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-amir=
73il@gmail.com/
> >
> >
> >  MAINTAINERS                  |   2 +
> >  fs/Kconfig                   |   4 +
> >  fs/Makefile                  |   1 +
> >  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++++
>
> I'm sorry but I'm missing mountains of context.
> How is that related to the backing file stuff exactly?
> The backing file stuff has this unpleasant
>
> file->f_inode =3D=3D real_inode !=3D file->f_path->dentry->d_inode
>
> that we all agree is something we really don't like. Is FUSE trying to
> do the same thing and build an read_iter/write_iter abstraction around
> it? I really really hope that's not the case.

That is not the case.
The commonality between FUSE passthrough and overlayfs is that
a "virtual" file (i.e. ovl/fuse), which has no backing blockdev of its own
"forwards" the io requests to a backing file on another filesystem.

The name "backing file" is therefore a pretty accurate description
for both cases. HOWEVER, FUSE does not need to use the
backing_file struct to hold an alternative path, so FUSE backing files
do not have FMODE_BACKING, same as cachefiles uses backing
files, but does not use the FMODE_BACKING/file_backing struct.

Yes, it's a bit of a naming mess.
I don't have any good ideas on how to do better naming.
Ideally, we will get rid of struct backing_file, so we won't need
to care about the confusing names...

>
> And why are we rushing this to a VFS API? This should be part of the
> FUSE series that make it necessary to hoist into the VFS not in
> overlayfs work that prematurely moves this into the VFS.

Fair enough, I will not rush this patch and will post it
along with the FUSE passthrough patches.

I posted it because I wanted to get early feedback - mission accomplished :=
)
In retrospect, I should have labeled it [RFC].

Thanks,
Amir.
