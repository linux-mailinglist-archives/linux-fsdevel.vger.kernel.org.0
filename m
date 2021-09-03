Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761203FFA64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbhICGcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 02:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344368AbhICGcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630650676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YC/rlauU/F6bmxF77VH11Mgk4hV/IwCNeLbfbf9xP5Q=;
        b=TOQpwkyAxLvlzLXRWkCbVCeCE5dtwOipp3KfMhTsZZgmgHMxaieBsuxMJzqrnQfcsL6c0N
        huctH7dsYXwGeLBp3QUFM3WJZL2yy5kmqNObe34UxLW044/QGVB8c3PH4JhLTG2UBkmogS
        9cpVbrT35Gfo9TDhAaU5Ue5gIce+bdg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-PkvSdAliMme5IXJuw2LnOg-1; Fri, 03 Sep 2021 02:31:15 -0400
X-MC-Unique: PkvSdAliMme5IXJuw2LnOg-1
Received: by mail-wm1-f69.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so1604521wmj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 23:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YC/rlauU/F6bmxF77VH11Mgk4hV/IwCNeLbfbf9xP5Q=;
        b=ukIbYa9gYDcCw58xSMnpgm3lU7K14MjDKnohCqeeb9C4pGOu5Zx7t0nXx4Os/Ziczw
         UIqe54Ma0CqbJwyzdUh8Fw7/LaqIN+t8+1zNxXVfX0RXqPxVWyYgRreO887HZZHR65Kd
         dgYpi0KdCr5t3FzsBSR3uQk1FzK+jDa1hAE5lNIEVaeELbvSE4yU5tjPH2HYt65hNS0i
         uVx2XJuJvP4Y4ehu9u3izfOYHWC4I8QvLopHxNVuV3/EYLfd1rOKRm7+t7XIQtS22xhW
         QAEtEx96qE6P0tG20ql6dDo0Im9M6mhreTnZbM3sHK8mM6OXUfirG9jYIkzt24HyZDli
         vNnA==
X-Gm-Message-State: AOAM532ALWwAdimYG84YiOTrubVSYhjxdr92G98MkSdvMhuhYvGbm1Y0
        8/EEp1qHNxmRnrblv2J7alSblZLb3S+bGxRxQoPCNHR9dSZo7f1l++R5yWugoH69A7qKI7JmL9J
        ncA/MjgaPKtVcggyB2ZXv79CpjZ5RrDZItuLcBIzlQg==
X-Received: by 2002:adf:d193:: with SMTP id v19mr2009429wrc.377.1630650674699;
        Thu, 02 Sep 2021 23:31:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyPFJw9ZP/m1ileU46mEBJVAfh6Zf+O3xQQjDX0TV+sCc5/OMAl/XmaZX2RmznLFq2omumgxC7UK2vm0m9SxM=
X-Received: by 2002:adf:d193:: with SMTP id v19mr2009383wrc.377.1630650674468;
 Thu, 02 Sep 2021 23:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
In-Reply-To: <YTDyE9wVQQBxS77r@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Sep 2021 08:31:03 +0200
Message-ID: <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> xfstests: generic/062: Do not run on newer kernels
>
> This test has been written with assumption that setting user.* xattrs will
> fail on symlink and special files. When newer kernels support setting
> user.* xattrs on symlink and special files, this test starts failing.

It's actually a good thing that this test case triggers for the kernel
change you're proposing; that change should never be merged. The
user.* namespace is meant for data with the same access permissions as
the file data, and it has been for many years. We may have
applications that assume the existing behavior. In addition, this
change would create backwards compatibility problems for things like
backups.

I'm not convinced that what you're actually proposing (mapping
security.selinux to a different attribute name) actually makes sense,
but that's a question for the selinux folks to decide. Mapping it to a
user.* attribute is definitely wrong though. The modified behavior
would affect anybody, not only users of selinux and/or virtiofs. If
mapping attribute names is actually the right approach, then you need
to look at trusted.* xattrs, which exist specifically for this kind of
purpose. You've noted that trusted.* xattrs aren't supported over nfs.
That's unfortunate, but not an acceptable excuse for messing up user.*
xattrs.

Thanks,
Andreas

