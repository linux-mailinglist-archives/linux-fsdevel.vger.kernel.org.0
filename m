Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE418062C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCJSZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 14:25:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41485 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJSZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:25:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id i1so14869735oie.8;
        Tue, 10 Mar 2020 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjIWuou5FNbpKIwkRVi1r1E7TPmhuA9yxao2LdlFDVE=;
        b=WI9tLQJg7U6QlzllzIJHpD6wSvkR6y1ff62nPXosfhZyJsydo0PdyMGciqTChMwu2L
         Oeyn/jiioMtizwmrzehdCVIxILPScyEy//UJqoyqpjyBgQ4bxN77BJUZELrZMuIGYnE/
         DRcAy4+vyqCWmO784Sc26Wz5AwMX5cbfSXi9YI2a+qslTFkjKXck0aqFJHIDOgI84NvM
         YjYBKH7u20RahkHVrddMtyGr/B8JLQ/UK7WOfnxQ+2x+rCfN1NnaPpk7YApJDiIcE1i1
         Ngv8MuaOiP+XYfokKVE6/fcDTZ8ajiTUtvG5vm1eXYSSJnj+xIcfUM15NbtEFkMnGwER
         KA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjIWuou5FNbpKIwkRVi1r1E7TPmhuA9yxao2LdlFDVE=;
        b=NSoZ7tk7aHyn1RBMHZR86yF6wOwsJvXBjc6r5ysRtrS+xXiFTmcc07yb0fowdaF8eP
         yXHJYAcd/RVSFRBQTWtZscXu04vZGNH4qf+JwYtYYjOCsMnKEoIRzG3buocFzM9QrbF3
         wnYjDW3CG8vf5p8HUIqIUhpdyoUuhjQFpKYWmmpSG8DOkrJ+YXGuFgkZxJMypsq+nc2Z
         36jiHZSM5anWzndsfjzwzsGtBzRNID2/eEwswbrDTr3BS2dyHdLnTKc7ZjxR8AC2OVGI
         AkJLEix0RADHmXXRHK6t8C+zlx7qEsvONA2AavSDXlR3svR4Bt1924IsRyAzc4aqiZvM
         u9KQ==
X-Gm-Message-State: ANhLgQ3Rx7c6ZrbhhWyLdd9/guBqDOlLvTnj/G+333/Rx33BsvYUMMox
        qZGF6RO5+d5mKbgc1HJ3KStfSFc1p4LDTXFvNdQ=
X-Google-Smtp-Source: ADFU+vswVRn0x9/9vIuzC+gThOxIhkBVxwX9dq/qu0w55L1cDu/dEBQIkOIBCMOLoSPfrr4X2xbAcHrscbEUEr5kLJQ=
X-Received: by 2002:aca:5191:: with SMTP id f139mr2210175oib.140.1583864720522;
 Tue, 10 Mar 2020 11:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov> <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
 <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com> <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
 <CAKOZuetUvu=maOmHXjCqkHaYEN5Sf+pKBc3BZ+qpy1tE1NJ9xQ@mail.gmail.com>
In-Reply-To: <CAKOZuetUvu=maOmHXjCqkHaYEN5Sf+pKBc3BZ+qpy1tE1NJ9xQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Mar 2020 14:26:11 -0400
Message-ID: <CAEjxPJ4+NM6-tfOeZ6UQfas6=KxtBTAk6f23GEyLomFn3K3qew@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     Daniel Colascione <dancol@google.com>
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

On Tue, Mar 10, 2020 at 2:11 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Feb 20, 2020 at 10:50 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 10:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > > On 2/17/2020 4:14 PM, Paul Moore wrote:
> > > > On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >> Add support for labeling and controlling access to files attached to anon
> > > >> inodes. Introduce extended interfaces for creating such files to permit
> > > >> passing a related file as an input to decide how to label the anon
> > > >> inode. Define a security hook for initializing the anon inode security
> > > >> attributes. Security attributes are either inherited from a related file
> > > >> or determined based on some combination of the creating task and policy
> > > >> (in the case of SELinux, using type_transition rules).  As an
> > > >> example user of the inheritance support, convert kvm to use the new
> > > >> interface for passing the related file so that the anon inode can inherit
> > > >> the security attributes of /dev/kvm and provide consistent access control
> > > >> for subsequent ioctl operations.  Other users of anon inodes, including
> > > >> userfaultfd, will default to the transition-based mechanism instead.
> > > >>
> > > >> Compared to the series in
> > > >> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> > > >> this approach differs in that it does not require creation of a separate
> > > >> anonymous inode for each file (instead storing the per-instance security
> > > >> information in the file security blob), it applies labeling and control
> > > >> to all users of anonymous inodes rather than requiring opt-in via a new
> > > >> flag, it supports labeling based on a related inode if provided,
> > > >> it relies on type transitions to compute the label of the anon inode
> > > >> when there is no related inode, and it does not require introducing a new
> > > >> security class for each user of anonymous inodes.
> > > >>
> > > >> On the other hand, the approach in this patch does expose the name passed
> > > >> by the creator of the anon inode to the policy (an indirect mapping could
> > > >> be provided within SELinux if these names aren't considered to be stable),
> > > >> requires the definition of type_transition rules to distinguish userfaultfd
> > > >> inodes from proc inodes based on type since they share the same class,
> > > >> doesn't support denying the creation of anonymous inodes (making the hook
> > > >> added by this patch return something other than void is problematic due to
> > > >> it being called after the file is already allocated and error handling in
> > > >> the callers can't presently account for this scenario and end up calling
> > > >> release methods multiple times), and may be more expensive
> > > >> (security_transition_sid overhead on each anon inode allocation).
> > > >>
> > > >> We are primarily posting this RFC patch now so that the two different
> > > >> approaches can be concretely compared.  We anticipate a hybrid of the
> > > >> two approaches being the likely outcome in the end.  In particular
> > > >> if support for allocating a separate inode for each of these files
> > > >> is acceptable, then we would favor storing the security information
> > > >> in the inode security blob and using it instead of the file security
> > > >> blob.
> > > > Bringing this back up in hopes of attracting some attention from the
> > > > fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> > > > perspective we would prefer to attach the security blob to the inode
> > > > as opposed to the file struct; does anyone have any objections to
> > > > that?
> > >
> > > Sorry for the delay - been sick the past few days.
> > >
> > > I agree that the inode is a better place than the file for information
> > > about the inode. This is especially true for Smack, which uses
> > > multiple extended attributes in some cases. I don't believe that any
> > > except the access label will be relevant to anonymous inodes, but
> > > I can imagine security modules with policies that would.
> > >
> > > I am always an advocate of full xattr support. It goes a long
> > > way in reducing the number and complexity of special case interfaces.
> >
> > It sounds like we have broad consensus on using the inode to hold
> > security information, implying that anon_inodes should create new
> > inodes. Do any of the VFS people want to object?
>
> Ping?

I'd recommend refreshing your patch series to incorporate feedback on
the previous version and re-post,
including viro and linux-fsdevel on the cc, and see if they have any
comments on it.
