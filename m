Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD94433D4E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 14:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhCPNe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 09:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235168AbhCPNe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615901666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qsZp7LXWaBY+H8++2RS+SfFIIpxcaTd9KVwPrknSik=;
        b=i7jgCh6YG2zD9CRBr0VTSC2vHjXRGUNju80dplNdxVf4idmCwHELruTlorroo4UEvU3P2j
        fQasM8z2IiHuUHJCvicMn6vf6RHfXxledhTO2yDNzphf2q6LDIlgeMfUSwhV13ObNotzjz
        daC2sMuuPKQAx025DI5CA64HOUb+2R8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-FxmKUzxCNB-KG9hEfNPg9Q-1; Tue, 16 Mar 2021 09:34:24 -0400
X-MC-Unique: FxmKUzxCNB-KG9hEfNPg9Q-1
Received: by mail-qk1-f198.google.com with SMTP id c1so26893918qke.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 06:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qsZp7LXWaBY+H8++2RS+SfFIIpxcaTd9KVwPrknSik=;
        b=P4j5ajzGTvsSyyytCxxQk40zRKPmb/Xi5B7W8gG6rjxj8ry5Qtuhp4I4K8fqhipu6g
         wre6L1FoLzI5NZ4CdQ8y4nqjufZNg4VJatqxzuMG0ACchFps9kkzaP/Rh+h6cjqZYSza
         54SK+14CF6Rdf6VqsWZFYOTm3X1tj+pqm/ube1nt+4ODxQf+pOwKdbWmtfqTzEd6JTCU
         nXH44qARszWHOVfuqmMLLVh+QNbBnkeCpsXFO5SgTbG58kgg67VqXsSP5mYw21fkktUN
         lgCd52i7CYHQnLKDbuipV7C/d0X6Hcq5gvUsGnQUgXtTF9OkpwWU8FlVh+nIiuJfkKdp
         cB6w==
X-Gm-Message-State: AOAM532zfc7rV6VPs3xzUS/ZPhJuoP5RR+MBiT8uLILdXK/6o6ZFXHoZ
        A668P1uLbxpXgpyAIEGL9yiEnHwgmE9ZrB5uJwU1l0bhvWh0J9LAhfFCr8I7KF/D6TkNolhhwLr
        VQjW/ikfgaCKsTadT+gNicgsNaY7tQcSp5nBo8ROAUg==
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr30569546qkn.273.1615901663859;
        Tue, 16 Mar 2021 06:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3DrhbmsxXsgIuAdzsotUcohvmnKhYA7SkeDPB2MuyE7tJXTxEatmLsdOEvpz9QAKgq+TwBuGA6j7gVgcJWfY=
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr30569526qkn.273.1615901663610;
 Tue, 16 Mar 2021 06:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210302124926.2637908-1-mszeredi@redhat.com>
In-Reply-To: <20210302124926.2637908-1-mszeredi@redhat.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 16 Mar 2021 14:34:11 +0100
Message-ID: <CAOssrKecSV4NSf7w-4+8keSLZBgyQ0=BjFowi4SpiKOGtYR6EA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: add miscattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 1:49 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Hi Al,
>
> Would you mind taking a look?
>
> Git tree for complete series rebased on v5.12-rc1 can be found at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#miscattr_v2
>
> Thanks,
> Miklos
>
> ---
> From: Miklos Szeredi <mszeredi@redhat.com>
> Date: Tue, 2 Mar 2021 13:38:22 +0100
> Subject: vfs: add miscattr ops
>
> There's a substantial amount of boilerplate in filesystems handling
> FS_IOC_[GS]ETFLAGS/ FS_IOC_FS[GS]ETXATTR ioctls.
>
> Also due to userspace buffers being involved in the ioctl API this is
> difficult to stack, as shown by overlayfs issues related to these ioctls.
>
> Introduce a new internal API named "miscattr" (fsxattr can be confused with
> xattr, xflags is inappropriate, since this is more than just flags).
>
> There's significant overlap between flags and xflags and this API handles
> the conversions automatically, so filesystems may choose which one to use.
>
> In ->miscattr_get() a hint is provided to the filesystem whether flags or
> xattr are being requested by userspace, but in this series this hint is
> ignored by all filesystems, since generating all the attributes is cheap.
>
> If a filesystem doesn't implemement the miscattr API, just fall back to
> f_op->ioctl().  When all filesystems are converted, the fallback can be
> removed.
>
> 32bit compat ioctls are now handled by the generic code as well.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Ping?

Thanks,
Miklos

