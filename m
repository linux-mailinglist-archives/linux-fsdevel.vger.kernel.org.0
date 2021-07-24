Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358E23D4A6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhGXV0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 17:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhGXV0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627164415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=977uLZZ1MP2YWJkQk/8ziIBF22i/BGM3rYPV0nl730Y=;
        b=Laskzr+zGM+NwbM9YgGyvagQQAqruBQJzLdqAnRj6feGxPehz+FKVqnDidsqwXl+ZW2XMI
        k2iQ9DRBt8bNtvWvHf5xCtTMs6AmZs/aY6AWxHjoi3VbVXVJEqXyXNnkofKN/vmU0OdbC1
        sE81QEbceLyW2DenlcWONVMxw46Eqnw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-CrsE3WJVMfu1jCAQJdRj3w-1; Sat, 24 Jul 2021 18:06:53 -0400
X-MC-Unique: CrsE3WJVMfu1jCAQJdRj3w-1
Received: by mail-wr1-f72.google.com with SMTP id c5-20020a5d52850000b0290126f2836a61so2601038wrv.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 15:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=977uLZZ1MP2YWJkQk/8ziIBF22i/BGM3rYPV0nl730Y=;
        b=gGFpBTXw6bviGl5YwzJlFkMcl4Pn4kZyYEJ4W3BfUkMOfEVSKI9H9V/Eodtv5RHhkA
         76+smqpr2FUEHq2yY0hDpZJIFns6KRlDB4meh0fpcWayNHflJGfCntLju73Zu2TkVrkG
         bzftY7xR4EGc3CEDO0yyM5sPG2LdM18q25QGTLo914urpXShrUct4nvg6gCdW4+30Fa2
         ug46oR66Yq9v5sTCPw6PUz3F8AioHDD93+a9FaVb9bVW6tSrFMJHzFJ59QNGMpbaqn1D
         4gVCL2nSCAK/8ZCE1TSyiyzdGy9pN5+Yhki70/VyjeKS8DT8/SIbtExU76H1r8MLD7+x
         tsww==
X-Gm-Message-State: AOAM530W/Zh4D8GYXoA4aoYrmMSXn5ZiT2cQ4Ie1WmTAPTBk+5i7OPv+
        Vcf1M+RLwEAiZMtmlYDIfEukaRGizS6U8pHal3i5zojX0TMA1TkZ9KHn3mC006eKoqk0B6aPuDS
        eTaSLF5/f/jARxKWJK6KK2cn7YC3zUlghLn2/nIppjg==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr3472786wrv.329.1627164412613;
        Sat, 24 Jul 2021 15:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw98aCqVjWxX38oeHKCaIaIHxY0Om7RKidPStZZN7z95eN6USQN5AiyYEGvql/V+hxUp7+bvK5ucN6W9nHcicg=
X-Received: by 2002:a5d:540d:: with SMTP id g13mr3472762wrv.329.1627164412331;
 Sat, 24 Jul 2021 15:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
 <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk> <CAHc6FU5nGRn1_oc-8rSOCPfkasWknH1Wb3FeeQYP29zb_5fFGQ@mail.gmail.com>
 <YPyMyPCpZKGlfAGk@zeniv-ca.linux.org.uk>
In-Reply-To: <YPyMyPCpZKGlfAGk@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 25 Jul 2021 00:06:41 +0200
Message-ID: <CAHc6FU4aVL_g3LHEWng1fr8j3jJt+QVK3wAda2q6pfi+xRJcwg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jul 24, 2021 at 11:38:20PM +0200, Andreas Gruenbacher wrote:
>
> > Hmm, how could we have sub-page failure areas when this is about if
> > and how pages are mapped? If we return the number of bytes that are
> > accessible, then users will know if they got nothing, something, or
> > everything, and they can act accordingly.
>
> What I'm saying is that in situation when you have cacheline-sized
> poisoned areas, there's no way to get an accurate count of readable
> area other than try and copy it out.
>
> What's more, "something" is essentially useless information - the
> pages might get unmapped right as your function returns; the caller
> still needs to deal with partial copies.  And that's a slow path
> by definition, so informing them of a partial fault-in is not
> going to be useful.
>
> As far as callers are concerned, it's "nothing suitable in the
> beginning of the area" vs. "something might be accessible".

Yes, and the third case would be "something might be accessible, but
not all of it". There probably are callers that give up when they
don't have it all.

Andreas

