Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB82EE8EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbhAGWlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 17:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbhAGWlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:41:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D0C0612F8
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 14:40:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 6so11958170ejz.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 14:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XqVUgVy1pNqlxwWd84db3LuiaUvuAHDBIZX+64W06k=;
        b=NWv01/zlyr6q4YPTCOMw9UY+da1CE8yvE6GZIprVi4hP1rB4m6+X4xE6B6p+eM1shE
         0zE5jIDed7UafJJVgMB6ps4K6ZZL2xhShkgG9G/NzeQO5b+qfNC3chpr/tt4pjl5byp/
         CIqStP6l1L3/IcWbmD/46AOc7BYuxJMUuzBYdv8+5r4+HKT+rE6PtzqhBvBDDAAYYAM8
         GpKBoLMnXaSmCjt5fHi0T0v1cbvIMuA0WHOmV9Ax+b5Q1knQxE73WaUPRiyKdQV9E5d0
         1jeQGsSOsRWOasPp3Y1z4wtnXrVsjdPt9zIppPGahZV1grkOPXoOm2q058gj8KL1AspE
         oKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XqVUgVy1pNqlxwWd84db3LuiaUvuAHDBIZX+64W06k=;
        b=fwBKAR6xdVLe3nWpO83WANbLadz4KLmcNSAC22FNAwfdwbUCYe7E3DGR0yVBeMv/B3
         PK+8KuGiBga2foKwpupWyoTDWaZsB4RcDCIAtKOA/UMcmMwHbYbiFyq7ugQdn7uKyNzG
         fJUvQfah5ndHdcltLe5g2Ajao8Y83fs43GmXmvPTmwN3yQIRJAuhYKaiFmA8OsJLwgcO
         TRuN+T2DnCZns/GO/1OXIY7N9fpKr/gVa5vaO+n14Ve1KOI7K710DWHJ4GTQL0NXlws0
         0SWEZQR0QS67Zu3SIy2Vp3z9wNq1Ew3n70ExPP7/5YXUhDFOHcDjBsVndRE5XSPeXwGI
         Sj5g==
X-Gm-Message-State: AOAM530La+9zD42P68zApwdiIH7FHgUeZ2v0bKmmL6zZWHCWGcet0Bn8
        LgC3oXQV59sFZPaCb/PSS/JjiqA3AOtHFcnQksD5rg==
X-Google-Smtp-Source: ABdhPJwZ7WP+sgJ8+ZyhYXNdwlC3xgvuyXpzmUt/hdDxhpxuuYpYzodvyLVmvEcLcEqe1d518K6Uml2VPwoViudSN5w=
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr657411eja.409.1610059230459;
 Thu, 07 Jan 2021 14:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CA+EESO5wXubeutVOdbp_LamfP5TyG0r7BO-qnWV=wkd9zWqJ4w@mail.gmail.com> <CAHC9VhSPOHr+ayFK2RADh6u8Dsmp5GYPTWs3HLPtjwbFTgVrfQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSPOHr+ayFK2RADh6u8Dsmp5GYPTWs3HLPtjwbFTgVrfQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 7 Jan 2021 14:40:19 -0800
Message-ID: <CA+EESO4YOJe6V6R_gng++gYH9BOGjGJQ9nqXyymTkJOWSaOUYg@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:30 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:55 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Wed, Jan 6, 2021 at 7:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > From: Daniel Colascione <dancol@google.com>
> > > >
> > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > the previous patches to give SELinux the ability to control
> > > > anonymous-inode files that are created using the new
> > > > anon_inode_getfd_secure() function.
> > > >
> > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > adding a name-based type_transition rule that assigns a new security
> > > > type to anonymous-inode files created in some domain. The name used
> > > > for the name-based transition is the name associated with the
> > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > "[perf_event]".
> > > >
> > > > Example:
> > > >
> > > > type uffd_t;
> > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > allow sysadm_t uffd_t:anon_inode { create };
> > > >
> > > > (The next patch in this series is necessary for making userfaultfd
> > > > support this new interface.  The example above is just
> > > > for exposition.)
> > > >
> > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > > >  security/selinux/include/classmap.h |  2 ++
> > > >  2 files changed, 58 insertions(+)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6b1826fc3658..d092aa512868 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > +                                           const struct qstr *name,
> > > > +                                           const struct inode *context_inode)
> > > > +{
> > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > +       struct common_audit_data ad;
> > > > +       struct inode_security_struct *isec;
> > > > +       int rc;
> > > > +
> > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > +               return 0;
> > > > +
> > > > +       isec = selinux_inode(inode);
> > > > +
> > > > +       /*
> > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > +        * untouched.
> > > > +        */
> > > > +
> > > > +       if (context_inode) {
> > > > +               struct inode_security_struct *context_isec =
> > > > +                       selinux_inode(context_inode);
> > > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > > +                       return -EACCES;
> > > > +
> > > > +               isec->sclass = context_isec->sclass;
> > >
> > > Taking the object class directly from the context_inode is
> > > interesting, and I suspect problematic.  In the case below where no
> > > context_inode is supplied the object class is set to
> > > SECCLASS_ANON_INODE, which is correct, but when a context_inode is
> > > supplied there is no guarantee that the object class will be set to
> > > SECCLASS_ANON_INODE.  This could both pose a problem for policy
> > > writers (how do you distinguish the anon inode from other normal file
> > > inodes in this case?) as well as an outright fault later in this
> > > function when we try to check the ANON_INODE__CREATE on an object
> > > other than a SECCLASS_ANON_INODE object.
> > >
> > Thanks for catching this. I'll initialize 'sclass' unconditionally to
> > SECCLASS_ANON_INODE in the next version. Also, do you think I should
> > add a check that context_inode's sclass must be SECCLASS_ANON_INODE to
> > confirm that we never receive a regular inode as context_inode?
>
> This is one of the reasons why I was asking if you ever saw the need
> to use a regular inode here.  It seems much safer to me to add a check
> to ensure that context_inode is SECCLASS_ANON_INODE and return an
> error otherwise; I would also suggest emitting an error using pr_err()
> with something along the lines of "SELinux:  initializing anonymous
> inode with inappropriate inode" (or something similar).
>
Thanks. I'll do that.

> If something changes in the future we can always reconsider this restriction.
>
> > > It works in the userfaultfd case because the context_inode is
> > > originally created with this function so the object class is correctly
> > > set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> > > case?  Do we ever need or want to support using a context_inode that
> > > is not SECCLASS_ANON_INODE?
> >
> > I don't think there is any requirement of supporting context_inode
> > which isn't anon-inode. And even if there is, as you described
> > earlier, for ANON_INODE__CREATE to work the sclass has to be
> > SECCLASS_ANON_INODE. I'll appreciate comments on this from others,
> > particularly Daniel and Stephen who originally discussed and
> > implemented this patch.
>
> I would encourage you not to wait too long for additional feedback
> before sending the next revision.

Certainly. I'll send next version in a day or two.
>
> --
> paul moore
> www.paul-moore.com
