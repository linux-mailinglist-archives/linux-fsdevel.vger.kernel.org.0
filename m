Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9471424D607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHUNST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHUNSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:18:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D11C061386
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:18:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so2210538ejb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ewq1eqi128tS/YtHe1Hdp0zK/pkzPgQy1G+gIZ86vk=;
        b=NU0Mcks72tdUBoRxTtGff5uEDLvy5q+04uOXS/JLA0SJHrmqdiP6jaEKtTvuhKsMgU
         lDfci7M0dnl3iqCTEKGFvbcUksW7F5hk3a91SmK7L3wWBKVmDsI9uP/rUVnGbwAsuDli
         PjLRD2P5KK/Uqcps5LzpvzKRXm9f6EQs1OMtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ewq1eqi128tS/YtHe1Hdp0zK/pkzPgQy1G+gIZ86vk=;
        b=JPMKosq0W1ZmT6HvvEycpBcvFmDVaU9y50/V8VQiFA8MU2i/lcx5bx1rMEf7eEdnKx
         9ZLnr5pZlGKAc/AfYdabzqj+JRqPXPMstMqRMXFtQSJS0+8sXBa/ddr3bH1/yevKTzMU
         JWVyixJ+FOeW85nDGQhgx+IyT8scxPF+DWh07pQdYaInshWra58EQvYH8auri3IE/Stk
         +8VvRmFoxE7PEwADiYbu2Q4U1gETYIufGHaHK2zGYk9gwhl9JvFnGFc6M8svKnzpYxFQ
         X2z6PgvpHJVzjFj2IL59edbQYnuVoFY8maDbdQR6Z6Nbp4K1uBLqECOqZF5hSbvocC0B
         6X1Q==
X-Gm-Message-State: AOAM530ikzfPj2e/dduk/sPk0gVrKoWdCfCljAKWUtQbyqiZrJJc6Uk1
        fQ8Whg4+DF0KlC+z/px0bhv3azzpg/3Knkq1MPMYEg==
X-Google-Smtp-Source: ABdhPJx3TSW7MukTCaIid5gIoeUYGZLVJD0O+yZ7UPk2PTQBJG9g/hYdPVKEFV4KdfwhkvYvNtwBHnp0gKnoaXGmvjM=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr2811015ejb.113.1598015890534;
 Fri, 21 Aug 2020 06:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
 <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
 <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com> <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
In-Reply-To: <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 15:17:59 +0200
Message-ID: <CAJfpegsBSsMkSXReN6Sheye1cksCO2pcqcx_3VwY4C1J9kDhaw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Basically, I think a rough rule of thumb can and should be:
>
>  - stuff that the VFS knows about natively and fully is clearly pretty
> mount-agnostic and generic, and can be represented in whatever
> extended "struct statfs_x" directly.
>
>  - anything that is variable-format and per-fs should be expressed in
> the ASCII buffer
>
> Look at our fancy new fs_context - that's pretty much what it does
> even inside the kernel. Sure, we have "binary" fields there for core
> basic information ("struct dentry *root", but also things like flags
> with MNT_NOSUID), but the configuration stuff is ASCII that the
> filesystem can parse itself.
>
> Exactly because some things are very much specific to some
> filesystems, not generic things.
>
> So we fundamentally already have a mix of "standard FS data" and
> "filesystem-specific options", and it's already basically split that
> way: binary flag fields for the generic stuff, and ASCII text for the
> odd options.

Okay.

Something else:  do we want a separate statmount(2) or is it okay to
mix per-mount and per-sb attributes in the same syscall?

/proc/mounts concatenates mount and sb options (since it copies the
/etc/mtab format)

/proc/self/mountinfo separates per-mount and per-sb data into
different fields at least, but the fields themselves are mixed

If we are introducing completely new interfaces, I think it would make
sense to separate per-mount and per-sb attributes somehow.  Atomicity
arguments don't apply since they have separate locking.  And we
already have separate interfaces for configuring them...

Thanks,
Miklos
