Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAC4E61D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349538AbiCXKg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:36:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698A6D955;
        Thu, 24 Mar 2022 03:34:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so2977128otk.8;
        Thu, 24 Mar 2022 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkUOtyTHE/TYF3m2vqOCfIm2T9ySzNIzBEKj/tfGQiA=;
        b=IjGlTehpEGtuYtSpr81vczsx73SdQa/f7uvnLaVxETKjnKAUSvlzJEnv/BiHQMRZ0n
         n1F96baOYoQNOFo6YmOcPq5nw7v9sq/bnT5xIbTzA9OQEbLdSwjwbyyRmsDVCHYhltLi
         wU20EnegAcKOUheWyZAYk1p5OLZUnY5K4ULqL0NOPNWMj+2Vya3W3Rn1sM8GOxohMzSY
         tuvbYMaq5Ix/137uTdxfusAwDk6ztd+fmdbN058ynV/JjWBbKdtxm/vxZ05qNQZZUJoP
         PYHH91cMRp289yd4itig77E6QdTlxk2F6wKIyXGDVhnf0XMpxWaNtafX5LuSKlSbErcp
         G2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkUOtyTHE/TYF3m2vqOCfIm2T9ySzNIzBEKj/tfGQiA=;
        b=VX7urL+W/0zctLzsvd1MB6FycMQLnaLsfnU2rGQpPx5Qu9rcygJi1TOKsRVb82RMxs
         /j09rG7+Bs95g5fMexQv65g85cXAvRfhq2oau85+r6yhDvUqTtQiCXT5Ga0Wd/uskBV9
         GyX+cqdQZ73joz+7I+iR1BCRjFAQJwVF+BFOsU0skQi3LqWEEdsZULjd35V8OUU/7zoz
         x/i7oewEFEmvy/E037XvJp12orNOyI+OHtI06RlTl75X6LM6m+yhB3HUFXuNa3XiiDrP
         rw7FwXlxZAp3/HlHGDp9w00fPbwcKLhYXhv0aBIgfMeuKFln7CmkPVEKfFODgUfxCfp8
         GvCg==
X-Gm-Message-State: AOAM5332W9GixEZVa/KSqWK6mRiMUMxmnu43THK4BQwQPJX17vgZLR5K
        Eau2chewcM+Ie0xN8NLY2pjPKHaV4op8+I8e7yeKxqJMP/Y=
X-Google-Smtp-Source: ABdhPJy7l9oWwPJ6OBUoAM36bkcS3M/p+SgBdY21YnbhlrHpkdnSvtMHV60SdyXuXWDEemHIwn3a/agyAEnhEiMyBKI=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr1700616oti.275.1648118094832; Thu, 24
 Mar 2022 03:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323225843.GI1609613@dread.disaster.area>
 <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
In-Reply-To: <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Mar 2022 12:34:43 +0200
Message-ID: <CAOQ4uxhbm2mtTp8PmgEq5KmwTe0n6MRRGhShXM=Ot6Bz87HXjA@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I've said in the past when discussing things like statx() that maybe
> > everything should be addressable via the xattr namespace and
> > set/queried via xattr names regardless of how the filesystem stores
> > the data. The VFS/filesystem simply translates the name to the
> > storage location of the information. It might be held in xattrs, but
> > it could just be a flag bit in an inode field.
>
> Right, that would definitely make sense for inode attributes.

Why limit to inode attributes?
The argument of getxattr()/fgetxattr() is exactly the same as
the argument for statfs()fstatfs() and the latter returns the attributes
of the sb and the mnt (i.e. calculate_f_flags()).

I don't see a problem with querying attributes of a mount/sb the same
way as long as the namespace is clear about what is the object that
is being queried (e.g. getxattr(path, "fsinfo.sbiostats.rchar",...).

>
> What about other objects' attributes, statistics?   Remember this
> started out as a way to replace /proc/self/mountinfo with something
> that can query individual mount.
>
> > > mnt                    - list of mount parameters
> > > mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
> > > mntns                  - list of mount ID's reachable from the current root
> > > mntns:21:parentid      - parent ID of the mount with ID of 21
> > > xattr:security.selinux - the security.selinux extended attribute
> > > data:foo/bar           - the data contained in file $ORIGIN/foo/bar
> >
> > How are these different from just declaring new xattr namespaces for
> > these things. e.g. open any file and list the xattrs in the
> > xattr:mount.mnt namespace to get the list of mount parameters for
> > that mount.
>
> Okay.
>
> > Why do we need a new "xattr in everything but name" interface when
> > we could just extend the one we've already got and formalise a new,
> > cleaner version of xattr batch APIs that have been around for 20-odd
> > years already?
>
> Seems to make sense. But...will listxattr list everyting recursively?
> I guess that won't work, better just list traditional xattrs,
> otherwise we'll likely get regressions, and anyway the point of a
> hierarchical namespace is to be able to list nodes on each level.  We
> can use getxattr() for this purpose, just like getvalues() does in the
> above example.
>

FYI, there are already precedents for "virtual" xattrs, see the user.smb3.*
family in fs/cifs/xattr.c for example.

Those cifs "virtual" (or "remote") xattrs are not listed by listxattr, even
though they ARE properties of the file which are very relevant for backup.

Currently, they use the user.* namespace, but the values could be
also exposed via a more generic fsinfo.* namespace that is dedicated
to these sort of things and then, as you suggest, getxattr(path, "fsinfo",...)
can list "smb3" for cifs.

I like where this is going :)

Thanks,
Amir.
