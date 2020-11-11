Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE72AE715
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKKDaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgKKDaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:30:22 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC9C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:30:22 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id e17so745234ili.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoTFRJAIMA31qT21kOie4hLHdFOnrBP6JkMlSYwvnXI=;
        b=qPqD9xJ15agGALdrbfTaEKsO9t0BJdhVFUe0x+i7ee/umFU4twQYB7dWW8pPh8hIoY
         Dxwh3C++Z1NVuJzD5KbagTyBNBdcFW5EnhRdvStAUC0PQ0f3/bB6h3YTYRECqLvO676z
         QQi5TNwiPRsYz0ekahfr0ZOcjJLH/pU3Hcbae5v+YQKiHYoAF+HCDzkHzOZZ0/+94XJb
         gd6fd8edTbeAJ5n1o8PnO0PRi52I97T3hjuT8ZFjhQo68dZTqgu7j7avR32qPGQ3l1Pz
         HP+Cs/gv8tr/439GLUoD+Au86pHpxQ4lDLQlCVMEF/QIVX3Tmos2hm0/GIk3l/JEm+5l
         fplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoTFRJAIMA31qT21kOie4hLHdFOnrBP6JkMlSYwvnXI=;
        b=SEmvkLEvLLozZOZIKyWPBDdvB3mnOuDTghfdh1REtBrItCpz94Q9Nsy12bJzYHHEmI
         1i5slSGsntyvfD+xOdVgrizJTDXMyQzuBzmjVD1fU9dlA0JrxvIygo+Y7mEqeQMe3y9Y
         JFHjbRI/ybWi1ka9GlRdgSb2iRnj1gzEgcPJLA/ftprMVFCShqFRl59WIO1jBjy/+I73
         ITRAN7oj40kjdAZFE+P7mBmZM4z4NRaYL9jnujYdsvqqUAxRXU+LBxI5MsaQWykX4hiE
         oYSqY6sXqMhRqfYEIbOcXvLo2wOgOYzAOuVweC4aOsD0wN8vN7K9GlLCGkWVX6YXxm4h
         Q/8A==
X-Gm-Message-State: AOAM530nbgsavy87izW9qu5hP7z57TsEm7b5uHbI/Ql8pw6a8tAwsTyT
        cVz52kBegex3zmZQLKqp/uWTWuaeITG6jjmZ3KOvhw==
X-Google-Smtp-Source: ABdhPJxK2Fi5zChFPjMF2Pn/NLuggjJUhsrqW9BIJNVd99uJhLXv9EktO5IEFPyPZvq0aC8iNVh/WmZqVika8Ky+Ta4=
X-Received: by 2002:a92:8b4e:: with SMTP id i75mr14330378ild.43.1605065420914;
 Tue, 10 Nov 2020 19:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com> <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
In-Reply-To: <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 10 Nov 2020 19:30:09 -0800
Message-ID: <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
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
        Thomas Cedeno <thomascedeno@google.com>,
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
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 6:13 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Nov 10, 2020 at 1:24 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Mon, Nov 9, 2020 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Nov 6, 2020 at 10:56 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > >
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
> > > >  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
> > > >  security/selinux/include/classmap.h |  2 ++
> > > >  2 files changed, 55 insertions(+)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6b1826fc3658..1c0adcdce7a8 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> > > > +               isec->sclass = context_isec->sclass;
> > > > +               isec->sid = context_isec->sid;
> > >
> > > I suppose this isn't a major concern given the limited usage at the
> > > moment, but I wonder if it would be a good idea to make sure the
> > > context_inode's SELinux label is valid before we assign it to the
> > > anonymous inode?  If it is invalid, what should we do?  Do we attempt
> > > to (re)validate it?  Do we simply fallback to the transition approach?
> >
> > Frankly, I'm not too familiar with SELinux. Originally this patch
> > series was developed by Daniel, in consultation with Stephen Smalley.
> > In my (probably naive) opinion we should fallback to transition
> > approach. But I'd request you to tell me if this needs to be addressed
> > now, and if so then what's the right approach.
> >
> > If the decision is to address this now, then what's the best way to
> > check the SELinux label validity?
>
> You can check to see if an inode's label is valid by looking at the
> isec->initialized field; if it is LABEL_INITIALIZED then it is all
> set, if it is any other value then the label isn't entirely correct.
> It may have not have ever been fully initialized (and has a default
> value) or it may have live on a remote filesystem where the host has
> signaled that the label has changed (and the label is now outdated).
>
> This patchset includes support for userfaultfd, which means we don't
> really have to worry about the remote fs problem, but the
> never-fully-initialized problem could be real in this case.  Normally
> we would revalidate an inode in SELinux by calling
> __inode_security_revalidate() which requires either a valid dentry or
> one that can be found via the inode; does d_find_alias() work on
> userfaultfd inodes?
>
> If all else fails, it seems like the safest approach would be to
> simply fail the selinux_inode_init_security_anon() call if a
> context_inode was supplied and the label wasn't valid.  If we later
> decide to change it to falling back to the transition approach we can
> do that, we can't go the other way (from transition to error).
>
I'm not sure about d_find_alias() on userfaultfd inodes. But it seems
ok to fail selinux_inode_init_security_anon() to begin with.

> > > > +       } else {
> > > > +               isec->sclass = SECCLASS_ANON_INODE;
> > > > +               rc = security_transition_sid(
> > > > +                       &selinux_state, tsec->sid, tsec->sid,
> > > > +                       isec->sclass, name, &isec->sid);
> > > > +               if (rc)
> > > > +                       return rc;
> > > > +       }
> > > > +
> > > > +       isec->initialized = LABEL_INITIALIZED;
> > > > +
> > > > +       /*
> > > > +        * Now that we've initialized security, check whether we're
> > > > +        * allowed to actually create this type of anonymous inode.
> > > > +        */
> > > > +
> > > > +       ad.type = LSM_AUDIT_DATA_INODE;
> > > > +       ad.u.inode = inode;
> > > > +
> > > > +       return avc_has_perm(&selinux_state,
> > > > +                           tsec->sid,
> > > > +                           isec->sid,
> > > > +                           isec->sclass,
> > > > +                           FILE__CREATE,
> > >
> > > I believe you want to use ANON_INODE__CREATE here instead of FILE__CREATE, yes?
> >
> > ANON_INODE__CREATE definitely seems more appropriate. I'll change it
> > in the next revision.
> >
> > > This brings up another question, and requirement - what testing are
> > > you doing for this patchset?  We require that new SELinux kernel
> > > functionality includes additions to the SELinux test suite to help
> > > verify the functionality.  I'm also *strongly* encouraging that new
> > > contributions come with updates to The SELinux Notebook.  If you are
> > > unsure about what to do for either, let us know and we can help get
> > > you started.
> > >
> > > * https://github.com/SELinuxProject/selinux-testsuite
> > > * https://github.com/SELinuxProject/selinux-notebook
> > >
> > I'd definitely need help with both of these. Kindly guide how to proceed.
>
> Well, perhaps the best way to start is to explain how you have been
> testing this so far and then using that information to draft a test
> for the testsuite.
>
As I said in my previous reply, Daniel worked on this patch along with
Stephan Smalley. Here's the conversation regarding testing from back
then:
https://lore.kernel.org/lkml/CAEjxPJ4iquFSBfEj+UEFLUFHPsezuQ-Bzv09n+WgOWk38Nyw3w@mail.gmail.com/

There have been only minor changes (fixing comments/coding-style),
except for addressing a double free issue with userfaultfd_ctx since
last time it was tested as per the link above.

> --
> paul moore
> www.paul-moore.com
