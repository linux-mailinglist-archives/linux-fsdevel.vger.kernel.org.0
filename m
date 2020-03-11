Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85821819C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgCKNaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 09:30:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32790 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgCKNaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:30:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id r7so1886512oij.0;
        Wed, 11 Mar 2020 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsSuSLKEfu3I1SAJl6xAjr3wjSOLPeFy3yPY3Iv28F8=;
        b=O63n39UljFStteXPWaHbRbdpOd2uAMy0s5j2fnaLfILxlCicixRYjHxQw6QvFk++1b
         VaGfDRjDs1bbaWSa4F64rl+av5D5RoudRzzzYBvbXP8ZHU6oiBIUnnud29vhj85vpwHu
         LHpSKss9nDNTi3xXzDulVL99eHFHJgf9/eYIQk2qA9+HwTifaclc4a9B7vluubeFe+eM
         LWsG3GcAZOYFOp8996mmBZ177nTLZzQNxrbEXCCH7Aj4mGIMNkT5rKcUwm/kBge5Epa/
         hbTvvnIXyorhpxoO9xjdlF8PkkXrEpHn7RUAN89qb4Dh+48hY9BfwZkHd3NPSydmQUGl
         jVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsSuSLKEfu3I1SAJl6xAjr3wjSOLPeFy3yPY3Iv28F8=;
        b=sJhqy5qCwY0coQYSHPGsdHIv1pvXGIA2RrPP7XlRXdlUBOLlbEhFnkI0eOF/mXArN/
         ZPDJTzZkqO0rKX2yKZMumj1GDmKcbaKxbHMGyfICT031H8XWlaVFUiF2wbRI+6etejim
         2YHQqKjdNBUZ8/2c5ijy53w4BQS0RzdaAqqxYK2tCldp+T6/jXswvjmMxmMMka+PLoP5
         +1AUhwbWvcE0Y5V+0ipx8+Bl0bDWBNANq7luye9lYPkKwwCXkvNN5ocVjcRul5KQXHSH
         GuIHVKHLGtZ5uq3gsEAqvryKiqEqnGj0l+WW2jJNN4l+RxM769GbYe4VgalV57I5Uwyh
         i3FA==
X-Gm-Message-State: ANhLgQ2XuStqeHLMwv6499PxPg8aaFarLDeb1BvQWVRyHz1F8ewfZjqB
        7CKWCzyuj5YE0YZRmWiGBAUn1O3eyuTstF4uv1A=
X-Google-Smtp-Source: ADFU+vtFqcIvIEMwdHZH1rUNUjfICLAyZmD0fE5Ggd/lDRNjab4mHbySl80mFwEwNzKaMPjOQGEMFq6AFbJCgSHIM9c=
X-Received: by 2002:aca:3544:: with SMTP id c65mr1865799oia.160.1583933434832;
 Wed, 11 Mar 2020 06:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov> <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
 <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com> <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
 <CAKOZuetUvu=maOmHXjCqkHaYEN5Sf+pKBc3BZ+qpy1tE1NJ9xQ@mail.gmail.com>
 <CAEjxPJ4+NM6-tfOeZ6UQfas6=KxtBTAk6f23GEyLomFn3K3qew@mail.gmail.com> <CAKOZuevcz+fvfhRXPx2iZGtkk6+FjVj3ZSaGGT8DfwsOJR0k3A@mail.gmail.com>
In-Reply-To: <CAKOZuevcz+fvfhRXPx2iZGtkk6+FjVj3ZSaGGT8DfwsOJR0k3A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 09:31:34 -0400
Message-ID: <CAEjxPJ7DykRX7Q1NLhtRh123rjAvW4t6symJ5ochth+iCyg3kg@mail.gmail.com>
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

On Tue, Mar 10, 2020 at 5:51 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Mar 10, 2020 at 11:25 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 2:11 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Thu, Feb 20, 2020 at 10:50 AM Daniel Colascione <dancol@google.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2020 at 10:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > >
> > > > > On 2/17/2020 4:14 PM, Paul Moore wrote:
> > > > > > On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > > >> We are primarily posting this RFC patch now so that the two different
> > > > > >> approaches can be concretely compared.  We anticipate a hybrid of the
> > > > > >> two approaches being the likely outcome in the end.  In particular
> > > > > >> if support for allocating a separate inode for each of these files
> > > > > >> is acceptable, then we would favor storing the security information
> > > > > >> in the inode security blob and using it instead of the file security
> > > > > >> blob.
> > > > > > Bringing this back up in hopes of attracting some attention from the
> > > > > > fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> > > > > > perspective we would prefer to attach the security blob to the inode
> > > > > > as opposed to the file struct; does anyone have any objections to
> > > > > > that?
> > > > >
> > > > > Sorry for the delay - been sick the past few days.
> > > > >
> > > > > I agree that the inode is a better place than the file for information
> > > > > about the inode. This is especially true for Smack, which uses
> > > > > multiple extended attributes in some cases. I don't believe that any
> > > > > except the access label will be relevant to anonymous inodes, but
> > > > > I can imagine security modules with policies that would.
> > > > >
> > > > > I am always an advocate of full xattr support. It goes a long
> > > > > way in reducing the number and complexity of special case interfaces.
> > > >
> > > > It sounds like we have broad consensus on using the inode to hold
> > > > security information, implying that anon_inodes should create new
> > > > inodes. Do any of the VFS people want to object?
> > >
> > > Ping?
> >
> > I'd recommend refreshing your patch series to incorporate feedback on
> > the previous version and re-post,
> > including viro and linux-fsdevel on the cc, and see if they have any
> > comments on it.
>
> I don't think there's anything in the patch series that needs to
> change right now. AFAICT, we're still just waiting on comment from the
> VFS people, who should be on this thread. Did I miss something?

There was some discussion on the SELinux bits in patch 2/3.  I would
take the silence on
the vfs bits as implicit acceptance until you hear otherwise and just
submit a v2 that addresses
the SELinux bits.
