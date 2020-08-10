Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F72409AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgHJPef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgHJPed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:34:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E5C061756;
        Mon, 10 Aug 2020 08:34:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g19so9324577ioh.8;
        Mon, 10 Aug 2020 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WTYhGSMVJwaOGI5CfF/LhAkHD90jfpwgnfPX4Hecs4=;
        b=SUqd4aq9Y6Av+Gv7ga8W5ylkM3EMuDB+BJKiZDlYcl88/yG7+n1hocgfPi2FLC+Vxx
         KqPoFLizRpDrrvQnQiwnl561zq27UuRh8UiqsCIrjxDmAuFJnRBl/DUzkplB4z4G7b9Q
         jc7U58KTucVI+gNlNrZukqTN/vkc4mBRHbDXl2OTOpJufnJriy9ap0BWG6XUUXmUipsK
         TVoTNnf58iia3wlyq6oUVjzJCFkxLz2VpA2zx08I9wplKHuxou/WV3K2uz/ioqL+Sskh
         6g11stI+pS9OhTnOPgH6HxIYKtKYfdcqu6n4sRawgxF0zuuxqz7wmHR/8ocnUyPutNez
         JFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WTYhGSMVJwaOGI5CfF/LhAkHD90jfpwgnfPX4Hecs4=;
        b=HCk45M7IiUQUwGNaebCvCzLmOhXp8ays57qbXRn5jzqfn13QBsrulYmg/+yP7B0lkA
         22XptBeBynIUOu4UYsNJHjViGqo3ymLHiKGjdiTwABth4dhDCTItrrJpKtCzqGacp8rG
         ck7x1yXd2S/Yf25nxiPyC2QWO0+MR1MGuw5H6syFh1R5EWJ1Wm8X1dWF8Ww9/zsm/dfK
         ecmTdAlxDaA12bfpTx5WWhQmRUoEgocN+pwmqJl+GISzlqtao99vvJy6Ib09rBUkGFkY
         o4wpF/U4xzAMWEwLdwrqRpSwdsL/yjQj/HI4EVfd0p/mozNNu7Gfksx6Q09AnbYCHttd
         g8xA==
X-Gm-Message-State: AOAM530kuD+v77llCe5AZuZMoeW5QtqySxpRKqkFAHm1r72OXdhHWYe/
        y7PvCzoHrRt4hUi+GF3HKBNezLcnCA298wT60hyz+Wi5
X-Google-Smtp-Source: ABdhPJx/72p6MbNErre05awlascVxCqkGhI8Z4HJDnMGlc4VJwJdcxlxvUk8VJQtBs+c1JaA8neSe/NM/cZiAC2o7ms=
X-Received: by 2002:a05:6638:bd1:: with SMTP id g17mr20791285jad.132.1597073672791;
 Mon, 10 Aug 2020 08:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <447452.1596109876@warthog.procyon.org.uk> <1851200.1596472222@warthog.procyon.org.uk>
 <667820.1597072619@warthog.procyon.org.uk>
In-Reply-To: <667820.1597072619@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Aug 2020 10:34:21 -0500
Message-ID: <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
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

cifs.ko also can set rsize quite small (even 1K for example, although
that will be more than 10x slower than the default 4MB so hopefully no
one is crazy enough to do that).   I can't imagine an SMB3 server
negotiating an rsize or wsize smaller than 64K in today's world (and
typical is 1MB to 8MB) but the user can specify a much smaller rsize
on mount.  If 64K is an adequate minimum, we could change the cifs
mount option parsing to require a certain minimum rsize if fscache is
selected.

On Mon, Aug 10, 2020 at 10:17 AM David Howells <dhowells@redhat.com> wrote:
>
> Hi Linus,
>
> Can you drop the fscache rewrite pull for now.  We've seem an issue in NFS
> integration and need to rework the read helper a bit.  I made an assumption
> that fscache will always be able to request that the netfs perform a read of a
> certain minimum size - but with NFS you can break that by setting rsize too
> small.
>
> We need to make the read helper able to make multiple netfs reads.  This can
> help ceph too.
>
> Thanks,
> David
>


-- 
Thanks,

Steve
