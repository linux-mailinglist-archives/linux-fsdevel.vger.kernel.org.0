Return-Path: <linux-fsdevel+bounces-1630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7227DCB9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C9B20F98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56D19BB9;
	Tue, 31 Oct 2023 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EzR+23Af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB412B79
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:17:12 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A1C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 04:17:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d242846194so384904566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698751027; x=1699355827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sVfdiIkLT3zi+9iU81uddDEF/A3tmazpchZ1K8++R6o=;
        b=EzR+23AfrSgXvUv6UneLo1XUr5aC8dts+U+3kYmxyuBs+bIsRpSR7f1SdzOD7nSaTJ
         PmQ+QGiYEAd/fVtrpgYuipnvs1HmZp7MufrYqy92lPl2rVixZsLyH5ZWxr52CAcXSo8h
         kMkybtfb+SQPL9p1yHlPHxODZ1NeGK2aJvPKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751027; x=1699355827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVfdiIkLT3zi+9iU81uddDEF/A3tmazpchZ1K8++R6o=;
        b=XBEkSabObXHUREgbBZHj1akLdVqgZpSSozc3OhkV57GP/H0k/sF5aCM0bj65n/ZRlB
         zFUM67UZeICBx0iLXHjyel7wKSXP0+4iTEHXQc6stVoWzgH8PpKGIhCIfq+GpKVMPd8w
         DHSN0JBa9lCFrjpY9wjadmctNhXijU22z6pP9Zaq/AeHNEDh4VWjnL5h90IibXBmx+RF
         N2Zj7LTxesFhwJig4+XX9eelcJrv50Y/ID+K/hINWt9h34kCp2JIfm7991v23HOJXgMb
         6qhaNrfQLmOITha/xjjEjStoYTmuAX/aoIMmQT2BUghSNDc2Q+pjw8FiC1rKY0ajo1iJ
         bO7g==
X-Gm-Message-State: AOJu0YyPXhb5HKgf91tKCZmN6YBOXBrFYtPIErm+9MtTzWQwmV4b11xX
	uGjGUQjF6Wj6WoMPugSJXeJhScrvLgOyRXK9XfYvXPvGF5bi+/FTCkI=
X-Google-Smtp-Source: AGHT+IEXSkqmo15SNBopPwrja2RYNaNL3NQg7/Wrt6Y/fHwiDspbDWIsFZCcGpbfbMf2GDJ3QE7J3U/8s5MXpDlrH/s=
X-Received: by 2002:a17:906:da82:b0:9b2:a96c:9290 with SMTP id
 xh2-20020a170906da8200b009b2a96c9290mr11324248ejb.33.1698751027162; Tue, 31
 Oct 2023 04:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com> <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 31 Oct 2023 12:16:55 +0100
Message-ID: <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Oct 2023 at 11:28, Amir Goldstein <amir73il@gmail.com> wrote:

> These tests do not do msync.
>
> Specifically, test generic/080 encodes an expectation that
> c/mtime will be changed for mmaped write following mmaped read.
> Not sure where this expectation is coming from?

Probably because "update on first store" is the de-facto standard on
linux (filemap_page_mkwrite -> file_update_time).

Thinking about it, the POSIX text is a bit sloppy, I think this is
what it wanted to say:

"The last data modification and last file status change timestamps of
a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
for update at some point in the interval between the _first_ write reference to
the mapped region _since_the_last_msync()_ call and the next call to msync()
..."

Otherwise the linux behavior would be non-conforming.

> I was thinking about a cache coherency model for FUSE passthough:
> At any given point, if we have access to a backing file, we can compare
> the backing file's inode timestamps with those of the FUSE inode.

Yes, that makes sense as long as there's a 1:1 mapping between backing
files and backed files.

It's not the case for e.g. a blockdev backed fs.   But current
patchset doesn't support that mode yet, so I don't think we need to
care now.

> If the timestamps differ, we do not copy them over to FUSE inode,
> as overlayfs does, but we invalidate the FUSE attribute cache.
> We can perform this checkup on open() release() flush() fsync()
> and at other points, such as munmap() instead of unconditionally
> invalidating attribute cache.

This check can be done directly in  fuse_update_get_attr(), no?

> I already used tha model for atime update:
>
>        /* Mimic atime update policy of backing inode, not the actual value */
>        if (!timespec64_equal(&backing_inode->i_atime, &inode->i_atime))
>                fuse_invalidate_atime(inode);
>
> Do you think that can work?
> Do you think that the server should be able to configure this behavior
> or we can do it by default?

I think this can be the default, and as we generalize the passthrough
behavior we'll add the necessary controls.

Thanks,
Miklos


>
> Thanks,
> Amir.

