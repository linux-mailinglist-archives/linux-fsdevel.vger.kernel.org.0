Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF242EFA64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbhAHVYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 16:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbhAHVYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:24:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128EAC061796;
        Fri,  8 Jan 2021 13:24:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so26297584lfg.4;
        Fri, 08 Jan 2021 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+afgHAtxhrr/i0EcynJ2CYFaHfGmcyOTzMQ7jRJw+34=;
        b=EWLV5/5BkInHF7B8SUxiUYVtKJo/pNuo44Gb8xnDt/w4FZxPLZ8xfTzdWYJMrAW/+a
         +LaIs19proJuaO55Kb6fm7+XwoBa0RSfdRj8CDpynFu+mvinLspy6QaPnJmyHZCXTpRH
         2tzjQhNaKzXG/hsIDyZN7dp+K0bG1Q1yOxvrbLQMQADxtmON3+FCqM6CvATijn69lpXO
         9g32ONk0kwEuiJ0f1/C+jgSCoxih3JnKyx8TQtMjyO0q7RmPmAItIL9AGhHuI+nVQ7dC
         YcfRN5oyxzE08hOUyju+DpHfnCLTyQYxz1HZ/Bv9mXci8/QpfnGPzGuEyGXWQbe/uGW3
         58vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+afgHAtxhrr/i0EcynJ2CYFaHfGmcyOTzMQ7jRJw+34=;
        b=UK0wocWUZtu0DHqTjE8Sdvb02AoF+BRQlebgV0oCZJX1Ub40meqOeHUQkMBRJoVAmh
         1lFLIZzWAtF+D/hzNX2GkkZjW6gQ1WvU8Hl1z1MOqEfmSJxx3bop6zDk7GVKd1qPhuaY
         ASCguyZ1BnWTOBaekcWh+l24DUocL5Nrj4YTJ9lrFIfXCyvnMoUZUhNwlDfpEy2+7ACJ
         ToSD15q4kVtAPWFp5maahIXg6VB68kOdVVNTptKvTDDDGxIK5v8453cbi8mDC1ci5D9I
         KmXu6eIb5iFufusqtjC0x70g0ROkKgPcfkZ/0ZZfQhmhrXvvAi3kU+m2jwDCH6qiV79I
         L5rg==
X-Gm-Message-State: AOAM531WxYsctfAqL+lN9TnPjgLTV4XpKrmMXyVDXFttzGgfW1mc+nJL
        3ztG67REqTHCNmyY8bnJDIMbCw0RLN526xjLCA4=
X-Google-Smtp-Source: ABdhPJw0Nu906p07vhl6IlMcKRUd1QVarTQZeVS6m9q64qCsKOGolBZa7QCJCdGe5JoJ7BqKGChStMaECN6aBDppJQc=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr162388lfa.210.1610141049528;
 Fri, 08 Jan 2021 13:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com> <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com>
In-Reply-To: <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Jan 2021 16:23:58 -0500
Message-ID: <CAEjxPJ7CL0WbEeooyh=d_LggZ7xTtcqsLY3TSunJ6oXWNxBOuw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
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
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:17 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> On Fri, Jan 8, 2021 at 11:35 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
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
> Stephen, as per your explanation below, is this check also
> problematic? I mean is it possible that /dev/kvm context_inode may not
> have its label initialized? If so, then v12 of the patch series can be
> used as is. Otherwise, I will send the next version which rollbacks
> v14 and v13, except for this check. Kindly confirm.

The context_inode should always be initialized already.  I'm not fond
though of silently returning -EACCES here.  At the least we should
have a pr_err() or pr_warn() here.  In reality, this could only occur
in the case of a kernel bug or memory corruption so it used to be a
candidate for WARN_ON() or BUG_ON() or similar but I know that
BUG_ON() at least is frowned upon these days.
