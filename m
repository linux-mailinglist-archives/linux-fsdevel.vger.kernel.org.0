Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741557B4B44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 07:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjJBF5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjJBF5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:57:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5C9B
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 22:57:07 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-452863742f3so7668213137.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696226227; x=1696831027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gien0z0Vm5xJbW0wKMIHzxeXkG2/DaaDfFcv7+QMF9E=;
        b=NFGzT6zBQTe53aqRuaECyZ+Y2RMxPpCrYJhwx0EwVhVpGXSGCGk6LXCDRwMdr/JhPO
         MSk/TELxxq3TaNeSAui95cisnnPLpA20IzLjnYFF6hur4jGwMXYc6XXhIMQMEbNnTAMn
         tdjFi5eaIRh2rCFciizjXw/v255eLqA0TEjg/z9x7siGM9kz28ijgR3e+T+y9jb8ExPP
         Q4vNg2t2qiBCThytOPAnIUuxn11Y+msYHb57bGhBhrck1I6WDFUnG8c4YkSSRX2TNxZL
         0tfDgujY/ycEKvadqaWidtt9AzcWbcw5E41MVJBjhkq9EN1wQEfAD1/R0sB4hg2erEgB
         FwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696226227; x=1696831027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gien0z0Vm5xJbW0wKMIHzxeXkG2/DaaDfFcv7+QMF9E=;
        b=X+diEk+nNlrxyhOA8Ahc9x1a9R324TetYI+tyJ/9UcHK91/Mbk6pIRR65WkpBTtrgP
         kcbG7v+hRvDDWVtbrpwpsP+av0kLcPhZ/QCVckKlDiUIkYXTtAzhW5nULCh+2j72hCFK
         HUMabmgcBSjRbVLhk7Dpw81HsGgC1ar1mcVZlMH/tSN5jSuIYAJeJA0zjzeTHLLZqdYj
         sOA07CcJDL4KcsqmnnDND3IQKYojZC6bH/m1+j4fqr8bsAZ9Hsiq6sdDkERTzleFE2Vl
         X81aQeUHDvBM0EwvgZtPrewrDZwoTkNsoVN4TlQ0MNcXMCEGrScimHbVnfdKzr0lnXno
         pzNw==
X-Gm-Message-State: AOJu0Yzl8SaDLSd69OwbJa/oRDRd/atngZnn2cgLpJvDhgZyF/kDfhY9
        mo88n6avqvr1iw5ODeJyxUhUwHKbpnGe1sy7m4o=
X-Google-Smtp-Source: AGHT+IEYPYpToe/d5j3hT8X/IEUHaipd1BN6qDU+gZAXNdjaZ7zKLT1PgUqgo5yRJrv6Tazh7+0mrBn4tpy6LLMTdZA=
X-Received: by 2002:a67:bb1a:0:b0:44d:476b:3bbd with SMTP id
 m26-20020a67bb1a000000b0044d476b3bbdmr9966154vsn.0.1696226226737; Sun, 01 Oct
 2023 22:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV> <20231002023643.GO3389589@ZenIV> <CAOQ4uxjLuk9XF8Yhy8Ym2Zt_iquKojY9-Yyxz9w8kV0CTooEmw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjLuk9XF8Yhy8Ym2Zt_iquKojY9-Yyxz9w8kV0CTooEmw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 08:56:55 +0300
Message-ID: <CAOQ4uxgedDFLmjjkWQEnqXD+n-O+1hJ9SbPpizk93YJ0HFp0vw@mail.gmail.com>
Subject: Re: [PATCH 14/15] ovl_dentry_revalidate_common(): fetch inode once
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 8:47=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Oct 2, 2023 at 5:36=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> >
> > d_inode_rcu() is right - we might be in rcu pathwalk;
> > however, OVL_E() hides plain d_inode() on the same dentry...
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> However, ovl_lowerstack(oe) does not appear to be stable in RCU walk...
>

Ah, you fixed that in another patch.
If you are going to be sending this to Linus, please add
Fixes: a6ff2bc0be17 ("ovl: use OVL_E() and OVL_E_FLAGS() accessors")

I was going to send some fixes this week anyway, so I can
pick those through the overlayfs tree if you like.

Thanks,
Amir.

> > ---
> >  fs/overlayfs/super.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index f09184b865ec..905d3aaf4e55 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -104,8 +104,8 @@ static int ovl_revalidate_real(struct dentry *d, un=
signed int flags, bool weak)
> >  static int ovl_dentry_revalidate_common(struct dentry *dentry,
> >                                         unsigned int flags, bool weak)
> >  {
> > -       struct ovl_entry *oe =3D OVL_E(dentry);
> > -       struct ovl_path *lowerstack =3D ovl_lowerstack(oe);
> > +       struct ovl_entry *oe;
> > +       struct ovl_path *lowerstack;
> >         struct inode *inode =3D d_inode_rcu(dentry);
> >         struct dentry *upper;
> >         unsigned int i;
> > @@ -115,6 +115,8 @@ static int ovl_dentry_revalidate_common(struct dent=
ry *dentry,
> >         if (!inode)
> >                 return -ECHILD;
> >
> > +       oe =3D OVL_I_E(inode);
> > +       lowerstack =3D ovl_lowerstack(oe);
> >         upper =3D ovl_i_dentry_upper(inode);
> >         if (upper)
> >                 ret =3D ovl_revalidate_real(upper, flags, weak);
> > --
> > 2.39.2
> >
