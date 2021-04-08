Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F53588F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhDHPzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhDHPzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:55:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FEC061761;
        Thu,  8 Apr 2021 08:55:04 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z3so2744619ioc.8;
        Thu, 08 Apr 2021 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw9LWPrQWc6kiLZPjcFQiKLeXLrHpXPrJsTzikBj3Ps=;
        b=PWpoenT+s9CtRQ74SpfnqSt7xp1pmjPptVmIlD2NiANMwpYbee+t39v4c2AKKxyLHl
         ayqkklZZW4Bdc6QhFPNSogAo1WtTIlVHarifnWUPhMjWymg4GBaIZTnqXM1sYAYI/SxY
         uvF6JTmVsdZZFwV8uPD1gdzZeRmgec5tpOI/8z6Z+tEPiHis5idchKvBGkruLEAYOBHl
         zUKr8m/cEFjGP9xy7bHT1vclK9vavRWn7nDHUgxgBAqDwu5UL4vk5osCREzVv3y6RlOV
         UFkOvkeMckEZJZiHdARbH3myv3LD5jxUdM4/cF2W9qiy3cEKKaFcgzZhVBlAHjjuH5Bw
         NM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw9LWPrQWc6kiLZPjcFQiKLeXLrHpXPrJsTzikBj3Ps=;
        b=MzQCiF91umSUootUEY3P7dVjnBtImPFqHQZMxANu0A+GlJ8RU0h89F5lZFoGL8n/G7
         gLRXcbMIwOM1yPdoOV71TBHpY2hnuNpMN4n6Atuv3hfQusMaWyg58z3BrVrnzxCGAB/N
         nFwYe+p+x/gltj96OB31Cg2OdU6ucyiQFMPp/DKXABOIs+nwRD5k3cYeNkUBFTjND5Jj
         WO+cBj9l5xoUsw4GbNYSd3qFBjlU1B5EXnOyQnYjL89AOmXewxmP0CRgIHSeZ7KGHkAr
         j4GPL2ODfs8O9pHAFJVLRXvsvpoElEMYexB6DPQTM+kBxNTQU7Z6sCsy0RZDmLpBDB+h
         w8bQ==
X-Gm-Message-State: AOAM531TwMeRBb422UCrgeD1OofSaB4kVX1nhdUmiLMGZhMfZpvuGorL
        eG3zleMwpC/7npxMxtubS60hRuO+3nDwzer+kpEdRu6NIH8=
X-Google-Smtp-Source: ABdhPJzA3yfw7DgGBSf46DAC+4h5MnP8TAINMsgEzOfsdl/Si2T+KFzxnSeFd98WS0Y4xiuy5Aj9rb/kSb0eoujpHIk=
X-Received: by 2002:a05:6602:2596:: with SMTP id p22mr7235872ioo.186.1617897303931;
 Thu, 08 Apr 2021 08:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
 <20210331100854.sdgtzma6ifj7w5yn@wittgenstein> <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com>
 <20210408125530.gnv5hqcmgewklypn@wittgenstein> <20210408141504.GB25439@fieldses.org>
In-Reply-To: <20210408141504.GB25439@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Apr 2021 18:54:52 +0300
Message-ID: <CAOQ4uxjkr_3d3KUkjMCtdpg===ZOPOwv41bUBkTppLmqRErHZQ@mail.gmail.com>
Subject: Re: open_by_handle_at() in userns
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 8, 2021 at 5:15 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Apr 08, 2021 at 02:55:30PM +0200, Christian Brauner wrote:
> > On Thu, Apr 08, 2021 at 02:44:47PM +0300, Amir Goldstein wrote:
> > > > One thing your patch
> > > >
> > > > commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Sat Mar 20 12:58:12 2021 +0200
> > > >
> > > >     fs: allow open by file handle inside userns
> > > >
> > > >     open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
> > > >     where most filesystems are mounted.
> > > >
> > > >     Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
> > > >     inside userns to open by file handle in filesystems that were
> > > >     mounted inside that userns.
> > > >
> > > >     In addition, also allow open by handle in an idmapped mount, which is
> > > >     mapped to the userns while verifying that the returned open file path
> > > >     is under the root of the idmapped mount.
> > > >
> > > >     This is going to be needed for setting an fanotify mark on a filesystem
> > > >     and watching events inside userns.
> > > >
> > > >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
> > > > open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
> > > > following and other callchains:
> > > >
> > > > exportfs_decode_fh()
> > > > -> exportfs_decode_fh_raw()
> > > >    -> lookup_one_len()
> > > >       -> inode_permission(mnt_userns, ...)
> > > >
> > > > That's not a huge problem though I did all these changes for the
> > > > overlayfs support for idmapped mounts I have in a branch from an earlier
> > > > version of the idmapped mounts patchset. Basically lookup_one_len(),
> > > > lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
> > > > the mnt_userns into account. I can rebase my change and send it for
> > > > consideration next cycle. If you can live without the
> > > > open_by_handle_at() support for now in this patchset (Which I think you
> > > > said you could.) then it's not a blocker either. Sorry for the
> > > > inconvenience.
> > > >
> > >
> > > Christian,
> > >
> > > I think making exportfs_decode_fh() idmapped mount aware is not
> > > enough, because when a dentry alias is found in dcache, none of
> > > those lookup functions are called.
> > >
> > > I think we will also need something like this:
> > > https://github.com/amir73il/linux/commits/fhandle_userns
> > >
> > > I factored-out a helper from nfsd_apcceptable() which implements
> > > the "subtree_check" nfsd logic and uses it for open_by_handle_at().
> > >
> > > I've also added a small patch to name_to_handle_at() with a UAPI
> > > change that could make these changes usable by userspace nfs
> > > server inside userns, but I have no demo nor tests for that and frankly,
> > > I have little incentive to try and promote this UAPI change without
> > > anybody asking for it...
> >
> > Ah, at first I was confused about why this would matter but it matters
> > because nfsd already implements a check of that sort directly in nfsd
> > independent of idmapped mounts:
> > https://github.com/amir73il/linux/commit/4bef9ff1718935b7b42afbae71cfaab7770e8436
>
> Only in the NFSEXP_NOSUBTREECHECK case.  Taking a quick look, I think
> Amir's not proposing a check like that by default, so, fine.  (I assume
> problems with e.g. subtreechecking and cross-directory renames are
> understood....)
>

They are understood to me :) but I didn't want to get into it, because it is
complicated to explain and I wasn't sure if anyone cared...

I started working on open_by_handle_at() in userns for fanotify and fanotify
mostly reports directory fhandle, so no issues with cross-directory renames.
In any case, fanotify never reports "connectable" non-dir file handles.

Because my proposed change ALSO makes it possible to start talking about
userspace nfs server inside userns (in case anyone cares), I wanted to lay
out the path towards a userspace "subtree_check" like solution.

Another thing I am contemplating is, if and when idmapped mount support
is added to overlayfs, we can store an additional "connectable" file handle
in the overlayfs index (whose key is the non-connectable fhandle) and
fix ovl_acceptable() similar to nfsd_acceptable() and then we will be able
to mount an overlayfs inside userns with nfs_export support.

I've included a two liner patch on the fhandle_userns branch to allow
overlayfs inside userns with nfs_export support in the case that
underlying filesystem was mounted inside userns, but that is not such
an interesting use case IMO.

Thanks,
Amir.
