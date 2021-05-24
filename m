Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072D738F613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEXXJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXXJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 19:09:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE74C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:08:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z12so42811557ejw.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XiMGNxYXobq8k1+6Xs4DhDuG+BuLQq/LJhQhViCVuGs=;
        b=RyQAZKQJ2AnlbGUJuA7vaJenpahH+bmhnJZh9jFSVRbWvXgiUZrrwAxgbHud5skKPk
         LAJTM9CBjYgn7Jbhg2Q75Edo4TOKWSQyockrVA6pKXMMn9s4rKazAIQi4edwcKOTmcGy
         G/zIyI2XCDqy+/0KCJHzNrCTOLboghhjO4EJzH0jSUztJxAB64WjOM6jW8UMZVDIVlH0
         smb21l4t3iU/SSjs4Kh49ElfdOwRhVhsw2XJkabJ4770PhFRsE/YKz87xF5uw4hjS/TT
         uwFjVoVrxyoUZWzQJLk2BhvP0b5sr7/0UyqLX0mYLFI8oKB/FERGVGXx3um8TocWuNVC
         O9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XiMGNxYXobq8k1+6Xs4DhDuG+BuLQq/LJhQhViCVuGs=;
        b=o4g2jZzsTNO57Zx29o2LK/4CUHDeOVoTxRpKTLtwHZA5ql343JGwWQr8OMryOvEMUq
         R/dlUgxGPatetUM9cx2b4gEQ8nMh0twOGD+ZF/SiQnFKpWqT982S4azVpvJAndx7DBrr
         8QNq74ARNwKuBCEdeIkU2QohrEcU3YRxTf7M6wvtfXEsYcVURnuW0xy9NNIYssjrwaLS
         S9YcLvq79jgxrCYj/str4bmQ8NcLlp4epIxWF/KfmB9FVLV2nd3jpMPV9DyVYIIbLxa4
         1lOlb2y1zwEGIBngFad9+MhQtXDks6zuHfCTWg/m3yV3kHu2nHeYnR8NmFeamWNmVHbc
         j4Pg==
X-Gm-Message-State: AOAM532+GI3lkYa6aXTuF+9hPVZpmMbckHDWK1ioZZwLfk+Mctxq6FEh
        8lEuD2/9pQ4NQ8XYhtffaY7gn0vx5osShXz1XXB+
X-Google-Smtp-Source: ABdhPJzzwj1n5e/zHh1DggqILVebXbU0R+v7/LHNPOFDR+3B3V3XP+is9w9Ox0FsIAkeF75AH8u4DYZr5NhmhT4fvMw=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr26453028ejc.178.1621897704595;
 Mon, 24 May 2021 16:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
 <20210520080318.owvsvvhh5qdhyzhk@wittgenstein>
In-Reply-To: <20210520080318.owvsvvhh5qdhyzhk@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 May 2021 19:08:13 -0400
Message-ID: <CAHC9VhRmhtheudAjGyumunC5zfHMVjuuBvjXNZzYEByTJQRt9g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] audit: add OPENAT2 record to list how
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 4:03 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Wed, May 19, 2021 at 04:00:22PM -0400, Richard Guy Briggs wrote:
> > Since the openat2(2) syscall uses a struct open_how pointer to communic=
ate
> > its parameters they are not usefully recorded by the audit SYSCALL reco=
rd's
> > four existing arguments.
> >
> > Add a new audit record type OPENAT2 that reports the parameters in its
> > third argument, struct open_how with fields oflag, mode and resolve.
> >
> > The new record in the context of an event would look like:
> > time->Wed Mar 17 16:28:53 2021
> > type=3DPROCTITLE msg=3Daudit(1616012933.531:184): proctitle=3D737973636=
16C6C735F66696C652F6F70656E617432002F746D702F61756469742D746573747375697465=
2D737641440066696C652D6F70656E617432
> > type=3DPATH msg=3Daudit(1616012933.531:184): item=3D1 name=3D"file-open=
at2" inode=3D29 dev=3D00:1f mode=3D0100600 ouid=3D0 ogid=3D0 rdev=3D00:00 o=
bj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DCREATE cap_fp=3D0 cap_f=
i=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> > type=3DPATH msg=3Daudit(1616012933.531:184): item=3D0 name=3D"/root/rgb=
/git/audit-testsuite/tests" inode=3D25 dev=3D00:1f mode=3D040700 ouid=3D0 o=
gid=3D0 rdev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DP=
ARENT cap_fp=3D0 cap_fi=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> > type=3DCWD msg=3Daudit(1616012933.531:184): cwd=3D"/root/rgb/git/audit-=
testsuite/tests"
> > type=3DOPENAT2 msg=3Daudit(1616012933.531:184): oflag=3D0100302 mode=3D=
0600 resolve=3D0xa
> > type=3DSYSCALL msg=3Daudit(1616012933.531:184): arch=3Dc000003e syscall=
=3D437 success=3Dyes exit=3D4 a0=3D3 a1=3D7ffe315f1c53 a2=3D7ffe315f1550 a3=
=3D18 items=3D2 ppid=3D528 pid=3D540 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3DttyS0 ses=3D1 comm=3D"open=
at2" exe=3D"/root/rgb/git/audit-testsuite/tests/syscalls_file/openat2" subj=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D"testsuite-1=
616012933-bjAUcEPO"
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Link: https://lore.kernel.org/r/d23fbb89186754487850367224b060e26f9b718=
1.1621363275.git.rgb@redhat.com
> > ---
> >  fs/open.c                  |  2 ++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.h             |  2 ++
> >  kernel/auditsc.c           | 18 +++++++++++++++++-
> >  5 files changed, 32 insertions(+), 1 deletion(-)

...

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 3f59ab209dfd..faf2485323a9 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -76,7 +76,7 @@
> >  #include <linux/fsnotify_backend.h>
> >  #include <uapi/linux/limits.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> > -#include <uapi/linux/openat2.h>
> > +#include <uapi/linux/openat2.h> // struct open_how
> >
> >  #include "audit.h"
> >
> > @@ -1319,6 +1319,12 @@ static void show_special(struct audit_context *c=
ontext, int *call_panic)
> >               audit_log_format(ab, "fd=3D%d flags=3D0x%x", context->mma=
p.fd,
> >                                context->mmap.flags);
> >               break;
> > +     case AUDIT_OPENAT2:
> > +             audit_log_format(ab, "oflag=3D0%llo mode=3D0%llo resolve=
=3D0x%llx",
>
> Hm, should we maybe follow the struct member names for all entries, i.e.
> replace s/oflag/flags?

There is some precedence for using "oflags" to refer to "open" flags,
my guess is Richard is trying to be consistent here.  I agree it's a
little odd, but it looks like the right thing to me from an audit
perspective; the audit perspective is a little odd after all :)

--=20
paul moore
www.paul-moore.com
