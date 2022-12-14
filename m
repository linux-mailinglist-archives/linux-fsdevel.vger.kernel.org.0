Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764764CE2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiLNQhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLNQh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:37:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D419331;
        Wed, 14 Dec 2022 08:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B62261B40;
        Wed, 14 Dec 2022 16:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED368C43396;
        Wed, 14 Dec 2022 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671035848;
        bh=zvv+vPRRo6jzZG+a+gegoT4F9zjoLrsxk+RITIkc/cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfZLQh8qtV2CerhiiZLadKDr7n7JbzA11RBg09s8p5kvrqBm7lctfyLwKjVVnmPnE
         NyRSrfClm+mH9m6az94WoqEtapgV33UHbIQ6JVHNHxds368UjQ847aO5CIWTRPsvt4
         6Y3vYf/jKrqAw2kg3wWfC4mbx7DIm5IE5IWbf/+6NewqYwN4eZdkdddq8ryeMQog2m
         1ituR4r2ocaYAKCFmlCB5uvtWRtNQkkoYM/qTx81EBtCebxxGjEc9sZzE80wKon6rN
         KhJGmw6r0z1XpECELZLtY3vhzs5cKuoQUUrwLq3dN0hcd6Ny5hiqDS9v6OETPy8Hr/
         9PtFOGlLdBR0Q==
Received: by mail-qk1-f180.google.com with SMTP id j26so1480710qki.10;
        Wed, 14 Dec 2022 08:37:27 -0800 (PST)
X-Gm-Message-State: ANoB5plj8CM3bG2rc3bo6kModR+E9ndeUBlsqEyMvGNW+W4vifNcGgsn
        zrShdoUTcWY2qPt98i7zOBvpGJiqiUZEKpEAqkE=
X-Google-Smtp-Source: AA0mqf5s2DLFs0U/eCuffsJwlt7OF4LnyztZpQaM6mL3Psyuc6glLUtOp7SRQRjMVETlIvU9luE8je34rSZzDNwN8wg=
X-Received: by 2002:a37:9a43:0:b0:6fe:c3d4:d9f4 with SMTP id
 c64-20020a379a43000000b006fec3d4d9f4mr12837348qke.646.1671035846942; Wed, 14
 Dec 2022 08:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20221207084309.8499-1-richard@nod.at> <20221207084309.8499-4-richard@nod.at>
 <92B44C88-61B5-4450-B027-60F9F7A614FF@oracle.com>
In-Reply-To: <92B44C88-61B5-4450-B027-60F9F7A614FF@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 14 Dec 2022 11:37:11 -0500
X-Gmail-Original-Message-ID: <CAFX2JfmTqQaWf2cB8QY3vTGzrrMStTGmCGWgthoqVJmcwpz8EA@mail.gmail.com>
Message-ID: <CAFX2JfmTqQaWf2cB8QY3vTGzrrMStTGmCGWgthoqVJmcwpz8EA@mail.gmail.com>
Subject: Re: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:09 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
> >
> > Now with NFSD being able to cross into auto mounts,
> > the check can be removed.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > fs/nfs/export.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index 01596f2d0a1e..0a5ee1754d50 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -42,7 +42,7 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_len, struct inode *parent)
> >       dprintk("%s: max fh len %d inode %p parent %p",
> >               __func__, *max_len, inode, parent);
> >
> > -     if (*max_len < len || IS_AUTOMOUNT(inode)) {
> > +     if (*max_len < len) {
> >               dprintk("%s: fh len %d too small, required %d\n",
> >                       __func__, *max_len, len);
> >               *max_len = len;
> > --
> > 2.26.2
> >
>
> I plan to take this through the nfsd tree, thus this one needs
> an Ack from the NFS client maintainers.

Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

>
> --
> Chuck Lever
>
>
>
