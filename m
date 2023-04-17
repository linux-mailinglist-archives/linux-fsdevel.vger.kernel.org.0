Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4676E54B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDQWZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDQWZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:25:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE555BF
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 15:25:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a34a0b531so620173666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681770332; x=1684362332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt00rbj9rgdI6Ug4AbYJfSaFz4iI77Ju+ZOe9VQKlIc=;
        b=FiL9+YSoCE1R97NMZwM2RtD6vSqySeMgF56wqMYLsqFpwiTG/QLIvV55T/knBVtP6W
         yGDHNFylTUjq+76TU2w37mFbqB+a5omC/N4JUb+AOn8kKbFIbkNyJ8IVJG8kPZ/5IE3/
         0ey+qdplU05G2i70ZKFXa6qw/Utxm0Kj1MYpHYyiEL6YFuWjze1T1eG1n+g0eVPXoUVS
         d2ftIHzxj7Y2tYc/0h28J3au0IWKcns2YqCA2IkwrDo+lq87AxX7v1N7TM/d7DNtF3Cr
         hBiJdHIDYMYoihWOfjimIuFFx6EH1jSite/8bRWWrXeS2Ui9aI9iCQlXtcagT63KsG/a
         ZTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681770332; x=1684362332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt00rbj9rgdI6Ug4AbYJfSaFz4iI77Ju+ZOe9VQKlIc=;
        b=aAQ0D48Dy9oZKy16knBk43QOWiKAnnIrHft05az0GWdvx0FZOHw+YqKzJI60Vfhi2H
         mXEUef47GfxhEBs+1b8sxGZGU0oTtvSifLg/6/0DauVTcntimHWNPQdFG3QrN8+7/12c
         3nwMYFcoEIx8awPyQviRpnbxxKbbhBZYuym+Yc5ovYAUsZieLuaiwXnSRP0m1LH97f51
         8ZQqyq+qPVn9EvKkp8dSn1aiTsFcK5UvsZA9pL3j0+TFV7wAnO2Xj8LxEPGsgNsOm54H
         3Z4wBljmQY24DNE9gOpTj1G7KmXDOq6ILG9blwPUYkPOCxVJLIUzHEGuyKK6oRvnGG8s
         IxxQ==
X-Gm-Message-State: AAQBX9etKDAeOekdrfPqDeIFYAEZ+K6RmtjcLeEF6hW/xct1RgdNu1P2
        95sHuFNlWJW1bnDQ0YkH6WFxWleSM50CHssDeuQiZw==
X-Google-Smtp-Source: AKy350bDBlInZtw97ifc2L/SK40JpHMxmpsuB9frzAAUFImhuiXIg9tVM+ChZasByXsP9Adk38VZhNEls7kIDzxUCn8=
X-Received: by 2002:a50:9b43:0:b0:504:7857:d739 with SMTP id
 a3-20020a509b43000000b005047857d739mr218682edj.7.1681770332247; Mon, 17 Apr
 2023 15:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com> <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org> <20230416233758.GD447837@dread.disaster.area>
In-Reply-To: <20230416233758.GD447837@dread.disaster.area>
From:   Frank van der Linden <fvdl@google.com>
Date:   Mon, 17 Apr 2023 15:25:20 -0700
Message-ID: <CAPTztWbPLdvaErM1G3E1C6JqnVjx1PjoDrX7j=RAWGn8p06-zw@mail.gmail.com>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from nfsd_getxattr()/nfsd_listxattr()
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 4:38=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
> > On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
> > > On 2023/04/16 3:40, Jeff Layton wrote:
> > > > On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> > > > > On 2023/04/16 1:13, Chuck Lever III wrote:
> > > > > > > On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-l=
ove.SAKURA.ne.jp> wrote:
> > > > > > >
> > > > > > > Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNE=
L | GFP_NOFS
> > > > > > > does not make sense. Drop __GFP_FS flag in order to avoid dea=
dlock.
> > > > > >
> > > > > > The server side threads run in process context. GFP_KERNEL
> > > > > > is safe to use here -- as Jeff said, this code is not in
> > > > > > the server's reclaim path. Plenty of other call sites in
> > > > > > the NFS server code use GFP_KERNEL.
> > > > >
> > > > > GFP_KERNEL memory allocation calls filesystem's shrinker function=
s
> > > > > because of __GFP_FS flag. My understanding is
> > > > >
> > > > >   Whether this code is in memory reclaim path or not is irrelevan=
t.
> > > > >   Whether memory reclaim path might hold lock or not is relevant.
> > > > >
> > > > > . Therefore, question is, does nfsd hold i_rwsem during memory re=
claim path?
> > > > >
> > > >
> > > > No. At the time of these allocations, the i_rwsem is not held.
> > >
> > > Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
> > > via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) a=
llocation.
> > > That's why
> > >
> > >     /*
> > >      * We're holding i_rwsem - use GFP_NOFS.
> > >      */
> > >
> > > is explicitly there in nfsd_listxattr() side.
>
> You can do GFP_KERNEL allocations holding the i_rwsem just fine.
> All that it requires is the caller holds a reference to the inode,
> and at that point inode will should skip the given inode without
> every locking it.
>
> Of course, lockdep can't handle the "referenced inode lock ->
> fsreclaim -> unreferenced inode lock" pattern at all. It throws out
> false positives when it detects this because it's not aware of the
> fact that reference counts prevent inode lock recursion based
> deadlocks in the vfs inode cache shrinker.
>
> If a custom, non-vfs shrinker is walking inodes that have no
> references and taking i_rwsem in a way that can block without first
> checking whether it is safe to lock the inode in a deadlock free
> manner, they are doing the wrong thing and the custom shrinker needs
> to be fixed.
>
> > >
> > > If memory reclaim path (directly or indirectly via locking dependency=
) involves
> > > inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __G=
FP_FS flag.
> > >
> >
> > (cc'ing Frank V. who wrote this code and -fsdevel)
> >
> > I stand corrected! You're absolutely right that it's taking the i_rwsem
> > for read there. That seems pretty weird, actually. I don't believe we
> > need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
> > certainly nothing else under there requires it.
> >
> > Frank, was there some reason you decided you needed the inode_lock
> > there? It looks like under the hood, the xattr code requires you to tak=
e
> > it for write in setxattr and removexattr, but you don't need it at all
> > in getxattr or listxattr. Go figure.
>
> IIRC, the filesytsem can't take the i_rwsem for get/listxattr
> because the lookup contexts may already hold the i_rwsem. I think
> this is largely a problem caused by LSMs (e.g. IMA) needing to
> access security xattrs in paths where the inode is already
> locked.
>
> > Longer term, I wonder what the inode_lock is protecting in setxattr and
> > removexattr operations, given that get and list don't require them?
> > These are always delegated to the filesystem driver -- there is no
> > generic xattr implementation.
>
> Serialising updates against each other. xattr modifications are
> supposed to be "atomic" from the perspective of the user - they see
> the entire old or the new xattr, never a partial value.
>
> FWIW, XFS uses it's internal metadata rwsem for access/update
> serialisation of xattrs because we can't rely on the i_rwsem for
> reliable serialisation. I'm guessing that most journalling
> filesystems do something similar.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

Sorry about the slow response - thanks Chuck for adding my
correct/updated email address.

As Dave notes, you need inode_lock to get an atomic view of an xattr.
Since both nfsd_getxattr and nfsd_listxattr to the standard trick of
querying the xattr length with a NULL buf argument (just getting the
length back), allocating the right buffer size, and then querying
again, they need to hold the inode lock to avoid having the xattr
changed from under them while doing that.

From that then flows the requirement that GFP_FS could cause problems
while holding i_rwsem, so I added GFP_NOFS.

If any of these requirements have changed since then, obviously this
should be fixed. But I don't think they have, right?

- Frank
