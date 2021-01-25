Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB61E30348E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbhAZFYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbhAYNrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611582374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+lH4jVBEWj7kNZTyZRP0Sg2RcVoDFoIqR+KnfPse8w=;
        b=goYoFKQ/okxvkDzt2zaxlGqdBERdbYKtbGZFxg37AYXPfDu/9o4PVe3qkv9GLfOumgabCx
        E3z4U0AkswkBSk893QUKTl9+UszkcxlgZmy3xc1Z84tF7za6Xqh3lrXjxOrxgIfqSOTKE1
        3kbv6JoQv9Bq0mvgKveviqda9RCi53U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-UCAtyKdnO0u2_s30JU6Wgw-1; Mon, 25 Jan 2021 08:46:12 -0500
X-MC-Unique: UCAtyKdnO0u2_s30JU6Wgw-1
Received: by mail-qv1-f71.google.com with SMTP id z8so7028538qva.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 05:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+lH4jVBEWj7kNZTyZRP0Sg2RcVoDFoIqR+KnfPse8w=;
        b=pzMcpUvWtW4VOsS0Lilnpk/kKEYi5My9rfIAJ3BuPFyZQpDWuk8mCn0fV9bCN6Y6vC
         NDrl/C8Et5rq8HHdM3EwrPuFmqDf0WcFAGdoIZYCjPXPWw5wu4Z+Ef0QzJpklu3njE+W
         YfNZ///ATVQeZ8O4A+jJOvoRtE2s/TfWCf2eTWEUkQsg1c7RcTouObNJflqMuMFE5fIz
         Z/gekJY71rnIEKsMOutfBkzLbU+eft2cwCr8HNSRT8D3Pm/llwDyJCY5gHE5pYa+bTTQ
         4I18e9t/agg2oz4bOqZlbskrYB3QLnbvzqQFstgN+HMFOVoYnj3YctnxZ8G4RdHSGymH
         bImg==
X-Gm-Message-State: AOAM5307mdt2UynQ+gRsnd3ZyBegKc5fTpT6WYmPYEclugGXOKh+U2hb
        GHRg69Nf9U7QLPYz2TQ+sTS2LZzWphJFTpoD1WabIGesFM2oQDxDTJEFFI6wsT2gMRVUd7FXf6g
        xHZFATY/rCMf6G9p7eMqJILZlyZNNxWuircI79CWEig==
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr708437qkn.273.1611582372374;
        Mon, 25 Jan 2021 05:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGFrUDAGOGavT1DgCTfWNXl/5gNkCr9sSWhUA52UIjWH/BAh3BdpRyQaPXiC8jDJV9kH2sQ3NHpmwBPpiZwxY=
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr708419qkn.273.1611582372176;
 Mon, 25 Jan 2021 05:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <20210122183141.GB81247@sequoia> <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
In-Reply-To: <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 25 Jan 2021 14:46:01 +0100
Message-ID: <CAOssrKd04WaFjM1=qyUVnxwM9k_4Mc=OvvuCeN9HvYJnq91wWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     Tyler Hicks <code@tyhicks.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 2:25 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Fri, Jan 22, 2021 at 7:31 PM Tyler Hicks <code@tyhicks.com> wrote:
> >
> > On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> > > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > > filesystems (overlayfs and ecryptfs) into account.
> > >
> > > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Thanks for sending a fix!
> >
> > I know that you don't have an eCryptfs setup to test with but I'm at a
> > loss about how to test this from the userns/fscaps side of things. Do
> > you have a sequence of unshare/setcap/getcap commands that I can run on
> > a file inside of an eCryptfs mount to verify that the bug exists after
> > 7c03e2cda4a5 and then again to verify that this patch fixes the bug?
>
> You need two terminals:
> $ = <USER>
> # = root
>
> $ unshare -Um
> $ echo $$
> <PID>
> # echo "0 1000 1" > uid_map

NOTE:  <USER> is assumed to have uid=1000, so this and following
"1000" values need to be fixed up if it's not the case.

Thanks,
Miklos

