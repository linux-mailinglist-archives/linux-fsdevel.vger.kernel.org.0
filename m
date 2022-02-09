Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E34B0055
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 23:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiBIWaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 17:30:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiBIWaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:30:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69774E01C8AE
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 14:29:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so10985587ejc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwxGeIICnqHoY2j7nGhsMaxduU8evuxeVgZai3IhacA=;
        b=xZ/h7zej5j3WDnJltPH+HHCzgcCr9JfH+MMu9lY0KjxOVQ/+RU/qqu9tBwzalHdJAd
         T3C2RWDm7kbMtC81ogUlrbeAiGBC5f+z330S6lMDqnXvCPCzu4XmbM6/pRxQOk8ky/9c
         F2/RBMCoEsh4Ubuug8Hhy6u2sJi1OO7R+NMpKSoyhLEaHAQHZcUrTcFVy9konIUAbFQW
         W+LWGHaDVPKsTAy0t2um82593RIIu6JHxgPZopY9b3pOi63KKA7nu2GhDc8XJANg8VTE
         Bv4UvrtulBkXVJ4kriNO/O8EfJyCRZiSHFA1e9eSQA0uwewREbIu3Z1nHo/YNc1NnxnS
         6K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwxGeIICnqHoY2j7nGhsMaxduU8evuxeVgZai3IhacA=;
        b=gCtnHiAPPxAzvZeEgXdr6cOvGhCnbC18k4Cz/Tiq/l7Yv9XFsrRKHblhLv2+dqCqAa
         ZEYKCEq9Uzh0ULGStMaaCDpmI0PqPJ4P2mGsGwual/5es6i/RSTqUuA+I4kleAFizU3J
         2ksxogW/0M64O34o+RGD6cVnehHlstyVAYHBIdRbs5EIKtvQm8APIVzkyOBDnBAvZySU
         ODAVApxSF3uarqPDYBy0TAZOE1quPN9YqkZBSEq8vkKkIuTpXSzsZiByOh9RWQuc5h6V
         Y3jlMJPuK/gku8hy7hwfFlY67J9PFtEeJ8fd94FTWjM3sPoIajHmiBF1h+tRIr+EXO0t
         zPpg==
X-Gm-Message-State: AOAM530v7cFFqx8GHgNogo0d3rdn0o5ASZZt8j46a70EK3SOvTHkRBHf
        Rxmb4DYP7ySJUpKrEONbTmTZMpTmodmJeFOBCOjA
X-Google-Smtp-Source: ABdhPJykZ3LPsq7/hz6HEeBOojoOK25gxY3dC3/fv7G6jhEj4Gog2tbmYXALr4PTsGzHEkdet8hpmJdSNw1E/6ycDqg=
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr3552212ejc.701.1644445772885;
 Wed, 09 Feb 2022 14:29:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com> <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
 <20220209214048.GF1708086@madcap2.tricolour.ca>
In-Reply-To: <20220209214048.GF1708086@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 17:29:21 -0500
Message-ID: <CAHC9VhRaenJq65nUKjU6U+wFJ5HJU6Qq0Yf4ejwfNyrKEP30Lw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
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

On Wed, Feb 9, 2022 at 4:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-02-09 10:57, Paul Moore wrote:
> > On Tue, Feb 8, 2022 at 10:44 PM Jeff Mahoney <jeffm@suse.com> wrote:
> > >
> > > Hi Richard -
> > >
> > > On 5/19/21 16:00, Richard Guy Briggs wrote:
> > > > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > > > ("open: introduce openat2(2) syscall")
> > > >
> > > > Add the openat2(2) syscall to the audit syscall classifier.
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > > > ---
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index d775ea16505b..3f59ab209dfd 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -76,6 +76,7 @@
> > > >  #include <linux/fsnotify_backend.h>
> > > >  #include <uapi/linux/limits.h>
> > > >  #include <uapi/linux/netfilter/nf_tables.h>
> > > > +#include <uapi/linux/openat2.h>
> > > >
> > > >  #include "audit.h"
> > > >
> > > > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> > > >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> > > >       case AUDITSC_EXECVE:
> > > >               return mask & AUDIT_PERM_EXEC;
> > > > +     case AUDITSC_OPENAT2:
> > > > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> > > >       default:
> > > >               return 0;
> > > >       }
> > >
> > > ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.
> > >
> > > I'm getting oopses, like so:
> > > BUG: unable to handle page fault for address: 00007fff961bbe70
> >
> > Thanks Jeff.
> >
> > Yes, this is obviously the wrong thing to being doing; I remember
> > checking to make sure we placed the audit_openat2_how() hook after the
> > open_how was copied from userspace, but I missed the argv dereference
> > in the syscall exit path when reviewing the code.
> >
> > Richard, as we are already copying the open_how info into
> > audit_context::openat2 safely, the obvious fix is to convert
> > audit_match_perm() to use the previously copied value instead of argv.
> > If you can't submit a patch for this today please let me know.
>
> Agreed.  It would have been more awkward with the original order of the
> patches.
>
> The syscalls_file test in the audit-testsuite should have caught this.
> https://github.com/rgbriggs/audit-testsuite/commit/1c99021ae27ea23eccce2bb1861df4c9c665cd5b
> The test provided does essentially the same thing.

I would have thought so, but I've now run this multiple times on both
affected and patched kernels but I don't see the page fault on my test
system.

Anyway, that test has now been merged with the audit-testsuite as well
as some cleanup on top to test for the new OPENAT2 record when
applicable.

-- 
paul-moore.com
