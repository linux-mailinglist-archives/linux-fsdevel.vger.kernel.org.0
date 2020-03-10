Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B89180AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 22:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJVvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 17:51:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43120 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJVvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:51:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so6855291otb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vb0GLcs/8L01cTZ3HReaJOKCCqFsvClKHIQrRrGWG3I=;
        b=ML2h3mATLzke2m39a1Y6P/zDeHMxWqmWXR8CmeCANV0lcaQJmDMP4U3tgRYj3VwNVk
         gcrsdaOTXdOK+JjqpLxko+kEbnGIn7QupEmi+2Q0b4vwqC6coa38rR0r7QcCru31DAfk
         sP5TSdEzlau5ApuVktDVZXO2kqn+tioqibI+YdajtqBI/IN2FQIVXJjbMrmTR6N8aagK
         4bYw66E+LCk5utYxoMeGj/mgh0bXybW9Hy21qFbJP8VzcWirKwIuqM4fg53vOIcf2M5G
         457LG5EtugTnBxKo2TqABdeUV2BIWYtxrAYSp56R1HBngCTQ7tFbkZP+oMTR4otrECVK
         bGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vb0GLcs/8L01cTZ3HReaJOKCCqFsvClKHIQrRrGWG3I=;
        b=XL3nGvDqhiyg5flPe/CXMpsHEowM7UmiPbidG4Jdp6dfpl4116gwH/hkmJ8yWqY40r
         NKoKkuCbY2L50Pj4/8XlTHG8fe6+GFSCzbdiFcBc3gRde7fR+cP1vXGxFUfP1SPrdmTJ
         AUmKatnVCYChuRUFxmBLSWcM9PUaOp28j4hzIgOZaWH/NIWLWUAHQH8n1LzvxRfbnvS+
         c7gwPUr4/9Xjg/TnFB8gHwOp8AlfYxNDA4KpkkLusyapLy+anDD8bc+ZrcIYeyfv3e0k
         GMw1eiz2AeAgz99IbC0QgqObzZV6oB8OQrE5ZH4qYWFCZaipH/gFaugN7/1XBfjODYHQ
         WdwQ==
X-Gm-Message-State: ANhLgQ107tKuLUubHVCkTXlUZPdPVFEShtbic+jFD7LSp7BqN+7RbPnG
        KWixNysFl4a2QiGa3tcagrQcFea2qt0emMVbBOT2yw==
X-Google-Smtp-Source: ADFU+vv6rIwq0naQzaPUTbSTkQPR9MrTSMoZs8D8+Kw1FxXqF+vvTQ6t7/pUXhQZwCfMKjxzfvYNNNcfLsXZgyFIH1w=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr19373893ota.127.1583877064482;
 Tue, 10 Mar 2020 14:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov> <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
 <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com> <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
 <CAKOZuetUvu=maOmHXjCqkHaYEN5Sf+pKBc3BZ+qpy1tE1NJ9xQ@mail.gmail.com> <CAEjxPJ4+NM6-tfOeZ6UQfas6=KxtBTAk6f23GEyLomFn3K3qew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+NM6-tfOeZ6UQfas6=KxtBTAk6f23GEyLomFn3K3qew@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 10 Mar 2020 14:50:27 -0700
Message-ID: <CAKOZuevcz+fvfhRXPx2iZGtkk6+FjVj3ZSaGGT8DfwsOJR0k3A@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Sandeep Patil <sspatil@google.com>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        SElinux list <selinux@vger.kernel.org>, kvm@vger.kernel.org,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:25 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 10, 2020 at 2:11 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 10:50 AM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Thu, Feb 20, 2020 at 10:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > >
> > > > On 2/17/2020 4:14 PM, Paul Moore wrote:
> > > > > On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > >> Add support for labeling and controlling access to files attached to anon
> > > > >> inodes. Introduce extended interfaces for creating such files to permit
> > > > >> passing a related file as an input to decide how to label the anon
> > > > >> inode. Define a security hook for initializing the anon inode security
> > > > >> attributes. Security attributes are either inherited from a related file
> > > > >> or determined based on some combination of the creating task and policy
> > > > >> (in the case of SELinux, using type_transition rules).  As an
> > > > >> example user of the inheritance support, convert kvm to use the new
> > > > >> interface for passing the related file so that the anon inode can inherit
> > > > >> the security attributes of /dev/kvm and provide consistent access control
> > > > >> for subsequent ioctl operations.  Other users of anon inodes, including
> > > > >> userfaultfd, will default to the transition-based mechanism instead.
> > > > >>
> > > > >> Compared to the series in
> > > > >> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> > > > >> this approach differs in that it does not require creation of a separate
> > > > >> anonymous inode for each file (instead storing the per-instance security
> > > > >> information in the file security blob), it applies labeling and control
> > > > >> to all users of anonymous inodes rather than requiring opt-in via a new
> > > > >> flag, it supports labeling based on a related inode if provided,
> > > > >> it relies on type transitions to compute the label of the anon inode
> > > > >> when there is no related inode, and it does not require introducing a new
> > > > >> security class for each user of anonymous inodes.
> > > > >>
> > > > >> On the other hand, the approach in this patch does expose the name passed
> > > > >> by the creator of the anon inode to the policy (an indirect mapping could
> > > > >> be provided within SELinux if these names aren't considered to be stable),
> > > > >> requires the definition of type_transition rules to distinguish userfaultfd
> > > > >> inodes from proc inodes based on type since they share the same class,
> > > > >> doesn't support denying the creation of anonymous inodes (making the hook
> > > > >> added by this patch return something other than void is problematic due to
> > > > >> it being called after the file is already allocated and error handling in
> > > > >> the callers can't presently account for this scenario and end up calling
> > > > >> release methods multiple times), and may be more expensive
> > > > >> (security_transition_sid overhead on each anon inode allocation).
> > > > >>
> > > > >> We are primarily posting this RFC patch now so that the two different
> > > > >> approaches can be concretely compared.  We anticipate a hybrid of the
> > > > >> two approaches being the likely outcome in the end.  In particular
> > > > >> if support for allocating a separate inode for each of these files
> > > > >> is acceptable, then we would favor storing the security information
> > > > >> in the inode security blob and using it instead of the file security
> > > > >> blob.
> > > > > Bringing this back up in hopes of attracting some attention from the
> > > > > fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> > > > > perspective we would prefer to attach the security blob to the inode
> > > > > as opposed to the file struct; does anyone have any objections to
> > > > > that?
> > > >
> > > > Sorry for the delay - been sick the past few days.
> > > >
> > > > I agree that the inode is a better place than the file for information
> > > > about the inode. This is especially true for Smack, which uses
> > > > multiple extended attributes in some cases. I don't believe that any
> > > > except the access label will be relevant to anonymous inodes, but
> > > > I can imagine security modules with policies that would.
> > > >
> > > > I am always an advocate of full xattr support. It goes a long
> > > > way in reducing the number and complexity of special case interfaces.
> > >
> > > It sounds like we have broad consensus on using the inode to hold
> > > security information, implying that anon_inodes should create new
> > > inodes. Do any of the VFS people want to object?
> >
> > Ping?
>
> I'd recommend refreshing your patch series to incorporate feedback on
> the previous version and re-post,
> including viro and linux-fsdevel on the cc, and see if they have any
> comments on it.

I don't think there's anything in the patch series that needs to
change right now. AFAICT, we're still just waiting on comment from the
VFS people, who should be on this thread. Did I miss something?
