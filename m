Return-Path: <linux-fsdevel+bounces-1534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85397DB7AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4242814FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605A10A39;
	Mon, 30 Oct 2023 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ikef2hso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835D379
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:17:02 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFB30CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 03:16:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c3aec5f326so1124748566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698661018; x=1699265818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AThZyGO6UG20hmjHcpACaf8i+znXal5Y8kmwc7kkktQ=;
        b=Ikef2hsolRHbAopLeUoyRZERha0ByCvzxydECzx05Mk4FCsjrpD5h6Sc7Xvz5XjKU5
         OEcQpV69Z16e+ZQRgRjXdjS2ehce/3Fbj469hnr53OUb1iJ1naYFOw2y/K6zeg5XzSEb
         evw7zMvmdayyF6DwG9IJ4Jk9p9M/FH4yZdIeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661018; x=1699265818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AThZyGO6UG20hmjHcpACaf8i+znXal5Y8kmwc7kkktQ=;
        b=BE1A5ah8yheIdH22S4uOkB+LObJl4Kx5moQKup4fuO0mjtKJlossVotJzgXDEMtBNv
         5ZUz6V0JtrcPePMpHGKTKdQPOC9MM5TGLDYhNFLhAyYfLBbiJZR72Pkba4eayzg8Idi6
         AlogrJwbEAqFKK9AkKohsKiN3jBKfnaOvrVLGX1qIahVfRg/sCR/8IiQ7iqDEtYn6VG7
         m20mSPhfycrQfp2fd6JJfInsJOyh7Rb85KFNMKb6DtF3nbzULI14G32TiNCoNY+8zIFK
         f8+j7VkZnO6APNTonal72+YCqEm3M6JyvPgRI3eG1FtHWPBohDgy+/HQiATPRwCyOQ1L
         rXgg==
X-Gm-Message-State: AOJu0YwJ+9DTTtXHseuqrxPPYVbUg71BeiSqCQK3zfizWU7OvAoKCz5c
	kTfUgXb469VJuNCCKQgW6CuAqbrFVY2iWq03A5FKBg==
X-Google-Smtp-Source: AGHT+IFjFiqYa075j+WRuX8k36PDoTVqgoa+OQv8/JcQndPEhCd0z3tvTVL3+CF3LXq1dHiEIuxEOYsswiC3HRDedwY=
X-Received: by 2002:a17:907:1c2a:b0:9bd:bdfd:e17a with SMTP id
 nc42-20020a1709071c2a00b009bdbdfde17amr9013118ejc.6.1698661017674; Mon, 30
 Oct 2023 03:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Oct 2023 11:16:46 +0100
Message-ID: <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 16:33, Amir Goldstein <amir73il@gmail.com> wrote:

> generic/120 tests -o noatime and fails because atime is
> updated (on the backing file).
> This is a general FUSE issue and passthrough_hp --nocache fails
> the same test (i.e. it only passed because of attribute cache).
>
> generic/080, generic/215 both test for c/mtime updates after mapped writes.
> It is not surprising that backing file passthrough fails these tests -
> there is no "passthrough getattr" like overlayfs and there is no opportunity
> to invalidate the FUSE inode attribute cache.

This is what POSIX has to say:

"The last data modification and last file status change timestamps of
a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
for update at some point in the interval between a write reference to
the mapped region and the next call to msync() with MS_ASYNC or
MS_SYNC for that portion of the file by any process. If there is no
such call and if the underlying file is modified as a result of a
write reference, then these timestamps shall be marked for update at
some time after the write reference."

Not sure if the test is doing msync(), but invalidating cached c/mtime
on msync() shouldn't be too hard (msync -> fsync).

While the standard doesn't seem to require updating c/mtime on
mumap(2) if there was a modification, that might also make sense in
practice.

Thanks,
Miklos

