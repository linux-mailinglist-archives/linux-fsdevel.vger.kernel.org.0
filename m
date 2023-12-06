Return-Path: <linux-fsdevel+bounces-4959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996F806C09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B009CB208B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087FE2DF65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g2W71uwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9D11F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 01:38:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so1341589a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701855538; x=1702460338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYZysdNMtlf+ieWkrppbfc337y9v9xlVK3DBQvAcSIY=;
        b=g2W71uwH6FU5oarCBKV9hIgmDC+dtVwEaG7wRE6OjYsdQirveXvNUAk094Re6x7SiO
         F8+HyrbNglcdin/GgKQbi2U71Ijf7NlflKwnKqvzvTpR1MKj4Tcg4/qpk3iZAPxOwUKL
         eozChQ39O/HTRHrE6s37g2H8TQFrzWE3Qx6Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855538; x=1702460338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYZysdNMtlf+ieWkrppbfc337y9v9xlVK3DBQvAcSIY=;
        b=BwwEH2T3Irbd0gH1529aZ4ewOkKm7fLeIW01OLJDEGX5LOmqaVjBosbr5b1ZEulmEv
         l+i0ioybzwJvc80UgT32r2a+WfASAplMR7Un8c8DRgPLz5swxp7q7v77rIkkOMUGz4Zv
         sSxpuQx1PMcjAe7f5qZuLQBUyGcGtnnCh5Ge4CPSaTRdeo7YuyvZuINIgxpF42PpPA9M
         e5OizPRmDk2hSvAhXWl40qJLBgfl9iovLFP52I/novf5KjCmU6WsyxuG5VvKgBtvCnTh
         6ZXmU5SvuB+W15KslMuQgO6jn23ioe81ZfqMhHrkoAD5dYKbpM0uHNjykQEh1BtwIZ35
         U7rw==
X-Gm-Message-State: AOJu0YyFW1BkXlftuSeEAKBmUd9ujMu7e0rDbAcJQaEhM2sXhehgLjZp
	CMv6Hqme9Ip0DJPvVNXETnDvQYFdEumJ4tq5LGXkGQ==
X-Google-Smtp-Source: AGHT+IHSxvjRmB4cOovZ8zqailwQcKq2WgClq7BAg4fC+QzkCYf4/VTwy9T7yn0SG0TpBYhxxOFAyiQTPtWxdweaBbE=
X-Received: by 2002:a17:906:bc95:b0:a19:a409:37ed with SMTP id
 lv21-20020a170906bc9500b00a19a40937edmr2458398ejb.70.1701855533199; Wed, 06
 Dec 2023 01:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
 <20231205175117.686780-1-mattlloydhouse@gmail.com>
In-Reply-To: <20231205175117.686780-1-mattlloydhouse@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Dec 2023 10:38:41 +0100
Message-ID: <CAJfpegvUWH9uncnxWj50o7p9WGWgV3BL2=EnqKY28S=4J4ywHw@mail.gmail.com>
Subject: Re: [RFC] proposed libc interface and man page for listmount
To: Matthew House <mattlloydhouse@gmail.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 18:51, Matthew House <mattlloydhouse@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 11:28 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Attaching the proposed man page for listing mounts (based on the new
> > listmount() syscall).
> >
> > The raw interface is:
> >
> >        syscall(__NR_listmount, const struct mnt_id_req __user *, req,
> >                   u64 __user *, buf, size_t, bufsize, unsigned int, flags);
> >
> > The proposed libc API is.
> >
> >        struct listmount *listmount_start(uint64_t mnt_id, unsigned int flags);
> >        uint64_t listmount_next(struct listmount *lm);
> >        void listmount_end(struct listmount *lm);
> >
> > I'm on the opinion that no wrapper is needed for the raw syscall, just
> > like there isn't one for getdents(2).
> >
> > Comments?
>
> One use case I've been thinking of involves inspecting the mount list
> between syscall(__NR_clone3) and _exit(), so it has to be async-signal-
> safe. It would be nice if there were a libc wrapper that accepted a user-
> provided buffer and was async-signal-safe, so that I wouldn't have to add
> yet another syscall wrapper and redefine the kernel types just for this
> use case. (I can't trust the libc not to make its own funny versions of the
> types' layouts for its own ends.)

You can just #include <linux/mount.h> directly.

Thanks,
Miklos

