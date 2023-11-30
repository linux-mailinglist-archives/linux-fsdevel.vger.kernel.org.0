Return-Path: <linux-fsdevel+bounces-4463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED527FF9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47DDB20C07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D25917D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVbGBpa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB690
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:18:38 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a338dfca7so7127066d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364718; x=1701969518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AppN1AuZcLF7Tm6nTZxrYUCsLPbnwfYqu6ZiXuAdp7M=;
        b=GVbGBpa8nJ/Dxkagh04XrUhI9Q3kBN+13dDTXDLJKl3NkVyJvhR2bt7Zeu6FM/HDUj
         ovk5NadwIINNk8ruiY3tspPogfc59KxYXsGOWpJPB+yM/YEaKVfpgAurm1ApEQWMrjsE
         5ADkaxfBnACd6zO9gkvNcS6hkac2I0axsG2j5plxiEppoCJm4COEygCsZWrmrAuKwwkp
         SdCoopZRNnTwyekNhdqJv9rKCB2NWJ7z5EgN6FUOtArlWrjmO+9RWxWQk6443jnqgEGp
         279KvoP0LHHjDFWzxPXVx9wCmvPprBKQG0K7Wq+LaeIGchi0fXTHp6bnGoboXp/NF1cR
         ulmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364718; x=1701969518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AppN1AuZcLF7Tm6nTZxrYUCsLPbnwfYqu6ZiXuAdp7M=;
        b=JYVHMbvzEjZ320On8lTkhPSOMOwLOCCv5WzvVsidS4FXiEeuxpyugOzs6lD6+sUidk
         iyWa17mImVcaWBFhwKMTgMt6qzoocTcEmXrwDxJA83Qdcow7dxXuW+ljGgjPURHLejs0
         sfK9Q4xMaDmcrAE/6MMg6HtHGtVxzN4YmovoTrHDr689ULpCfz+2tu6z7y1pY1lQZhjI
         6es5cqEP05/MRS2jMhiWQBJEap5nVxZeekvJQWblp5yQOILjCgBkmczVkCa0yb1Og9XK
         tczdOogKoa7FPOlS7UsUTeoZK7/JG5h4WdDo8LiojBblO1CU3KfTx0ijBcOzmooO7NZx
         QXyg==
X-Gm-Message-State: AOJu0YyUyEZ2DE5uSRf9Zh+g70xvoCbymAlyRuvPOQKl+EcYMUU/RcJ5
	KJkGEk19Qu4IfDXdq1vvQImMhyda8B6CyRVhWw0=
X-Google-Smtp-Source: AGHT+IE83YgWCJJYpHLc/T9yRVt1WciQchJ9q1Y+C+KQjfw97vFNdr5QHDQRqnpm15T5Xi0cgWXC9+TGcJ/SZwbC0Ic=
X-Received: by 2002:ad4:5894:0:b0:67a:1e5e:f600 with SMTP id
 dz20-20020ad45894000000b0067a1e5ef600mr20940782qvb.31.1701364718043; Thu, 30
 Nov 2023 09:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130165619.3386452-1-amir73il@gmail.com> <20231130165619.3386452-3-amir73il@gmail.com>
 <20231130171216.qrrtlitprrkrbt54@quack3>
In-Reply-To: <20231130171216.qrrtlitprrkrbt54@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 19:18:26 +0200
Message-ID: <CAOQ4uxgJAZ3z5pgbfH+hNGj1G9EWQxQ4Hz4h+9X0xTktdiqsWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 7:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 30-11-23 18:56:19, Amir Goldstein wrote:
> > So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> > on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> > non-uniform fsid (e.g. btrfs non-root subvol).
> >
> > When group is watching inodes all from the same filesystem (or subvol),
> > allow adding inode marks with "weak" fsid, because there is no ambiguit=
y
> > regarding which filesystem reports the event.
> >
> > The first mark added to a group determines if this group is single or
> > multi filesystem, depending on the fsid at the path of the added mark.
> >
> > If the first mark added has a "strong" fsid, marks with "weak" fsid
> > cannot be added and vice versa.
> >
> > If the first mark added has a "weak" fsid, following marks must have
> > the same "weak" fsid and the same sb as the first mark.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Yep, this is good. Can you please repost the whole series so that b4 can
> easily pick it up from the list ;)? Thanks!

hmm. I posted all but they did not hit the list :-/
now reposted.

Thanks,
Amir.

