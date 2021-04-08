Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB92358896
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhDHPe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHPe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:34:26 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB3C061760;
        Thu,  8 Apr 2021 08:34:13 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p8so2119926ilm.13;
        Thu, 08 Apr 2021 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LU8x7lnSesMn3yP0g3CLR2macH3T/sUXQfh2XvsVGj4=;
        b=X+4f4gVMuhlAnKPwA+tk8KcjygEhEQP2lPOmaL9CyMjZWpuzC7nHNqBtvnvIJBVvR/
         naUjGc51ZbXC2tWSVIXKbu7outTVBtI8DKj8EKRUrbVmzsCFp4Q8CpUmScuKymZI8sYM
         ibpw0PgxEXq6G7FMgHqXQ6TuFt2NwojkbJ/UD4G1GdLF/9+uPT3LLk/BrZYmyWUU4Q3v
         IQDbhz5UqP3Pyz2fWwWCNQykrcdBrR42IHZlrHHWyUbA1zDBwIOrRNYEHqkcxFGktp72
         HFilDDgwSdop+mrpn6dGR2IrFzWu2RtHNz7Sw8Ii5Mnq0r0NVuezAA4B8SJJqFIXhqYL
         6pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LU8x7lnSesMn3yP0g3CLR2macH3T/sUXQfh2XvsVGj4=;
        b=AnCq9PufuU10vPFCtCDK8rxFiVvv5zwmpmpx0zVphiiQCk7gA2fYB1pJ8a0e9S86df
         8eR9JvcyYy4g5Vlp2Bw8EqVA24xnNZw6vfvG8cWbz1kG6eqectuxrVTVhfVdXV6lRDbo
         9Q49CNXcKnjRaT843AoKM0zXgPTchMQsRKh1cQYGESlwnHbXgOvNAolsdb0mxaL9OxQb
         A/0LA1J+cXCWrXkeARd3JH1TWhfn6Fo/DI7fcyva1jDwhdn0WhxVgs31g4JvN51LnWQq
         L0Hi/afgmyFoBx/XqWjQF0qiHd1TQdfUXiC/AL+ZQ0p/PcxzETtW6+rmsqluzdw6tw7C
         gOxQ==
X-Gm-Message-State: AOAM533bYB8dqM8km6sd+Y+X2/W0tugm3ud+AWg28g7/DdAVb+ExBT/L
        xS6KyMyrXmRfVDZpt0qXo9C+px2iSdviyXkolk0=
X-Google-Smtp-Source: ABdhPJw2iWGvP/6vnROopYLNy/OK/UPlINec5P4+geYJoDDYKH8pa2ZyYm6CmodXFCmWw20lF7zXG+DRUruxilQ3dZE=
X-Received: by 2002:a92:cd0d:: with SMTP id z13mr7745480iln.250.1617896052678;
 Thu, 08 Apr 2021 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
 <20210331100854.sdgtzma6ifj7w5yn@wittgenstein> <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com>
 <20210408125530.gnv5hqcmgewklypn@wittgenstein>
In-Reply-To: <20210408125530.gnv5hqcmgewklypn@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Apr 2021 18:34:01 +0300
Message-ID: <CAOQ4uxi=jKRxLoRs=fNh96zAzqeoG5OZrOi6i7m7Ooy8b5zxBA@mail.gmail.com>
Subject: Re: open_by_handle_at() in userns
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 8, 2021 at 3:55 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Apr 08, 2021 at 02:44:47PM +0300, Amir Goldstein wrote:
> > > One thing your patch
> > >
> > > commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Sat Mar 20 12:58:12 2021 +0200
> > >
> > >     fs: allow open by file handle inside userns
> > >
> > >     open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
> > >     where most filesystems are mounted.
> > >
> > >     Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
> > >     inside userns to open by file handle in filesystems that were
> > >     mounted inside that userns.
> > >
> > >     In addition, also allow open by handle in an idmapped mount, which is
> > >     mapped to the userns while verifying that the returned open file path
> > >     is under the root of the idmapped mount.
> > >
> > >     This is going to be needed for setting an fanotify mark on a filesystem
> > >     and watching events inside userns.
> > >
> > >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
> > > open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
> > > following and other callchains:
> > >
> > > exportfs_decode_fh()
> > > -> exportfs_decode_fh_raw()
> > >    -> lookup_one_len()
> > >       -> inode_permission(mnt_userns, ...)
> > >
> > > That's not a huge problem though I did all these changes for the
> > > overlayfs support for idmapped mounts I have in a branch from an earlier
> > > version of the idmapped mounts patchset. Basically lookup_one_len(),
> > > lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
> > > the mnt_userns into account. I can rebase my change and send it for
> > > consideration next cycle. If you can live without the
> > > open_by_handle_at() support for now in this patchset (Which I think you
> > > said you could.) then it's not a blocker either. Sorry for the
> > > inconvenience.
> > >
> >
> > Christian,
> >
> > I think making exportfs_decode_fh() idmapped mount aware is not
> > enough, because when a dentry alias is found in dcache, none of
> > those lookup functions are called.
> >
> > I think we will also need something like this:
> > https://github.com/amir73il/linux/commits/fhandle_userns
> >
> > I factored-out a helper from nfsd_apcceptable() which implements
> > the "subtree_check" nfsd logic and uses it for open_by_handle_at().
> >
> > I've also added a small patch to name_to_handle_at() with a UAPI
> > change that could make these changes usable by userspace nfs
> > server inside userns, but I have no demo nor tests for that and frankly,
> > I have little incentive to try and promote this UAPI change without
> > anybody asking for it...
>
> Ah, at first I was confused about why this would matter but it matters
> because nfsd already implements a check of that sort directly in nfsd
> independent of idmapped mounts:
> https://github.com/amir73il/linux/commit/4bef9ff1718935b7b42afbae71cfaab7770e8436
>

The check is needed for slightly different reasons.
nfsd "subtree_check" feature explicitly meant to forbid access in case
file was moved "out of reach", for example, out of the export path.
Note the nfsd "subtree_check" affects both file handle encoding
(i.e. "connectable") and file handle decoding (i.e. nfsd_acceptable()).

open_by_handle_at() in idmapped mount needs to verify that the ancestry
inode owners can be mapped to the userns, because we already checked
that user has CAP_DAC_READ_SEARCH in userns, but it's nicer to do
the full inode_permission() check IMO.

> Afaict, an nfs server can't be mounted inside of userns right now. That
> is something that folks from Netflix and from Kinvolk have been
> interested in enabling. They also want the ability to use idmapped
> mounts + nfs. Understandable that you don't want to drive this of
> course. I'll sync with them about this.
>
> Independent of that, I thought our last understanding was that you
> wouldn't need to handle open_by_handle_at() for now.
>

I don't need it. But I realized that the fanotify_userns demo branch
I provided you is buggy in terms of security, so I wanted to give you
(or whoever wants to pursue this) a better reference.
It was one of those things that are easier to code than to explain ;-)

Thanks,
Amir.
