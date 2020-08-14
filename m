Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD824447A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgHNFUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 01:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNFUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:20:47 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8297C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 22:20:46 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id g3so4594391ybc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg14DGUUTv8H89VUwzRZsbktcbP23wgUdWgjdUjfNQA=;
        b=dEX2+30aTsCAIysXdZvVJFU14uPr90OtNVrO7vOwLZJuVg1Ttkl0JjOa26DSWWRwVg
         RQhMmdjxeyMFgAAr8jTCR/nr0nymCith0gbs8dQEcNH/6YjiuFULZrdElioNOkJDXGli
         DcxQskqpumXcVMzbfls6BcagbkAcAO6FTBBX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg14DGUUTv8H89VUwzRZsbktcbP23wgUdWgjdUjfNQA=;
        b=tNBicI+EMHvFUhorWYziwtbQTx/GAoRD/Pzm2B/j7HwtEfMJCBMWuhlXfiXhV4bQIS
         N5qVS0w6fJoGvGdEYs6CYW/oKUAQt+nCjZL3590r+sHL8medhaEwvpw/g8sl5nDEsAUo
         IbJyhiUCmSm4c8Jjdc42fUuc6vA3a00eoIz2uUurcPFcB1FOCWDl3Sjtp3Mi4XQF0CCC
         Mbv7ii1c2ZxWxZzZKnjeuQgIfI/Z0Y4//sxVC2Zun79FWfdRU7qEwztqeSRrt1BWQNxq
         51LADVJrEMqTyJfo2n/9r68cPDPuWuF66lE+7bePDKrhPKieJkrXQ5t5HXX7YmJyBF8i
         Wyig==
X-Gm-Message-State: AOAM530yDVdBnibZM2L5qRxOr68yLVdkneY1MwXwymR8IJbHLVjNQY7m
        TKf3Nm+uBZRmL7KaSWYm1WBA5+osJjnB4Hwo3CtyXA==
X-Google-Smtp-Source: ABdhPJwigPM0o0HjqNk8MMoz9/OzJtfdk0Bfx2IUg4eJu0bnhsOEMQPPceOziV2L0FeFk2j4jIrWVKN0LZs1bVNNoJU=
X-Received: by 2002:a25:5d7:: with SMTP id 206mr1586353ybf.512.1597382445205;
 Thu, 13 Aug 2020 22:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200722090758.3221812-1-chirantan@chromium.org>
In-Reply-To: <20200722090758.3221812-1-chirantan@chromium.org>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 14 Aug 2020 14:20:33 +0900
Message-ID: <CAJFHJrr+B=xszNvdkmksG5ULPy_nKpn4_MS9_Pnq6ySkkb5y6g@mail.gmail.com>
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 6:09 PM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> fuse_init_out struct.  When this flag is set the kernel will append the
> security context for a newly created inode to the request (create,
> mkdir, mknod, and symlink).  The server is responsible for ensuring that
> the inode appears atomically with the requested security context.
>
> For example, if the server is backed by a "real" linux file system then
> it can write the security context value to
> /proc/thread-self/attr/fscreate before making the syscall to create the
> inode.
>

Friendly ping. Will this (and the next patch in the series) be merged into 5.9?

Chirantan


Chirantan
