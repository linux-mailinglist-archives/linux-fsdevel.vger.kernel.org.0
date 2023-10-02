Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0377B4B35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjJBFrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 01:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:47:54 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B0DAC
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 22:47:51 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49d45964fcaso948513e0c.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696225670; x=1696830470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYdCG1fJDSqcFx6LvR5aXujiB2i7d0hlqSkabIgD6lQ=;
        b=J0GsZ4jViC1io8YXU4zPZkUI2ngseZwdwuN+Pgf6Amaqk/ZkI0apu0zESm2MIeTAf5
         H/rQNmFiWrKBYARRaGu7/BN4DK6AO7Lhm7Y64YUpAs+LkgtcyqUoBjWesOK2WYfj0fKe
         c4YzkyLV0XM+Aa0/HNmovP9UB2MXYj99COhTD8RRzq5S2qcJYM/QXhIzqytd2dsCAydO
         kftBYYyCk9l8aCy9qdrgUkjNDZ9Z/XSc7vr6vTz23YtAuwtOreWtPdWJxyca/hbQf76x
         SFHWzFo513K5kHdwltFPfNPapKuixKdZ8HQwq0qTLwz0nDUZgOtqDNRsa9Ac1MWUnB40
         fxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696225670; x=1696830470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYdCG1fJDSqcFx6LvR5aXujiB2i7d0hlqSkabIgD6lQ=;
        b=snWxDAnFiovjYQ3P9rqY/tTCbVaHQHTKSOXHg/PzySb+B93Y6hsmZUVXn4gx60OODO
         VFsXAIkehB4EBuAJRqzbclIm9+L6f9J+N5E0qcGnFC8fmwtRBqP5Dq6DPuZ7t6WmmmNc
         jAQvcsm9hJJDsz9yvuiHDEvncx9x3MOoa/eDaTViRSbDhvcbnDeEdByos1xF3/0cqx+J
         h4M5lxPE7NPrF0GO1e5G719ngAiXvZB5JQMHDm7+NcKBgbjlpmoO2bWahQu1SB2USdWI
         skaub2SwX2eMu5Cr1xdoKTB+4PciFT6FqvF6H6dGMsnXeCIoqhLDsCS2Gc3t8JE5xjfo
         nRiw==
X-Gm-Message-State: AOJu0YzarKOF2hGjQCWIaHYZHjnOxbJ6ywyLHDoxsBdwa2g+gcNlI5ny
        SQvOO1i/vaDnC9h5OzB5HQaFd3rJFOXasvB6gxUHVrkmUAI=
X-Google-Smtp-Source: AGHT+IEoiDlV3qKKzLKc0PSkRTV5AlIi3+Kl7hZ/ZKJDYYG3uRyMYte83+f1Z7fEascDItofB40H1eKS+A6nJ5qKvCY=
X-Received: by 2002:ac5:cde2:0:b0:49d:20fb:c899 with SMTP id
 v2-20020ac5cde2000000b0049d20fbc899mr3001154vkn.4.1696225670623; Sun, 01 Oct
 2023 22:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV> <20231002023643.GO3389589@ZenIV>
In-Reply-To: <20231002023643.GO3389589@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 08:47:39 +0300
Message-ID: <CAOQ4uxjLuk9XF8Yhy8Ym2Zt_iquKojY9-Yyxz9w8kV0CTooEmw@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 5:36=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> d_inode_rcu() is right - we might be in rcu pathwalk;
> however, OVL_E() hides plain d_inode() on the same dentry...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

However, ovl_lowerstack(oe) does not appear to be stable in RCU walk...

> ---
>  fs/overlayfs/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index f09184b865ec..905d3aaf4e55 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -104,8 +104,8 @@ static int ovl_revalidate_real(struct dentry *d, unsi=
gned int flags, bool weak)
>  static int ovl_dentry_revalidate_common(struct dentry *dentry,
>                                         unsigned int flags, bool weak)
>  {
> -       struct ovl_entry *oe =3D OVL_E(dentry);
> -       struct ovl_path *lowerstack =3D ovl_lowerstack(oe);
> +       struct ovl_entry *oe;
> +       struct ovl_path *lowerstack;
>         struct inode *inode =3D d_inode_rcu(dentry);
>         struct dentry *upper;
>         unsigned int i;
> @@ -115,6 +115,8 @@ static int ovl_dentry_revalidate_common(struct dentry=
 *dentry,
>         if (!inode)
>                 return -ECHILD;
>
> +       oe =3D OVL_I_E(inode);
> +       lowerstack =3D ovl_lowerstack(oe);
>         upper =3D ovl_i_dentry_upper(inode);
>         if (upper)
>                 ret =3D ovl_revalidate_real(upper, flags, weak);
> --
> 2.39.2
>
