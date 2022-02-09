Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8D4AFF22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 22:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiBIVSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 16:18:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBIVSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:18:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4DC0F8692
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 13:18:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y17so5713097edd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lF4t68p5+AhzDhd9G64qMyTKhDZNN82OhTXuxCv8VxI=;
        b=g4nwEVBifqeezQZFyCEixAYLJ1SK6nOot4QmaQz+GuMzaVX2NSR3JuBVm/Sqs69Cv6
         /ZOSFV+AITbOKT5LePXr6+vt0ZEvW0me8uKvQUIXyihX98Q9V4uYLUGTSjotzPL0j37G
         Hpb8eChJ7IVkrRiKhV9leSzOlQgSqYGq6tD0H/vUIh2H/9TN7OY2YIFAccZCcA0ufUzM
         t2a9SOVTiHqO7r9Y41rd7bNXKK88zVv210T/Bxt89a9Z2Fdg5D1UkeT6muli8QGDBQRm
         K1mZKuObKKCkMKGPAAXObW42A4XnKO0CJJLSnAAGj/UzfJdgVklh1WeM94ItKo+SZ1pn
         f5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lF4t68p5+AhzDhd9G64qMyTKhDZNN82OhTXuxCv8VxI=;
        b=WOLLZenc102jkFY9VCuSCeB//vct7WTVNhs+Mtso2A6ONPOXuBUug3cAFTlw65S1Pe
         IPjS42F4IcqoDNp5tnP9/D0ZXZ77+aerW96FEKXWmrxfka/+3IoC6B8NzTRQVAdbV2k7
         yINniG0g/VbYMyKGl2rehDErFkMO039lmB/qN7ggLDp5t1IOqvvujQ6CuoJWh7W8o3pX
         xCUi2AXjql6D2NaBDtdiviJHz9tqkOnr+4ddOGKcU9PLx0PwO9xGAyFTt/XLc2HyPTqR
         gPixKi9UoURGGZlnRTN20pOlko44qd1qjHOs+ePaCbcz/WZ+BU+gMYYZL459GOEEtczc
         nC4Q==
X-Gm-Message-State: AOAM530Xs7gWHGW0zYQRVZl0ZEkARJ4o8IfNmAhPde4ZrmYpyUSwDeZm
        AtyKhrft3VXterjpYYcULlq2k5KMNbhGqajB1gEx
X-Google-Smtp-Source: ABdhPJxsokW6G/LJ/gQwG8CJxjVH9JGRKD+0ILnj3BoonWIf4UGbJ3ZivXMHLP81VTNpzLiQjzS3L6RAOr/F91hB43Q=
X-Received: by 2002:a05:6402:1d4c:: with SMTP id dz12mr4836556edb.385.1644441531886;
 Wed, 09 Feb 2022 13:18:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com> <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
In-Reply-To: <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 16:18:40 -0500
Message-ID: <CAHC9VhRCBMtWWscTFWe4W_F_KNdfLys7e5Ged+N_xddD2tkuRQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
To:     Jeff Mahoney <jeffm@suse.com>, Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, Tony Jones <tonyj@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 9, 2022 at 10:57 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Feb 8, 2022 at 10:44 PM Jeff Mahoney <jeffm@suse.com> wrote:
> >
> > Hi Richard -
> >
> > On 5/19/21 16:00, Richard Guy Briggs wrote:
> > > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > > ("open: introduce openat2(2) syscall")
> > >
> > > Add the openat2(2) syscall to the audit syscall classifier.
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > > ---
> >
> > [...]
> >
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index d775ea16505b..3f59ab209dfd 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -76,6 +76,7 @@
> > >  #include <linux/fsnotify_backend.h>
> > >  #include <uapi/linux/limits.h>
> > >  #include <uapi/linux/netfilter/nf_tables.h>
> > > +#include <uapi/linux/openat2.h>
> > >
> > >  #include "audit.h"
> > >
> > > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> > >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> > >       case AUDITSC_EXECVE:
> > >               return mask & AUDIT_PERM_EXEC;
> > > +     case AUDITSC_OPENAT2:
> > > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> > >       default:
> > >               return 0;
> > >       }
> >
> > ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.
> >
> > I'm getting oopses, like so:
> > BUG: unable to handle page fault for address: 00007fff961bbe70
>
> Thanks Jeff.
>
> Yes, this is obviously the wrong thing to being doing; I remember
> checking to make sure we placed the audit_openat2_how() hook after the
> open_how was copied from userspace, but I missed the argv dereference
> in the syscall exit path when reviewing the code.
>
> Richard, as we are already copying the open_how info into
> audit_context::openat2 safely, the obvious fix is to convert
> audit_match_perm() to use the previously copied value instead of argv.
> If you can't submit a patch for this today please let me know.

I haven't heard anything from Richard so I put together a patch which
should fix the problem (link below).  It's currently untested, but
I've got a kernel building now with the patch ...

https://lore.kernel.org/linux-audit/164444111699.153511.15656610495968926251.stgit@olly/T/#u

-- 
paul-moore.com
