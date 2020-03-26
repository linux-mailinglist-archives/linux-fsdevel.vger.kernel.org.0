Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB31945F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZSAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 14:00:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44086 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZSAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:00:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id j188so5642093lfj.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rceHKfjao+uDGRra9UF3uhK0a0AeUDhxMcu5Qcf+otU=;
        b=etIa99nr6bm25NrBlkHQnJRTiwL1U3f2GGcUc2zPfdQZuyHnxg0asGUYsNXKwcuPxr
         LDSdnr68HVigzzCnfUiC2OaPSQS1RTGiSXpK977g9GagrBMdVytSjK30lD1rYgsogG0w
         REyIwh4CbLCtz+u+EsDZ1KJNDIaTXi5elhRnnuAcuiiBkzK8ixk2nS7o38LjrK/u8gc+
         q0tzYOVf1cY2LIkvba0iMsaj3q18RiwjqVt4hvl1FC2IdZEB/uAw4dPpkK74Z9egxT/l
         H/cOEa1BkQMIlbvofPof5CiupQXjZVOJIRBCsShsouMd079XhFFq90Pyovj8lyRA8H7Y
         4QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rceHKfjao+uDGRra9UF3uhK0a0AeUDhxMcu5Qcf+otU=;
        b=KJd9M8BqTV50TjNS3abSijQD3cEXbE1iMfmx7BxZI873WvwcCSEOExxtFxzfcd168A
         MDPCGWbRvACpljiuzhLbvkjlsG7/O2+zxIa5aI3iqGq8dkogbti9JjqsWxX+hAQHIYBn
         fFeFRycWaOLB+56Fy1PbOvOaoxNntyQsrvgYo9G7Z4jeC06C19XaVmVKUZie1cJkyoBV
         Tqe117yeRBaJ2+Y0hz5axc0DqA+j/daQaayhQlRPSRvWj/6LuH1lxAsfZYNFSxgbEB9T
         JwhFM75OxQ0Vx/t8OOHr2V358X/Jh1gT+HN/giyftyu4Pl7KdGftSzeyP80qioVtR80n
         +V4g==
X-Gm-Message-State: ANhLgQ3anftQEyMVaZEOasmqOYvfmo8W5M9mLqhbVhoGPU5fXIMIVNuD
        pzHxepAincXSu274ZyggVTNLucxwSqgU+WGLburRNA==
X-Google-Smtp-Source: ADFU+vtNiW6JWvS32/vnFzBQwNxILQURl2WF5g4cDVQE/3AuIvJTayB02deDSwzX0n3ZE86pi6UbGe7fvkOGgd8pNqM=
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr6562434lfe.178.1585245620066;
 Thu, 26 Mar 2020 11:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com> <20200325230245.184786-3-dancol@google.com>
 <b5999b89-6921-5667-9eb2-662b14d5f730@tycho.nsa.gov>
In-Reply-To: <b5999b89-6921-5667-9eb2-662b14d5f730@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 26 Mar 2020 10:59:41 -0700
Message-ID: <CAKOZueuztKTAVDKLBPePXfCzOcWXiTEJvC=-zH71mGZPi1YawQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Teach SELinux about anonymous inodes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for taking a look!

On Thu, Mar 26, 2020 at 6:57 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 3/25/20 7:02 PM, Daniel Colascione wrote:
> > This change uses the anon_inodes and LSM infrastructure introduced in
> > the previous patch to give SELinux the ability to control
> > anonymous-inode files that are created using the new _secure()
> > anon_inodes functions.
> >
> > A SELinux policy author detects and controls these anonymous inodes by
> > adding a name-based type_transition rule that assigns a new security
> > type to anonymous-inode files created in some domain. The name used
> > for the name-based transition is the name associated with the
> > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > "[perf_event]".
> >
> > Example:
> >
> > type uffd_t;
> > type_transition sysadm_t sysadm_t : file uffd_t "[userfaultfd]";
> > allow sysadm_t uffd_t:file { create };

Oops. Will fix.

> > (The next patch in this series is necessary for making userfaultfd
> > support this new interface.  The example above is just
> > for exposition.)
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > ---
> >   security/selinux/hooks.c            | 54 +++++++++++++++++++++++++++++
> >   security/selinux/include/classmap.h |  2 ++
> >   2 files changed, 56 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1659b59fb5d7..b9eb45c2e4e5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2915,6 +2915,59 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >       return 0;
> >   }
> >
> > +static int selinux_inode_init_security_anon(struct inode *inode,
> > +                                         const struct qstr *name,
> > +                                         const struct file_operations *fops,
> > +                                         const struct inode *context_inode)
> > +{
> > +     const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +     struct common_audit_data ad;
> > +     struct inode_security_struct *isec;
> > +     int rc;
> > +
> > +     if (unlikely(!selinux_state.initialized))
> > +             return 0;
>
> This leaves secure anon inodes created before first policy load with the
> unlabeled SID rather than defaulting to the SID of the creating task
> (kernel SID in that situation).  Is that what you want?  Alternatively
> you can just remove this test and let it proceed; nothing should be
> break and the anon inodes will get the kernel SID.

We talked about this decision on the last thread [1], and I think you
mentioned that either the unlabeled or the kernel SID approach would
be defensible. Using the unlabeled SID seems more "honest" to me than
using the kernel SID: the unlabeled SID says "we don't know", while
using kernel SID would be making an affirmative claim that the
anonymous inode belongs to the kernel, and claim wouldn't be true.
That's why I'm leaning toward the unlabeled approach right now.

[1] https://lore.kernel.org/lkml/9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov/
