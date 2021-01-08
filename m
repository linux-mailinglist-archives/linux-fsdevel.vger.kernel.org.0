Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429242EFAA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbhAHVcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbhAHVcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:32:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03151C061793
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 13:31:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y24so12580549edt.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usABmZbPBqvxIY7U6EdGtDSIYnBKPUAxoopqfJsbtF4=;
        b=pBGi9wERfXy2hax+45WV3pYPQR65fOvZkuo+5mJBYJm6oCBXdlsNQ8MLB2BBZJghLV
         krg0LeT8dDbheD2uijN7Xt+GmkSuJtHYSwgxWq/ZMwJHgwuur7rw2L4h0Q84fHnxuYNJ
         BqLkmzGllNp9DvPfiijxoam7DIejfT06c3wqhBqPdvllpbzncL7z7xc3zfkeYvEFM0/y
         wLRqioz1SjBMUYCnZJZfs2GaQIr7j9B/ZvO5kT1xaSSlgo1x8DGIuqaPmbr921IxGow9
         VT3idPThY7BJWa/DhX2K/205uPggSR1O8exx7M439p7jP5pUTCEm50o6MJ2bZAPGa1i1
         9JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usABmZbPBqvxIY7U6EdGtDSIYnBKPUAxoopqfJsbtF4=;
        b=T/U0uX2HRTg5QHQg+vAkMeY29GZqcyQbge4pfp9bVzvEGoUf/GFwp3OvzDNIKSe7af
         OGDpW0jr8Of47BE5qpOziJ0FuW46dImkhQhZ8KQpPsWwWW/9W4vVIsBCs1K6FpJ/YDnd
         Ss3bQgNRTt9PvEgWDCT27NzvAKdX/UpqFMVifkGmJPQR0sHPpehF3aBeSwYD1prr3Aay
         u6osqkWlRVOc5J+S+GBBPP3LxRCW3GmKuwp9gDiMVenDSDJTETvjhb0w8uGYEsfVJVF6
         2agR1kE34C8YRJ7z8Px8WTg/BAWvBinoDiZu+ts5h/Lu1UVww9WGLzfsUdUBTzC+idwY
         h/nA==
X-Gm-Message-State: AOAM5311Xs0Tec35iVu4SWkG+eo21G8tYfCCundig9cus4z3y3pDuFOE
        IJVVLdnbZRJSVDHzYm+CsynG25+0sxg/hAjsMTXNbA==
X-Google-Smtp-Source: ABdhPJw2qYeDr60GGb3HJnbXtjHALUnLnnC8WnJbfhBCDpJkWDyszY9IxAR+lhJgwDJyVCmFAUsAet6wSO0g94hykG0=
X-Received: by 2002:aa7:da03:: with SMTP id r3mr6546470eds.155.1610141501281;
 Fri, 08 Jan 2021 13:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
 <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com> <CAEjxPJ7CL0WbEeooyh=d_LggZ7xTtcqsLY3TSunJ6oXWNxBOuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7CL0WbEeooyh=d_LggZ7xTtcqsLY3TSunJ6oXWNxBOuw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 8 Jan 2021 13:31:30 -0800
Message-ID: <CA+EESO56RQdB3vV4_BKHT6rhGnbyT07HvrfPcR5s5OFMh1XURw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Fri, Jan 8, 2021 at 1:24 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 3:17 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 11:35 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > > From: Daniel Colascione <dancol@google.com>
> > > > >
> > > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > > the previous patches to give SELinux the ability to control
> > > > > anonymous-inode files that are created using the new
> > > > > anon_inode_getfd_secure() function.
> > > > >
> > > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > > adding a name-based type_transition rule that assigns a new security
> > > > > type to anonymous-inode files created in some domain. The name used
> > > > > for the name-based transition is the name associated with the
> > > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > > "[perf_event]".
> > > > >
> > > > > Example:
> > > > >
> > > > > type uffd_t;
> > > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > > allow sysadm_t uffd_t:anon_inode { create };
> > > > >
> > > > > (The next patch in this series is necessary for making userfaultfd
> > > > > support this new interface.  The example above is just
> > > > > for exposition.)
> > > > >
> > > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > > > >  security/selinux/include/classmap.h |  2 ++
> > > > >  2 files changed, 58 insertions(+)
> > > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 6b1826fc3658..d092aa512868 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > > +                                           const struct qstr *name,
> > > > > +                                           const struct inode *context_inode)
> > > > > +{
> > > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > > +       struct common_audit_data ad;
> > > > > +       struct inode_security_struct *isec;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > > +               return 0;
> > > > > +
> > > > > +       isec = selinux_inode(inode);
> > > > > +
> > > > > +       /*
> > > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > > +        * untouched.
> > > > > +        */
> > > > > +
> > > > > +       if (context_inode) {
> > > > > +               struct inode_security_struct *context_isec =
> > > > > +                       selinux_inode(context_inode);
> > > > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > > > +                       return -EACCES;
> > Stephen, as per your explanation below, is this check also
> > problematic? I mean is it possible that /dev/kvm context_inode may not
> > have its label initialized? If so, then v12 of the patch series can be
> > used as is. Otherwise, I will send the next version which rollbacks
> > v14 and v13, except for this check. Kindly confirm.
>
> The context_inode should always be initialized already.  I'm not fond
> though of silently returning -EACCES here.  At the least we should
> have a pr_err() or pr_warn() here.  In reality, this could only occur
> in the case of a kernel bug or memory corruption so it used to be a
> candidate for WARN_ON() or BUG_ON() or similar but I know that
> BUG_ON() at least is frowned upon these days.

Got it. I'll add a pr_err(). Thanks a lot.
