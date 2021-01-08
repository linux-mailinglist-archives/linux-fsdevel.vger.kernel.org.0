Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B142EF9BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbhAHU7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 15:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbhAHU7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:59:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820FCC0612EA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 12:58:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ga15so16332474ejb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khq1BhJKP5TVovoHPldpcRP4cKiwHOG+v7RRKqn8j58=;
        b=obA6xuhmm9kV3+sXrUgxMMsfFga8AGTLVYwR5OX5nJ2XlW6dNnOubwbilqkj0TMDh8
         T6qAuoauDw+XXUxxElzoTtfFf8VMi/L3cL9wpra8fzRz/wdI150FS4zxBD61HcPZy1vR
         A2E91WGbe5uDVTG7ZQVJvENnGfVNZ4Y8niHT1pIza7xgove9CGQ4CF6CSrurFmwazb2q
         865Ias4cNka3b/TIVm4UJ4SWpJxjm3Az8lE+E/Pn+5qvhwWyelWJb62Lx+uMZ3jLbsH6
         /OEoKonYp9djudJ6iqMYJ5mJil8vbsCZWb0PG4tjs6RI5UTLM9ZDwq3LR5ukjgANpAYY
         OBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khq1BhJKP5TVovoHPldpcRP4cKiwHOG+v7RRKqn8j58=;
        b=mk/1O54R1j1zfJcP3hNHJQMB5IBffRhglTflNFMzyWGUgfCz7j39IZPJFrlhWBadyj
         EuZAuY7iXcPHg1HGTYG/BsTK5R1YdlRNjQ9SfMKrGHA6yO+EAagP0l6AWBBExFcmcPeS
         VQr7yCPpbXEs50vBe0Z8Po1MapsVDCoJhNvFcTKenrZWRiYLOK1rLqckLNkzvDM0r9TR
         1pPv/fb/vYfrw3aHbEFH4zDpa4HvL81f/bx9GcWlZ1Po3xP/fHw5v3nGvN4SelpFfAyq
         stDJOHVhT4C6ozePr/cdNy9MrSzbH4YPANWtlyUpDBL/wN/VmT5PcL7u6stOPvpT4mqc
         ohPg==
X-Gm-Message-State: AOAM531o/PNNNbzuYetMlOhgVamiVVNduFwsWoR0L3Q7VFSBL20+VvgF
        C/B75FZ0TbqsuwNnF1oLdddYsTCxdqzFnPbP9Obb
X-Google-Smtp-Source: ABdhPJyP7SJrjpEnSE+OMOznxeG8QiQoQrfxZc/4hifZZz6dTOsmW0rbarXi+MMdwr3oks6Eb5k7RhEOrKdTQzWv4Mk=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr3822560ejb.542.1610139527942;
 Fri, 08 Jan 2021 12:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
In-Reply-To: <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Jan 2021 15:58:36 -0500
Message-ID: <CAHC9VhQHjNwTNGw4PP=w0h+NOvJzcDWHyAsj2Q6s+itJ_hY71g@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
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
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 2:35 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
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
> policy rule over all ioctl operations related to /dev/kvm.

Thanks for the background, and the /dev/kvm example, that is what I was missing.

> That's
> also why we used the FILE__CREATE permission here originally; that was
> also intentional.  All the file-related classes including anon_inode
> inherit a common set of file permissions including create and thus we
> often use the FILE__<permission> in common code when checking
> permission against any potentially derived class.

Yes, if all of the anonymous inodes are not going to fall into the
anon_inode object class then FILE__CREATE makes the most sense.

Thanks Stephen.

-- 
paul moore
www.paul-moore.com
