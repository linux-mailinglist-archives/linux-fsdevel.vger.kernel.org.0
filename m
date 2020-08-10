Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D6240AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHJQKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHJQKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:10:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBAC061756;
        Mon, 10 Aug 2020 09:10:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so3690316ioe.5;
        Mon, 10 Aug 2020 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ80cO9LgIseSA6VcNmJzpLJOqoglGp0soH8ddcaoxk=;
        b=EcS/NmAZLLY7RIcl1zkSH3YoNOu5TYUBfe6QqC6ForXpE8Diy77syyyGuwCHiceu2A
         UQSMSPKjBXDI9UgCB2mREaVFuyYXSISzKUWCvjknG+/u7WVvDGaspds8ll8DnLyKWa9I
         atLadaVEYzMJaqN1yHE0J7IYgy5C2qsh/zo6r0EmXPnm6kHJBKtTISYxRYZzhT1R5W7o
         dKZXiPgJjBmvU5RIBadNZ2EuZx/OHmI9Ftbs6agUxa+kxejtMDbGCSifUzQHFZWkUZIL
         7sQoJswBBvwLnAz44vZNgNdSmNu0UDEo1x0sF8zPp+TdjT843E9ofRjzTut8B1feGj04
         6VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ80cO9LgIseSA6VcNmJzpLJOqoglGp0soH8ddcaoxk=;
        b=b3yfArxgYA+yBfeyVwdLmUoCrp8XXJ48oVO7qkf8RgOCt5Jw07M+GPwl1GG5TIolBZ
         EujyGlJeknnTjuH7XpfiZCjmFJNwjPAf8EsSVYffr3D7lCcolqPfMwIfWMIOf1QY1A/T
         0e2MStfpD8qu1Ujym//j+gLFWs+y50/5XUZvHxmp9xAJl5JXnpyHTH5BdPgkLNb4h6Ep
         qPrCpgH7TU0ldr2tcVkfq8EqmYEBc6TAiMz1FrzBJfgI/JsQHIJe/cDfbuvJ8FzD4k8X
         wvyhROyIySO4Zmpj05sGEu+LLaOrJBr+ivuDyl/NnxktE20/ce8akCKwWgB9UpbFREqr
         hRTg==
X-Gm-Message-State: AOAM530/tGqTGCXNPKjH68kN/K9fe/T/5hWP+hyo5WCKW9CUTltAgkhR
        W7g2vgUtf6xbHg3ld4lqx/In5bsuWf1iw0lXWOM=
X-Google-Smtp-Source: ABdhPJyTY4QlAr8BTih462f1lgyS9bJi/R2Ew8ZaVjmxeOvg71SlD2qbh1tJxbs+xTPFWT+NxUm+fxwz6XlvyZjiHMI=
X-Received: by 2002:a05:6638:bd1:: with SMTP id g17mr20966062jad.132.1597075803972;
 Mon, 10 Aug 2020 09:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <447452.1596109876@warthog.procyon.org.uk> <1851200.1596472222@warthog.procyon.org.uk>
 <667820.1597072619@warthog.procyon.org.uk> <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
 <672169.1597074488@warthog.procyon.org.uk>
In-Reply-To: <672169.1597074488@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Aug 2020 11:09:53 -0500
Message-ID: <CAH2r5msO+N9dXKtYE3p+EfXaZTtqp6r=Bsx5vKdTdxe7XBBeOw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:48 AM David Howells <dhowells@redhat.com> wrote:
>
> Steve French <smfrench@gmail.com> wrote:
>
> > cifs.ko also can set rsize quite small (even 1K for example, although
> > that will be more than 10x slower than the default 4MB so hopefully no
> > one is crazy enough to do that).
>
> You can set rsize < PAGE_SIZE?

I have never seen anyone do it and it would be crazy to set it so
small (would hurt
performance a lot and cause extra work on client and server) but yes
it can be set
very small. Apparently NFS can also set rsize to 1K as well (see
https://linux.die.net/man/5/nfs)

I don't mind adding a minimum rsize check for cifs.ko (preventing a
user from setting
rsize below page size for example) if there is a precedent for this in
other fs or
bug that it would cause.   In general my informal perf measurements showed
slight advantages to all servers with larger rsizes up to 4MB (thus
cifs client will
negotiate 4MB by default even if server supports larger), but
overriding rsize (larger)
on mount by having the user setting rsize to 8MB on mount could help
perf to some
servers. I am hoping we can figure out a way to automatically
determine when to negotiate
rsize larger than 4MB but in the meantime rsize will almost always be
4MB (or 1MB on
mounts to some older servers) for cifs but some users will benefit
slightly from manually
setting it to 8MB.

> > I can't imagine an SMB3 server negotiating an rsize or wsize smaller than
> > 64K in today's world (and typical is 1MB to 8MB) but the user can specify a
> > much smaller rsize on mount.  If 64K is an adequate minimum, we could change
> > the cifs mount option parsing to require a certain minimum rsize if fscache
> > is selected.
>
> I've borrowed the 256K granule size used by various AFS implementations for
> the moment.  A 512-byte xattr can thus hold a bitmap covering 1G of file
> space.
>
> David
>


-- 
Thanks,

Steve
