Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4E2EF8E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbhAHUSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbhAHUSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:18:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1FC061380
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 12:17:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lt17so16220370ejb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwrOgDTg96KrzDvgtinwO514AtzHfwPfpJcfahxEYVI=;
        b=aGlRquYV7bBoqWOfhg/mBYEuzggSozf1JOKAipPHB6CHoFm9cW3lprBEnleXHV82pE
         r5stn0vhAinJiv33KPHJ5w2fLw5Icm3NYqX8LQ0wAt21tWNTl6vudMYutWVrDrufXsKL
         5FFs6hddoUdt10NDUrvs+56xFAfqToaAXTQent1IQQntDeUhmZ/QkLQcxbY/QmNj0Dca
         4weEE7eCLoFXkAgKjbAxDWd7Haie/lzKOV1kXZl5EnV7TrZ3SpiwDi9RMToSkT0It6C6
         HcFCJqGsfukio8J9XbsSYIhGB9QtbX2JDlLjWpn94zM1pIQkBdL0pEHk7skG8iTc9zyH
         kVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwrOgDTg96KrzDvgtinwO514AtzHfwPfpJcfahxEYVI=;
        b=Hz7i6HomXoP66Ge/1G0mpUKtkTeXZ8oMejPKSzRguOJAL58WbgotTjjPkZ5XCBiXu+
         7/SkIP9Wqbe788T6wQNuyPPiXBtiUeNFUfBFkiw1VXWIquvINn26vK88/C89jryj2rTo
         wlrLK3wWLh+s+heivpl7ga4x2U6xY9kDUsHPbK5dRAKUJJ2auq34aOfCUqaBjXEUXDtB
         Q4rnohzrXAmRm8Tyo8QP5uXI6ihrhmWpZ98FhfMcKTD7xSU7bniJVmNMnlYP+4IfgOOO
         EhvP3pvQmlLtSEA5/BFXq6X++Zb4u1cdnhL/57IA4yIM7/I+T9YsiZi1UQIvmzveZPfK
         /WQg==
X-Gm-Message-State: AOAM531yDMH9kmnHVoIdtKLip0tCE8ifAJsQ9ogFms2ngTcYK+I6cf0/
        MPLdsubNPow/3V+m0bu4SYNWA3kYn9RhWBjBs9J5yQ==
X-Google-Smtp-Source: ABdhPJye2R3aseIB1YZzP7HfOO+3uXuVcvm7i9jO6SKjJISprsBWoeK3t3aCDNf/qzYvphit8xROqcEb2lZxYjcwLC4=
X-Received: by 2002:a17:907:101c:: with SMTP id ox28mr3462266ejb.201.1610137044856;
 Fri, 08 Jan 2021 12:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
In-Reply-To: <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 8 Jan 2021 12:17:13 -0800
Message-ID: <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 11:35 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > From: Daniel Colascione <dancol@google.com>
> > >
> > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > the previous patches to give SELinux the ability to control
> > > anonymous-inode files that are created using the new
> > > anon_inode_getfd_secure() function.
> > >
> > > A SELinux policy author detects and controls these anonymous inodes by
> > > adding a name-based type_transition rule that assigns a new security
> > > type to anonymous-inode files created in some domain. The name used
> > > for the name-based transition is the name associated with the
> > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > "[perf_event]".
> > >
> > > Example:
> > >
> > > type uffd_t;
> > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > allow sysadm_t uffd_t:anon_inode { create };
> > >
> > > (The next patch in this series is necessary for making userfaultfd
> > > support this new interface.  The example above is just
> > > for exposition.)
> > >
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > >  security/selinux/include/classmap.h |  2 ++
> > >  2 files changed, 58 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 6b1826fc3658..d092aa512868 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > >         return 0;
> > >  }
> > >
> > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > +                                           const struct qstr *name,
> > > +                                           const struct inode *context_inode)
> > > +{
> > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > +       struct common_audit_data ad;
> > > +       struct inode_security_struct *isec;
> > > +       int rc;
> > > +
> > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > +               return 0;
> > > +
> > > +       isec = selinux_inode(inode);
> > > +
> > > +       /*
> > > +        * We only get here once per ephemeral inode.  The inode has
> > > +        * been initialized via inode_alloc_security but is otherwise
> > > +        * untouched.
> > > +        */
> > > +
> > > +       if (context_inode) {
> > > +               struct inode_security_struct *context_isec =
> > > +                       selinux_inode(context_inode);
> > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > +                       return -EACCES;
Stephen, as per your explanation below, is this check also
problematic? I mean is it possible that /dev/kvm context_inode may not
have its label initialized? If so, then v12 of the patch series can be
used as is. Otherwise, I will send the next version which rollbacks
v14 and v13, except for this check. Kindly confirm.

> > > +
> > > +               isec->sclass = context_isec->sclass;
> >
> > Taking the object class directly from the context_inode is
> > interesting, and I suspect problematic.  In the case below where no
> > context_inode is supplied the object class is set to
> > SECCLASS_ANON_INODE, which is correct, but when a context_inode is
> > supplied there is no guarantee that the object class will be set to
> > SECCLASS_ANON_INODE.  This could both pose a problem for policy
> > writers (how do you distinguish the anon inode from other normal file
> > inodes in this case?) as well as an outright fault later in this
> > function when we try to check the ANON_INODE__CREATE on an object
> > other than a SECCLASS_ANON_INODE object.
> >
> > It works in the userfaultfd case because the context_inode is
> > originally created with this function so the object class is correctly
> > set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> > case?  Do we ever need or want to support using a context_inode that
> > is not SECCLASS_ANON_INODE?
>
> Sorry, I haven't been following this.  IIRC, the original reason for
> passing a context_inode was to support the /dev/kvm or similar use
> cases where the driver is creating anonymous inodes to represent
> specific objects/interfaces derived from the device node and we want
> to be able to control subsequent ioctl operations on those anonymous
> inodes in the same manner as for the device node.  For example, ioctl
> operations on /dev/kvm can end up returning file descriptors for
> anonymous inodes representing a specific VM or VCPU or similar.  If we
> propagate the security class and SID from the /dev/kvm inode (the
> context inode) to the new anonymous inode, we can write a single
> policy rule over all ioctl operations related to /dev/kvm.  That's
> also why we used the FILE__CREATE permission here originally; that was
> also intentional.  All the file-related classes including anon_inode
> inherit a common set of file permissions including create and thus we
> often use the FILE__<permission> in common code when checking
> permission against any potentially derived class.

Thanks a lot for the explanation.
