Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F67296BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbjFIKVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbjFIKUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:20:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DABA5278
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 03:12:31 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 258DF3F13F
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686305548;
        bh=x/LSfzy08peg5Has0ch83FB0MT7KpddVcyNy/Fniu5c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Wq9Q+d/j5hGl2DjwYMXR16thBG6lOLEuJPhLRTWlR4//ip8GEttvIu+SDnXgbCbxy
         fUCyt5zHBiiblDAFXjQw+xYUTwgQWTKjKKByLQHKgdJF04KEB5FBX6ZoWIvw/6+BRa
         x+iKkqEHsQ3/H3f2iBc/sQEnXjs7M9Gq7d6k9WeYfCVZwbaTCpZf/ji1cwJ5MZrh1n
         +mtL7lXNtRYG8vmxafoo6M2Bemm9aEUMBpUDWUpCs9O7MZOYzSqxB47gMZPwLzLJik
         g50O+vkKQt+WHxS6FZQlCNs1IUARSVT/myLe3xmIBdaXXcO+at5DjWcxuzQ3Dwrl2G
         cQe1kuISN58eA==
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-ba8c3186735so2191591276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 03:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305547; x=1688897547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/LSfzy08peg5Has0ch83FB0MT7KpddVcyNy/Fniu5c=;
        b=R442E80lf6/AzibWcfjk/IXbBFxQgEbnVkPuo1O8GHp+RCdQimKncyRRuVgjOnRstQ
         yCGieJqNLeW5yIO4cAcGtR1fG6/0sDGqQiJphb9LtCbTwTfMSX4buvEEWm/rMdeoVRHK
         ECiS7hBEJ4ndSWfP5P5J6UT2Mxts6X3t0EmrD4UnIxN2AnY2uPlAR9y+2bUbRH0NtmOK
         PnZQ2jnXnHsI0cCA7dnCpdHWYrIjvixMbbEldSDnABhn4wTTFMGzYvXsTw/IstW8ltFE
         23bv1nyFnMwxgzWzc0UHh0lKPjswlyn3WZTq1cbH+33fEwZSGnibQ6WAxgSN8h6Ix+1v
         V9zQ==
X-Gm-Message-State: AC+VfDy2rplr9ooYfsYDzb788xfwOTOPla3Ba8vkPfM5SLizjwCXfrb3
        tDPfCqEsg5u53sOeuU2Bf716SA+kpVplGr8AB3V3G9ekNskKztd3kqw5/Nq9pC+jkxj4ChaAFZX
        IT6zm7XDtttMLZNJV9cFLW5S7eOptxrpdMrVFuKCWMEYWBKrPDt50xxr242o=
X-Received: by 2002:a5b:2d1:0:b0:bbb:5379:1057 with SMTP id h17-20020a5b02d1000000b00bbb53791057mr611006ybp.37.1686305547145;
        Fri, 09 Jun 2023 03:12:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/3qzoKWt8hDAny2WmyojQZZsunUGWqY6SACiSO0yUcMPghu0JofawuvNMelaRZTvn+wgf9Vf6eEW9pN5zzT8=
X-Received: by 2002:a5b:2d1:0:b0:bbb:5379:1057 with SMTP id
 h17-20020a5b02d1000000b00bbb53791057mr610994ybp.37.1686305546889; Fri, 09 Jun
 2023 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
In-Reply-To: <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 9 Jun 2023 12:12:15 +0200
Message-ID: <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrote:
> > On Fri, Jun 9, 2023 at 3:57=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wro=
te:
> > >
> > >
> > > On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> > > > Dear friends,
> > > >
> > > > This patchset was originally developed by Christian Brauner but I'l=
l continue
> > > > to push it forward. Christian allowed me to do that :)
> > > >
> > > > This feature is already actively used/tested with LXD/LXC project.
> > > >
> > > > Git tree (based on https://github.com/ceph/ceph-client.git master):
> >
> > Hi Xiubo!
> >
> > >
> > > Could you rebase these patches to 'testing' branch ?
> >
> > Will do in -v6.
> >
> > >
> > > And you still have missed several places, for example the following c=
ases:
> > >
> > >
> > >     1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> > >               req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETA=
TTR,
> > > mode);
> >
> > +
> >
> > >     2    389  fs/ceph/dir.c <<ceph_readdir>>
> > >               req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS=
);
> >
> > +
> >
> > >     3    789  fs/ceph/dir.c <<ceph_lookup>>
> > >               req =3D ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS)=
;
> >
> > We don't have an idmapping passed to lookup from the VFS layer. As I
> > mentioned before, it's just impossible now.
>
> ->lookup() doesn't deal with idmappings and really can't otherwise you
> risk ending up with inode aliasing which is really not something you
> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wide
> value. So better not even risk exposing the idmapping in there at all.

Thanks for adding, Christian!

I agree, every time when we use an idmapping we need to be careful with
what we map. AFAIU, inode->i_{g,u}id should be based on the filesystem
idmapping (not mount),
but in this case, Xiubo want's current_fs{u,g}id to be mapped
according to an idmapping.
Anyway, it's impossible at now and IMHO, until we don't have any
practical use case where
UID/GID-based path restriction is used in combination with idmapped
mounts it's not worth to
make such big changes in the VFS layer.

May be I'm not right, but it seems like UID/GID-based path restriction
is not a widespread
feature and I can hardly imagine it to be used with the container
workloads (for instance),
because it will require to always keep in sync MDS permissions
configuration with the
possible UID/GID ranges on the client. It looks like a nightmare for sysadm=
in.
It is useful when cephfs is used as an external storage on the host, but if=
 you
share cephfs with a few containers with different user namespaces idmapping=
...

Kind regards,
Alex
